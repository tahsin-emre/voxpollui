const { initializeApp } = require('firebase-admin/app');
const { setGlobalOptions } = require('firebase-functions/v2');
const { getFirestore } = require('firebase-admin/firestore');
setGlobalOptions({ region: 'europe-west3' });
initializeApp();
const db = getFirestore();
