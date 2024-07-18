import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jailerecord/features/auth/screens/signup.dart';
import 'package:jailerecord/features/auth/screens/signin.dart';
import 'package:jailerecord/features/auth/services/auth_service.dart';
import 'package:jailerecord/features/lawyer/screens/lawyerHome.dart';
import 'package:jailerecord/features/police/screens/policeHome.dart';
import 'package:jailerecord/provider/laywerProvider.dart';
import 'package:jailerecord/provider/policeProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LawyerProvider()),
    ChangeNotifierProvider(create: (context) => PoliceProvider())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  late SharedPreferences prefs;
  String? role;
  _init() async {
    final prefs = await SharedPreferences.getInstance();
    role = await prefs.getString('role');
    AuthService.getUser(
      context: context,
    );

    // print(Provider.of<>(context))
    // if (role != null) {
    if (role == 'lawyer') {
      print(
          'jjjjjjjjjjjjjjjjjjjjjjjj ${Provider.of<LawyerProvider>(context, listen: false).laywer.id}');
    } else if (role == 'police') {
      print(Provider.of<PoliceProvider>(context, listen: false).police.id);
    }
    // }
  }

  @override
  void initState() {
    // prefs = await SharedPreferences.getInstance();
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? role == 'police'
              ? PoliceHome()
              : LawyerHome()
          : SigninScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Text('Hello'));
  }
}
