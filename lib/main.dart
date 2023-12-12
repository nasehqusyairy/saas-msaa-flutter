import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saas_msaa/firebase_options.dart';
import 'package:saas_msaa/login.dart';
import 'package:saas_msaa/models/activities.dart';
import 'package:saas_msaa/models/presences.dart';
import 'package:saas_msaa/pages/home/page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PresenceProvider()),
        ChangeNotifierProvider(create: (context) => ActivitiesProvider()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true),
        // home: const HomePage());
        home: const Login());
  }
}
