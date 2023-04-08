import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tweet-card"
export default class extends Controller {
  connect() {
    console.log('tweet card connected!')
  }

  viewTweet(event) {
    if(event.target.parentElement.dataset.ignoreClicks !== 'true') {
      Turbo.visit(this.element.dataset.tweetPath)
    }
  }
}
