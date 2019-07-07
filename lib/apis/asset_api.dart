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

  Future<List<MyAssetResp>> getMyMemes({
    @required String memberToken
  }) async {
    List<dynamic> list = await _requester.requestWithAuth(
      url: "/meme/$memberToken/memes",
      method: HttpMethod.GET,
    );
    List<MyAssetResp> images = list.map((elem) => MyAssetResp.fromJson(elem)).toList();
    return images;
  }
}