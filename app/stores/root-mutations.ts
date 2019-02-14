import { RootState, InitializeState, Auth, Member } from './types';
import { Room } from '@/stores/types';

const mutations = {
  tabIndex(state: RootState, tabIdx: number) {
    state.tabIndex = tabIdx;
  },
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
  },
  addRooms(state: RootState, rooms: Room[]) {
    state.rooms = state.rooms.concat(rooms);
  },
  clearRooms(state: RootState) {
    state.rooms = [];
  }
};
export default mutations;