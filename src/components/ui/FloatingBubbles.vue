<template>
  <div class="bubble-layer" aria-label="Interactive background bubbles">
    <button
      v-for="bubble in bubbles"
      :key="bubble.id"
      class="bubble"
      :class="[`bubble-${bubble.side}`, { popped: bubble.popped }]"
      type="button"
      :aria-label="`Pop ${bubble.label} bubble`"
      :style="{
        top: bubble.top,
        width: `${bubble.size}px`,
        height: `${bubble.size}px`,
        animationDelay: bubble.delay
      }"
      @click="popBubble(bubble.id)"
    >
      <span>{{ bubble.label }}</span>
    </button>
  </div>
</template>

<script setup>
import { onBeforeUnmount, onMounted, ref } from "vue";

let bubbleTimer = null;
let nextBubbleId = 7;

const bubbleWords = [
  "Forest",
  "Water",
  "Route",
  "Village",
  "Survey",
  "GPS",
  "Habitat",
  "Crop",
  "River",
  "Track"
];

const bubbles = ref([
  { id: 1, label: "Forest", side: "left", top: "16%", size: 74, delay: "0s", popped: false },
  { id: 2, label: "Water", side: "left", top: "38%", size: 56, delay: "-1.4s", popped: false },
  { id: 3, label: "Route", side: "left", top: "68%", size: 66, delay: "-2.8s", popped: false },
  { id: 4, label: "Village", side: "right", top: "22%", size: 64, delay: "-0.8s", popped: false },
  { id: 5, label: "Survey", side: "right", top: "48%", size: 78, delay: "-2.1s", popped: false },
  { id: 6, label: "GPS", side: "right", top: "76%", size: 52, delay: "-3.3s", popped: false }
]);

function addBubble() {
  const activeBubbles = bubbles.value.filter((item) => !item.popped);
  if (activeBubbles.length >= 8) return;

  const side = Math.random() > 0.5 ? "left" : "right";
  const label = bubbleWords[Math.floor(Math.random() * bubbleWords.length)];
  const top = `${14 + Math.round(Math.random() * 70)}%`;
  const size = 48 + Math.round(Math.random() * 34);
  const delay = `${-(Math.random() * 4).toFixed(1)}s`;

  bubbles.value.push({
    id: nextBubbleId,
    label,
    side,
    top,
    size,
    delay,
    popped: false
  });

  nextBubbleId += 1;
}

function popBubble(id) {
  const bubble = bubbles.value.find((item) => item.id === id);
  if (bubble) bubble.popped = true;

  window.setTimeout(() => {
    bubbles.value = bubbles.value.filter((item) => item.id !== id);
    addBubble();
  }, 360);
}

onMounted(() => {
  bubbleTimer = window.setInterval(addBubble, 4200);
});

onBeforeUnmount(() => {
  window.clearInterval(bubbleTimer);
});
</script>

<style scoped>
.bubble-layer {
  position: fixed;
  inset: 0;
  z-index: 2;
  pointer-events: none;
  overflow: hidden;
}

.bubble {
  position: absolute;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0;
  border: 1px solid rgba(255, 255, 255, 0.72);
  border-radius: 50%;
  background:
    radial-gradient(circle at 30% 24%, rgba(255, 255, 255, 0.96) 0 11%, rgba(255, 255, 255, 0.44) 12% 24%, transparent 36%),
    radial-gradient(circle at 68% 72%, rgba(35, 111, 97, 0.16), transparent 34%),
    linear-gradient(135deg, rgba(164, 238, 204, 0.48), rgba(111, 188, 255, 0.34));
  color: #21495b;
  cursor: pointer;
  opacity: 0.88;
  box-shadow:
    inset -10px -12px 20px rgba(35, 111, 97, 0.14),
    inset 8px 10px 18px rgba(255, 255, 255, 0.58),
    0 18px 36px rgba(18, 38, 55, 0.14);
  pointer-events: auto;
  animation: bubble-float 7s ease-in-out infinite;
  transition:
    opacity 0.18s ease,
    transform 0.18s ease,
    filter 0.18s ease;
  backdrop-filter: blur(5px);
  appearance: none;
}

.bubble::before,
.bubble::after {
  content: "";
  position: absolute;
  border-radius: inherit;
  pointer-events: none;
}

.bubble::before {
  top: 16%;
  left: 20%;
  width: 22%;
  height: 22%;
  background: rgba(255, 255, 255, 0.74);
}

.bubble::after {
  inset: -9px;
  border: 1px solid rgba(142, 232, 189, 0.28);
  opacity: 0;
  transition: opacity 0.18s ease;
}

.bubble:hover {
  opacity: 1;
  filter: saturate(1.18);
  transform: scale(1.08);
}

.bubble:hover::after {
  opacity: 1;
}

.bubble span {
  position: relative;
  z-index: 1;
  max-width: 76%;
  overflow: hidden;
  color: rgba(33, 73, 91, 0.72);
  font-size: 10px;
  font-weight: 800;
  letter-spacing: 0.03em;
  text-overflow: ellipsis;
  text-transform: uppercase;
  white-space: nowrap;
}

.bubble-left {
  left: max(18px, calc((100vw - 1040px) / 2 - 132px));
}

.bubble-right {
  right: max(18px, calc((100vw - 1040px) / 2 - 134px));
}

.bubble.popped {
  pointer-events: none;
  animation: bubble-pop 0.34s ease-out forwards;
}

@media (max-width: 720px) {
  .bubble-layer {
    display: none;
  }
}

@keyframes bubble-float {
  0%,
  100% {
    translate: 0 0;
  }

  50% {
    translate: 0 -18px;
  }
}

@keyframes bubble-pop {
  0% {
    opacity: 0.95;
    transform: scale(1);
  }

  58% {
    opacity: 0.82;
    transform: scale(1.35);
  }

  100% {
    opacity: 0;
    transform: scale(0.18);
    filter: blur(5px);
  }
}
</style>
