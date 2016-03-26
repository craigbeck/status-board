module.exports = {
  entry: "./web/static/js/main.jsx",

  output: {
    path: "./priv/static/js",
    filename: "app.js"
  },

  module: {
    loaders: [{
      test: /\.jsx?$/,
      exclude: /node_modules/,
      loader: "babel",
      query: {
        presets: [
          "es2015",
          "react"
        ]
      }
    }]
  },

  resolve: {
    // modulesDirectories: [
    //   __dirname + "/web/static/js",
    //   "./node_modules"
    // ],
    alias: {
      phoenix_html:
        __dirname + "/deps/phoenix_html/web/static/js/phoenix_html.js",
      phoenix:
        __dirname + "/deps/phoenix/web/static/js/phoenix.js"
    },
    extensions: ["", ".js", ".jsx"]
  }
};
