import { RootState, InitializeState } from './types';

const mutations = {
  loading(state: RootState, loading: boolean) {
    state.loading = loading;
  },

  splashInitState(state: RootState, ins: InitializeState) {
    state.scenes.splash.state = ins;
  },

  emitError(state: RootState, code: string) {
    state.error = {
      code: code
    };
  },

  confirmError(state: RootState) {
    state.error = null;
  }
};
export default mutations;