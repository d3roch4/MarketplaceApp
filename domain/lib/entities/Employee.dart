import 'entity.dart';
import 'user.dart';

class Employee extends Entity {
  String userId;
  EmployeeType type;

  Employee({required this.userId, required this.type});
}

enum EmployeeType { unknow, owner, seller, manager, stockist }
