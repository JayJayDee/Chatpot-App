import { Auth } from '@/stores';
import { sha256 } from 'js-sha256';

export const generateRefreshKey = (auth: Auth): string => {
  const rawKey = `${auth.token}${auth.sessionKey}${auth.password}`;
  return sha256(rawKey);
};