import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mocktail/mocktail.dart';

part 'url_launcher.g.dart';

class MockUrlLauncher extends _$UrlLauncher with Mock implements UrlLauncher {}

@riverpod
class UrlLauncher extends _$UrlLauncher {
  @override
  FutureOr<void> build() => const AsyncData(null);

  Future<void> launch(String? url) async {
    if (url == null) return;

    state = AsyncValue<void>.loading();

    final Uri _url = Uri.parse(url);
    state = await AsyncValue.guard(() async {
      if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
        // coverage:ignore-line
        throw Exception('Could not launch $_url');
      }
    });
  }
}
