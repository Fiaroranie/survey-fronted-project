<script setup>
import {
  landUseChangeLevelOptions,
  landChangeTypeOptions,
  distanceHomeForestOptions,
  waterSourceOptions
} from "../../data/surveyOptions";

const model = defineModel();
</script>

<template>
  <section>
    <h3>Section C. Land Use and Environmental Change</h3>

    <label>
      C1. How has land use around your village changed during the last 10 years?
    </label>
    <select v-model="model.land_use_change_level">
      <option disabled value="">Please select</option>
      <option v-for="item in landUseChangeLevelOptions" :key="item">
        {{ item }}
      </option>
    </select>

    <label>C2. Main changes observed - Multiple answers allowed</label>
    <div
      class="checkbox-row"
      v-for="item in landChangeTypeOptions"
      :key="item"
    >
      <input
        type="checkbox"
        :value="item"
        v-model="model.change_types"
      />
      <span>{{ item }}</span>
    </div>

    <label>If Other, please specify</label>
    <input v-model="model.change_type_other" />

    <label>C3. Distance from your home to nearest forest</label>
    <select v-model="model.distance_home_forest_group">
      <option disabled value="">Please select</option>
      <option v-for="item in distanceHomeForestOptions" :key="item">
        {{ item }}
      </option>
    </select>

    <label>C4. Distance from your farmland to forest edge - km</label>
    <input
      type="number"
      step="0.01"
      min="0"
      v-model.number="model.distance_farmland_forest_km"
    />

    <label>C5. Presence of water sources near village</label>
    <div
      class="checkbox-row"
      v-for="item in waterSourceOptions"
      :key="item"
    >
      <input
        type="checkbox"
        :value="item"
        v-model="model.water_sources"
      />
      <span>{{ item }}</span>
    </div>
  </section>
</template>