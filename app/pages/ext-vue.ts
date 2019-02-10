import Vue from 'vue';

declare module 'vue/types/vue' {
  interface Vue {
    $navigateTo: (v: any, opts?: any) => void;
  }
}