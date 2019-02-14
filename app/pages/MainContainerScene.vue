<template>
  <Page>
    <GridLayout columns="*" rows="*, auto">
      <StackLayout>
        <Label :text="memberName" />
      </StackLayout>
      <BottomBar row="1"
        v-on:tabSelected="tabSelected">
        <BottomBarItem
          icon="res://ic_home_outline" 
          title="Home 1"
          checkedIcon="res://ic_home_filled">
        </BottomBarItem>
        <BottomBarItem
          icon="res://ic_home_outline" 
          title="Home 2"
          checkedIcon="res://ic_home_filled">
        </BottomBarItem>
        <BottomBarItem
          icon="res://ic_home_outline" 
          title="Home 3"
          checkedIcon="res://ic_home_filled">
        </BottomBarItem>
      </BottomBar>
    </GridLayout>
  </Page>
</template>

<script lang="ts">
const VUE_NAME = 'MainContainerScene';

import Vue from 'vue';
import '@/ext-vue';
import Component from 'vue-class-component';
import { State, Action } from 'vuex-class';
import { BottomBar, BottomBarItem } from 'nativescript-bottombar/vue';

import log from '../logger';
import { memberApi } from '../apis';
import SimpleJoinScene from './SimpleJoinScene.vue';
import { Member } from '@/stores';
import DefaultButton from '@/components/DefaultButton.vue';

@Component({
  name: VUE_NAME,
  components: {
    BottomBar, BottomBarItem
  }
})
export default class MainContainerScene extends Vue {

  @State('tabIndex')
  private tabIndex;

  @Action('changeTab')
  private changeTab: (tabIdx: number) => Promise<void>;

  private subPages: Vue[];

  constructor() {
    super();
  }

  public tabSelected(event) {
    const selectedIdx = event.object.selectedIndex;
    this.changeTab(selectedIdx);
  }
}
</script>

<style scoped>
</style>