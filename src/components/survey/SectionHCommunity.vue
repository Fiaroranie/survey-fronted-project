<script setup>
import { yesNoOptions } from "../../data/surveyOptions";

const model = defineModel();
</script>

<template>
  <section>
    <h3>Section H. Community Knowledge</h3>

    <label>H1. Do you know any traditional elephant movement routes?</label>
    <div
      class="radio-row"
      v-for="option in yesNoOptions"
      :key="option.label"
    >
      <input
        type="radio"
        :value="option.value"
        v-model="model.knows_traditional_routes"
      />
      <span>{{ option.label }}</span>
    </div>

    <label>If Yes, describe location</label>
    <textarea v-model="model.traditional_route_description"></textarea>

    <label>H2. Do local elders possess knowledge about elephant movements?</label>
    <div
      class="radio-row"
      v-for="option in yesNoOptions"
      :key="option.label"
    >
      <input
        type="radio"
        :value="option.value"
        v-model="model.elders_know_routes"
      />
      <span>{{ option.label }}</span>
    </div>

    <label>H3. Are there community-based conservation activities?</label>
    <div
      class="radio-row"
      v-for="option in yesNoOptions"
      :key="option.label"
    >
      <input
        type="radio"
        :value="option.value"
        v-model="model.community_conservation"
      />
      <span>{{ option.label }}</span>
    </div>

    <label>If Yes, please describe</label>
    <textarea v-model="model.community_conservation_description"></textarea>
  </section>
</template>