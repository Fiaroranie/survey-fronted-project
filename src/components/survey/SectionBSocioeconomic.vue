<script setup>
import {
  yesNoOptions,
  incomeOptions,
  incomeSourceOptions,
  landUseTypeOptions,
  livestockOptions
} from "../../data/surveyOptions";

const model = defineModel();
</script>

<template>
  <section>
    <h3>Section B. Socioeconomic Characteristics</h3>

    <label>B1. Average Monthly Household Income</label>
    <select v-model="model.monthly_income_group">
      <option disabled value="">Please select</option>
      <option v-for="item in incomeOptions" :key="item">
        {{ item }}
      </option>
    </select>

    <label>B2. Main Income Source</label>
    <select v-model="model.main_income_source">
      <option disabled value="">Please select</option>
      <option v-for="item in incomeSourceOptions" :key="item">
        {{ item }}
      </option>
    </select>

    <label>If Other, please specify</label>
    <input v-model="model.main_income_source_other" />

    <label>B3. Do you own agricultural land?</label>
    <div
      class="radio-row"
      v-for="option in yesNoOptions"
      :key="option.label"
    >
      <input
        type="radio"
        :value="option.value"
        v-model="model.owns_agricultural_land"
      />
      <span>{{ option.label }}</span>
    </div>

    <label>If Yes, area owned - ha</label>
    <input
      type="number"
      step="0.01"
      v-model.number="model.land_area_ha"
    />

    <label>B4. Land Use Types Owned - Multiple answers allowed</label>
    <div
      class="checkbox-row"
      v-for="item in landUseTypeOptions"
      :key="item"
    >
      <input
        type="checkbox"
        :value="item"
        v-model="model.land_use_types"
      />
      <span>{{ item }}</span>
    </div>

    <label>If Other, please specify</label>
    <input v-model="model.land_use_type_other" />

    <label>B5. Livestock Ownership</label>

    <div class="grid-2">
      <template v-for="item in livestockOptions" :key="item.key">
        <label>{{ item.label }}</label>
        <input type="number" min="0" v-model.number="model.livestock[item.key]" />
      </template>
    </div>
  </section>
</template>
