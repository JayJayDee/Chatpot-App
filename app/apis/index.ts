import accessor from '../credential-accessor';
import { authorizedRequestBuilder, requestBuilder } from './request';
import authApiBuilder from './auth-apis';
import memberApiBuilder from './member-apis';
import roomApiBuilder from './room-apis';

const AUTH_SERVER_BASE = 'http://dev-auth.chatpot.chat';
const ROOM_SERVER_BASE = 'http://dev-room.chatpot.chat';

const memberReq = authorizedRequestBuilder(AUTH_SERVER_BASE, AUTH_SERVER_BASE, accessor);
const roomReq = authorizedRequestBuilder(ROOM_SERVER_BASE, AUTH_SERVER_BASE, accessor);
const authReq = requestBuilder(AUTH_SERVER_BASE);

export const memberApi = memberApiBuilder(memberReq);
export const roomApi = roomApiBuilder(roomReq);
export const authApi = authApiBuilder(authReq);

export { ApiRequestError } from './errors';