import 'entity.dart';

class Marketplace extends Entity {
  String name;
  String userId;
  String? subDomain;
  List<String> domains = [];

  Marketplace({required this.name, required this.userId});
}
