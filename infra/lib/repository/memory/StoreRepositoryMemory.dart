import 'package:application/repository/StoreRepository.dart';
import 'package:domain/entities/Store.dart';
import 'package:infra/repository/memory/RepositoryBaseMemory.dart';

class StoreRepositoryMemory extends StoreRepository with RepositoryBaseMemory<Store>{}

// class StoreRepositoryMemory extends StoreRepository {
//   var wrapper = RepositoryBaseMemory<Store>();

//   @override
//   Future add(Store entity) {
//     return wrapper.add(entity);
//   }

//   @override
//   Future<Store?> getById(String id) {
//     return wrapper.getById(id);
//   }

//   @override
//   Future update(Store entity) {
//     return wrapper.update(entity);
//   }
// }
