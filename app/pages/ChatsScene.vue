<template>
  <GridLayout columns="*" rows="*, auto" class="scene-background">
    <label text="chats-scene" />
  </GridLayout>
</template>

<script lang="ts">
const VUE_NAME = 'ChatsScene';

import Vue from 'vue';
import '@/ext-vue';
import Component from 'vue-class-component';
import { State, Action } from 'vuex-class';
import { BottomBar, BottomBarItem } from 'nativescript-bottombar/vue';

import log from '../logger';

@Component({
  name: VUE_NAME
})
export default class ChatsScene extends Vue {

  public mounted() {
    log(`VIEW INIT: ${VUE_NAME}`);
  }
}
</script>

<style scoped>
.scene-background {
  background-color: burlywood;
}
</style>