import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PowerBar extends PositionComponent {
  double powerLevel = 50.0;

  PowerBar({required Vector2 position}) : super(position: position, size: Vector2(200, 20));

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final bg = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRect(bg, Paint()..color = Colors.grey);

    final fill = Rect.fromLTWH(0, 0, size.x * (powerLevel / 100), size.y);
    canvas.drawRect(fill, Paint()..color = _getColor());

    canvas.drawRect(bg, Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2);

    final tp = TextPainter(
      text: TextSpan(
        text: 'Power: ${powerLevel.toStringAsFixed(1)}%',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(5, 1));
  }

  Color _getColor() {
    if (powerLevel > 75) return Colors.green;
    if (powerLevel > 50) return Colors.lightGreen;
    if (powerLevel > 25) return Colors.yellow;
    if (powerLevel > 10) return Colors.orange;
    return Colors.red;
  }

  void updatePower(double newPower) {
    powerLevel = newPower;
  }
}
