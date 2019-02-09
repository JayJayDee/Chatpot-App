export type LocalCredentialAccessor = {
  getToken: () => string;
  setToken: (token: string) => void;
  getSecret: () => string;
  setSecret: (secret: string) => void;
  getSessionKey: () => string;
  setSessionKey: (session: string) => void;
};