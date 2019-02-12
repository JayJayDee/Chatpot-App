export type Member = {
  nick: Nick;
  region: string;
  language: string;
  gender: 'M' | 'F';
  token: string;
};
export type Nick = {
  en: string;
  ko: string;
  ja: string;
};