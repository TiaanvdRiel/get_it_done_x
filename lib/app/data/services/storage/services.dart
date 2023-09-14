import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/utils/keys.dart';

class StorageService extends GetxService {
  late GetStorage _storage;

  // Will check if we already have data stored in our local storage
  // with the key that we defined, if not write empty list to local storage
  Future<StorageService> init() async {
    _storage = GetStorage();
    await _storage.writeIfNull(taskKey, []);
    return this;
  }

  T read<T>(String key) {
    return _storage.read(key);
  }

  void write(String key, dynamic value) async {
    await _storage.write(key, value);
  }
}
