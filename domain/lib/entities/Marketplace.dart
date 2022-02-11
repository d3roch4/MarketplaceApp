import 'Entity.dart';

class Marketplace extends Entity {
  String name;
  String? subDomain;
  List<String> domains = [];

  Marketplace({required this.name});
}
