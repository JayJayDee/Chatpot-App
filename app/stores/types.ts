export type RootState = {
  error: null | ErrorPayload;
  member: null | Member;
  auth: null | Auth;
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

export type ScenesState = {
  splash: SplashState;
};

export enum InitializeState {
  NOT_LOGGED_IN,
  AUTH_COMPLETE
}
export type SplashState = {
  loading: boolean;
  state: InitializeState;
};