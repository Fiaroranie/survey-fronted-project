<script setup>
import { likertOptions } from "../../data/surveyOptions";

const model = defineModel();

const perceptionItems = [
  {
    key: "elephants_important_ecosystem",
    label: "Elephants are important for ecosystems"
  },
  {
    key: "elephant_population_protected",
    label: "Elephant populations should be protected"
  },
  {
    key: "government_programs_effective",
    label: "Government conservation programs are effective"
  },
  {
    key: "conflict_increasing",
    label: "Human-elephant conflict is increasing"
  },
  {
    key: "communities_benefit_conservation",
    label: "Local communities benefit from elephant conservation"
  },
  {
    key: "habitats_preserved",
    label: "Elephant habitats should be preserved"
  },
  {
    key: "development_affects_distribution",
    label: "Economic development affects elephant distribution"
  },
  {
    key: "agricultural_expansion_reduces_habitat",
    label: "Agricultural expansion reduces elephant habitat"
  }
];
</script>

<template>
  <section>
    <h3>Section F. Perceptions of Elephant Conservation</h3>
    <p class="hint">1 = Strongly Disagree, 5 = Strongly Agree</p>

    <div
      class="likert-row"
      v-for="item in perceptionItems"
      :key="item.key"
    >
      <label>{{ item.label }}</label>
      <select v-model.number="model[item.key]">
        <option :value="null">Please select</option>
        <option
          v-for="option in likertOptions"
          :key="option.value"
          :value="option.value"
        >
          {{ option.value }} - {{ option.label }}
        </option>
      </select>
    </div>
  </section>
</template>