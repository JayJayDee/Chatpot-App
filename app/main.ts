import Vue from 'nativescript-vue';
import VueDevtools from 'nativescript-vue-devtools';
import Vuex from 'vuex';

import App from './components/App.vue';
import Splash from './pages/Splash.vue';

import './app.css';

if (TNS_ENV !== 'production') {
  Vue.use(VueDevtools);
}
// Prints Vue logs when --env.production is *NOT* set while building
Vue.config.silent = (TNS_ENV === 'production');

new Vue({
  render: h => h('frame', [h(Splash)])
}).$start();