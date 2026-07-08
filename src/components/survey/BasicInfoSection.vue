<script setup>
const model = defineModel();
</script>

<template>
  <section>
    <h3>Enumerator Information</h3>

    <label>Survey ID</label>
    <input v-model.trim="model.survey_id" placeholder="e.g. S001" required />

    <label>Date</label>
    <input type="date" v-model="model.survey_date" required />

    <label>Enumerator Name</label>
    <input v-model.trim="model.enumerator_name" required />

    <label>Village Name</label>
    <input v-model.trim="model.village_name" required />

    <label>District</label>
    <input v-model.trim="model.district" required />

    <label>Longitude</label>
    <input
      type="number"
      step="0.000001"
      min="-180"
      max="180"
      v-model.number="model.longitude"
      required
    />

    <label>Latitude</label>
    <input
      type="number"
      step="0.000001"
      min="-90"
      max="90"
      v-model.number="model.latitude"
      required
    />

    <label>Respondent Code</label>
    <input v-model.trim="model.respondent_code" />
  </section>
</template>
