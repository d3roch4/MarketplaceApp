import 'package:domain/entities/employee.dart';

extension EmployeeJson on Employee {
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'type': type.index,
  };

  static Employee fromJson(Map<String, dynamic> json){
    var employee = Employee(
      userId: json['userId'],
      type: EmployeeType.values[json['type']],
    );
    return employee;
  }
}
