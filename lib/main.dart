import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moible_app/page/category_page.dart';
import 'controller/init_ctr.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'OpenSans',
        // textTheme:GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: CategoryPage(),
    );
  }
}

