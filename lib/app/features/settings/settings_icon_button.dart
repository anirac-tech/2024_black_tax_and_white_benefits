import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({super.key});
  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => context.pushNamed('settings'),
        icon: const Icon(Icons.settings),
      );
}
