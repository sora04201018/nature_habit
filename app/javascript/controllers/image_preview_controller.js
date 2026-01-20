import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  preview(event) {
    const file = event.target.files[0]
    if (!file) return
    
    const reader = new FileReader()

    reader.onload = (e) => {
      const img = document.getElementById("post-image-preview")
      img.src = e.target.result
      img.classList.remove("hidden")
    }
    reader.readAsDataURL(file)
  }
}
