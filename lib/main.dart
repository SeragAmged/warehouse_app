import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/layout/app_layout.dart';
import 'package:warehouse_app/layout/cubit/cubit.dart';
import 'package:warehouse_app/modules/login/login_screen.dart';
import 'package:warehouse_app/modules/qr/cubit/cubit.dart';
import 'package:warehouse_app/modules/register/register_screen.dart';
import 'package:warehouse_app/modules/settings/settings_screen.dart';
import 'bloc_observer.dart';
import 'shared/components/variables.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'styles/styles.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

//adb connect 127.0.0.1:58526
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'token') ?? '';

  Widget startWidget() => onBoarding
      ? token.isNotEmpty
          ? const Placeholder()
          : const Placeholder()
      : LoginScreen();
  runApp(MyApp(startWidget()));
}

class MyApp extends StatelessWidget {
  const MyApp(this.startWidget, {super.key});

  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..getItems()),
        BlocProvider(create: (context) => ItemByIdCubit()),
      ],
      child: MaterialApp(
        title: 'Social app',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: LoginScreen(),
      ),
    );
  }
}
