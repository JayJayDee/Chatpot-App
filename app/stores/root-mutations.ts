import { RootState } from './types';

const mutations = {
  splashLoading(state: RootState, loading: boolean) {
    state.scenes.splash.loading = loading;
  }
};
export default mutations;