import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';
import 'package:chatpot_app/apis/api_entities.dart';

typedef UploadProgressCallback (int);

class AssetApi {
  Requester _requester;

  AssetApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<AssetUploadResp> requestImageUpload(File file, {
    UploadProgressCallback uploadCallback
  }) async {
    // TODO: upload required.
    return null;
  }
}