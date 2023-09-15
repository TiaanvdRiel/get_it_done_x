import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/utils/keys.dart';

class StorageService extends GetxService {
  late GetStorage _storage;

  Future<StorageService> init() async {
    _storage = GetStorage();
    await _storage.writeIfNull(todoListKey, []);
    return this;
  }

  T read<T>(String key) {
    return _storage.read(key);
  }

  void write(String key, dynamic value) async {
    await _storage.write(key, value);
  }
}
