import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cineland/splash_screen.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const mainUrl = "https://cineland.pro/";

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late InAppWebViewController controller;
  String url = MyApp.mainUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        const SizedBox(
          height: 40,
        ),
        Expanded(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(url)),
            onWebViewCreated: (InAppWebViewController webViewController) {
              controller = webViewController;
            },
            onEnterFullscreen: (controller) async {
              await SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]);
            },
            onExitFullscreen: (controller) async {
              await SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitDown,
                DeviceOrientation.portraitUp,
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]);
            },
            initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(
                disableDefaultErrorPage: true,
              ),
              crossPlatform: InAppWebViewOptions(
                  mediaPlaybackRequiresUserGesture: false,
                  horizontalScrollBarEnabled: false,
                  // userAgent: userAgent,
                  verticalScrollBarEnabled: false),
            ),
            androidOnPermissionRequest: (InAppWebViewController controller, String origin,
                List<String> resources) async {
              return PermissionRequestResponse(
                  resources: resources, action: PermissionRequestResponseAction.GRANT);
            },
          ),
        ),
        /*Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                child: const Icon(Icons.refresh),
                onPressed: () {
                  if (controller != null) {
                    controller.reload();
                  }
                },
              ),
              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                child: Icon(Icons.share),
                onPressed: () async {},
              ),
              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                child: Icon(Icons.arrow_back),
                onPressed: () => _handleBack(context),
              ),
              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                child: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (controller != null) {
                    controller.goForward();
                  }
                },
              ),
            ],
          ),
        ),*/
      ]),
    );
  }

// Future<bool> _handleBack(context) async {
//   var status = await controller.canGoBack();
//   var _exitMsg = 'Do you want to exit ?';
//   if (status) {
//     controller.goBack();
//   } else {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text(_exitMsg),
//           actions: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('No'),
//             ),
//             ElevatedButton(
//               onPressed: () => SystemNavigator.pop(),
//               child: Text('Yes'),
//             ),
//           ],
//         ));
//   }
//   return false;
// }
}
