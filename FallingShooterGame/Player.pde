class Player {
  float x, y;
  float widthSize = 40;
  float heightSize = 60;
  
  ArrayList<Fragment> fragments;
  boolean exploding = false;
  int effectDuration = 60;
  int effectTimer = 0;
  PImage img; // 画像用変数

  Player(float x, float y) {
    this.x = x;
    this.y = y;
    fragments = new ArrayList<Fragment>();
    img = loadImage("PlayerCharacter.jpg"); // プレイヤー画像を読み込む
  }

  void update() {
    x = mouseX;
    y = mouseY;

    if (exploding) {
      for (Fragment f : fragments) {
        f.update();
      }
      effectTimer--;
      if (effectTimer <= 0) {
        exploding = false;
        fragments.clear();
      }
    }
  }

  void display() {
    if (!exploding) {
      // プレイヤー画像を表示（中央揃え）
      imageMode(CENTER);
      image(img, x, y, widthSize, heightSize);
    } else {
      for (Fragment f : fragments) {
        f.display();
      }
    }
  }

  void explodeEffect() {
    exploding = true;
    fragments.clear();
    effectTimer = effectDuration;

    int n = 20;
    for (int i = 0; i < n; i++) {
      fragments.add(new Fragment(x, y, widthSize/5));
    }
  }
}
