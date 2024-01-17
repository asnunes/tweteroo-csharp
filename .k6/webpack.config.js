const path = require("path");
const fs = require("fs");

const entries = fs.readdirSync("./src").reduce((acc, file) => {
  if (file.endsWith(".js")) {
    const key = file.slice(0, -3);
    const value = `./src/${file}`;

    acc[key] = value;
  }
  return acc;
}, {});

module.exports = {
  entry: entries,
  output: {
    path: path.resolve(__dirname, "dist"), // eslint-disable-line
    libraryTarget: "commonjs",
    filename: "[name].bundle.js",
  },
  module: {
    rules: [{ test: /\.js$/, use: "babel-loader" }],
  },
  target: "web",
  externals: /k6(\/.*)?/,
};
