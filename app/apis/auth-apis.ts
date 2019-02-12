import { RequestFunction, HttpMethod } from './types';
import { MemberCreateResp, MemberCreateReq, MemberAuthReq, MemberAuthRes } from './auth-api-types';
import { Auth } from '@/stores';
import { generateRefreshKey } from '@/utils';
import log from '@/logger';

const authApisBuilder = (request: RequestFunction) => ({

  requestSimpleJoin:
    async (req: MemberCreateReq): Promise<MemberCreateResp> => {
      const raw = await request({
        url: '/member',
        method: HttpMethod.POST,
        body: {
          region: req.region,
          language: req.language,
          gender: req.gender
        }
      });
      return {
        nick: raw.nick,
        token: raw.token,
        passphrase: raw.passphrase
      };
    },

  requestAuth:
    async (req: MemberAuthReq): Promise<MemberAuthRes> => {
      const raw = await request({
        url: '/auth',
        method: HttpMethod.POST,
        body: {
          login_id: req.token,
          password: req.password
        }
      });
      return {
        session_key: raw.session_key
      };
    },

  requestReauth:
    async (auth: Auth): Promise<MemberAuthRes> => {
      const refreshKey = generateRefreshKey(auth);
      const requestOpts = {
        url: '/auth/reauth',
        method: HttpMethod.POST,
        body: {
          token: auth.token
        },
        qs: {
          session_key: auth.sessionKey,
          refresh_key: refreshKey
        }
      };
      log('REAUTH PARAMS');
      log(requestOpts);
      const raw = await request(requestOpts);
      return {
        session_key: raw.session_key
      };
    }
});
export default authApisBuilder;