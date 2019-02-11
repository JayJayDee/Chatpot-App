import { RootState, InitializeState, Auth, Member } from './types';

const mutations = {
  loading(state: RootState, loading: boolean) {
    state.loading = loading;
  },
  emitError(state: RootState, code: string) {
    state.error = {
      code: code
    };
  },
  confirmError(state: RootState) {
    state.error = null;
  },

  updateAuth(state: RootState, auth: Auth) {
    state.auth = auth;
  },
  updateMember(state: RootState, member: Member) {
    state.member = member;
  }
};
export default mutations;