import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tweet-form"
export default class extends Controller {
  connect() {
    console.log('tweet form connected')
    console.log(this)
    this.element.addEventListener('turbo:submit-end', () => {
      document.querySelector("#close-modal-btn").click();
      console.log(this)
      this.element.reset();
    })
  }
}
