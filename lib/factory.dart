import 'package:chatpot_app/storage/auth_accessor.dart';
import 'package:chatpot_app/storage/pref_auth_accessor.dart';

Map<String, dynamic> _instances;

void initFactory() {
  _instances = new Map<String, dynamic>();
  _instances['AuthAccessor'] = PrefAuthAccessor();
}

AuthAccessor authAccessor() => _instances['AuthAccessor'];