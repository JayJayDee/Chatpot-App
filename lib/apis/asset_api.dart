import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class AssetApi {
  Requester _requester;

  AssetApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<AssetUploadResp> uploadImage(File file, {
    UploadProgressCallback callback    
  }) async {
    Map<String, dynamic> resp = await _requester.upload(
      url: '/image/upload',
      method: HttpMethod.POST,
      file: file,
      progress: callback
    );
    return AssetUploadResp.fromJson(resp);
  }
}