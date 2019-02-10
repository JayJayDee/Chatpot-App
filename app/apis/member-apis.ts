import { RequestFunction, HttpMethod } from './types';
import { MemberCreateResp, MemberCreateReq, MemberAuthReq, MemberAuthRes } from './member-api-types';
import { Auth } from '@/stores';
import { generateRefreshKey } from '@/utils';

const memberApisBuilder = (request: RequestFunction) => ({

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
          passphrase: req.password
        }
      });
      return {
        session_key: raw.session_key
      };
    },

  requestReauth:
    async (auth: Auth): Promise<MemberAuthRes> => {
      const refreshKey = generateRefreshKey(auth);
      const raw = await request({
        url: '/auth/reauth',
        method: HttpMethod.POST,
        body: {
          token: auth.token
        },
        qs: {
          session_key: auth.sessionKey,
          refresh_key: refreshKey
        }
      });
      return {
        session_key: raw.session_key
      };
    }
});
export default memberApisBuilder;