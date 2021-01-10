module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      outline: {
        blue: ['2px solid #3b82f6', '-1px']
      },
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
      display: ["group-hover", "focus-within"],
      outline: ["group-hover", "focus-within", "hover"]
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require("kutty")
  ],
}