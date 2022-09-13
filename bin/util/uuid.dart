import 'package:uuid/uuid.dart';

class UuidGenerator {
  static final _uuid = Uuid();
  static String newUuid() {
    return _uuid.v4().toString();
  }
}