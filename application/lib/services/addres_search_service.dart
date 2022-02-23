import 'package:domain/entities/Address.dart';

abstract class AddresSearchService {
  Future<Address?> findByZipCode(String zipCode);
}
