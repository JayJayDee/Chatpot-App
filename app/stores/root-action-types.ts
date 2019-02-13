export type JoinSimpleParam = {
  language: string;
  region: string;
  gender: 'M' | 'F';
};
export type RoomsQueryParam = {
  offset?: number;
  size?: number;
};