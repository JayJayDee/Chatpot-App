declare module 'vue/types' {
  export interface Vue {
    $navigateTo: (vue: any) => void;
  }
}