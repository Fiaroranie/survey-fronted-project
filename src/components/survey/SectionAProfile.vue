<script setup>
import {
  genderOptions,
  maritalStatusOptions,
  educationOptions,
  occupationOptions
} from "../../data/surveyOptions";

const model = defineModel();
</script>

<template>
  <section>
    <h3>Section A. Respondent Profile</h3>

    <label>A1. Gender</label>
    <select v-model="model.gender">
      <option disabled value="">Please select</option>
      <option v-for="item in genderOptions" :key="item">
        {{ item }}
      </option>
    </select>

    <label>A2. Age</label>
    <input type="number" v-model.number="model.age" />

    <label>A3. Marital Status</label>
    <select v-model="model.marital_status">
      <option disabled value="">Please select</option>
      <option v-for="item in maritalStatusOptions" :key="item">
        {{ item }}
      </option>
    </select>

    <label>A4. Education Level</label>
    <select v-model="model.education_level">
      <option disabled value="">Please select</option>
      <option v-for="item in educationOptions" :key="item">
        {{ item }}
      </option>
    </select>

    <label>A5. Occupation Main</label>
    <select v-model="model.occupation_main">
      <option disabled value="">Please select</option>
      <option v-for="item in occupationOptions" :key="item">
        {{ item }}
      </option>
    </select>

    <label>If Other, please specify</label>
    <input v-model="model.occupation_other" />

    <label>A6. Household Size</label>
    <input type="number" v-model.number="model.household_size" />

    <label>A7. Number of Income Earners</label>
    <input type="number" v-model.number="model.income_earners" />
  </section>
</template>