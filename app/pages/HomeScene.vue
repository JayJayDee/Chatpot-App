<template>
  <Page>
    <label text="home-scene" />
  </Page>
</template>

<script lang="ts">
const VUE_NAME = 'HomeScene';

import Vue from 'vue';
import '@/ext-vue';
import Component from 'vue-class-component';
import { State, Action } from 'vuex-class';
import { BottomBar, BottomBarItem } from 'nativescript-bottombar/vue';

import log from '../logger';

@Component({
  name: VUE_NAME
})
export default class HomeScene extends Vue {
}
</script>

<style scoped>
</style>