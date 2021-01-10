module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        primary: {
          light: "#6B7280", // For lighter primary color
          DEFAULT: "#1F2937", // Normal primary color
          dark: "#111827", // Used for hover, active, etc.
        },
      },
    },
  },
  variants: {
    extend: {
      display: ["group-hover", "focus-within"]
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require("kutty")
  ],
}