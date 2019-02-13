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

  @State(state => state.member)
  private member: Member;

  @Action('refreshRooms')
  private refreshRooms: () => Promise<void>;

  constructor() {
    super();
  }

  public get memberName(): string {
    if (!this.member) return '';
    return this.member.nick.ko;
  }

  public tabSelected(event) {
    console.log(event);
  }

  public mounted() {
    log(`VUE_INIT: ${VUE_NAME}`);
    log(this.member.nick.en);

    this.refreshRooms().then(() => {
      log('ROOMS OK!');
    })
    .catch((err) => {
      log(`err.message`);
    });
  }
}
</script>

<style scoped>
</style>