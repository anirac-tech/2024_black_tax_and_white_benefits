import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flavor.g.dart';

@Riverpod(keepAlive: true)
String? flavor(FlavorRef ref) => appFlavor;
