import 'package:bitmec/screens/screens.dart';

class MyRoutes {
  static String initialRoute() {
    return LoginScreen.routeName;
  }

  static final routes = {
    HomeScreen.routeName: (context) => HomeScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),

    // Patient Routes
    PatientListScreen.routeName: (context) => PatientListScreen(),
  };
}
