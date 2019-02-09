export enum HttpMethod {
  POST = 'post',
  GET = 'get'
}
export type Param = {[key: string]: any};
export type RequestOpts = {
  url: string,
  method: HttpMethod,
  qs?: Param,
  body?: Param
};
export type RequestFunction = (opts: RequestOpts) => Promise<any>;