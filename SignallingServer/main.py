from flask import Flask, jsonify

app = Flask(__name__)

notifications = []

@app.route("/send/<string:name>/<float:lat>/<float:long>/<string:notif>")
def trial(name, lat, long, notif):
    notifications.append({
        'name': name,
        'message': f'emergency with {notif}',
        'location': {'lat': lat, 'long': long}
    })
    print(notifications)
    return jsonify(notifications)

@app.route("/notifs")
def get_notifications():
    return jsonify(notifications)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
