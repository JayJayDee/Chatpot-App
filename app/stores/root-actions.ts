import { ActionContext } from 'vuex';

import { RootState, InitializeState, Auth } from './types';
import accessor from '../credential-accessor';
import log from '../logger';
import { JoinSimpleParam } from './root-action-types';
import { authApi } from '@/apis';
import { Preferences } from 'nativescript-preferences';

const delayLittle = (sec: number) =>
  new Promise((resolve, reject) =>
    setTimeout(() => resolve(), sec * 1000));

const actions = {
  async initialize(store: ActionContext<RootState, any>): Promise<InitializeState> {
    store.commit('loading', true);
    const token = accessor.getToken();
    await delayLittle(1);

    log(`STORED_TOKEN = ${token}`);
    const t = new Preferences().get('CP_TOKEN');
    log(`STORED_TOKEN2 = ${token}`);

    if (!token) {
      store.commit('loading', false);
      return InitializeState.NOT_LOGGED_IN;
    }

    const auth: Auth = {
      token,
      password: accessor.getSecret(),
      sessionKey: accessor.getSessionKey()
    };
    store.commit('updateAuth', auth);

    const refreshResp = await authApi.requestReauth(auth);
    log(refreshResp);

    // TODO: call member-fetching api.

    store.commit('loading', false);
    return InitializeState.AUTH_COMPLETE;
  },

  async joinSimple(store: ActionContext<RootState, any>, param: JoinSimpleParam): Promise<void> {
    // TODO: simple-join actions.
    store.commit('loading', true);

    // STEP1. call simple-join api.
    const resp = await authApi.requestSimpleJoin(param);
    accessor.setToken(resp.token);
    accessor.setSecret(resp.passphrase);

    new Preferences().set('CP_TOKEN', resp.token);
    log(`GOT TOKEN = ${resp.token}`);
    log(`GOT PASS = ${resp.passphrase}`);

    // STEP2. call auth-api.
    const authResp = await authApi.requestAuth({
      token: resp.token,
      password: resp.passphrase
    });
    accessor.setSessionKey(authResp.session_key);
    store.commit('loading', false);

    // STEP3. call member-fetching api.
  }
};
export default actions;