

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_training/constants.dart';

class EnemyData{

  final String fileName;
  final Vector2 srcSize;
  final Vector2 size;
  final double speed;
  final int from;
  final int to;

  EnemyData( {
    required this.fileName,required this.srcSize,required this.size,required this.speed, required this.from, required this.to
});
}

class Enemy extends SpriteAnimationComponent{
  Enemy(this.data);

  final EnemyData data;
  late Vector2 _screenSize = Vector2.zero();

  @override
  Future<void> onLoad() async {
    final spriteSheet = SpriteSheet(image: await Flame.images.load(data.fileName),  srcSize: data.srcSize,);
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1,from: data.from, to: data.to);
    size = data.size;
    // print('onLoad');
  }

  @override
  void update(double dt) {
    super.update(dt);
    x -= data.speed * dt;
    if(x < -width){
      x = _screenSize.x + width;
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _screenSize = size;
    // print('onGameResize');
    position = Vector2(size.x + width, size.y - height - groundHeight);
  }

}