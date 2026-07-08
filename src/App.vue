<template>
  <div class="ambient-shell" aria-hidden="true">
    <div class="ambient-panel ambient-panel-left">
      <span>Forest edge</span>
      <strong>3.2 km</strong>
    </div>
    <div class="ambient-panel ambient-panel-right">
      <span>Survey route</span>
      <strong>Yunnan South</strong>
    </div>
    <div class="ambient-track track-left"></div>
    <div class="ambient-track track-right"></div>
  </div>

  <FloatingBubbles />

  <form class="page" @submit.prevent="handleSubmit">
    <header
      class="survey-header"
      :style="[
        { backgroundImage: `linear-gradient(90deg, rgba(12, 31, 45, 0.88), rgba(12, 31, 45, 0.58)), url(${heroImage})` },
        sceneStyle
      ]"
      @pointermove="handleSceneMove"
      @pointerleave="resetSceneMove"
    >
      <div class="field-scene" aria-hidden="true">
        <div class="scene-grid"></div>
        <div class="route route-main"></div>
        <div class="route route-secondary"></div>
        <span class="scene-marker marker-village"></span>
        <span class="scene-marker marker-water"></span>
        <span class="scene-marker marker-forest"></span>
        <span class="scene-marker marker-elephant"></span>
        <div class="scene-card card-route">
          <strong>Route Shift</strong>
          <span>+2.4 km</span>
        </div>
        <div class="scene-card card-conflict">
          <strong>Conflict Reports</strong>
          <span>18 cases</span>
        </div>
        <div class="signal-ring ring-one"></div>
        <div class="signal-ring ring-two"></div>
      </div>
      <div class="header-content">
        <p class="eyebrow">Asian Elephant Field Survey</p>
        <h1>Questionnaire Survey</h1>
        <h2>
          Analysis of Elephant Herd Distribution Characteristics Based on
          Socioeconomic Development
        </h2>
        <p class="subtitle">
          Study Case: Southern Part of Yunnan Province, China
        </p>
      </div>
    </header>

    <div class="survey-meta" aria-label="Survey sections">
      <button
        v-for="(label, index) in sectionLabels.slice(0, 6)"
        :key="label"
        class="meta-chip"
        :class="{ active: activeSection === index }"
        type="button"
        @click="scrollToSection(index)"
      >
        {{ label }}
      </button>
    </div>

    <nav class="section-dock" aria-label="Questionnaire section navigation" :style="sectionProgressStyle">
      <button class="dock-top" type="button" @click="scrollToTop">Top</button>
      <div class="dock-track">
        <button
          v-for="(label, index) in sectionLabels"
          :key="label"
          class="dock-dot"
          :class="{ active: activeSection === index }"
          type="button"
          :aria-label="`Go to ${label}`"
          @click="scrollToSection(index)"
        >
          <span>{{ index + 1 }}</span>
        </button>
      </div>
    </nav>

    <BasicInfoSection v-model="form.basic" />
    <SectionAProfile v-model="form.section_a" />
    <SectionBSocioeconomic v-model="form.section_b" />
    <SectionCEnvironment v-model="form.section_c" />
    <SectionDElephantPresence v-model="form.section_d" />
    <SectionEConflict v-model="form.section_e" />
    <SectionFPerceptions v-model="form.section_f" />
    <SectionGDevelopment v-model="form.section_g" />
    <SectionHCommunity v-model="form.section_h" />
    <SectionJOpenEnded v-model="form.section_j" />

    <button class="submit-button" type="submit" :disabled="isSubmitting">
      {{ isSubmitting ? "Submitting..." : "Submit Survey" }}
    </button>
  </form>
</template>

<script setup>
import { computed, onBeforeUnmount, onMounted, reactive, ref } from "vue";
import heroImage from "./assets/hero.png";
import { createSurveyForm } from "./utils/createSurveyForm";
import { validateSurveyForm } from "./utils/validateSurveyForm";
import { submitSurvey } from "./api/surveyApi";

import BasicInfoSection from "./components/survey/BasicInfoSection.vue";
import SectionAProfile from "./components/survey/SectionAProfile.vue";
import SectionBSocioeconomic from "./components/survey/SectionBSocioeconomic.vue";
import SectionCEnvironment from "./components/survey/SectionCEnvironment.vue";
import SectionDElephantPresence from "./components/survey/SectionDElephantPresence.vue";
import SectionEConflict from "./components/survey/SectionEConflict.vue";
import SectionFPerceptions from "./components/survey/SectionFPerceptions.vue";
import SectionGDevelopment from "./components/survey/SectionGDevelopment.vue";
import SectionHCommunity from "./components/survey/SectionHCommunity.vue";
import SectionJOpenEnded from "./components/survey/SectionJOpenEnded.vue";
import FloatingBubbles from "./components/ui/FloatingBubbles.vue";

const form = reactive(createSurveyForm());
const isSubmitting = ref(false);
const activeSection = ref(0);
let sectionObserver = null;

const sectionLabels = [
  "Enumerator",
  "Profile",
  "Socioeconomic",
  "Environment",
  "Elephant Presence",
  "Conflict",
  "Perceptions",
  "Development",
  "Community",
  "Open-ended"
];

const sectionProgressStyle = computed(() => ({
  "--progress": `${((activeSection.value + 1) / sectionLabels.length) * 100}%`
}));
const sceneStyle = ref({
  "--scene-x": "0px",
  "--scene-y": "0px",
  "--scene-tilt": "0deg"
});

function handleSceneMove(event) {
  const bounds = event.currentTarget.getBoundingClientRect();
  const xRatio = (event.clientX - bounds.left) / bounds.width - 0.5;
  const yRatio = (event.clientY - bounds.top) / bounds.height - 0.5;

  sceneStyle.value = {
    "--scene-x": `${xRatio * 18}px`,
    "--scene-y": `${yRatio * 14}px`,
    "--scene-tilt": `${xRatio * 2.5}deg`
  };
}

function resetSceneMove() {
  sceneStyle.value = {
    "--scene-x": "0px",
    "--scene-y": "0px",
    "--scene-tilt": "0deg"
  };
}

function getSurveySections() {
  return Array.from(document.querySelectorAll(".page > section"));
}

function scrollToSection(index) {
  const section = getSurveySections()[index];
  if (!section) return;

  section.scrollIntoView({
    behavior: "smooth",
    block: "start"
  });
}

function scrollToTop() {
  document.querySelector(".survey-header")?.scrollIntoView({
    behavior: "smooth",
    block: "start"
  });
}

const validationErrors = computed(() => validateSurveyForm(form));

async function handleSubmit() {
  if (validationErrors.value.length > 0) {
    alert(`Please complete required fields:\n\n${validationErrors.value.join("\n")}`);
    return;
  }

  if (isSubmitting.value) return;
  isSubmitting.value = true;

  try {
    const result = await submitSurvey(form);
    alert(`Questionnaire saved successfully: ${result.survey_id}`);
  } catch (err) {
    console.error(err);
    alert(`Failed to save questionnaire: ${err.message}`);
  } finally {
    isSubmitting.value = false;
  }
}

onMounted(() => {
  sectionObserver = new IntersectionObserver(
    (entries) => {
      const visibleEntry = entries
        .filter((entry) => entry.isIntersecting)
        .sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];

      if (!visibleEntry) return;
      const index = getSurveySections().indexOf(visibleEntry.target);
      if (index >= 0) activeSection.value = index;
    },
    {
      rootMargin: "-20% 0px -55% 0px",
      threshold: [0.15, 0.35, 0.55]
    }
  );

  getSurveySections().forEach((section) => sectionObserver.observe(section));

});

onBeforeUnmount(() => {
  sectionObserver?.disconnect();
});
</script>

<style>
.page {
  position: relative;
  z-index: 1;
  width: min(1040px, calc(100% - 32px));
  margin: 28px auto 64px;
  padding: 22px;
  border: 1px solid rgba(255, 255, 255, 0.48);
  border-radius: 22px;
  background-color: rgba(232, 241, 247, 0.72);
  color: #202938;
  text-align: left;
  box-shadow: 0 30px 90px rgba(18, 38, 55, 0.18);
  counter-reset: survey-section;
  isolation: isolate;
  overflow: hidden;
}

.page::before,
.page::after {
  content: "";
  position: absolute;
  inset: 0;
  z-index: -1;
  pointer-events: none;
}

.page::before {
  background:
    linear-gradient(180deg, rgba(246, 250, 252, 0.72), rgba(246, 250, 252, 0.38) 420px),
    radial-gradient(circle at 12% 24%, rgba(142, 232, 189, 0.2), transparent 24%),
    radial-gradient(circle at 86% 42%, rgba(45, 127, 249, 0.16), transparent 28%);
}

.page::after {
  opacity: 0.34;
  background:
    repeating-linear-gradient(35deg, rgba(255, 255, 255, 0.4) 0 1px, transparent 1px 28px),
    repeating-radial-gradient(circle at 18% 52%, rgba(35, 111, 97, 0.22) 0 1px, transparent 1px 34px);
  mask-image: linear-gradient(180deg, transparent, black 220px, black calc(100% - 120px), transparent);
}

.ambient-shell {
  position: fixed;
  inset: 0;
  z-index: 0;
  pointer-events: none;
  overflow: hidden;
}

.ambient-shell::before,
.ambient-shell::after {
  content: "";
  position: absolute;
  top: 92px;
  bottom: 72px;
  width: 24vw;
  max-width: 340px;
  opacity: 0.42;
  background:
    radial-gradient(circle at 48% 18%, rgba(35, 111, 97, 0.24), transparent 28%),
    repeating-radial-gradient(
      circle at 52% 38%,
      rgba(35, 111, 97, 0.18) 0 1px,
      transparent 1px 26px
    );
  mask-image: linear-gradient(90deg, black, transparent);
}

.ambient-shell::before {
  left: 0;
}

.ambient-shell::after {
  right: 0;
  transform: scaleX(-1);
}

.ambient-panel {
  position: absolute;
  display: grid;
  gap: 2px;
  width: 168px;
  padding: 14px 15px;
  border: 1px solid rgba(35, 111, 97, 0.16);
  border-radius: 14px;
  background: rgba(255, 255, 255, 0.58);
  color: #244357;
  box-shadow: 0 18px 42px rgba(21, 35, 55, 0.08);
  backdrop-filter: blur(10px);
  animation: side-float 7s ease-in-out infinite;
}

.ambient-panel span {
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.04em;
  text-transform: uppercase;
  color: #587082;
}

.ambient-panel strong {
  font-size: 18px;
  color: #236f61;
}

.ambient-panel-left {
  left: max(22px, calc((100vw - 1040px) / 2 - 210px));
  top: 430px;
}

.ambient-panel-right {
  right: max(22px, calc((100vw - 1040px) / 2 - 214px));
  top: 620px;
  animation-delay: -2.6s;
}

.ambient-track {
  position: absolute;
  width: 140px;
  height: 420px;
  border: 1px solid rgba(45, 127, 249, 0.15);
  border-radius: 999px;
  opacity: 0.56;
}

.ambient-track::before,
.ambient-track::after {
  content: "";
  position: absolute;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: #2f7d6d;
  box-shadow: 0 0 0 8px rgba(47, 125, 109, 0.12);
}

.ambient-track::before {
  top: 24%;
  left: -5px;
}

.ambient-track::after {
  right: -5px;
  bottom: 22%;
}

.track-left {
  left: max(-72px, calc((100vw - 1040px) / 2 - 280px));
  top: 180px;
  transform: rotate(-18deg);
}

.track-right {
  right: max(-74px, calc((100vw - 1040px) / 2 - 286px));
  top: 240px;
  transform: rotate(16deg);
}

.survey-header {
  position: relative;
  min-height: 300px;
  display: flex;
  align-items: flex-end;
  margin-bottom: 18px;
  padding: 34px;
  border-radius: 14px;
  background-size: cover;
  background-position: center;
  overflow: hidden;
  box-shadow: 0 24px 60px rgba(19, 34, 56, 0.24);
  isolation: isolate;
}

.header-content {
  position: relative;
  z-index: 2;
  max-width: 760px;
}

.field-scene {
  position: absolute;
  top: 28px;
  right: 30px;
  z-index: 1;
  width: min(38%, 360px);
  min-width: 280px;
  aspect-ratio: 1.35;
  border: 1px solid rgba(255, 255, 255, 0.24);
  border-radius: 18px;
  background:
    radial-gradient(circle at 72% 24%, rgba(126, 211, 164, 0.42), transparent 23%),
    radial-gradient(circle at 30% 78%, rgba(45, 127, 249, 0.26), transparent 27%),
    rgba(12, 31, 45, 0.34);
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.18),
    0 24px 58px rgba(0, 0, 0, 0.22);
  overflow: hidden;
  transform:
    translate3d(var(--scene-x), var(--scene-y), 0)
    rotate(var(--scene-tilt));
  transition: transform 0.18s ease-out;
  backdrop-filter: blur(8px);
}

.field-scene::before {
  content: "";
  position: absolute;
  inset: 0;
  background:
    linear-gradient(115deg, transparent 0 42%, rgba(255, 255, 255, 0.13) 47%, transparent 54%),
    linear-gradient(180deg, rgba(255, 255, 255, 0.1), transparent 45%);
  animation: scene-sheen 7s ease-in-out infinite;
}

.scene-grid {
  position: absolute;
  inset: 0;
  opacity: 0.34;
  background-image:
    linear-gradient(rgba(255, 255, 255, 0.2) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255, 255, 255, 0.2) 1px, transparent 1px);
  background-size: 38px 38px;
  mask-image: radial-gradient(circle at center, black, transparent 78%);
}

.route {
  position: absolute;
  height: 4px;
  border-radius: 999px;
  background: linear-gradient(90deg, rgba(240, 255, 244, 0.15), #88e0b7, rgba(45, 127, 249, 0.9));
  transform-origin: left center;
  box-shadow: 0 0 18px rgba(136, 224, 183, 0.55);
}

.route-main {
  left: 18%;
  top: 55%;
  width: 62%;
  transform: rotate(-22deg);
  animation: route-glow 2.8s ease-in-out infinite;
}

.route-secondary {
  left: 28%;
  top: 35%;
  width: 45%;
  transform: rotate(31deg);
  opacity: 0.72;
  animation: route-glow 3.4s ease-in-out infinite reverse;
}

.scene-marker {
  position: absolute;
  width: 14px;
  height: 14px;
  border: 2px solid rgba(255, 255, 255, 0.86);
  border-radius: 50%;
  background: #8ee8bd;
  box-shadow: 0 0 0 7px rgba(142, 232, 189, 0.16), 0 0 22px rgba(142, 232, 189, 0.55);
}

.scene-marker::after {
  content: "";
  position: absolute;
  inset: -10px;
  border: 1px solid rgba(142, 232, 189, 0.36);
  border-radius: inherit;
  animation: marker-pulse 2.4s ease-out infinite;
}

.marker-village {
  left: 18%;
  top: 58%;
}

.marker-water {
  left: 42%;
  top: 31%;
  background: #76c7ff;
  box-shadow: 0 0 0 7px rgba(118, 199, 255, 0.16), 0 0 22px rgba(118, 199, 255, 0.55);
}

.marker-forest {
  left: 76%;
  top: 24%;
}

.marker-elephant {
  left: 68%;
  top: 64%;
  width: 18px;
  height: 18px;
  background: #ffd166;
  box-shadow: 0 0 0 8px rgba(255, 209, 102, 0.15), 0 0 25px rgba(255, 209, 102, 0.5);
  animation: marker-drift 4.2s ease-in-out infinite;
}

.scene-card {
  position: absolute;
  display: grid;
  gap: 2px;
  min-width: 112px;
  padding: 9px 10px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 10px;
  background: rgba(10, 24, 36, 0.54);
  color: #eff8ff;
  box-shadow: 0 14px 28px rgba(0, 0, 0, 0.16);
}

.scene-card strong {
  font-size: 11px;
  letter-spacing: 0.03em;
  text-transform: uppercase;
  color: #c7f4de;
}

.scene-card span {
  font-size: 18px;
  font-weight: 800;
}

.card-route {
  left: 9%;
  top: 12%;
  animation: scene-float 5s ease-in-out infinite;
}

.card-conflict {
  right: 8%;
  bottom: 10%;
  animation: scene-float 5.8s ease-in-out infinite reverse;
}

.signal-ring {
  position: absolute;
  border: 1px solid rgba(255, 255, 255, 0.28);
  border-radius: 50%;
  animation: signal-spin 12s linear infinite;
}

.ring-one {
  right: -42px;
  top: -34px;
  width: 132px;
  height: 132px;
}

.ring-two {
  left: -34px;
  bottom: -52px;
  width: 150px;
  height: 150px;
  animation-duration: 16s;
  animation-direction: reverse;
}

.eyebrow {
  display: inline-flex;
  margin: 0 0 14px;
  padding: 7px 11px;
  border: 1px solid rgba(255, 255, 255, 0.34);
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.13);
  color: #dcefe8;
  font-size: 13px;
  font-weight: 700;
  letter-spacing: 0.04em;
  text-transform: uppercase;
}

h1 {
  margin: 0 0 12px;
  font-size: 44px;
  font-weight: 700;
  letter-spacing: 0;
  color: #ffffff;
}

h2 {
  max-width: 760px;
  margin: 0;
  font-size: 20px;
  line-height: 1.45;
  font-weight: 500;
  color: #e8f1f7;
}

.subtitle {
  color: #b9c9d7;
  margin: 12px 0 0;
  font-size: 15px;
}

.survey-meta {
  display: grid;
  grid-template-columns: repeat(6, minmax(0, 1fr));
  gap: 8px;
  margin-bottom: 20px;
}

.meta-chip {
  min-height: 38px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 7px 10px;
  border: 1px solid #d8e4ee;
  border-radius: 999px;
  background: #ffffff;
  color: #3f556c;
  font-size: 13px;
  font-weight: 700;
  box-shadow: 0 8px 22px rgba(23, 42, 63, 0.06);
  cursor: pointer;
  transition:
    transform 0.16s ease,
    border-color 0.16s ease,
    background-color 0.16s ease,
    color 0.16s ease,
    box-shadow 0.16s ease;
}

.meta-chip:hover,
.meta-chip.active {
  border-color: #88c8b5;
  background: #e8f4ef;
  color: #1f6457;
  box-shadow: 0 10px 24px rgba(35, 111, 97, 0.14);
  transform: translateY(-1px);
}

.section-dock {
  position: fixed;
  top: 50%;
  right: max(18px, calc((100vw - 1040px) / 2 - 92px));
  z-index: 5;
  display: grid;
  justify-items: center;
  gap: 10px;
  padding: 10px 8px;
  border: 1px solid rgba(35, 111, 97, 0.15);
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.72);
  box-shadow: 0 16px 38px rgba(21, 35, 55, 0.12);
  backdrop-filter: blur(12px);
  transform: translateY(-50%);
}

.dock-top {
  min-width: 42px;
  min-height: 30px;
  padding: 5px 8px;
  border: none;
  border-radius: 999px;
  background: #173447;
  color: #ffffff;
  font-size: 12px;
  font-weight: 800;
  cursor: pointer;
}

.dock-track {
  position: relative;
  display: grid;
  gap: 8px;
  padding: 4px 0;
}

.dock-track::before,
.dock-track::after {
  content: "";
  position: absolute;
  left: 50%;
  top: 10px;
  bottom: 10px;
  width: 2px;
  border-radius: 999px;
  transform: translateX(-50%);
}

.dock-track::before {
  background: #d8e4ee;
}

.dock-track::after {
  height: var(--progress);
  bottom: auto;
  background: linear-gradient(180deg, #236f61, #2d7ff9);
}

.dock-dot {
  position: relative;
  z-index: 1;
  width: 30px;
  height: 30px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #d6e2eb;
  border-radius: 50%;
  background: #ffffff;
  color: #587082;
  cursor: pointer;
  transition:
    transform 0.16s ease,
    background-color 0.16s ease,
    border-color 0.16s ease,
    color 0.16s ease;
}

.dock-dot span {
  font-size: 11px;
  font-weight: 800;
}

.dock-dot:hover,
.dock-dot.active {
  border-color: #236f61;
  background: #236f61;
  color: #ffffff;
  transform: scale(1.08);
}

section {
  position: relative;
  border: 1px solid rgba(217, 226, 236, 0.72);
  border-left: 6px solid rgba(47, 125, 109, 0.9);
  border-radius: 12px;
  padding: 28px 30px 30px;
  margin-bottom: 20px;
  background: rgba(255, 255, 255, 0.66);
  box-shadow: 0 16px 42px rgba(21, 35, 55, 0.08);
  counter-increment: survey-section;
  backdrop-filter: blur(14px) saturate(1.15);
  transition:
    background-color 0.18s ease,
    box-shadow 0.18s ease,
    transform 0.18s ease;
}

section:nth-of-type(2n) {
  background: rgba(255, 255, 255, 0.58);
}

section:nth-of-type(3n) {
  background: rgba(247, 252, 249, 0.62);
}

section:hover {
  background: rgba(255, 255, 255, 0.76);
  box-shadow: 0 20px 52px rgba(21, 35, 55, 0.13);
  transform: translateY(-1px);
}

section::before {
  content: counter(survey-section, decimal-leading-zero);
  position: absolute;
  top: 22px;
  right: 24px;
  min-width: 42px;
  min-height: 32px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 999px;
  background: #e8f4ef;
  color: #216456;
  font-weight: 800;
  font-size: 14px;
}

h3 {
  margin: 0 62px 20px 0;
  border-bottom: 1px solid #edf2f7;
  padding-bottom: 14px;
  font-size: 21px;
  font-weight: 700;
  color: #132238;
}

label {
  display: block;
  margin-top: 16px;
  margin-bottom: 7px;
  color: #25364d;
  font-weight: bold;
  font-size: 14px;
}

input,
select,
textarea {
  width: 100%;
  min-height: 42px;
  padding: 10px 12px;
  box-sizing: border-box;
  border: 1px solid #c7d2df;
  border-radius: 6px;
  background: #fcfeff;
  color: #1f2937;
  font-size: 15px;
  transition:
    border-color 0.16s ease,
    box-shadow 0.16s ease,
    background-color 0.16s ease;
}

input:hover,
select:hover,
textarea:hover {
  border-color: #9fb4cc;
}

input:focus,
select:focus,
textarea:focus {
  outline: none;
  border-color: #2d7ff9;
  background: #ffffff;
  box-shadow: 0 0 0 3px rgba(45, 127, 249, 0.16);
}

textarea {
  min-height: 104px;
  resize: vertical;
}

.radio-row,
.checkbox-row {
  display: flex;
  align-items: center;
  gap: 10px;
  min-height: 38px;
  margin: 7px 0;
  padding: 8px 10px;
  border: 1px solid #e3ebf3;
  border-radius: 8px;
  background: #f7faf8;
  transition:
    border-color 0.16s ease,
    background-color 0.16s ease,
    transform 0.16s ease;
}

.radio-row:hover,
.checkbox-row:hover {
  border-color: #9bc5b8;
  background: #f0f8f5;
  transform: translateX(2px);
}

.radio-row input,
.checkbox-row input {
  width: auto;
  min-height: auto;
  accent-color: #2d7ff9;
}

.radio-row span,
.checkbox-row span {
  color: #344256;
  font-size: 15px;
}

.grid-2 {
  display: grid;
  grid-template-columns: 150px 1fr;
  gap: 12px;
  align-items: center;
  padding: 14px;
  border: 1px solid #e3ebf3;
  border-radius: 10px;
  background: #f7faf8;
}

.grid-2 label {
  margin: 0;
  color: #4a5b70;
}

.hint {
  color: #66788f;
  font-size: 14px;
  margin-bottom: 12px;
}

.likert-row {
  margin-bottom: 18px;
  padding: 14px;
  border: 1px solid #e3ebf3;
  border-radius: 10px;
  background: #f7faf8;
}

.likert-row label {
  margin-top: 0;
}

.submit-button {
  width: 100%;
  min-height: 52px;
  margin-top: 8px;
  padding: 14px 18px;
  font-size: 18px;
  font-weight: 700;
  background: linear-gradient(135deg, #236f61, #2d7ff9);
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  box-shadow: 0 16px 32px rgba(35, 111, 97, 0.28);
  transition:
    transform 0.16s ease,
    box-shadow 0.16s ease,
    background-color 0.16s ease;
}

.submit-button:hover:not(:disabled) {
  background: linear-gradient(135deg, #1f6457, #1f6fe5);
  box-shadow: 0 18px 36px rgba(35, 111, 97, 0.34);
  transform: translateY(-1px);
}

.submit-button:focus-visible {
  outline: 3px solid rgba(45, 127, 249, 0.28);
  outline-offset: 3px;
}

.submit-button:disabled {
  cursor: not-allowed;
  opacity: 0.65;
  box-shadow: none;
}

@media (max-width: 720px) {
  .ambient-panel,
  .ambient-track {
    display: none;
  }

  .ambient-shell::before,
  .ambient-shell::after {
    width: 44vw;
    opacity: 0.24;
  }

  .page {
    width: min(100% - 20px, 940px);
    margin: 22px auto 36px;
    padding: 12px;
  }

  h1 {
    font-size: 30px;
  }

  h2 {
    font-size: 16px;
  }

  .survey-header {
    min-height: 260px;
    padding: 24px;
    border-radius: 12px;
  }

  .field-scene {
    top: 18px;
    right: 18px;
    width: 170px;
    min-width: 170px;
    opacity: 0.72;
  }

  .scene-card {
    display: none;
  }

  .survey-meta {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .section-dock {
    display: none;
  }

  section {
    padding: 20px 18px 22px;
    margin-bottom: 14px;
  }

  section::before {
    position: static;
    margin-bottom: 12px;
  }

  h3 {
    margin-right: 0;
  }

  .grid-2 {
    grid-template-columns: 1fr;
    gap: 8px;
  }
}

@keyframes side-float {
  0%,
  100% {
    transform: translate3d(0, 0, 0);
  }

  50% {
    transform: translate3d(0, -12px, 0);
  }
}

@keyframes marker-pulse {
  0% {
    transform: scale(0.6);
    opacity: 0.75;
  }

  100% {
    transform: scale(1.45);
    opacity: 0;
  }
}

@keyframes marker-drift {
  0%,
  100% {
    transform: translate3d(0, 0, 0);
  }

  50% {
    transform: translate3d(-10px, -8px, 0);
  }
}

@keyframes route-glow {
  0%,
  100% {
    filter: brightness(0.95);
    opacity: 0.72;
  }

  50% {
    filter: brightness(1.28);
    opacity: 1;
  }
}

@keyframes scene-float {
  0%,
  100% {
    transform: translateY(0);
  }

  50% {
    transform: translateY(-8px);
  }
}

@keyframes signal-spin {
  to {
    transform: rotate(360deg);
  }
}

@keyframes scene-sheen {
  0%,
  100% {
    transform: translateX(-35%);
    opacity: 0.45;
  }

  50% {
    transform: translateX(35%);
    opacity: 0.85;
  }
}
</style>
