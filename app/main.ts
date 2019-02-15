import Vue, { registerElement } from 'nativescript-vue';
import './ext-vue';
import VueDevtools from 'nativescript-vue-devtools';

import SplashScene from './pages/SplashScene.vue';
import store from './stores';

import 'nativescript-theme-core/css/core.light.css';
import './app.css';

require('nativescript-bottombar/vue').register(Vue);
registerElement('CardView', () => require('nativescript-cardview').CardView);

if (TNS_ENV !== 'production') {
  Vue.use(VueDevtools);
}
// Prints Vue logs when --env.production is *NOT* set while building
Vue.config.silent = (TNS_ENV === 'production');

new Vue({
  render: h => h('frame', [h(SplashScene)]),
  store
}).$start();