import { RootState, InitializeState } from './types';

const mutations = {
  splashLoading(state: RootState, loading: boolean) {
    state.scenes.splash.loading = loading;
  },

  splashInitState(state: RootState, ins: InitializeState) {
    state.scenes.splash.state = ins;
  },
};
export default mutations;