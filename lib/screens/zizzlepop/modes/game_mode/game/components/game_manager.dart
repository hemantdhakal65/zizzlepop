import 'package:flame/components.dart';

class GameManager extends Component {
  double powerLevel = 50.0;
  int score = 0;
  int health = 100;

  void reset() {
    powerLevel = 50.0;
    score = 0;
    health = 100;
  }
}
