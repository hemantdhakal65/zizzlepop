import 'package:audioplayers/audioplayers.dart';
import 'package:zizzlepop/utils/logger.dart';

class SoundManager {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isInitialized = false;

  static Future<void> _initialize() async {
    if (!_isInitialized) {
      await _player.setReleaseMode(ReleaseMode.stop);
      _isInitialized = true;
    }
  }

  static Future<void> playAnswerSound(String soundPath, String category) async {
    await _initialize();
    try {
      // Try loading with various path formats
      await _tryPlay(soundPath);
    } catch (e) {
      Logger.error('Error playing $soundPath: $e');
      // Fallback to default sound
      await _tryPlay('sounds/effects/default.mp3');
    }
  }

  static Future<void> _tryPlay(String path) async {
    final pathsToTry = [
      path,
      'assets/$path',
      'assets/sounds/effects/default.mp3'
    ];

    for (final p in pathsToTry) {
      try {
        await _player.play(AssetSource(p));
        Logger.info('Playing sound: $p');
        return;
      } catch (e) {
        Logger.error('Failed to play $p: $e');
      }
    }
  }

  static Future<void> playCorrectSound() async {
    await _initialize();
    await _tryPlay('sounds/effects/correct.mp3');
  }

  static Future<void> playIncorrectSound() async {
    await _initialize();
    await _tryPlay('sounds/effects/incorrect.mp3');
  }

  static void dispose() {
    _player.dispose();
  }
}