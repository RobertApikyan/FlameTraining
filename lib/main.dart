import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_training/dino_sprite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'enemy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setOrientation(DeviceOrientation.landscapeRight);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final game = DinoGame();

  @override
  Widget build(BuildContext context) => GameWidget(game: game);
}

class DinoGame extends FlameGame with HasTappableComponents {
  DinoSprite? _dinoSprite;

  @override
  Future<void>? onLoad() async {
    await addBackground();
    await add(_dinoSprite = DinoSprite());
    // await add(Enemy(EnemyData(
    //     size: Vector2(176, 80),
    //     speed: 200,
    //     srcSize: Vector2(84, 38),
    //     fileName: 'chameleon.png',
    //     from: 0,
    //     to: 7)));
    await add(Enemy(EnemyData(
        size: Vector2(80, 80),
        speed: 200,
        srcSize: Vector2(34, 44),
        fileName: 'bunny.png',
        from: 0,
        to: 8)));
  }

  Future<void> addBackground() async {
    // groundImage.
    final parallaxComponent = ParallaxComponent(
        parallax: Parallax([
      ParallaxLayer(
          ParallaxImage(await Flame.images.load('parallax/plx-1.png')),
          velocityMultiplier: Vector2(0.05, 1)),
      ParallaxLayer(
          ParallaxImage(await Flame.images.load('parallax/plx-1.png')),
          velocityMultiplier: Vector2(0.2, 1)),
      ParallaxLayer(
          ParallaxImage(await Flame.images.load('parallax/plx-2.png')),
          velocityMultiplier: Vector2(0.3, 1)),
      ParallaxLayer(
          ParallaxImage(await Flame.images.load('parallax/plx-2.png')),
          velocityMultiplier: Vector2(0.4, 1)),
      ParallaxLayer(
          ParallaxImage(await Flame.images.load('parallax/plx-3.png')),
          velocityMultiplier: Vector2(0.6, 1)),
      ParallaxLayer(
          ParallaxImage(await Flame.images.load('parallax/plx-4.png')),
          velocityMultiplier: Vector2(0.8, 1)),
      ParallaxLayer(
          ParallaxImage(await Flame.images.load('parallax/plx-5.png')),
          velocityMultiplier: Vector2(1, 1)),
      ParallaxLayer(
          ParallaxImage(await Flame.images.load('parallax/plx-6.png')),
          velocityMultiplier: Vector2(1, 1)),
    ], baseVelocity: Vector2(100, 0)));
    add(parallaxComponent);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    _dinoSprite?.jump();
  }
}
