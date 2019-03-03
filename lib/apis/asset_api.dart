import 'dart:async';
import 'package:meta/meta.dart';
import 'package:chatpot_app/apis/requester.dart';

class AssetApi {
  Requester _requester;

  AssetApi({
    @required Requester requester
  }) {
    _requester =requester;
  }

  // TODO: image upload to be implemented.
}