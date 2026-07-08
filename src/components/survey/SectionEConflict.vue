<script setup>
import { watch } from "vue";
import {
  yesNoOptions,
  cropDamageFrequencyOptions,
  economicLossOptions,
  cropTypeOptions,
  deterrenceMethodOptions
} from "../../data/surveyOptions";

const model = defineModel();

watch(
  () => model.value.crop_damage,
  (hasCropDamage) => {
    if (hasCropDamage === false) {
      model.value.crop_damage_frequency = "";
      model.value.economic_loss_group = "";
      model.value.crop_types = [];
      model.value.crop_type_other = "";
    }
  }
);
</script>

<template>
  <section>
    <h3>Section E. Human-Elephant Conflict</h3>

    <label>E1. Have elephants damaged your crops?</label>
    <div
      class="radio-row"
      v-for="option in yesNoOptions"
      :key="option.label"
    >
      <input
        type="radio"
        :value="option.value"
        v-model="model.crop_damage"
      />
      <span>{{ option.label }}</span>
    </div>

    <template v-if="model.crop_damage === true">
      <label>E2. Frequency of crop damage</label>
      <select v-model="model.crop_damage_frequency">
        <option disabled value="">Please select</option>
        <option v-for="item in cropDamageFrequencyOptions" :key="item">
          {{ item }}
        </option>
      </select>

      <label>E3. Estimated Economic Loss Due to Elephant Damage per Year</label>
      <select v-model="model.economic_loss_group">
        <option disabled value="">Please select</option>
        <option v-for="item in economicLossOptions" :key="item">
          {{ item }}
        </option>
      </select>

      <label>E4. Types of crops affected</label>
      <div
        class="checkbox-row"
        v-for="item in cropTypeOptions"
        :key="item"
      >
        <input
          type="checkbox"
          :value="item"
          v-model="model.crop_types"
        />
        <span>{{ item }}</span>
      </div>

      <label>If Other, please specify</label>
      <input v-model="model.crop_type_other" />
    </template>

    <label>E5. Have elephants damaged property?</label>
    <div
      class="radio-row"
      v-for="option in yesNoOptions"
      :key="option.label"
    >
      <input
        type="radio"
        :value="option.value"
        v-model="model.property_damage"
      />
      <span>{{ option.label }}</span>
    </div>

    <label>E6. Have elephants injured people?</label>
    <div
      class="radio-row"
      v-for="option in yesNoOptions"
      :key="option.label"
    >
      <input
        type="radio"
        :value="option.value"
        v-model="model.human_injury"
      />
      <span>{{ option.label }}</span>
    </div>

    <label>E7. Have elephants killed people?</label>
    <div
      class="radio-row"
      v-for="option in yesNoOptions"
      :key="option.label"
    >
      <input
        type="radio"
        :value="option.value"
        v-model="model.human_death"
      />
      <span>{{ option.label }}</span>
    </div>

    <label>E8. Methods used to deter elephants - Multiple answers allowed</label>
    <div
      class="checkbox-row"
      v-for="item in deterrenceMethodOptions"
      :key="item"
    >
      <input
        type="checkbox"
        :value="item"
        v-model="model.deterrence_methods"
      />
      <span>{{ item }}</span>
    </div>

    <label>If Other, please specify</label>
    <input v-model="model.deterrence_method_other" />
  </section>
</template>
