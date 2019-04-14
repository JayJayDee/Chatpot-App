import 'dart:async';
import 'package:meta/meta.dart';

class Translated {
  final String translated;
  final String key;

  Translated({
    this.translated,
    this.key
  });
}

abstract class TranslationCacheAccessor {
  Future<void> cacheTranslations({
    @required String roomToken,
    @required List<Translated> translated
  });

  Future<void> cacheRoomTitleTranslations({
    @required List<Translated> translated
  });

  Future<List<Translated>> getCachedTranslations({
    @required String roomToken,
    @required List<String> keys
  });

  Future<List<Translated>> getCachedRoomTitleTranslations({
    @required List<String> keys
  });
}