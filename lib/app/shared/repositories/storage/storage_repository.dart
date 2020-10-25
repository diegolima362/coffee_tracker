import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/storage_repository_interface.dart';

part 'storage_repository.g.dart';

@Injectable()
class StorageRepository implements IStorageRepository {
  //dispose will be called automatically
  @override
  void dispose() {}
}
