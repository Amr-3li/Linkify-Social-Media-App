const functions = require("firebase-functions");
const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");

// تهيئة Firebase Admin باستخدام Service Account
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// Cloud Function لإرسال الإشعارات
exports.sendNotification = functions.https.onRequest(async (req, res) => {
  try {
    const { targetToken, title, body, data } = req.body;

    if (!targetToken || !title || !body) {
      return res.status(400).send("Missing fields");
    }

    // إرسال الإشعار باستخدام FCM HTTP v1 API
    const message = {
      token: targetToken,
      notification: { title, body },
      data: data || { type: "general" },
    };

    await admin.messaging().send(message);

    res.status(200).send("Notification sent successfully");
  } catch (error) {
    console.error("Error sending notification:", error);
    res.status(500).send("Internal Server Error");
  }
});
