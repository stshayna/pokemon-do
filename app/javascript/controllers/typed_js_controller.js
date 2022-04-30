import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["^400 Let's Go...", "Pikachu!", "Pika Papow⚡️"],
      typeSpeed: 10,
      loop: true,
      loopCount: Infinity,
      showCursor: false,
      backDelay: 1000,
    });
  }
}
