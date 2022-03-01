import 'employee.dart';
import 'entity.dart';

class Store extends Entity {
  String name;
  List<Employee> employees = [];
  String marketplaceId;
  String emailToNotifications;

  Store({
      required this.name,
      required this.marketplaceId,
      required this.emailToNotifications,
      String? id,
      this.employees = const []}) {
    this.id = id;
  }
}
