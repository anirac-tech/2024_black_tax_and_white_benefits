import 'package:black_tax_and_white_benefits/app/features/text_size/text_size_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextSizeIconButton extends ConsumerWidget {
  const TextSizeIconButton({
    super.key,
    this.increaseSize = true,
  });

  final bool increaseSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textSize = ref.watch(textSizeControllerProvider);
    final enabled = (increaseSize && textSize < 2) || (!increaseSize && textSize > 0.8);

    return IconButton(
      onPressed: enabled
          ? increaseSize
              ? ref.read(textSizeControllerProvider.notifier).increase
              : ref.read(textSizeControllerProvider.notifier).decrease
          : null,
      icon: Icon(
        increaseSize ? Icons.text_increase_rounded : Icons.text_decrease_rounded,
        size: 32,
      ),
    );
  }
}
