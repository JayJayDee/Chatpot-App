<template>
  <GridLayout columns="*" rows="*, auto" class="scene-background">
    <label text="my-scene" />
  </GridLayout>
</template>

<script lang="ts">
const VUE_NAME = 'MyScene';

import Vue from 'vue';
import '@/ext-vue';
import Component from 'vue-class-component';
import { State, Action } from 'vuex-class';
import { BottomBar, BottomBarItem } from 'nativescript-bottombar/vue';

import log from '../logger';
import { setTimeout } from 'timers';

import LoadingDialog from '@/components/LoadingDialog.vue';

@Component({
  name: VUE_NAME
})
export default class MyScene extends Vue {
  public mounted() {
    log(`VIEW INIT: ${VUE_NAME}`);
    this.$showModal(LoadingDialog, {
      fullscreen: false
    });
  }
}
</script>

<style scoped>
.scene-background {
  background-color: chartreuse;
}
</style>