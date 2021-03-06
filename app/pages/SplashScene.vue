<template>
  <Page actionBarHidden="true">
    <FlexboxLayout class="page">
      <StackLayout class="form">
        <Image class="logo" src="~/assets/images/chatpot-logo.png"></Image>
        <Label class="header" text="Chatpot"></Label>
        <ActivityIndicator :busy="loading"></ActivityIndicator>
      </StackLayout>
    </FlexboxLayout>
  </Page>
</template>

<script lang="ts">
const VUE_NAME = 'SplashScene';

import Vue from 'vue';
import '@/ext-vue';

import Component from 'vue-class-component';
import { State, Action } from 'vuex-class';

import log from '../logger';
import { SplashState, InitializeState } from '../stores/types';

import LoginScene from './LoginScene.vue';
import MainContainerScene from './MainContainerScene.vue';

@Component({
  name: VUE_NAME
})
export default class SplashScene extends Vue {

  @State(state => state.loading)
  private loading: boolean;

  @State(state => state.scenes.splash.state)
  private state: InitializeState;

  @Action('initialize')
  private initialize: () => Promise<InitializeState>;

  constructor() {
    super();
  }

  public mounted() {
    this.initialize().then((state) => {
      log(`APP STATE = ${state}`);
      if (state === InitializeState.NOT_LOGGED_IN) {
        this.$navigateTo(LoginScene, {
          clearHistory: true
        });
      } else if (state === InitializeState.AUTH_COMPLETE) {
        this.$navigateTo(MainContainerScene, {
          clearHistory: true
        });
      }
    });
  }
}
</script>

<style scoped>
.page {
  align-items: center;
  flex-direction: column;
}
.form {
  margin-left: 30;
  margin-right: 30;
  flex-grow: 2;
  vertical-align: middle;
}
.logo {
  margin-bottom: 12;
  height: 90;
  font-weight: bold;
}
.header {
  horizontal-align: center;
  font-size: 25;
  font-weight: 600;
  margin-bottom: 70;
  text-align: center;
  color: #D51A1A;
}
</style>