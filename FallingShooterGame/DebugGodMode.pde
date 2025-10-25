// ===================== DebugGodMode.pde =====================
class DebugGodMode {
  boolean enabled = false;  // 無敵モードのON/OFF状態

  void toggle() {
    enabled = !enabled;
    println("無敵モード: " + (enabled ? "ON" : "OFF"));
  }

  boolean isEnabled() {
    return enabled;
  }

  // デバッグ情報を画面上に描画
  void display() {
    if (enabled) {
      fill(255, 0, 0);
      textAlign(LEFT, TOP);
      textSize(18);
      text("GOD MODE", 10, 10);
    }
  }
}
