import 'package:domain/entities/address.dart';

import 'employee.dart';
import 'entity.dart';

class Store extends Entity {
  String name;
  List<Employee> employees = [];
  String marketplaceId;
  String emailToNotifications;
  Address address;

  Store(
      {required this.name,
      required this.marketplaceId,
      required this.emailToNotifications,
      required this.address,
      String? id,
      this.employees = const []}) {
    this.id = id;
  }
}
