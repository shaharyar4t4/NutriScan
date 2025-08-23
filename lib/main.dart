import 'core/constants/app_linker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nutri Scan',
      theme: ThemeData(
          primaryColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme()),
      getPages: allPage,
      home: AuthWrapper(),
    );
  }
}
