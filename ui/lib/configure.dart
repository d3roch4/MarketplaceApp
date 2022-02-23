import 'package:application/application.dart';
import 'package:infra/infra.dart';

Future<void> configureApp() async {
  await Infra.useParse();
  Application.registerHandles();
}
