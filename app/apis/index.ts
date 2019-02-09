import accessor from '../credential-accessor';
import memberApiBuilder from './member-apis';
import { authorizedRequestBuilder } from './request';

const AUTH_SERVER_BASE = 'http://dev-auth.chatpot.chat';
const ROOM_SERVER_BASE = 'http://dev-room.chatpot.chat';

const memberReq = authorizedRequestBuilder(AUTH_SERVER_BASE, accessor);

export const memberApi = memberApiBuilder(memberReq);
export { ApiRequestError } from './errors';