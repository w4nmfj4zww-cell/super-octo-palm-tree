// ===================== Enemy.pde =====================
class Enemy {
  float x, y;
  float size;
  color col;
  boolean alive = true;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {}
  void display() {
    fill(col);
    noStroke();
    ellipse(x, y, size, size);
  }

  boolean isOffScreen() {
    return (y > height + size);
  }
}
