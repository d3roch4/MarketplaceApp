import 'package:domain/entities/address.dart';

abstract class LocationSearchService {
  Future<Address?> findAdddressByZipCode(String zipCode);
  Future<Address?> getCurrentAddress();
}
