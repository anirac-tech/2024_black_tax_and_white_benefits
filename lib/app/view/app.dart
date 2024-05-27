import 'package:black_tax_and_white_benefits/app/data/post_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app.g.dart';

@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hello world';
}

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = useState(0);

    final value = ref.watch(helloWorldProvider);
    final posts = ref.watch(getPostsProvider);

    debugPrint(posts.valueOrNull?.map((e) => '${e.id}').toString());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Black Tax White Benefits')),
        body: Center(
          child: Column(
            children: [
              Text('$value ${counter.value}'),
              if (posts.hasValue)
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.value!.length,
                    itemBuilder: (context, index) {
                      final post = posts.value![index];
                      return ListTile(
                        title: Text(post.title.rendered),
                        subtitle: Text(post.excerpt?.rendered ?? ''),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.value++,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
