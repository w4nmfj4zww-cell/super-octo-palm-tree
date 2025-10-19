// ===================== FallingShooterGame.pde =====================
Player player;
ArrayList<Enemy> enemies;
ArrayList<Shrapnel> shrapnels;
boolean gameOver = false;

// 敵自動生成用
float enemySpawnInterval = 120; // フレーム間隔
float lastEnemySpawn = 0;

void setup() {
  size(600, 800);
  initGame();
}

void initGame() {
  player = new Player(width/2, height - 100);
  enemies = new ArrayList<Enemy>();
  shrapnels = new ArrayList<Shrapnel>();
  gameOver = false;
  lastEnemySpawn = 0;

  // 初期敵をランダム生成
  for (int i = 0; i < 4; i++) {
    float x = random(50, width - 50);
    float y = random(-200, -20);
    if (i % 2 == 0) {
      enemies.add(new ZigZagEnemy(x, y));
    } else {
      enemies.add(new StraightEnemy(x, y));
    }
  }
}

void draw() {
  background(0);

  if (!gameOver) {
    player.update();
    player.display();
  }

  // 敵更新・描画
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy e = enemies.get(i);

    if (e instanceof StraightEnemy) {
      ((StraightEnemy)e).update(shrapnels);
    } else {
      e.update();
    }

    e.display();

    if (!e.alive || e.isOffScreen()) {
      enemies.remove(i);
      continue;
    }

    // 当たり判定
    if (!gameOver && dist(player.x, player.y, e.x, e.y) < (player.size/2 + e.size/2)) {
      player.explodeEffect();
      gameOver = true;
    }
  }

  // Shrapnel更新・描画
  for (int i = shrapnels.size() - 1; i >= 0; i--) {
    Shrapnel s = shrapnels.get(i);
    s.update();
    s.display();

    if (!s.alive) {
      shrapnels.remove(i);
      continue;
    }

    // 当たり判定
    float sSize = s.baseSize * map(s.y, height, 0, 1, 2);
    if (!gameOver && dist(player.x, player.y, s.x, s.y) < (player.size/2 + sSize/2)) {
      player.explodeEffect();
      gameOver = true;
    }
  }

  // 敵自動生成
  if (!gameOver && frameCount - lastEnemySpawn >= enemySpawnInterval) {
    float x = random(50, width - 50);
    float y = random(-50, -20);
    if (random(1) < 0.5) enemies.add(new ZigZagEnemy(x, y));
    else enemies.add(new StraightEnemy(x, y));
    lastEnemySpawn = frameCount;
  }

  // ゲームオーバー描画（外部ファイルに委譲）
  if (gameOver) {
    showGameOverScreen(); // <- GameOverScreen.pde にこの関数を実装してください
  }
}

// ----- クリック処理（リスタート用） -----
void mousePressed() {
  if (gameOver) {
    // GameOverScreen上のボタン領域
    float bx = width/2 - 120;
    float by = height/2 + 40;
    float bw = 240;
    float bh = 64;
    if (mouseX >= bx && mouseX <= bx + bw &&
        mouseY >= by && mouseY <= by + bh) {
      initGame();
    }
  }
}
