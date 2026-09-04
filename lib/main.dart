import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app/presentation/flash_kids_theme.dart';

void main() {
  runApp(const ProviderScope(child: FlashKidsApp()));
}

final appRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [GoRoute(path: '/', builder: (context, state) => const HomePage())],
  ),
);

class FlashKidsApp extends ConsumerWidget {
  const FlashKidsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'FlashKids',
      theme: flashKidsTheme(),
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('FlashKids')));
  }
}
