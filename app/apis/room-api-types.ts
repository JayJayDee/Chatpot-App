import { Member } from './member-api-types';

export type Room = {
  room_token: string;
  owner: Member;
  title: string;
  num_attendee: number;
  max_attendee: number;
  reg_date: string;
};
export type ResRoomList = {
  all: number;
  size: number;
  list: Room[];
};