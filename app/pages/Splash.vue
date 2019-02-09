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
import Vue from 'vue';
import Component from 'vue-class-component';

@Component({
  name: 'Splash'
})
export default class Splash extends Vue {
  private loading: boolean;

  constructor() {
    super();
    this.loading = true;
  }

  public mounted() {
    console.log('mounted!');
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