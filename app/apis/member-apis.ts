import { RequestFunction, HttpMethod } from './types';
import { MemberCreateResp } from './member-api-types';

const memberApisBuilder = (request: RequestFunction) => ({

  requestSimpleJoin:
    async (region: string, language: string, gender: string): Promise<MemberCreateResp> => {
      const raw = await request({
        url: '/member',
        method: HttpMethod.POST,
        body: {
          region,
          language,
          gender
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