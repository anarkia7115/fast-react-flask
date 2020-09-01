npm init -y
npm install webpack webpack-cli --save-dev

# add private: true
sed -i "/description/a \ \ \"private\": true," package.json

# install babel
npm install --save-dev \
    @babel/core \
    @babel/cli \
    @babel/preset-env \
    @babel/preset-react

# install loader
npm install --save-dev \
    babel-loader

cat <<EOF > babel.config.json
{
  "presets": ["@babel/env", "@babel/preset-react"]
}
EOF


# install react
npm install --save-prod \
    react react-dom

# install bootstrap
npm install --save-dev \
    jquery popper.js

npm install --save-prod \
    bootstrap 

npm install --save-dev \
    css-loader style-loader 

# webpack.config.js
cat <<EOF > webpack.config.js
const path = require('path');

module.exports = {
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist'),
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /(node_modules|bower_components)/,
        loader: "babel-loader",
        options: { presets: ["@babel/env"] }
      },
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"]
      }, 
    ]
  }, 
};
EOF

# index.js
mkdir src
cat <<EOF > src/index.js

const path = require('path');
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import React, { Component } from "react";
import ReactDOM from "react-dom";

class App extends Component {
  render() {
    return(
      <h1>Hello, world!</h1>
    )
  }
}

ReactDOM.render( <App /> ,
  document.getElementById("app"))

EOF

# index.html
mkdir templates
cat <<EOF > templates/index.html

<!doctype html>
<html lang="en">

<head>
</head>

<body>
    <div id="app"></div>
  <script src="{{ url_for('static', filename='main.js') }}"></script>
</body>

</html>

EOF

# flask app.py
cat <<EOF > app.py

from flask import Flask, render_template

app = Flask(__name__, static_folder="dist")

@app.route("/")
def index():
    return render_template("index.html")

EOF

# watch.sh
echo " npx webpack --watch --mode development --config webpack.config.js " > watch.sh

# env
cat <<EOF > env.sh
export FLASK_APP=app.py
export FLASK_DEBUG=1
EOF
