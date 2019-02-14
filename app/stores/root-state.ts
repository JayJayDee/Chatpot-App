import { RootState } from './types';

const rootState: RootState = {
  tabIndex: 0,
  member: null,
  auth: null,
  loading: false,
  rooms: [],
  error: {
    code: null
  }
};
export default rootState;