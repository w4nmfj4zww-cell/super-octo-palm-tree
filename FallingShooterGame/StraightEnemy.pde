// ===================== StraightEnemy.pde =====================
class StraightEnemy extends Enemy {
  float speedY = 3.0;

  StraightEnemy(float x, float y) {
    super(x, y);
    col = color(100, 200, 255);
    size = 42;
  }

  void update(ArrayList<Shrapnel> shrapnels) {
    y += speedY;

    if (y + size/2 >= height) {
      explode(shrapnels);
      alive = false;
    }
  }

  void explode(ArrayList<Shrapnel> shrapnels) {
    for (int i = 0; i < 20; i++) {
      Shrapnel s = new Shrapnel(x, height - size/2);
      shrapnels.add(s);
    }
  }
}
