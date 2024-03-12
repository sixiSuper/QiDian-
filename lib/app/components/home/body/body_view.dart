// ...
// 主体部分
// ...

import 'package:flutter/material.dart';
import '../../general/container/container.dart';

Widget body(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return container(
    context,
    height: size.height - 167,
  );
}
