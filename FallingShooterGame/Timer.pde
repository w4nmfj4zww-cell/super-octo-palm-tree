// ============================
//  Timer クラス
// ============================
class Timer {
  PApplet p;
  int limitSec;          // 制限時間（秒）
  boolean limited;       // true=制限あり, false=なし
  float startTime;       // 開始時刻（ミリ秒）
  PFont font;            // 表示フォント
  float posX, posY;      // 表示位置
  
  Timer(PApplet parent, int limitSec, boolean limited) {
    this.p = parent;
    this.limitSec = limitSec;
    this.limited = limited;
    this.startTime = p.millis();
    this.font = p.createFont("MS Gothic", 32); // 日本語対応フォント
    p.textFont(font);
          
    posX = p.width - 20;
    posY = 20;
  }

  // 時間リセット
  void reset() {
    startTime = p.millis();
  }

  // 経過時間を返す
  float getElapsed() {
    return (p.millis() - startTime) / 1000.0;
  }

  // 残り時間を返す（制限なしの場合は無意味）
  float getRemaining() {
    return limitSec - getElapsed();
  }

  // 時間切れかどうか
  boolean isTimeUp() {
    return limited && getRemaining() <= 0;
  }

  // 時間更新（現状は特に処理なしだが、拡張用）
  void update() {
    // 今後、BGMテンポや背景変化と同期するならここで行う
  }

  // 時間を画面に表示
  void display() {
    p.fill(0);
    p.textAlign(PConstants.RIGHT, PConstants.TOP);
    p.textSize(24);
    
    if (limited) {
      float remain = max(0, getRemaining());
      p.text("残り時間: " + p.nf(remain, 0, 1) + " 秒", posX, posY);
    } else {
      p.text("経過時間: " + p.nf(getElapsed(), 0, 1) + " 秒",  posX, posY);
    }
  }
}
