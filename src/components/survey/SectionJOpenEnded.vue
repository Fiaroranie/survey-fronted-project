<script setup>
const model = defineModel();
</script>

<template>
  <section>
    <h3>Section J. Open-Ended Questions</h3>

    <label>
      J1. What do you think is the main reason elephants occur in this area?
    </label>
    <textarea v-model="model.reason_elephants_occur"></textarea>

    <label>
      J2. How has socioeconomic development affected elephant movements?
    </label>
    <textarea v-model="model.development_effect_on_movements"></textarea>

    <label>
      J3. What measures should be taken to reduce human-elephant conflict?
    </label>
    <textarea v-model="model.conflict_reduction_measures"></textarea>

    <label>J4. Additional comments</label>
    <textarea v-model="model.additional_comments"></textarea>
  </section>
</template>