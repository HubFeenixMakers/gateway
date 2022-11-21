module.exports = {
  content: [
    './app/views/**/*.haml',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  variants: {
    extend: {
      overflow: ['hover']
    }
  },
  plugins: [
  ],
}
