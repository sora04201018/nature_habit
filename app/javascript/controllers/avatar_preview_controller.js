import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  preview(event) {
    const file = event.target.files[0]
    if (!file) return

    const reader = new FileReader()

    reader.onload = (e) => {
      const img = document.getElementById("avatar-preview")
      img.src = e.target.result
    }

    reader.readAsDataURL(file)
  }
}
