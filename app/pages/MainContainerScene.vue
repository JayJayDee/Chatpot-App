<template>
  <Page>
    <ActionBar title="메인" class="action-bar" />
    <FlexBoxLayout class="page">
      <Label text="호옹이" />
    </FlexBoxLayout>
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
import { Member } from '@/stores';

@Component({
  name: VUE_NAME
})
export default class MainCotainerScene extends Vue {

  @State(state => state.member)
  private member: Member;

  constructor() {
    super();
  }

  public mounted() {
    log(`VUE_INIT: ${VUE_NAME}`);
    log(`${this.member.nick.en}`);
  }
}
</script>

<style scoped>
</style>