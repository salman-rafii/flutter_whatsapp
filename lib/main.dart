import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whatsapp/colors.dart';
import 'package:flutter_whatsapp/common/widgets/error.dart';
import 'package:flutter_whatsapp/common/widgets/loader.dart';
import 'package:flutter_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:flutter_whatsapp/features/auth/screens/user_information_screen.dart';
import 'package:flutter_whatsapp/features/landing/landing_screen.dart';
import 'package:flutter_whatsapp/firebase_options.dart';
import 'package:flutter_whatsapp/router.dart';
import 'package:flutter_whatsapp/screens/mobile_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Whatsapp',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(color: appBarColor)),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataProvider).when(
            data: (user) {
              if (user == null) {
                return const LandingScreen();
              }
              return const MobileLayoutScreen();
            },
            error: (error, stackTrace) {
              return ErrorScreen(
                error: error.toString(),
              );
            },
            loading: () => const Loader(),
          ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileLayoutScreen(),
      //   webScreenLayout: WebLayoutScreen(),
      // ),
    );
  }
}
