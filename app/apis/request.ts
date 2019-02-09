import axios from 'axios';
import * as qs from 'querystring';
import { RequestFunction } from './types';

const requestBuilder = (baseUrl: string): RequestFunction =>
  async (opts) => {
    const mergedUrl = `${baseUrl}${opts.url}`;
    const resp: any = await axios({
      method: opts.method,
      url: mergedUrl
    });
  };
export default requestBuilder;