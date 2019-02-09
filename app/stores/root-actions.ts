import { ActionContext } from 'vuex';

import { RootState } from './types';
import accessor from '../credential-accessor';

const actions = {
  async initialize(store: ActionContext<RootState, any>): Promise<void> {
    const token = accessor.getToken();
    store.commit('splashLoading', true);
  }
};
export default actions;