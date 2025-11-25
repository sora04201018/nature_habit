import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static values = { timeout: Number } // html側のdata-flash-timeout-valueの値をNumber(整数値)で受け取る。timeoutNumberが使えるようになる。

  connect() {

    requestAnimationFrame(() => {
      // translate-x-full をremoveで外して、addでtranslate-x-0を挿入する。→スライドイン。
      this.element.classList.remove("translate-x-full") // translate-x-full(右に100%押し出す→画面外)
      this.element.classList.add("translate-x-0")  // taranslate-x-0 (元の位置)
    })

    // 自動で閉じる時間(デフォルトは5秒)
    const ms = this.timeoutValue || 5000
    this.autoHideTimer = setTimeout(() => this.close(), ms)
  }

  disconnect() {
    // DOM から消えるときはタイマーをクリア
    if (this.autoHideTimer) clearTimeout(this.autoHideTimer)
  }

  close(event) {
    // 明示的にボタンから来た場合は event がある。preventDefault は不要だが念のため
    if (event && typeof event.preventDefault === "function") event.preventDefault()

    // スライドアウト：右に戻す
    this.element.classList.remove("translate-x-0")
    this.element.classList.add("translate-x-full")

    // transition duration の時間待ってから要素を削除（400ms に合わせる）
    setTimeout(() => {
      // 親要素から remove（Turbo Stream などの非同期でも DOM が更新される場合があるが、ここで直接消す）
      this.element.remove()
    }, 400)
  }
}
