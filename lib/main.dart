import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/data/network/firebase_storage_services.dart';
// import 'package:reward_app/di/injection.dart';
import 'package:reward_app/repository/auth_repo.dart';
import 'package:reward_app/repository/firebase_storage_repo.dart';
import 'package:reward_app/utils/routes/routes.dart';
import 'package:reward_app/utils/routes/routes_name.dart';
import 'package:reward_app/view_models/auth_view_model.dart';
import 'package:reward_app/view_models/login_view_model.dart';
import 'package:reward_app/view_models/logout_view_model.dart';
import 'package:reward_app/view_models/payment_view_model.dart';
import 'package:reward_app/view_models/home_view_model.dart';
import 'package:reward_app/view_models/sidebar_navigation_view_model.dart';
import 'package:reward_app/view_models/signup_view_model.dart';
import 'package:reward_app/view_models/theme_view_model.dart';
import 'package:reward_app/view_models/user_view_model.dart';
import 'package:reward_app/view_models/wallet_view_model.dart';
import 'data/network/firebase_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await configureDependencies();

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeViewModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseServices firebaseServices = FirebaseServices(firebaseAuth);
    FirebaseStorageServices firebaseStorageServices = FirebaseStorageServices();
    FirebaseStorageRepo firebaseStorageRepo =
        FirebaseStorageRepo(firebaseStorageServices);
    AuthRepository authRepository = AuthRepository(firebaseServices);
    UserViewModel userViewModel = UserViewModel();
    HomeViewModel homeViewModel =
        HomeViewModel(firebaseStorageRepo, userViewModel);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SideBarNavigationViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel(authRepository)),
        ChangeNotifierProvider(
            create: (_) => HomeViewModel(firebaseStorageRepo, userViewModel)),
        ChangeNotifierProvider(
            create: (_) => WalletViewModel(firebaseStorageRepo)),
        ChangeNotifierProvider(
            create: (_) => PaymentViewModel(firebaseStorageRepo)),
        ChangeNotifierProvider(create: (_) => userViewModel),
        ChangeNotifierProvider(
            create: (_) => LoginViewModel(authRepository, userViewModel)),
        ChangeNotifierProvider(create: (_) => SignUpViewModel(authRepository)),
        ChangeNotifierProvider(
            create: (_) =>
                LogOutViewModel(authRepository, userViewModel, homeViewModel)),
      ],
      // providers: [
      //   ChangeNotifierProvider(create: (_) => SideBarNavigationViewModel()),
      //   ChangeNotifierProvider(
      //       create: (context) => AuthViewModel(context.read<AuthRepository>())),
      //   ChangeNotifierProvider(
      //       create: (context) => HomeViewModel(
      //           context.read<FirebaseStorageRepo>(),
      //           context.read<UserViewModel>())),
      //   ChangeNotifierProvider(
      //       create: (context) =>
      //           WalletViewModel(context.read<FirebaseStorageRepo>())),
      //   ChangeNotifierProvider(
      //       create: (context) =>
      //           PaymentViewModel(context.read<FirebaseStorageRepo>())),
      //   ChangeNotifierProvider(create: (_) => userViewModel),
      //   ChangeNotifierProvider(
      //       create: (context) => LoginViewModel(
      //           context.read<AuthRepository>(), context.read<UserViewModel>())),
      //   ChangeNotifierProvider(
      //       create: (context) =>
      //           SignUpViewModel(context.read<AuthRepository>())),
      //   ChangeNotifierProvider(
      //       create: (context) => LogOutViewModel(context.read<AuthRepository>(),
      //           context.read<UserViewModel>(), context.read<HomeViewModel>())),
      // ],
      child: Consumer<ThemeViewModel>(
        builder: (BuildContext context, ThemeViewModel value, Widget? child) {
          return MaterialApp(
            theme: value.themeData,
            initialRoute: RoutesName.splashScreen,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}
