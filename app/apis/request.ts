import axios, { AxiosResponse } from 'axios';

import { LocalCredentialAccessor } from '../credential-accessor';
import { RequestFunction } from './types';
import { ApiRequestError, ApiServerDenied, ApiSessionExpired } from './errors';

export const requestBuilder = (baseUrl: string): RequestFunction =>
  async (opts) => {
    const mergedUrl = `${baseUrl}${opts.url}`;
    let resp: AxiosResponse = null;

    try {
      resp = await axios({
        method: opts.method,
        url: mergedUrl,
        params: opts.qs,
        data: opts.body
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
  (baseUrl: string, credAccessor: LocalCredentialAccessor): RequestFunction =>
  async (opts) => {
    const request = requestBuilder(baseUrl);
    let resp: AxiosResponse = null;

    try {
      resp = await request(opts);
      return resp.data;
    } catch (err) {
      if (err instanceof ApiSessionExpired) {
        const token = credAccessor.getToken();
        const secret = credAccessor.getSecret();
        const sessionKey = credAccessor.getSessionKey();
        // TODO: make revalidate token & request again.
      } else {
        throw err;
      }
    }
  };