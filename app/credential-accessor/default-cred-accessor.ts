import { Preferences } from 'nativescript-preferences';
import { LocalCredentialAccessor } from './types';

const TOKEN_KEY = 'CP_TOKEN';
const SECRET_KEY = 'CP_SECRET';
const SESSION_KEY = 'CP_SESSION';

const defaultCredentialAccessor =
  (prep: Preferences): LocalCredentialAccessor => ({
    getToken: () => prep.get(TOKEN_KEY),
    setToken: (token) => prep.set(TOKEN_KEY, token),

    getSecret: () => prep.get(SECRET_KEY),
    setSecret: (secret) => prep.set(SECRET_KEY, secret),

    getSessionKey: () => prep.get(SESSION_KEY),
    setSessionKey: (session) => prep.set(SESSION_KEY, session)
  });
export default defaultCredentialAccessor;