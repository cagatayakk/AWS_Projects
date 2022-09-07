from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def head():
    return render_template("index.html" , number1=10 , number2=20)

@app.route('/sum')
def number():
    x=15
    y=20
    return render_template('body.html', num1=x, num2=y, sum=x+y)
    
if __name__ == '__main__':
    #app.run(debug=False)
    # app.run(debug=True)
    app.run(host='0.0.0.0', port=80)