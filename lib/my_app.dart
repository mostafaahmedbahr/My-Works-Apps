import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
 import 'core/shared_widgets/cubits/lang_cubit/lang_cubit.dart';
import 'core/utils/app_colors/app_colors.dart';
import 'features/splash/presentation/views/splash_view.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LanguageCubit()),

      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          context.setLocale(locale);
          return MaterialApp(
            navigatorKey: navigatorKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: locale,
            // locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: "My ProtoFile",
            theme: ThemeData(
              fontFamily: locale.languageCode == 'ar' ? "Cairo" : "RobotoCondensed",
              scaffoldBackgroundColor: AppColors.whiteColor,
              appBarTheme: const AppBarTheme(
                scrolledUnderElevation: 0,
                backgroundColor: AppColors.whiteColor,
              ),
              primarySwatch: Colors.blue,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: AppColors.whiteColor,
              ),
            ),
            home: const RotateScaleSplash(),
            builder: (context, child) {
                SystemChrome.setSystemUIOverlayStyle(
                  const SystemUiOverlayStyle(
                    systemNavigationBarColor: AppColors.whiteColor,
                    systemNavigationBarIconBrightness: Brightness.dark,
                  ),
                );
              return ResponsiveBreakpoints.builder(
                child: child!,
                breakpoints: const [

                  Breakpoint(start: 0, end: 450, name: MOBILE),
                  Breakpoint(start: 451, end: 800, name: TABLET),
                  Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                ],
              );
            },
          );
        },
      ),
    );
  }
}