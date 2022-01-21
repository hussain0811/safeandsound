const functions = require("firebase-functions");

const admin = require("firebase-admin");


admin.initializeApp(functions.config().firebase);


exports.fcmTester1 = functions.firestore.document("Calls/{CallsID}")
    .onCreate((snapshot, context) => {
      return admin.firestore().collection("pushtokens").get()
          .then((snapshot) => {
            const tokens = [];

            if (snapshot.empty) {
              console.log("No Devices");
              throw new Error("No Devices");
            } else {
              for (const token of snapshot.docs) {
                tokens.push(token.data().devtokens);
              }

              const payload = {
                "notification": {
                  "title": "New Call Uploaded",
                  "body": "",
                  "sound": "default",
                },

              };

              return admin.messaging().sendToDevice(tokens, payload);
            }
          })
          .catch((err) => {
            console.log(err);
            return null;
          });
    });
