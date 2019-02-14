export type RootState = {
  tabIndex: number;
  error: null | ErrorPayload;
  member: null | Member;
  auth: null | Auth;
  rooms: Room[];
  loading: boolean;
};

export type ErrorPayload = {
  code: string;
};

export type Member = {
  nick: Nick;
  region: string;
  language: string;
  gender: 'M' | 'F';
  token: string;
};

export type Nick = {[locale: string]: string};

export type Auth = {
  token: string;
  password: string;
  sessionKey: string;
};

export type Room = {
  room_token: string;
  owner: Member;
  title: string;
  num_attendee: number;
  max_attendee: number;
  reg_date: string;
};

export enum InitializeState {
  NOT_LOGGED_IN,
  AUTH_COMPLETE
}
export type SplashState = {
  loading: boolean;
  state: InitializeState;
};