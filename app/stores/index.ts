import Vue from 'vue';
import Vuex from 'vuex';

import actions from './actions';
import mutations from './mutations';
import state from './state';

Vue.use(Vuex);

export default new Vuex.Store({
  state: state,
  mutations: mutations,
  actions: actions
});

export { RootState, Member, Auth } from './types';