import 'package:flutter/material.dart';
import 'package:flutter_app_github_dev_dojo/screen/home_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Github repositories search',
        theme: ThemeData(
          primarySwatch: MaterialColor(
            0xFF000000,
            <int, Color>{
              50: Color(0xFF000000),
              100: Color(0xFF000000),
              200: Color(0xFF000000),
              300: Color(0xFF000000),
              400: Color(0xFF000000),
              500: Color(0xFF000000),
              600: Color(0xFF000000),
              700: Color(0xFF000000),
              800: Color(0xFF000000),
              900: Color(0xFF000000),
            },
          ),
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<bool> _delay() async{
    await Future.delayed(Duration(milliseconds: 5000), () {});

    return true;
  }

  void _navigateToHomeScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen()
      )
    );
  }


  @override
  void initState() {
    super.initState();

    _delay().then((status) => _navigateToHomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Icon(FlutterIcons.github_zoc, size: 120)),
                Center(
                  child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Shimmer.fromColors(
                    baseColor: Color(0xff555555),
                    highlightColor: Color(0xff000000),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Find Repositories",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            shadows: [
                              Shadow(
                                blurRadius: 18.0,
                                color: Colors.black87,
                                offset: Offset.fromDirection(120, 12)
                              )
                            ]
                          )
                      ),
                    )
                    ),
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
