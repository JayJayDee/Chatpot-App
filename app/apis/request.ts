import axios, { AxiosResponse } from 'axios';
import { stringify } from 'qs';

import { LocalCredentialAccessor } from '../credential-accessor';
import { RequestFunction, HttpMethod } from './types';
import { ApiRequestError, ApiServerDenied, ApiSessionExpired } from './errors';
import { Auth } from '@/stores';
import { generateRefreshKey } from '@/utils';

export const requestBuilder = (baseUrl: string): RequestFunction =>
  async (opts) => {
    const mergedUrl = `${baseUrl}${opts.url}`;
    let resp: AxiosResponse = null;
    try {
      resp = await axios({
        method: opts.method,
        url: mergedUrl,
        params: opts.qs,
        data: stringify(opts.body),
        responseType: 'json'
      });
      if (!resp.data) throw new ApiRequestError('error when api request');
      return resp.data;
    } catch (err) {
      if (err.response.status && err.response.status === 400) {
        throw new ApiServerDenied(err.response.code);
      }

      if (err.response.status && err.response.status === 401 &&
            err.response.code === 'SESSION_EXPIRED') {
        throw new ApiSessionExpired(err.response.code);
      }
    }
  };

export const authorizedRequestBuilder =
  (baseUrl: string, authBaseUrl: string, credAccessor: LocalCredentialAccessor): RequestFunction =>
  async (opts) => {
    const request = requestBuilder(baseUrl);
    let resp: AxiosResponse = null;

    try {
      resp = await request(opts);
      return resp;
    } catch (err) {
      if (err instanceof ApiSessionExpired) {
        const token = credAccessor.getToken();
        const password = credAccessor.getSecret();
        const sessionKey = credAccessor.getSessionKey();

        const auth: Auth = { token, password, sessionKey };
        const refreshKey = generateRefreshKey(auth);

        const reauthResp = await request({
          url: `${authBaseUrl}/auth/reauth`,
          method: HttpMethod.POST,
          qs: {
            session_key: auth.sessionKey,
            refresh_key: refreshKey
          },
          body: {
            token: auth.token
          }
        });
        console.log(reauthResp);

      } else {
        throw err;
      }
    }
  };