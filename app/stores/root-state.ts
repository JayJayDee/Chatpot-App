import { RootState } from './types';

const rootState: RootState = {
  member: null,
  auth: null,
  scenes: {
    splash: {
      loading: false,
      state: null
    }
  },
  loading: false,
  error: {
    code: null
  }
};
export default rootState;