import Vue from 'vue';

declare module 'vue/types/vue' {
  interface Vue {
    $navigateTo: (v: any, opts?: any) => void;
  }
}

declare module 'nativescript-vue' {
  export default interface Vue {
    registerElement: (name: string, registerer: () => any) => void;
  }
}