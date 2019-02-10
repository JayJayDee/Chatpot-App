<template>
  <Page>
    <ActionBar title="Start without sign-up" class="action-bar" />
    <FlexBoxLayout class="page">
      <StackLayout>
        <Label text="성별을 선택해 주세요." />
      </StackLayout>
      <GridLayout columns="auto, *" rows="auto, *">
        <Button
          row="0" col="0"
          text="Male"
          :isEnabled="!loading"
          class="btn btn-primary gender-button"
          @onTap="onSelectGender('M')" />
        <Button
          row="0" col="1"
          text="Female"
          :isEnabled="!loading"
          class="btn btn-primary gender-button"
          @onTap="onSelectGender('F')" />
      </GridLayout>
      <ActivityIndicator :busy="loading"></ActivityIndicator>
    </FlexBoxLayout>
  </Page>
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';
import { State, Action } from 'vuex-class';
import { device } from 'tns-core-modules/platform';

import log from '../logger';
import { JoinSimpleParam } from '@/stores/root-action-types';

const VUE_NAME = 'SimpleJoinScene';

@Component({
  name: 'SimpleJoinScene'
})
export default class SimpleJoinScene extends Vue {

  @State(state => state.loading)
  private loading: boolean;

  @Action('joinSimple')
  private joinSimple: (param: JoinSimpleParam) => Promise<void>;

  constructor() {
    super();
  }

  public mounted() {
    log(`VUE_MOUNTED: ${VUE_NAME}`);
    log(`DEVICE_INFO ${device.region} ${device.language}`);
  }

  public onSelectGender(gender: 'M' | 'F') {
    const param: JoinSimpleParam = {
      region: device.region,
      language: this.convertLocaleExpr(device.language),
      gender
    };
    this.joinSimple(param).then(() => {
      log('**DONE!');
    })
    .catch((err) => {
      log('**ERRROR');
      log(err.message);
    });
  }

  private convertLocaleExpr(locale: string) {
    if (locale.length > 2) {
      return locale.substring(0, 2);
    } else if (locale.length == 2) {
      return locale;
    }
    return null;
  }
}
</script>

<style scoped>
.page {
  align-items: center;
  flex-direction: column;
  padding: 10px;
}
.gender-button {
  font-size: 24;
  align-content: center;
  horizontal-align: middle;
}
</style>