import { RootState } from './types';

const rootState: RootState = {
  member: null,
  auth: null,
  loading: false,
  rooms: [],
  error: {
    code: null
  }
};
export default rootState;