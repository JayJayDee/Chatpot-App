<template>
  <GridLayout columns="*" rows="*, auto">
    <StackLayout col="0" row="0" orientation="horizontal" class="title-bar">
      <Label class="h2" text="Public chats" />
    </StackLayout>
    <ScrollView col="0" row="1">
      <StackLayout>
        <StackLayout v-for="room in rooms" :key="room.room_token">
          <Label :text="room.title" class="h2" />
        </StackLayout>
      </StackLayout>
    </ScrollView>
  </GridLayout>
</template>

<script lang="ts">
const VUE_NAME = 'HomeScene';

import Vue from 'vue';
import '@/ext-vue';
import Component from 'vue-class-component';
import { State, Action } from 'vuex-class';
import { BottomBar, BottomBarItem } from 'nativescript-bottombar/vue';

import log from '../logger';
import { Room } from '@/stores/types';

type TestCard = {
  id: number;
  title: string;
  description: string;
};

@Component({
  name: VUE_NAME
})
export default class HomeScene extends Vue {

  @State('rooms')
  private rooms: Room[];

  @Action('refreshRooms')
  private refreshRooms: () => Promise<void>;

  private cards: TestCard[] = [
    {
      id: 1,
      title: 'Title1',
      description: 'title1 description'
    },
    {
      id: 2,
      title: 'Title2',
      description: 'title2 description'
    }
  ];

  public mounted() {
    log(`VIEW INIT: ${VUE_NAME}`);
    this.refreshRooms();
  }
}
</script>

<style scoped>
.scene-background {
  background-color: brown;
}
.title-bar {
  height: 50px;
}
</style>