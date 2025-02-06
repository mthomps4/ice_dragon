import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";
import { post } from "@rails/request.js";

// Connects to data-controller="multi-select"
export default class extends Controller {
  static values = {
    createUrl: String,
    createType: String,
  };

  connect() {
    this.tomSelect = new TomSelect(this.element, {
      plugins: ["remove_button", "no_backspace_delete"],
      create: true,
      createOnBlur: false,
      persist: true,
      createFilter: function (input) {
        const inputLower = input.toLowerCase();
        // Check minimum length
        if (inputLower.length < 2) return false;

        // Get all existing options and check if input matches any (case-insensitive)
        const existingOptions = Object.values(this.options).map((option) =>
          option.text.toLowerCase()
        );
        return !existingOptions.includes(inputLower);
      },
      onItemAdd: function () {
        this.setTextboxValue("");
        this.refreshOptions(false);
      },
      onOptionAdd: async (option) => {
        if (!this.createUrlValue || !this.createTypeValue) return;

        const response = await post(this.createUrlValue, {
          body: JSON.stringify({
            [this.createTypeValue]: {
              name: option,
            },
          }),
          responseKind: "json",
        });
        if (response.ok) {
          const { record } = await response.json;

          // Remove the old text only option
          this.tomSelect.removeOption(option);

          this.tomSelect.addOption({
            value: record.id.toString(),
            text: record.name,
          });

          // Add the new item to the select for the form
          this.tomSelect.addItem(record.id.toString());
        } else {
          console.log("error", response.status);
        }
      },
    });
  }

  disconnect() {
    if (this.tomSelect) {
      this.tomSelect.destroy();
    }
  }
}
