import 'dart:typed_data';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Shared/constatnce/string.dart';
import 'package:social_app/Shared/network/local/cache_helper.dart';
import 'package:social_app/Shared/resources/theme_manager.dart';
import 'package:social_app/layout/cubit/socialapp_states.dart';

import 'Shared/bloc_observe.dart';
import 'Shared/resources/routes_manager.dart';
import 'layout/Main/layout_screen.dart';
import 'layout/cubit/socialapp_cubit.dart';
import 'presentation/Login/Login_cubit/login_cubit.dart';
import 'presentation/Login/login_screen.dart';
import 'presentation/SignUp/SignUp_cubit/signup_cubit.dart';

Widget? startwidget;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Extract notification details
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  // Display a custom popup notification
  if (notification != null && android != null) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
      importance: Importance.high,
      priority: Priority.high,
      icon: "@mipmap/bookit",
      // styleInformation: bigTextStyleInformation,
      playSound: true,
      enableVibration: true,
      visibility: NotificationVisibility.public,
      showWhen: true,
    );
    DarwinNotificationDetails iosPlatformNotificationDetailsSpecifics =
        DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformNotificationDetailsSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      notification.title, // Notification title
      notification.body, // Notification body
      platformChannelSpecifics,
      payload: 'Custom_Screen', // Payload for custom screen
    );
  }
}

void main() async {
  // SocialUserModel model = SocialUserModel(
  //     firstname: "ads",
  //     lastname: "SAd",
  //     image: "ASdsad",
  //     uId: "12",
  //     email: "Sadasdsda",
  //     bio: "dsadsasda",
  //     cover: ""
  //         "asd");
  //
  // SocialUserModel model1 = SocialUserModel(
  //     firstname: "ads",
  //     lastname: "SAd",
  //     image: "ASdsad",
  //     uId: "12",
  //     email: "Sadasdsda",
  //     bio: "dsadsasda",
  //     cover: ""
  //         "asd");
  // print(model == model1);
  // print(model.hashCode);
  // print(model1.hashCode);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  Bloc.observer = MyBlocObserver();
  try {
    int? _orderID;
    final RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      _orderID = remoteMessage.notification!.titleLocKey != null
          ? int.parse(remoteMessage.notification!.titleLocKey!)
          : null;
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {}
  await FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  await FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  StringConstance.uID = await CacheHelper.getData(key: "uID");
  // bool isdark = await CacheHelper.getData(key: "theme");
  if (StringConstance.uID != null) {
    startwidget = MainLayoutScreen();
  } else {
    startwidget = LoginScreen();
  }
  runApp(
    MyApp(
        // isdark: isdark,
        ),
  );
}

class MyApp extends StatelessWidget {
  // bool? isdark;
  MyApp({
    super.key,
  });

  @override
  // void initState() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => SignUpCubit(),
          ),
          BlocProvider(
            create: (context) => SocialAppCubit()
              ..getUserData()
              ..getPosts()
              ..changeTheme(),
          ),
        ],
        child: BlocConsumer<SocialAppCubit, SocialAppStates>(
          builder: (context, state) => ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: false,
              builder: (context, child) {
                return MaterialApp(
                    navigatorKey: navigatorKey,
                    locale: DevicePreview.locale(context),
                    builder: DevicePreview.appBuilder,
                    // supportedLocales: [Locale('ar')],
                    // localizationsDelegates: [
                    //   AppLocalizations.delegate,
                    //   GlobalMaterialLocalizations.delegate,
                    //   GlobalWidgetsLocalizations.delegate,
                    //   GlobalCupertinoLocalizations.delegate,
                    // ],
                    // localeResolutionCallback: (deviceLocale, supportedLocales) {
                    //   for (var locale in supportedLocales) {
                    //     if (deviceLocale != null &&
                    //         deviceLocale.languageCode == locale.languageCode) {
                    //       return deviceLocale;
                    //     }
                    //   }
                    //   return supportedLocales.first;
                    // },
                    debugShowCheckedModeBanner: false,
                    onGenerateRoute: Routes.generateRoute,
                    // initialRoute: Routes.loginRoute,
                    home: startwidget,
                    title: 'Social App',
                    theme: getApplicationLightTheme(),
                    darkTheme: getApplicationDarkTheme(),
                    themeMode: SocialAppCubit.get(context).light
                        ? ThemeMode.light
                        : ThemeMode.dark);
              }),
          listener: (context, state) {},
        ));
  }
}
