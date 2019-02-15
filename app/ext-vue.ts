import Vue from 'vue';

declare module 'vue/types/vue' {
  interface Vue {
    $navigateTo: (v: any, opts?: any) => void;
    $showModal: (v: any, opts?: any) => void;
  }
}

declare module 'nativescript-vue' {
  export default interface NativeScriptVue {
    registerElement: (name: string, registerer: () => any) => void;
  }
}