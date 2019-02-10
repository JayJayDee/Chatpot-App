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