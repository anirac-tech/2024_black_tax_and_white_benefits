import 'package:black_tax_and_white_benefits/app/features/settings/wpa_settings_list.dart';
import 'package:black_tax_and_white_benefits/app/features/text_size/adjustable_text_widget.dart';
import 'package:black_tax_and_white_benefits/app/shared/wpa_app_bar.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  // Route information
  static const path = '/settings';
  static const name = 'settings';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: WpaAppBar(
          title: const Text('Settings'),
          surfaceTintColor: Colors.transparent,
        ),
        body: AdjustableTextWidget(
          child: Center(
            child: WpaSettingsList(),
          ),
        ),
      );
}
