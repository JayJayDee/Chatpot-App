import Vue from 'vue';
import Vuex from 'vuex';

import rootActions from './root-actions';
import rootMutations from './root-mutations';
import rootState from './root-state';

Vue.use(Vuex);

export default new Vuex.Store({
  state: rootState,
  mutations: rootMutations,
  actions: rootActions
});

export { RootState, Member, Auth } from './types';