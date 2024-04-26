import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_app/config/config.dart';

class RouterScreen extends ConsumerWidget {
  const RouterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider + Go Router'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          // Cerrar la pantalla actual con go_router
          // context.pop();

          // Cerrar la pantalla directamente desde la instancia de go_router
          ref.read(appRouterProvider).pop();
        },
      ),
    );
  }
}
