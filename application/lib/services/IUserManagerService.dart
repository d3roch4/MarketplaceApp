import 'package:domain/entities/User.dart';

abstract class IUserManagerService {
  User currentUser();
}
