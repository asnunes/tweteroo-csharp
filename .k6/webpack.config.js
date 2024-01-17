const webpack = require("webpack");
const path = require("path");
const fs = require("fs");

const dotenv = require("dotenv");

module.exports = (env) => {
  console.log(dotenv.parse(fs.readFileSync(".env")));

  const fileEntry = env.entry;
  if (!fileEntry) {
    throw new Error("No entry file provided");
  }

  const key = fileEntry.split(path.sep).pop().split(".").slice(0, -1).join(".");
  const value = fileEntry;

  return {
    entry: {
      [key]: value,
    },
    output: {
      path: path.resolve(__dirname, "dist"), // eslint-disable-line
      libraryTarget: "commonjs",
      filename: "[name].js",
    },
    module: {
      rules: [{ test: /\.js$/, use: "babel-loader" }],
    },
    target: "web",
    externals: /k6(\/.*)?/,
    plugins: [
      new webpack.DefinePlugin({
        "process.env": JSON.stringify(dotenv.parse(fs.readFileSync(".env"))),
      }),
    ],
  };
};
