import { ActionContext } from 'vuex';

import { RootState, InitializeState, Auth } from './types';
import accessor from '../credential-accessor';
import log from '../logger';
import { JoinSimpleParam } from './root-action-types';
import { authApi, memberApi, roomApi } from '@/apis';
import { Preferences } from 'nativescript-preferences';

const delayLittle = (sec: number) =>
  new Promise((resolve, reject) =>
    setTimeout(() => resolve(), sec * 1000));

const actions = {
  async initialize(store: ActionContext<RootState, any>): Promise<InitializeState> {
    store.commit('loading', true);
    const token = accessor.getToken();
    await delayLittle(1);

    if (!token) {
      store.commit('loading', false);
      return InitializeState.NOT_LOGGED_IN;
    }

    log(`STORED_TOKEN = ${accessor.getToken()}`);
    log(`STORED_SECRET = ${accessor.getSecret()}`);
    log(`STORED_SESSION = ${accessor.getSessionKey()}`);

    const auth: Auth = {
      token,
      password: accessor.getSecret(),
      sessionKey: accessor.getSessionKey()
    };
    store.commit('updateAuth', auth);

    try {
      const refreshResp = await authApi.requestReauth(auth);
      auth.sessionKey = refreshResp.session_key;
      accessor.setSessionKey(refreshResp.session_key);

      const member = await memberApi.requestMember(token);

      store.commit('updateAuth', auth);
      store.commit('updateMember', member);
    } catch (err) {
      // TODO: error handling required.
      log('*** FAIL');
      log(err.message);
    }

    // TODO: when error occured, must fixed not to be returns COMPLETE.

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

    log(`GOT TOKEN = ${resp.token}`);
    log(`GOT PASS = ${resp.passphrase}`);

    // STEP2. call auth-api.
    const authResp = await authApi.requestAuth({
      token: resp.token,
      password: resp.passphrase
    });
    log(`GOT SESSION_KEY = ${authResp.session_key}`);

    accessor.setSessionKey(authResp.session_key);
    store.commit('loading', false);

    // STEP3. call member-fetching api.
  },

  async refreshRooms(store: ActionContext<RootState, any>): Promise<void> {
    store.commit('loading', true);
    store.commit('clearRooms');
    const roomsResp = await roomApi.requestRoomList();
    store.commit('addRooms', roomsResp.list);
    store.commit('loading', false);
  }
};
export default actions;