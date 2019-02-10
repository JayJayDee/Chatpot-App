import { RequestFunction, HttpMethod } from './types';
import { MemberCreateResp, MemberCreateReq } from './member-api-types';

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
    }
});
export default memberApisBuilder;