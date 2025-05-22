import 'package:flutter/material.dart';

import 'App Constant/constant.dart';

void main() {
  runApp(
      MaterialApp(
          initialRoute: AppRoutes.ROUTE_HOME,
          routes: AppRoutes.getRoutes(),
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false));
}
