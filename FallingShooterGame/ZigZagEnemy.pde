// ===================== ZigZagEnemy.pde =====================
class ZigZagEnemy extends Enemy {
  float vx;
  float vy;
  float angle = 0;

  ZigZagEnemy(float x, float y) {
    super(x, y);
    col = color(255, 150, 100);
    size = 40;
    vy = 4.0 * 1.5;
    vx = 4.0 * 1.5;
  }

  void update() {
    y += vy;
    x += vx * sin(angle);
    angle += 0.05;

    if (x < size/2) {
      x = size/2;
      vx *= -1;
    } else if (x > width - size/2) {
      x = width - size/2;
      vx *= -1;
    }
  }
}
