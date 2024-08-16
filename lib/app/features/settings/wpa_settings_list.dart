import 'package:black_tax_and_white_benefits/app/features/text_size/text_size_icon_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class WpaSettingsList extends StatelessWidget {
  const WpaSettingsList({super.key});

  @override
  Widget build(BuildContext context) => kIsWeb
      // coverage:ignore-start
      ? Column(
          children: [
            Card(
              margin: const EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Text size'),
                    ),
                    TextSizeIconButton(isIncrease: false),
                    TextSizeIconButton(),
                  ],
                ),
              ),
            ),
          ],
        )
      // coverage:ignore-end
      : SettingsList(
          sections: [
            SettingsSection(
              title: MediaQuery.withNoTextScaling(child: Text('General')),
              tiles: <SettingsTile>[
                SettingsTile(
                  title: Text('Text size'),
                  trailing: Row(
                    children: [
                      TextSizeIconButton(isIncrease: false),
                      TextSizeIconButton(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
}
