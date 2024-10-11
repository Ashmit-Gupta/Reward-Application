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
import 'package:reward_app/view_models/payment_view_model.dart';
import 'package:reward_app/view_models/home_view_model.dart';
import 'package:reward_app/view_models/sidebar_navigation_view_model.dart';
import 'package:reward_app/view_models/theme_view_model.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SideBarNavigationViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel(authRepository)),
        ChangeNotifierProvider(
            create: (_) => HomeViewModel(firebaseStorageRepo)),
        ChangeNotifierProvider(
            create: (_) => WalletViewModel(firebaseStorageRepo)),
        ChangeNotifierProvider(
            create: (_) => PaymentViewModel(firebaseStorageRepo)),
      ],
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
