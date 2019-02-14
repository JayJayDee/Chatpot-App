<template>
  <StackLayout class="p-20" backgroundColor="white">
    <Label text="Loading.." />
  </StackLayout>
</template>

<script lang="ts">
const VUE_NAME = 'LoadingDialog';

import Vue from 'vue';
import '@/ext-vue';
import Component from 'vue-class-component';

import log from '../logger';

@Component({
  name: VUE_NAME
})
export default class LoadingDialog extends Vue {

  public mounted() {
    log(`VIEW INIT: ${VUE_NAME}`);
  }
}
</script>

<style scoped>
</style>