import 'package:flutter/material.dart';
import 'package:mft_customer_side/common/config/global_translation.dart';
import 'package:mft_customer_side/dependencies.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  final GlobalTranslation translator =
      AppDependencies.injector.get<GlobalTranslation>();
}

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  final GlobalTranslation translator =
      AppDependencies.injector.get<GlobalTranslation>();
}
