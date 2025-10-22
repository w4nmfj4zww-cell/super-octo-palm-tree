// --- GameOverScreen.pde ---
String[] messages = {
  "GAME OVER",
  "Nooooooooooooooob!!",
  "You Loser|go cry to your mam" // 2行表示用に "|" で分割
};
int selectedMessage = -1;

void showGameOverScreen() {
  // ランダムメッセージを選択（初回のみ）
  if (selectedMessage == -1) {
    selectedMessage = int(random(messages.length));
  }

  // 背景を薄く暗くする
  fill(0, 0, 0, 160);
  rect(0, 0, width, height);

  // メッセージ表示
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(255, 50, 50);

  String msg = messages[selectedMessage];

  // "|" がある場合は2行に分割
  if (msg.indexOf("|") >= 0) {
    String[] lines = split(msg, '|');
    float startY = height/2 - 60;
    for (int i = 0; i < lines.length; i++) {
      text(lines[i], width/2, startY + i*80); // 行間80px
    }
  } else {
    text(msg, width/2, height/2 - 60);
  }

  // リスタートボタン
  float bx = width/2 - 120;
  float by = height/2 + 40;
  float bw = 240;
  float bh = 64;
  fill(0, 200, 200);
  rect(bx, by, bw, bh, 12);
  fill(255);
  textSize(32);
  text("RESTART", width/2, by + bh/2);
}

// ゲーム再スタート時に呼ぶ関数（メイン側 initGame() の中で）
