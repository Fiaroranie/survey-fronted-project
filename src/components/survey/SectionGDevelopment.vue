<script setup>
import {
  yesNoOptions,
  developmentChangeOptions,
  increaseChangeOptions
} from "../../data/surveyOptions";

const model = defineModel();
</script>

<template>
  <section>
    <h3>Section G. Socioeconomic Development Indicators</h3>

    <label>
      G1. Has road infrastructure improved in your area during the last 10 years?
    </label>
    <select v-model="model.road_infrastructure_change">
      <option disabled value="">Please select</option>
      <option v-for="item in developmentChangeOptions" :key="item">
        {{ item }}
      </option>
    </select>

    <label>G2. Has agricultural expansion increased?</label>
    <select v-model="model.agricultural_expansion_change">
      <option disabled value="">Please select</option>
      <option v-for="item in increaseChangeOptions" :key="item">
        {{ item }}
      </option>
    </select>

    <label>G3. Has population density increased?</label>
    <select v-model="model.population_density_change">
      <option disabled value="">Please select</option>
      <option v-for="item in increaseChangeOptions" :key="item">
        {{ item }}
      </option>
    </select>

    <label>G4. Have new businesses or industries been established nearby?</label>
    <div
      class="radio-row"
      v-for="option in yesNoOptions"
      :key="option.label"
    >
      <input
        type="radio"
        :value="option.value"
        v-model="model.new_business_nearby"
      />
      <span>{{ option.label }}</span>
    </div>

    <label>G5. Has household income improved over the last 10 years?</label>
    <select v-model="model.household_income_change">
      <option disabled value="">Please select</option>
      <option v-for="item in developmentChangeOptions" :key="item">
        {{ item }}
      </option>
    </select>
  </section>
</template>