class Shrapnel {
  float x, y;
  float vx, vy;
  float baseSize = 8;  // 追加
  boolean alive = true;
  float speed;
  color col;

  Shrapnel(float x, float y) {
    this.x = x;
    this.y = y;
    col = color(255, 200, 100);
    float angle = random(-PI, 0); // 上方向のみ
    speed = random(3, 8);
    vx = cos(angle) * speed;
    vy = sin(angle) * speed;
  }

  void update() {
    x += vx;
    y += vy;
    if (y < -baseSize || x < -baseSize || x > width + baseSize) alive = false;
  }

  void display() {
    float scale = map(y, height, 0, 1, 2); // 上ほど大きく
    fill(col);
    noStroke();
    ellipse(x, y, baseSize * scale, baseSize * scale);
  }
}
