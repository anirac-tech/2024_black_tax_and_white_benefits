import 'package:black_tax_and_white_benefits/app/features/text_size/text_size_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Center(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: Text('General'),
                tiles: <SettingsTile>[
                  SettingsTile(
                    title: Text('Text size'),
                    trailing: Row(
                      children: [
                        TextSizeIconButton(increaseSize: false),
                        TextSizeIconButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}