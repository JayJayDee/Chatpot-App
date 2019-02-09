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

        <Button
          text="Log in"
          class="btn btn-primary m-t-20"
          :disabled="loading"
          @onTap="onLogin">
        </Button>
      </StackLayout>

      <Label class="login-label sign-up-label">
        <FormattedString>
          <Span text="Don’t have an account?"></Span>
          <Span text="Sign up" class="bold"></Span>
        </FormattedString>
      </Label>
    </FlexboxLayout>
  </Page>
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

@Component({
  name: 'App'
})
export default class App extends Vue {
  private loading: boolean;

  constructor() {
    super();
    this.loading = false;
  }

  public onLogin() {
    this.loading = true;
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
