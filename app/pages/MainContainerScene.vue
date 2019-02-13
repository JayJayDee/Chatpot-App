<template>
  <Page>
    <ActionBar title="메인" class="action-bar" />
      <Label :text="memberName" />
  </Page>
</template>

<script lang="ts">
const VUE_NAME = 'MainCotainerScene';

import Vue from 'vue';
import '@/ext-vue';
import Component from 'vue-class-component';
import { State } from 'vuex-class';
import { BottomNavigation, BottomNavigationTab } from 'nativescript-bottom-navigation';

import log from '../logger';
import { memberApi } from '../apis';
import SimpleJoinScene from './SimpleJoinScene.vue';
import { Member } from '@/stores';
import DefaultButton from '@/components/DefaultButton.vue';

@Component({
  name: VUE_NAME
})
export default class MainCotainerScene extends Vue {

  @State(state => state.member)
  private member: Member;

  constructor() {
    super();
  }

  public get memberName(): string {
    if (!this.member) return '';
    return this.member.nick.ko;
  }

  public mounted() {
    log(`VUE_INIT: ${VUE_NAME}`);
    log(this.member.nick.en);
  }
}
</script>

<style scoped>
</style>