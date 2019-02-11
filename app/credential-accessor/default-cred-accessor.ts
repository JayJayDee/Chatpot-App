import { getItem, setItem } from 'nativescript-localstorage';
import { LocalCredentialAccessor } from './types';

const TOKEN_KEY = 'CP_TOKEN';
const SECRET_KEY = 'CP_SECRET';
const SESSION_KEY = 'CP_SESSION';

const defaultCredentialAccessor =
  (): LocalCredentialAccessor => ({
    getToken: () => getItem(TOKEN_KEY),
    setToken: (token) => setItem(TOKEN_KEY, token),

    getSecret: () => getItem(SECRET_KEY),
    setSecret: (secret) => setItem(SECRET_KEY, secret),

    getSessionKey: () => getItem(SESSION_KEY),
    setSessionKey: (session) => setItem(SESSION_KEY, session)
  });
export default defaultCredentialAccessor;