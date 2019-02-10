export type MemberCreateReq = {
  region: string;
  language: string;
  gender: 'M' | 'F';
};
export type MemberCreateResp = {
  nick: Nick;
  token: string;
  passphrase: string;
};
type Nick = {[key: string]: string};

export type MemberAuthReq = {
  token: string;
  password: string;
};
export type MemberAuthRes = {
  session_key: string;
};