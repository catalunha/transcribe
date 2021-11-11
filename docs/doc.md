# Compilar e deploy
flutter build web --web-renderer canvaskit

firebase deploy --only hosting:transcribing



# keytool
catalunha@pop-os:~/myapps/transcribe$ keytool -list -v -alias <your-key-name> -keystore <path-to-production-keystore>
bash: syntax error near unexpected token `newline'
catalunha@pop-os:~/myapps/transcribe$ keytool -list -v \
-alias androiddebugkey -keystore ~/.android/debug.keystore
Enter keystore password:  
Alias name: androiddebugkey
Creation date: Jun 30, 2021
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: C=US, O=Android, CN=Android Debug
Issuer: C=US, O=Android, CN=Android Debug
Serial number: 1
Valid from: Wed Jun 30 14:38:17 BRT 2021 until: Fri Jun 23 14:38:17 BRT 2051
Certificate fingerprints:
         SHA1: 35:89:8E:FB:FB:FA:95:8A:56:08:5C:CE:B5:7D:93:A0:E8:BD:4C:F7
         SHA256: E5:AB:93:21:D4:A3:B5:E6:B0:4C:98:05:EA:91:6E:54:DD:32:D1:23:69:88:AE:6F:2E:13:02:7D:50:89:1C:09
Signature algorithm name: SHA1withRSA (weak)
Subject Public Key Algorithm: 2048-bit RSA key
Version: 1

Warning:
The certificate uses the SHA1withRSA signature algorithm which is considered a security risk. This algorithm will be disabled in a future update.
catalunha@pop-os:~/myapps/transcribe$ 

