import 'package:flutter/material.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/routes/app_pages.dart';
import 'package:gaweid2/ui/DW/datadiri1_dw.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/utils/Splash.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/modules/user/view/register/Register_user.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri1.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'constant/constant.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("85accc5a-8084-4a43-9c52-1b47cd06c076");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NetworkProvider>.value(
      value: NetworkProvider(),
      child: GetMaterialApp(
        home: Splash(),
        getPages: MediaPages.pages,
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

