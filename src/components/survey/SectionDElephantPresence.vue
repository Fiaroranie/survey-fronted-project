<script setup>
import { watch } from "vue";
import {
  yesNoOptions,
  elephantFrequencyOptions,
  elephantLocationOptions,
  elephantSeasonOptions,
  herdSizeOptions,
  elephantNumberChangeOptions
} from "../../data/surveyOptions";

const model = defineModel();

watch(
  () => model.value.seen_elephants,
  (seenElephants) => {
    if (seenElephants === false) {
      model.value.elephant_frequency = "";
      model.value.elephant_common_locations = [];
      model.value.elephant_common_location_other = "";
      model.value.elephant_common_distance_km = null;
      model.value.elephant_season = "";
      model.value.herd_size_group = "";
      model.value.elephant_number_change = "";
      model.value.elephant_route_change = null;
      model.value.elephant_route_change_explanation = "";
    }
  }
);

watch(
  () => model.value.elephant_route_change,
  (routeChanged) => {
    if (routeChanged !== true) {
      model.value.elephant_route_change_explanation = "";
    }
  }
);
</script>

<template>
  <section>
    <h3>Section D. Elephant Presence and Distribution</h3>

    <label>D1. Have you ever seen wild elephants?</label>
    <div
      class="radio-row"
      v-for="option in yesNoOptions"
      :key="option.label"
    >
      <input
        type="radio"
        :value="option.value"
        v-model="model.seen_elephants"
      />
      <span>{{ option.label }}</span>
    </div>

    <div v-if="model.seen_elephants === true">
      <label>D2. How often do elephants appear near your village?</label>
      <select v-model="model.elephant_frequency">
        <option disabled value="">Please select</option>
        <option v-for="item in elephantFrequencyOptions" :key="item">
          {{ item }}
        </option>
      </select>

      <label>D3. Where are elephants commonly observed?</label>
      <div
        class="checkbox-row"
        v-for="item in elephantLocationOptions"
        :key="item"
      >
        <input
          type="checkbox"
          :value="item"
          v-model="model.elephant_common_locations"
        />
        <span>{{ item }}</span>
      </div>

      <label>If Other, please specify</label>
      <input v-model="model.elephant_common_location_other" />

      <label>
        D4. Approximate distance from village center where elephants are commonly observed - km
      </label>
      <input
        type="number"
        step="0.01"
        min="0"
        v-model.number="model.elephant_common_distance_km"
      />

      <label>D5. In which season are elephants most frequently observed?</label>
      <select v-model="model.elephant_season">
        <option disabled value="">Please select</option>
        <option v-for="item in elephantSeasonOptions" :key="item">
          {{ item }}
        </option>
      </select>

      <label>D6. Typical herd size observed</label>
      <select v-model="model.herd_size_group">
        <option disabled value="">Please select</option>
        <option v-for="item in herdSizeOptions" :key="item">
          {{ item }}
        </option>
      </select>

      <label>
        D7. Have you observed changes in elephant numbers during the last 10 years?
      </label>
      <select v-model="model.elephant_number_change">
        <option disabled value="">Please select</option>
        <option v-for="item in elephantNumberChangeOptions" :key="item">
          {{ item }}
        </option>
      </select>

      <label>D8. Have you observed changes in elephant movement routes?</label>
      <div
        class="radio-row"
        v-for="option in yesNoOptions"
        :key="option.label"
      >
        <input
          type="radio"
          :value="option.value"
          v-model="model.elephant_route_change"
        />
        <span>{{ option.label }}</span>
      </div>

      <template v-if="model.elephant_route_change === true">
        <label>If Yes, explain</label>
        <textarea v-model="model.elephant_route_change_explanation"></textarea>
      </template>
    </div>
  </section>
</template>
