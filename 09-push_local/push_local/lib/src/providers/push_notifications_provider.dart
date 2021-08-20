import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications() async {
    _firebaseMessaging.requestNotificationPermissions();
    
    _firebaseMessaging.getToken().then((token) {
      print('===== FCM Token =====');
      print(token);

      // fE35c2BxOMU:APA91bGzcVMrv3iwIejb5Fkl98oX2uqW7FaQktMsTZ4f4_ikY30JfBaU7wTAOwBYotHgbUQdcrEu-U7we80xD-Hl3oNzysUa-3OWikzjH2dWu3xLJG71_LNHgYyeIsdlZr3ebzSebw69
    });

    _firebaseMessaging.configure(
      onMessage: (info) async {
        print("===== On Message =====");
        print(info);

        String argumento = 'no-data';

        if(Platform.isAndroid) {
          argumento = info['data']['comida'] ?? 'no-data';
        }
        else {
          argumento = info['comida'] ?? 'no-data-ios';
        }

        _mensajesStreamController.sink.add(argumento);
      },
      onBackgroundMessage: (info) async {
        print("===== On Background Message =====");
        print(info);
      },
      onLaunch: (info) async {
        print("===== On Launch =====");
        print(info);
      },
      onResume: (info) async {
        print("===== On Resume =====");
        print(info);

        String argumento = 'no-data';

        if(Platform.isAndroid) {
          argumento = info['data']['comida'] ?? 'no-data';
        }
        else {
          argumento = info['comida'] ?? 'no-data-ios';
        }

        _mensajesStreamController.sink.add(argumento);
      },
    );

  }

  dispose() {
    _mensajesStreamController?.close();
  }
}