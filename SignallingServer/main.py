from flask import Flask, jsonify

app = Flask(__name__)

notifications = []

@app.route("/predict/<string:name>/<int:notif>/<string:loc>")
def trial(name, notif, loc):
    notifications.append({
        'type': name,
        'message': f'Notification with {notif} from {loc}',
        'timeAgo': 'Just now'
    })
    print(notifications)
    return jsonify(notifications)

@app.route("/notifs")
def get_notifications():
    return jsonify(notifications)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
