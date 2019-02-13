import { RequestFunction, HttpMethod } from './types';
import { ResRoomList } from './room-api-types';

const roomApiBuilder = (request: RequestFunction) => ({

  requestRoomList: async (): Promise<ResRoomList> => {
    const raw = await request({
      url: '/rooms',
      method: HttpMethod.GET
    });
    return {
      all: raw.all,
      size: raw.size,
      list: raw.list
    };
  }

});
export default roomApiBuilder;