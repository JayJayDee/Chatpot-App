import Vue from 'nativescript-vue';
import VueDevtools from 'nativescript-vue-devtools';

import SplashScene from './pages/SplashScene.vue';
import store from './stores';
import './app.css';

if (TNS_ENV !== 'production') {
  Vue.use(VueDevtools);
}
// Prints Vue logs when --env.production is *NOT* set while building
Vue.config.silent = (TNS_ENV === 'production');

new Vue({
  render: h => h('frame', [h(SplashScene)]),
  store
}).$start();