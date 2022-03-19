import 'package:application/services/location_search_service.dart';
import 'package:domain/entities/address.dart';
import 'package:location/location.dart';

class LocationSearchServiceImpl extends LocationSearchService {
  Location location = Location();

  @override
  Future<Address?> findAdddressByZipCode(String zipCode) {
    // TODO: implement findAdddressByZipCode
    throw UnimplementedError();
  }

  @override
  Future<Address?> getCurrentAddress() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Address.empty;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied || _permissionGranted == PermissionStatus.deniedForever) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted || _permissionGranted != PermissionStatus.grantedLimited) {
        return Address.empty;
      }
    }

    var data = await location.getLocation();
    var address = Address.empty;
    address.latitude = data.latitude ?? -1;
    address.longitude = data.longitude ?? -1;
  }
}
