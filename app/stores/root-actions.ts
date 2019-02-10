import { ActionContext } from 'vuex';

import { RootState, InitializeState } from './types';
import accessor from '../credential-accessor';
import { JoinSimpleParam } from './root-action-types';

const delayLittle = (sec: number) =>
  new Promise((resolve, reject) =>
    setTimeout(() => resolve(), sec * 1000));

const actions = {
  async initialize(store: ActionContext<RootState, any>): Promise<void> {
    store.commit('splashLoading', true);
    const token = accessor.getToken();
    await delayLittle(2);

    if (!token) {
      store.commit('splashInitState', InitializeState.NOT_LOGGED_IN);
      store.commit('splashLoading', false);
      return;
    }
  },

  async joinSimple(store: ActionContext<RootState, any>, param: JoinSimpleParam): Promise<void> {
    // TODO: simple-join actions.
  }
};
export default actions;