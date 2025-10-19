// ===================== Fragment.pde =====================
class Fragment {
  float x, y;
  float vx, vy;
  float sz;
  color col;
  float life = 60;

  Fragment(float x, float y, float sz) {
    this.x = x;
    this.y = y;
    this.sz = sz;
    col = color(0, 255, 0);
    float angle = random(TWO_PI);
    float speed = random(2, 6);
    vx = cos(angle) * speed;
    vy = sin(angle) * speed;
  }

  void update() {
    x += vx;
    y += vy;
    life--;
  }

  void display() {
    float alpha = map(life, 0, 60, 0, 255);
    fill(col, alpha);
    noStroke();
    ellipse(x, y, sz, sz);
  }
}
