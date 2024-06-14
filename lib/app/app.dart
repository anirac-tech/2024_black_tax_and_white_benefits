import 'package:black_tax_and_white_benefits/app/config/router.dart';
import 'package:black_tax_and_white_benefits/app/features/text_size/adjustable_text_widget.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => AdjustableTextWidget(
        child: MaterialApp.router(
          routerConfig: goRouter,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
        ),
      );
}
