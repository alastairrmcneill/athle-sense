import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/services.dart';
import 'package:reading_wucc/support/theme.dart';
import 'package:reading_wucc/support/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<AppUser?>.value(
            value: AuthService().appUserStream,
            initialData: null,
          ),
          ChangeNotifierProvider<UserNotifier>(
            create: (_) => UserNotifier(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyThemes.getLightTheme(),
          home: const Wrapper(),
        ));
  }
}
