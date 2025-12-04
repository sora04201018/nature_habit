import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reveal"
export default class extends Controller {
  static targets = ["item"]

  connect() {
    this.observe()
  }

  observe() {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add("show")
        }
      })
    }, { threshold: 0.2 })

    this.itemTargets.forEach((el) => observer.observe(el))
  }
}

