import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:mft_customer_side/common/config/global_translation.dart';

class AppDependencies {
  static Injector get injector => Injector();

  static Injector initialize(String rootFolder) {
    injector.map<GlobalTranslation>((injector) => GlobalTranslation(),
        isSingleton: true);
    return injector;
  }
}
