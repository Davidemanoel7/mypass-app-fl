import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import './controllers/initializerApp/AppStarter.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  // force portrait position
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  runApp( const AppStarter() );

  FlutterNativeSplash.remove();
}
