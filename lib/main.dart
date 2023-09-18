import 'package:dynamic_tooltip_plotline/application/tooltip/design_page_provider.dart';
import 'package:dynamic_tooltip_plotline/application/tooltip/onboarding_page_provider.dart';
import 'package:dynamic_tooltip_plotline/application/tooltip/preview_page_provider.dart';
import 'package:dynamic_tooltip_plotline/domain/tooltip/my_double.dart';
import 'package:dynamic_tooltip_plotline/infrastructure/tooltip/shared_preferences_repository.dart';
import 'package:dynamic_tooltip_plotline/presentation/pages/onboarding_page.dart';
import 'package:dynamic_tooltip_plotline/presentation/pages/preview_tooltip_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'application/tooltip/data_provider.dart';
import 'presentation/core/style_elements.dart';
import 'presentation/pages/design_tooltip_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsBinding b = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: b);

  await sharedPrefs.init();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((value) {
    return runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _firstLaunch = false;
  @override
  void initState() {
    _firstLaunch = SharedPreferencesRepository().isFirstLaunch();
    FlutterNativeSplash.remove();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => PreviewPageProvider()),
        ChangeNotifierProvider(create: (context) => DesignPageProvider()),
        ChangeNotifierProvider(create: (context) => OnboardingStateProvider()),
      ],
      child: MaterialApp(
        title: 'Dynamytip',
        theme: ThemeData(
          textTheme: TextTheme(
            headlineMedium: headlineMedium,
            bodySmall: bodySmall,
            bodyMedium: bodyMedium,
            labelLarge: bodySmall.copyWith(color: Colors.black),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: renderButtonColor),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            border: myBorder,
            enabledBorder: myBorder,
            errorBorder: myBorder,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          DesignTooltipPage.routeName: (context) => WillPopScope(
              onWillPop: () => Future.sync(() => false),
              child: const DesignTooltipPage()),
          PreviewTooltipPage.routeName: (context) => const PreviewTooltipPage(),
          OnboardingPage.routeName: (context) => const OnboardingPage(),
        },
        initialRoute: _firstLaunch
            ? OnboardingPage.routeName
            : DesignTooltipPage.routeName,

        ///Prevents the home screen from accidentally getting popped by backbutton
      ),
    );
  }
}
