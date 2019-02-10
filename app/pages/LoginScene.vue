<template>
  <Page actionBarHidden="true">
    <FlexboxLayout class="page">
      <StackLayout class="form">
        <Image class="logo" src="~/assets/images/chatpot-logo.png"></Image>
        <Label class="header" text="Chatpot"></Label>

        <GridLayout rows="auto, auto, auto">
          <StackLayout row="0" class="input-field">
            <TextField class="input" hint="Email"
              keyboardType="email" autocorrect="false"
              autocapitalizationType="none"
              returnKeyType="next"></TextField>
            <StackLayout class="hr-light"></StackLayout>
          </StackLayout>

          <StackLayout row="1" class="input-field">
            <TextField class="input" ref="password"
              hint="Password" secure="true"></TextField>
            <StackLayout class="hr-light"></StackLayout>
          </StackLayout>

          <ActivityIndicator rowSpan="2" :busy="loading"></ActivityIndicator>
        </GridLayout>

        <StackLayout>
          <Button
            text="Sign in"
            class="btn btn-primary m-t-20"
            :disabled="loading"
            @onTap="onLogin">
          </Button>

          <Button
            text="Start without sign-up"
            class="btn btn-primary"
            @onTap="onSimpleJoinClicked">
          </Button>
        </StackLayout>
        
      </StackLayout>

      <Label class="login-label sign-up-label">
        <FormattedString>
          <Span text="Don’t have an account? "></Span>
          <Span text="Sign up" class="bold"></Span>
        </FormattedString>
      </Label>
    </FlexboxLayout>
  </Page>
</template>

<script lang="ts">
const VUE_NAME = 'LoginScene';

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
export default class LoginScene extends Vue {

  @State(state => state.loading)
  private loading: boolean;

  constructor() {
    super();
  }

  public mounted() {
    log(`VUE_INIT: ${VUE_NAME}`);
  }

  public onSimpleJoinClicked() {
    this.$navigateTo(SimpleJoinScene);
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

.input-field {
  margin-bottom: 25;
}

.input {
  font-size: 18;
  placeholder-color: #A8A8A8;
}

.input:disabled {
  background-color: white;
  opacity: 0.5;
}

.btn-primary {
  margin: 30 5 15 5;
}

.login-label {
  horizontal-align: center;
  color: #A8A8A8;
  font-size: 16;
}

.sign-up-label {
  margin-bottom: 20;
}

.bold {
  color: #000000;
}
</style>