// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:templering/screens/adoptify_splash_screen.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:http/http.dart' as http;

// int id = 0;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// final StreamController<String?> selectNotificationStream =
//     StreamController<String?>.broadcast();

// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');

// const String portName = 'notification_send_port';

// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });

//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;
// }

// String? selectedNotificationPayload;

// const String urlLaunchActionId = 'id_1';
// const String navigationActionId = 'id_3';
// const String darwinNotificationCategoryText = 'textCategory';
// const String darwinNotificationCategoryPlain = 'plainCategory';

// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   // ignore: avoid_print
//   print('notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}');
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//     // ignore: avoid_print
//     print(
//         'notification action tapped with input: ${notificationResponse.input}');
//   }
// }

// Future<void> _configureLocalTimeZone() async {
//   if (kIsWeb || Platform.isLinux) {
//     return;
//   }
//   tz.initializeTimeZones();
//   final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
//   tz.setLocalLocation(tz.getLocation(timeZoneName!));
// }

// Future<void> checkAndRunApi() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

//   if (isFirstLaunch) {
//     // Mark as not the first launch
//     await prefs.setBool('isFirstLaunch', false);

//     // Run the API
//     try {
//       var request = http.Request(
//           'GET', Uri.parse('https://alarmclock.rukmanimfg.com/api/users'));
//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 200) {
//         print(await response.stream.bytesToString());
//       } else {
//         print('Error: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('API Error: $e');
//     }
//   } else {
//     print('API call skipped, not the first launch.');
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await _configureLocalTimeZone();

//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   final List<DarwinNotificationCategory> darwinNotificationCategories =
//       <DarwinNotificationCategory>[
//     DarwinNotificationCategory(
//       darwinNotificationCategoryText,
//       actions: <DarwinNotificationAction>[
//         DarwinNotificationAction.text(
//           'text_1',
//           'Action 1',
//           buttonTitle: 'Send',
//           placeholder: 'Placeholder',
//         ),
//       ],
//     ),
//     DarwinNotificationCategory(
//       darwinNotificationCategoryPlain,
//       actions: <DarwinNotificationAction>[
//         DarwinNotificationAction.plain('id_1', 'Action 1'),
//         DarwinNotificationAction.plain(
//           'id_2',
//           'Action 2 (destructive)',
//           options: <DarwinNotificationActionOption>{
//             DarwinNotificationActionOption.destructive,
//           },
//         ),
//         DarwinNotificationAction.plain(
//           navigationActionId,
//           'Action 3 (foreground)',
//           options: <DarwinNotificationActionOption>{
//             DarwinNotificationActionOption.foreground,
//           },
//         ),
//         DarwinNotificationAction.plain(
//           'id_4',
//           'Action 4 (auth required)',
//           options: <DarwinNotificationActionOption>{
//             DarwinNotificationActionOption.authenticationRequired,
//           },
//         ),
//       ],
//       options: <DarwinNotificationCategoryOption>{
//         DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
//       },
//     )
//   ];

//   final DarwinInitializationSettings initializationSettingsDarwin =
//       DarwinInitializationSettings(
//     requestAlertPermission: false,
//     requestBadgePermission: false,
//     requestSoundPermission: false,
//     notificationCategories: darwinNotificationCategories,
//   );
//   final LinuxInitializationSettings initializationSettingsLinux =
//       LinuxInitializationSettings(
//     defaultActionName: 'Open notification',
//     defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
//   );
//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsDarwin,
//     macOS: initializationSettingsDarwin,
//     linux: initializationSettingsLinux,
//   );
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onDidReceiveNotificationResponse:
//         (NotificationResponse notificationResponse) {
//       switch (notificationResponse.notificationResponseType) {
//         case NotificationResponseType.selectedNotification:
//           selectNotificationStream.add(notificationResponse.payload);
//           break;
//         case NotificationResponseType.selectedNotificationAction:
//           if (notificationResponse.actionId == navigationActionId) {
//             selectNotificationStream.add(notificationResponse.payload);
//           }
//           break;
//       }
//     },
//     onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//   );
//   await checkAndRunApi();

//   MobileAds.instance.initialize();
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _notificationsEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _isAndroidPermissionGranted();
//     _requestPermissions();
//     _scheduleNotificationAt12();
//     _scheduleNotificationAt7();
//   }

//   Future<void> _isAndroidPermissionGranted() async {
//     if (Platform.isAndroid) {
//       final bool granted = await flutterLocalNotificationsPlugin
//               .resolvePlatformSpecificImplementation<
//                   AndroidFlutterLocalNotificationsPlugin>()
//               ?.areNotificationsEnabled() ??
//           false;

//       setState(() {
//         _notificationsEnabled = granted;
//       });
//     }
//   }

//   Future<void> _requestPermissions() async {
//     if (Platform.isIOS || Platform.isMacOS) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               MacOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//     } else if (Platform.isAndroid) {
//       final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
//           flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>();

//       final bool? grantedNotificationPermission =
//           await androidImplementation?.requestNotificationsPermission();
//       setState(() {
//         _notificationsEnabled = grantedNotificationPermission ?? false;
//       });
//     }
//   }

//   // Future<void> _cancelAllNotifications() async {
//   //   await flutterLocalNotificationsPlugin.cancelAll();
//   // }

//   // Future<void> _fetchAlarmTimeAndScheduleNotification12() async {
//   // try {
//   //   var request = http.Request('GET',
//   //       Uri.parse('https://alarmclock.rukmanimfg.com/api/getsetalarm'));

//   //   http.StreamedResponse response = await request.send();

//   //   if (response.statusCode == 200) {
//   //     // Parse the response
//   //     final String responseBody = await response.stream.bytesToString();
//   //     final Map<String, dynamic> responseData = json.decode(responseBody);

//   //     if (responseData['success'] == true &&
//   //         responseData['alarms'] != null &&
//   //         responseData['alarms'].isNotEmpty) {
//   //       final String alarmTime =
//   //           responseData['alarms'][0]['time']; // Get the time
//   //       final List<String> timeParts =
//   //           alarmTime.split(':'); // Split time into hours and minutes

//   //       final int hour = int.parse(timeParts[0]);
//   //       final int minute = int.parse(timeParts[1]);

//   //       // Schedule notification using the fetched time
//   //      _scheduleNotificationAt();
//   //     } else {
//   //       throw Exception("No alarms found in the API response.");
//   //     }
//   //   } else {
//   //     throw Exception("Failed to fetch alarm time: ${response.reasonPhrase}");
//   //   }
//   // } catch (e) {
//   //   print("Error fetching or scheduling alarm: $e");
//   // }
// //  }

//   // Future<void> _fetchAlarmTimeAndScheduleNotification12PM() async {
//   //   try {
//   //     var request = http.Request('GET',
//   //         Uri.parse('https://alarmclock.rukmanimfg.com/api/getsetalarm'));

//   //     http.StreamedResponse response = await request.send();

//   //     if (response.statusCode == 200) {
//   //       // Parse the response
//   //       final String responseBody = await response.stream.bytesToString();
//   //       final Map<String, dynamic> responseData = json.decode(responseBody);

//   //       if (responseData['success'] == true &&
//   //           responseData['alarms'] != null &&
//   //           responseData['alarms'].isNotEmpty) {
//   //         final String alarmTime =
//   //             responseData['alarms'][0]['time']; // Get the time
//   //         final List<String> timeParts =
//   //             alarmTime.split(':'); // Split time into hours and minutes

//   //         final int hour = int.parse(timeParts[0]);
//   //         final int minute = int.parse(timeParts[1]);

//   //         // Schedule notification using the fetched time
//   //         _scheduleNotificationAt12(hour, minute);
//   //       } else {
//   //         throw Exception("No alarms found in the API response.");
//   //       }
//   //     } else {
//   //       throw Exception("Failed to fetch alarm time: ${response.reasonPhrase}");
//   //     }
//   //   } catch (e) {
//   //     print("Error fetching or scheduling alarm: $e");
//   //   }
//   // }

//   @override
//   void dispose() {
//     selectNotificationStream.close();
//     super.dispose();
//   }

//   Future<void> _scheduleNotificationAt7() async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         id++,
//         'शुभ दिन 🙏',
//         '',
//         _nextInstanceOf7(),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'alarm_channel',
//             'Alarm Notifications',
//             channelDescription: 'Channel for alarm notifications',
//             color: Colors.green,
//             playSound: true,
//             priority: Priority.max,
//             sound: RawResourceAndroidNotificationSound('slow_spring_board'),
//             importance: Importance.max,
//             enableVibration: true,
//             channelShowBadge: true,
//             icon: '@mipmap/ic_launcher',
//           ),
//           iOS: DarwinNotificationDetails(
//             presentAlert: true,
//             presentBadge: true,
//             presentSound: true,
//             sound: 'sound.wav',
//           ),
//         ),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time);
//   }

//   tz.TZDateTime _nextInstanceOf7() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, 19, 00);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }

//   Future<void> _scheduleNotificationAt12() async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         id++,
//         'शुभ दिन 🙏',
//         '',
//         _nextInstanceOf12(),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'alarm_channel',
//             'Alarm Notifications',
//             channelDescription: 'Channel for alarm notifications',
//             color: Colors.green,
//             playSound: true,
//             priority: Priority.max,
//             sound: RawResourceAndroidNotificationSound('slow_spring_board'),
//             importance: Importance.max,
//             enableVibration: true,
//             channelShowBadge: true,
//             icon: '@mipmap/ic_launcher',
//           ),
//           iOS: DarwinNotificationDetails(
//             presentAlert: true,
//             presentBadge: true,
//             presentSound: true,
//             sound: 'sound.wav',
//           ),
//         ),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time);
//   }

//   tz.TZDateTime _nextInstanceOf12() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, 12, 00);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const AdoptifySplashscreen(),
//     );
//   }
// }
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:templering/screens/adoptify_splash_screen.dart';
import 'package:templering/screens/home.dart';
import 'package:templering/screens/plan_sheet_screen.dart';
import 'package:templering/screens/userinfo.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

const String urlLaunchActionId = 'id_1';
const String navigationActionId = 'id_3';
const String darwinNotificationCategoryText = 'textCategory';
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

Future<void> checkAndRunApi() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);

    try {
      var request = http.Request(
          'GET', Uri.parse('https://alarmclock.rukmanimfg.com/api/users'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('API Error: $e');
    }
  } else {
    print('API call skipped, not the first launch.');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final hasSeenUserForm = prefs.getBool('hasSeenUserForm') ?? false;
  await _configureLocalTimeZone();
  await checkAndRunApi();
  MobileAds.instance.initialize();
  runApp(MyApp(hasSeenUserForm: hasSeenUserForm));
}

class MyApp extends StatefulWidget {
  final bool hasSeenUserForm;
  const MyApp({super.key, required this.hasSeenUserForm});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _notificationsEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await _isAndroidPermissionGranted();
    await _requestPermissions();
    await _scheduleNotificationAt12();
    await _scheduleNotificationAt7();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      setState(() {
        _notificationsEnabled = grantedNotificationPermission ?? false;
      });
    }
  }

  @override
  void dispose() {
    selectNotificationStream.close();
    super.dispose();
  }

  Future<void> _scheduleNotificationAt7() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id++,
        'शुभ दिन 🙏',
        '',
        _nextInstanceOf7(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'alarm_channel',
            'Alarm Notifications',
            channelDescription: 'Channel for alarm notifications',
            color: Colors.green,
            playSound: true,
            priority: Priority.max,
            sound: RawResourceAndroidNotificationSound('slow_spring_board'),
            importance: Importance.max,
            enableVibration: true,
            channelShowBadge: true,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: 'sound.wav',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOf7() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 19, 00);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _scheduleNotificationAt12() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id++,
        'शुभ दिन 🙏',
        '',
        _nextInstanceOf12(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'alarm_channel',
            'Alarm Notifications',
            channelDescription: 'Channel for alarm notifications',
            color: Colors.green,
            playSound: true,
            priority: Priority.max,
            sound: RawResourceAndroidNotificationSound('slow_spring_board'),
            importance: Importance.max,
            enableVibration: true,
            channelShowBadge: true,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: 'sound.wav',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOf12() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 12, 00);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(body: Center(child: CircularProgressIndicator())));
    }

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: widget.hasSeenUserForm
          ? const HomeScreen()
          // ? PlansheetLogsScreen()
          : const UserInfoFormScreen(),
    );
  }
}
