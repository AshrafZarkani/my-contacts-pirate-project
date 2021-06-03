import 'package:flutter/material.dart';
import 'package:my_contacts_pirate/screens/landing_page/ui/pin_screen.dart';
import 'package:provider/provider.dart';
import 'screens/home/Logic/getContactsLogic.dart';
import 'screens/home/ui/home_page.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ContactListLogic?>(
                create: (_) => ContactListLogic()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Contacts Pirate App',
            theme: ThemeData(
              primarySwatch: Colors.grey,
              primaryColor: Colors.white,
              brightness: Brightness.light,
              backgroundColor: const Color(0xFFE5E5E5),
              accentColor: Colors.black,
              accentIconTheme: IconThemeData(color: Colors.white),
              dividerColor: Colors.white54,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
              '/pinScreen': (context) => PinScreen(),
              '/homePage': (context) => HomePage(),
            },
          ),
        ),
      );
    });
  }
}
