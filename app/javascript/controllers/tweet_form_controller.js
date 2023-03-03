import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tweet-form"
export default class extends Controller {
  connect() {
    this.element.addEventListener('submit', () => {
      document.querySelector("#close-modal-btn").click();
    } )
  }
}
