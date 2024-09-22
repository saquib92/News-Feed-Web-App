// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyBNbt8CFlSzCVc5LfxtRItBDOFikzC4CJw",
    authDomain: "news-feed-web-app1.firebaseapp.com",
    projectId: "news-feed-web-app1",
    storageBucket: "news-feed-web-app1.appspot.com",
    messagingSenderId: "106521978567",
    appId: "1:106521978567:web:31b7bdf150da29b0ba00e2"

});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});