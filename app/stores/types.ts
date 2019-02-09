export type RootState = {
  member: null | Member;
  auth: null | Auth;
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