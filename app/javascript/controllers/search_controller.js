import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

export default class extends Controller {
  static values = { url: String };

  connect() {
    this.timeout = null;
  }

  search(event) {
    clearTimeout(this.timeout);

    const query = event.target.value.trim();

    this.timeout = setTimeout(() => {
      get(`${this.urlValue}?q=${encodeURIComponent(query)}`, {
        responseKind: "turbo-stream",
      });
    }, 500);
  }
}
