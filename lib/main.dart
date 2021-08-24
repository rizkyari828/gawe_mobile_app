import 'package:flutter/material.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/datadiri1_dw.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/utils/Splash.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/modules/user/view/register/Register_user.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri1.dart';
import 'package:provider/provider.dart';
import 'constant/constant.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("85accc5a-8084-4a43-9c52-1b47cd06c076");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    // print("Accepted permission: $accepted");
  });

  // OneSignal.shared.init(
  //   "c243b1b4-497a-45cb-8895-21ba35e2b8c5",
  //   iOSSettings: {
  //     OSiOSSettings.autoPrompt: false,
  //     OSiOSSettings.inAppLaunchUrl: false
  //   }
  // );
  // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NetworkProvider>.value(
      value: NetworkProvider(),
      child: MaterialApp(
        home: Splash(),
        debugShowCheckedModeBanner: false,
         routes: <String,WidgetBuilder>{
          SPLASH_SCREAN : (BuildContext context)=> Splash(),
          SIGN_UP : (BuildContext context) => Register(),
          SIGN_IN :  (BuildContext context) => Login(),
          HOMEPAGE :  (BuildContext context) => UserDashboard(),
          DATADIRI1 :  (BuildContext context) => datadiri1(),
          DATADIRI1_DW :  (BuildContext context) => datadiri1_dw(),
        },
        initialRoute: SPLASH_SCREAN,
      ),
    );
  }
}

