import 'package:black_tax_and_white_benefits/app/features/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({super.key});
  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => context.pushNamed(SettingsView.name),
        icon: const Icon(Icons.settings),
      );
}
