import { Controller } from "@hotwired/stimulus"
import Tagify from "@yaireo/tagify"

// Connects to data-controller="tag"
export default class extends Controller {
  static values = { tags: Array }


  connect() {
    const input = this.element.querySelector("input")

    if (!input) return

    this.tagify = new Tagify(input, {
      whitelist: this.tagsValue, // 既存カテゴリー入れる
      dropdown: {
        enabled: 0,      // フォーカスで表示
        maxItems: 20,
        closeOnSelect: false
      }
    })

    // 編集画面用
    if (this.hasInitialValueValue && this.initialValueValue.length > 0) {
      const tags = this.initialValueValue
        .split(",")
        .map(t => t.trim())
        .filter(t => t.length > 0)

      this.tagify.addTags(tags)
    }
  }
}
