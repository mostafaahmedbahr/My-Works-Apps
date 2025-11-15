import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'core/utils/app_services/local_services/cache_helper.dart';
import 'core/utils/app_services/remote_services/service_locator.dart';
import 'core/utils/bloc_observer.dart';
import 'lang/codegen_loader.g.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  await firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  FirebaseMessaging.onMessageOpenedApp;

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {}
  });
  FirebaseMessaging.instance.subscribeToTopic('all');

  FirebaseMessaging.instance.getToken().then((value) async {
    CacheHelper.saveData(key: "fcmToken", value: value);
  });

  setupServiceLocator();

  Bloc.observer = SimpleBlocObserver();
  runApp(EasyLocalization(
    startLocale: const Locale('ar',""),
    supportedLocales: const [
      Locale('ar',""),
      Locale('en',""),
    ],
    path: 'lib/lang',
    saveLocale: true,
    fallbackLocale: const Locale('ar',""),
    useOnlyLangCode: true,
    assetLoader: const CodegenLoader(),
    child: MyApp(),
  ),);
}