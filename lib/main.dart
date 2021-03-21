import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flow_app/auth_repository.dart';
import 'package:flow_app/demo_page.dart';
import 'package:yeet/yeet.dart';

import 'auth_repository.dart';
import 'home_page.dart';
import 'login_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final yeetProvider = Provider<Yeet>((ref) {
  ref.watch(authRepositoryProvider);
  return Yeet(
    children: [
      Yeet(
        path: '/login',
        builder: (_, __) => LoginPage(),
        children: [
          Yeet(
            path: '/demo',
            builder: (_, __) => DemoPage(),
          ),
        ],
      ),
      Yeet(
        path: '/',
        builder: (_, __) => HomePage(),
      ),
    ],
  );
});

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final yeet = useProvider(yeetProvider);
    return MaterialApp.router(
      title: 'Flow',
      theme: ThemeData(),
      routeInformationParser: YeetInformationParser(),
      routerDelegate: YeeterDelegate(yeet: yeet, initialPath: '/login'),
    );
  }
}
