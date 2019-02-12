import { Auth } from '@/stores';
import { sha256 } from 'js-sha256';
import log from '@/logger';

export const generateRefreshKey = (auth: Auth): string => {
  const rawKey = `${auth.token}${auth.sessionKey}${auth.password}`;
  log(`PRE_GENERATE_REFRESH_KEY = ${rawKey}`);
  return sha256(rawKey);
};