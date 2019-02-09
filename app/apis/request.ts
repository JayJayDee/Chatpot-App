import { RequestFunction } from './types';

const requestBuilder = (baseUrl: string): RequestFunction =>
  async (opts) => {
    const mergedUrl = `${baseUrl}${opts.url}`;
  };
export default requestBuilder;