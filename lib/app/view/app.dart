import 'package:black_tax_and_white_benefits/app/data/post_client.dart';
import 'package:black_tax_and_white_benefits/app/view/post_cell.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(getPostsProvider);

    debugPrint(posts.valueOrNull?.map((e) => '${e.id}').toString());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Black Tax White Benefits')),
        body: Center(
          child: posts.when(
            data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final post = data[index];
                return PostCell(post);
              },
            ),
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text(error.toString()),
          ),
        ),
      ),
    );
  }
}
