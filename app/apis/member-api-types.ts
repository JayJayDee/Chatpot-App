export type MemberCreateResp = {
  nick: Nick;
  token: string;
  passphrase: string;
};
type Nick = {[key: string]: string};