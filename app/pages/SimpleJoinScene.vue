<template>
  <Page>
    <ActionBar title="Start without sign-up" class="action-bar" />
    <FlexboxLayout class="page">
      <Label text="호옹이" />
      <Button
        text="Click to back"
        class="btn btn-primary"
        @onTap="$navigateBack" />
    </FlexboxLayout>
  </Page>
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';
import log from '../logger';

const VUE_NAME = 'SimpleJoinScene';

@Component({
  name: 'SimpleJoinScene'
})
export default class SimpleJoinScene extends Vue {

  constructor() {
    super();
  }

  public mounted() {
    log(`VUE_MOUNTED: ${VUE_NAME}`);
  }
}
</script>

<style scoped>
.page {
  align-items: center;
  flex-direction: column;
}
</style>