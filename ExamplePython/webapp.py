from flask import Flask

app = Flask(__name__)
    
@app.route("/", methods=['GET'])
def index():
    return 'Hello world'
    
@app.route("/get_info", methods=['GET'])
def get_info():
    return 'Hello! Get Info OK!'

if __name__ == '__main__':
    app.run(debug=True, host='192.168.178.21', port='8080')