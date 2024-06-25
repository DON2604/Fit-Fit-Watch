"use client";
import React from "react";
import { useEffect, useState } from "react";
import { onValue, ref } from 'firebase/database';
import { database } from "../../components/FirebaseConfig";

const Page = () => {
  const [notifications, setNotifications] = useState([]);

  useEffect(() => {
    const notifsRef = ref(database, "notifs");
    
    const unsubscribe = onValue(notifsRef, (snapshot) => {
      if (snapshot.exists()) {
        const notifsArray = Object.entries(snapshot.val()).map(
          ([key, data]) => ({
            key,
            ...data,
          })
        );
        setNotifications(notifsArray);
      } else {
        setNotifications([]);
      }
    }, (error) => {
      console.error("Error fetching data:", error);
    });

    // Cleanup function to unsubscribe when component unmounts
    return () => unsubscribe();
  }, []);

  return (
    <div className="text-center">
      {notifications.map((notif) => (
        <div key={notif.key} className="p-4">
          <h2 className="text-center text-white">ID: {notif.id}</h2>
          <p className="text-white">Notification: {notif.notif}</p>
          <p className="text-white">Value: {notif.val}</p>
        </div>
      ))}
    </div>
  );
};

export default Page;