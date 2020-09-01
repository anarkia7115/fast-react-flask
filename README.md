# fast-react-flask
Construct React Flask environment in 127 lines. 

``` bash
mkdir flask-react-app
cp react-webpack-template.sh flask-react-app/
cd flask-react-app

sh react-webpack-template.sh

# terminal 1
sh watch.sh

# terminal 2
source env.sh
flask run
```
