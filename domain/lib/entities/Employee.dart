import 'Entity.dart';
import 'User.dart';

class Employee extends Entity {
  User user;
  EmployeeType type;

  Employee({required this.user, required this.type});
}

enum EmployeeType { unknow, owner, seller, manager, stockist }
