import 'package:tech_news/net/GitHub.dart';

abstract class Service {
  final GitHub gitHub;

  const Service(this.gitHub);
}