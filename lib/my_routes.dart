import 'package:bitmec/screens/home_screen.dart';
import 'package:bitmec/screens/login_screen.dart';

class MyRoutes {
  static String initialRoute() {
    return LoginScreen.routeName;
  }

  static final routes = {
    HomeScreen.routeName: (context) => HomeScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
  };
}
