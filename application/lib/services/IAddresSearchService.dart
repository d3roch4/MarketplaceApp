import 'package:domain/entities/Address.dart';

abstract class IAddresSearchService {
  Future<Address?> findByZipCode(String zipCode);
}
