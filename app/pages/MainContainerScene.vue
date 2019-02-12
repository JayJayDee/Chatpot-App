<template>
  <Page>
    <ActionBar title="Chatpot" class="action-bar" />
  </Page>
</template>

<script lang="ts">
const VUE_NAME = 'MainCotainerScene';

import Vue from 'vue';
import './ext-vue';
import Component from 'vue-class-component';

import log from '../logger';
import { memberApi } from '../apis';
import SimpleJoinScene from './SimpleJoinScene.vue';
import { State } from 'vuex-class';

@Component({
  name: VUE_NAME
})
export default class MainCotainerScene extends Vue {

  @State(state => state.loading)
  private loading: boolean;

  constructor() {
    super();
  }

  public mounted() {
    log(`VUE_INIT: ${VUE_NAME}`);
  }
}
</script>

<style scoped>
</style>