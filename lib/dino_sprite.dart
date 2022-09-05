import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'constants.dart';

class DinoSprite extends SpriteAnimationComponent {
  /*
    * 0 - 3 idle
    * 4 - 10 run
    * 11 - 13 kick
    * 14 - 16 hit
    * 17 - 23 sprint
    * */
  SpriteAnimation? _runAnimation;
  SpriteAnimation? _hitAnimation;
  double _speedY = 0.0;
  double _yGround = 0.0;
  Vector2 _screenSize = Vector2(0.0, 0.0);

  bool get _isOnTheGround => y >= _yGround;

  @override
  Future<void>? onLoad() async {
    await createSpriteAnimations();
    run();
  }

  Future<void> createSpriteAnimations() async {
    final image = await Flame.images.load('dino_sprite.png');
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(24, 24),
    );
    _runAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 4, to: 10);
    size = spriteDefSize;

    _hitAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 14, to: 16);
  }

  void run() {
    animation = _runAnimation;
  }

  void hit() {
    animation = _hitAnimation;
  }

  void jump() {
    if (_isOnTheGround) {
      _speedY = -600;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _speedY += gravity * dt;
    y += _speedY * dt;
    if (_isOnTheGround) {
      y = _yGround;
      _speedY = 0.0;
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _screenSize = size;
    _yGround = size.y - height - groundHeight-10;
    position = Vector2(50, _yGround);
  }
}
