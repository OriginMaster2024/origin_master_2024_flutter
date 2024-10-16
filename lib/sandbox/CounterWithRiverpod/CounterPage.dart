import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/sandbox/CounterWithRiverpod/Counter.dart';

class CounterPage extends HookConsumerWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod counter example'),
      ),
      body: Center(
        // HookConsumer is a builder widget that allows you to read providers and utilise hooks.
        child: HookConsumer(
          builder: (context, ref, _) {
            final count = ref.watch(counterProvider);

            return Text(
              '$count',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}