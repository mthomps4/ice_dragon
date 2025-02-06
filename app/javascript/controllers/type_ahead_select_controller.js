import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

// Connects to data-controller="type-ahead-select"
export default class extends Controller {
  connect() {
    this.tomSelect = new TomSelect(this.element, {
      plugins: ["remove_button", "no_backspace_delete"],
      create: false,
      createOnBlur: false,
      persist: false,
      multiple: false,
      onItemAdd: function () {
        this.setTextboxValue("");
        this.refreshOptions(false);
      },
    });
  }

  disconnect() {
    if (this.tomSelect) {
      this.tomSelect.destroy();
    }
  }
}
