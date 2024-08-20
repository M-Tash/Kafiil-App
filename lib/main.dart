import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kafiil_test/ui/auth/login/login_screen_view.dart';
import 'package:kafiil_test/ui/auth/register/register_screen_view.dart';
import 'package:kafiil_test/ui/home/home_screen.dart';
import 'package:kafiil_test/utils/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? isLoggedIn = await secureStorage.read(key: 'isLoggedIn');
  runApp(MyApp(loggedIn: isLoggedIn == 'true'));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;

  const MyApp({Key? key, required this.loggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: loggedIn ? HomeScreen.routeName : LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
      },
      theme: MyTheme.lightMode,
    );
  }
}
