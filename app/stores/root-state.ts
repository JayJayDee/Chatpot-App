import { RootState } from './types';

const rootState: RootState = {
  member: null,
  auth: null,
  loading: false,
  error: {
    code: null
  }
};
export default rootState;