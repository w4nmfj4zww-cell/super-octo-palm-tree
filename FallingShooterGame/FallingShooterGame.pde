// ===================== FallingShooterGame.pde =====================
Player player;
ArrayList<Enemy> enemies;
ArrayList<Shrapnel> shrapnels;
boolean gameOver = false;

// 敵自動生成用
float enemySpawnInterval = 120; // フレーム間隔
float lastEnemySpawn = 0;
float startTime = 0; // ★ゲーム開始時刻を記録するための変数

//タイマー
Timer timer;

void setup() {
  size(600, 800);
  initGame();
  timer = new Timer(this, 40 , true);
}

void initGame() {
  player = new Player(width/2, height - 100);
  enemies = new ArrayList<Enemy>();
  shrapnels = new ArrayList<Shrapnel>();
  gameOver = false;
  lastEnemySpawn = 0;
  startTime = millis(); // ★ゲーム開始時に記録

  // 初期敵をランダム生成
  for (int i = 0; i < 1; i++) {
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
  background(255);

  // ★経過秒数を計算（frameRateではなくmillisで）
  float elapsedSec = (millis() - startTime) / 1000.0;

  // ★右上に経過秒数を表示
  //fill(0);
  //textAlign(RIGHT, TOP);
  //textSize(20);
  //text(nf(elapsedSec, 1, 1) + " s", width - 10, 10); // 小数1桁まで表示

  timer.display();  // 時間を描画  
  
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
    if (!gameOver && dist(player.x, player.y, e.x, e.y) < (player.widthSize/2 + e.size/2)) {
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

    float sSize = s.baseSize * map(s.y, height, 0, 1, 2);
    if (!gameOver && dist(player.x, player.y, s.x, s.y) < (player.widthSize/2 + sSize/2)) {
      player.explodeEffect();
      gameOver = true;
    }
  }

  // 敵自動生成（経過秒数で制御）
  if (!gameOver && frameCount - lastEnemySpawn >= enemySpawnInterval) {
    lastEnemySpawn = frameCount;

    int spawnMultiplier = (elapsedSec >= 30) ? 2 : 1;

    for (int n = 0; n < spawnMultiplier; n++) {
      float x = random(50, width - 50);
      float y = random(-50, -20);

      if (elapsedSec < 10) {
        enemies.add(new ZigZagEnemy(x, y));
      } else if (elapsedSec < 20) {
        enemies.add(new StraightEnemy(x, y));
      } else {
        if (random(1) < 0.5) enemies.add(new ZigZagEnemy(x, y));
        else enemies.add(new StraightEnemy(x, y));
      }
    }
  }

  // ゲームオーバー描画
  if (gameOver) {
    showGameOverScreen();
  }
}

// ----- クリック処理（リスタート用） -----
void mousePressed() {
  if (gameOver) {
    float bx = width/2 - 120;
    float by = height/2 + 40;
    float bw = 240;
    float bh = 64;
    if (mouseX >= bx && mouseX <= bx + bw &&
        mouseY >= by && mouseY <= by + bh) {
      initGame();
      timer.reset();
    }
  }
}
