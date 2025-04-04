module.exports = {
  darkMode: "class",
  content: [
    "./app/views/**/*.html.erb",
    "./app/views/**/*.turbo_stream.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  plugins: [require("@tailwindcss/forms"), require("@tailwindcss/typography")],
};
