import { ActionContext } from 'vuex';

import { RootState, InitializeState, Auth } from './types';
import accessor from '../credential-accessor';
import { JoinSimpleParam } from './root-action-types';
import { memberApi } from '@/apis';

const delayLittle = (sec: number) =>
  new Promise((resolve, reject) =>
    setTimeout(() => resolve(), sec * 1000));

const actions = {
  async initialize(store: ActionContext<RootState, any>): Promise<void> {
    store.commit('loading', true);
    const token = accessor.getToken();
    await delayLittle(1);

    if (!token) {
      store.commit('splashInitState', InitializeState.NOT_LOGGED_IN);
      store.commit('loading', false);
      return;
    }

    const auth: Auth = {
      token,
      password: accessor.getSecret(),
      sessionKey: accessor.getSessionKey()
    };
    store.commit('updateAuth', auth);

    // TODO: call session-key referesh api.
    // TODO: call member-fetching api.

    store.commit('loading', false);
    store.commit('splashInitState', InitializeState.AUTH_COMPLETE);
  },

  async joinSimple(store: ActionContext<RootState, any>, param: JoinSimpleParam): Promise<void> {
    // TODO: simple-join actions.
    store.commit('loading', true);

    // STEP1. call simple-join api.
    const resp = await memberApi.requestSimpleJoin(param);
    accessor.setToken(resp.token);
    accessor.setSecret(resp.passphrase);

    // STEP2. call auth-api.
    const authResp = await memberApi.requestAuth({
      token: resp.token,
      password: resp.passphrase
    });
    accessor.setSessionKey(authResp.session_key);
    store.commit('loading', false);

    // STEP3. call member-fetching api.
  }
};
export default actions;