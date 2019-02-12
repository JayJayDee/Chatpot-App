import { RequestFunction, HttpMethod } from './types';
import { Member, Nick } from './member-api-types';

const memberApiBuilder = (request: RequestFunction) => ({

  async requestMember(token: string): Promise<Member> {
    const raw = await request({
      url: `/member/${token}`,
      method: HttpMethod.GET
    });
    return cvtMember(raw);
  }
});
export default memberApiBuilder;

const cvtNick = (raw: any): Nick => ({
  ja: raw.ja,
  ko: raw.ko,
  en: raw.en
});

const cvtMember = (raw: any): Member => ({
  region: raw.region,
  language: raw.language,
  nick: cvtNick(raw.nick),
  token: raw.token,
  gender: raw.gender
});