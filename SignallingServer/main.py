from flask import Flask, jsonify
from pyngrok import ngrok

ngrok_auth_token = ""


port_no=5000
public_url = ngrok.connect(port_no).public_url
print(public_url)

app = Flask(__name__)

notifications = []


@app.route("/send/<string:name>/<path:lat>/<path:long>/<string:notif>")
def trial(name, lat, long, notif):
    try:
        lat = float(lat)
        long = float(long)
    except ValueError:
        return jsonify({"error": "Invalid latitude or longitude format"}), 400
    notifications.append(
        {
            "name": name,
            "message": f"emergency with {notif}",
            "location": {"lat": lat, "long": long},
        }
    )
    print(notifications)
    return jsonify(notifications)


@app.route("/notifs")
def get_notifications():
    return jsonify(notifications)


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
