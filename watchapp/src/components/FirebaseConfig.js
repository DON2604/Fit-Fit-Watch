import { initializeApp } from "firebase/app";
import { getDatabase } from "firebase/database";
const firebaseConfig = {
  apiKey: "AIzaSyDoJXOLXIiPuxYZrp2Rf5Pf5Sk7RoCSnYY",
  databseURL: "https://watch-2d03a-default-rtdb.firebaseio.com/",
  authDomain: "watch-2d03a.firebaseapp.com",
  projectId: "watch-2d03a",
  storageBucket: "watch-2d03a.appspot.com",
  messagingSenderId: "192199627011",
  appId: "1:192199627011:web:b2e3ab97630bcba38e9936",
  measurementId: "G-Z2SMX7L9TE"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const database = getDatabase(app);
export {database};