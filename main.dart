import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diaspora_connect/theme/app_theme.dart';
import 'package:diaspora_connect/services/storage_service.dart';
import 'package:diaspora_connect/services/demo_data_service.dart';
import 'package:diaspora_connect/controllers/index.dart';
import 'package:diaspora_connect/screens/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await DemoDataService.initializeDemoData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialiser les GetX Controllers
    Get.put(AuthController());
    Get.put(TransferController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DiasporaConnect',
      theme: appTheme(),
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/transfer', page: () => const ExpediteurTransferScreen()),
        GetPage(name: '/transfer-success', page: () => const TransferSuccessScreen()),
        GetPage(name: '/withdraw', page: () => const WithdrawScreen()),
        GetPage(name: '/withdraw-success', page: () => const WithdrawSuccessScreen()),
      ],
      initialRoute: '/login',
      home: _buildInitialScreen(),
    );
  }

  Widget _buildInitialScreen() {
    final user = StorageService.getCurrentUser();
    if (user != null) {
      return const HomeScreen();
    }
    return const LoginScreen();
  }
}

