const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.verifyLicenseKey = functions.https.onCall(async (data, context) => {
  // Log de l'objet data complet pour le débogage
  const parsedData = JSON.parse(data["data"]);

  // Accès à la clé licenseKey
  const licenseKey = parsedData.licenseKey;

  if (!licenseKey) {
    throw new functions.https.HttpsError('invalid-argument', 'La clé de licence est manquante.');
  }

  try {
    console.log('Start');

    const doc = await admin.firestore().collection('users').doc(licenseKey).get();

    console.log(doc.data());

    if (doc.exists && doc.data().use > 0) {
      console.log('Key already used');
      return { valid: false };
    } else {
      console.log('Key not used');

      await admin.firestore().collection('users').doc(licenseKey).update({
        use: admin.firestore.FieldValue.increment(1)
      });    
      
      console.log('Incrementing use');


      return { valid: true };
    }
  } catch (error) {
    throw new functions.https.HttpsError('internal', 'Erreur lors de la vérification de la clé de licence.');
  }
});
