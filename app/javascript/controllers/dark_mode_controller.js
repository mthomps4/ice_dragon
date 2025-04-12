import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["lightIcon", "darkIcon", "themeToggle"];

  connect() {
    this.updateTheme(this.isDarkMode());
  }

  isDarkMode() {
    const theme = localStorage.getItem("theme");
    if (theme) {
      return theme === "dark";
    }
    return window.matchMedia("(prefers-color-scheme: dark)").matches;
  }

  updateTheme(isDark) {
    if (isDark) {
      document.documentElement.classList.add("dark");
      this.lightIconTarget.classList.remove("hidden");
      this.darkIconTarget.classList.add("hidden");
      localStorage.setItem("theme", "dark");
    } else {
      document.documentElement.classList.remove("dark");
      this.darkIconTarget.classList.remove("hidden");
      this.lightIconTarget.classList.add("hidden");
      localStorage.setItem("theme", "light");
    }
  }

  toggleTheme() {
    const isDark = !this.isDarkMode();
    this.updateTheme(isDark);
  }
}
