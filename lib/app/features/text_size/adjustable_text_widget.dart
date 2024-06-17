import 'package:black_tax_and_white_benefits/app/features/text_size/text_size_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdjustableTextWidget extends ConsumerWidget {
  const AdjustableTextWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double textSizeFactor = ref.watch(textSizeControllerProvider);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(textSizeFactor),
      ),
      child: child,
    );
  }
}
