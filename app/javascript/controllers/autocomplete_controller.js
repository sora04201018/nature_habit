import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "results" ]
  static values = { url: String } // HTML側からのURLを取得し、JS処理を共通化（　habit・post）

  search() {
    const keyword = this.inputTarget.value

    if (keyword.length < 1) {
      this.resultsTarget.innerHTML = ""
      this.resultsTarget.classList.add("hidden")
      return
    }

    fetch(`${this.urlValue}?q=${encodeURIComponent(keyword)}`)
    .then(response => response.json())
      .then(data => {
        this.renderResults(data)
      })
  }

  renderResults(items) {
    this.resultsTarget.innerHTML = ""

    items.forEach(item => {
      const li = document.createElement("li")
      li.textContent = item
      li.className = "p-2 hover:bg-green-100 cursor-pointer"

      li.addEventListener("click", () => {
        this.inputTarget.value = item
        this.resultsTarget.classList.add("hidden")
      })

      this.resultsTarget.appendChild(li)
    })

    this.resultsTarget.classList.remove("hidden")
  }
}
