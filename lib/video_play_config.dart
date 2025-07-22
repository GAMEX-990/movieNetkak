import 'package:flutter/services.dart';
import 'dart:io';

class VideoPlayerConfig {
  static Future<void> configureAndroid() async {
    if (Platform.isAndroid) {
      try {
        await const MethodChannel('com.flutter.plugins/video_player_android')
            .invokeMethod<void>('setLegacyDecoderOnly', false);
      } catch (e) {
        print('Failed to configure video player: $e');
      }
    }
  }
}