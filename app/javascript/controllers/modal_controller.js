import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "content", "body"];

  connect() {
    // Ensure ESC key closes the modal
    document.addEventListener("keydown", this.handleKeydown.bind(this));
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeydown.bind(this));
  }

  open() {
    this.containerTarget.classList.remove("hidden");
    this.containerTarget.classList.add("flex");
    // Prevent scrolling on the background
    document.body.style.overflow = "hidden";
  }

  close() {
    this.containerTarget.classList.remove("flex");
    this.containerTarget.classList.add("hidden");
    // Re-enable scrolling
    document.body.style.overflow = "auto";
  }

  closeBackground(event) {
    if (event.target === this.containerTarget) {
      this.close();
    }
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      this.close();
    }
  }
}
