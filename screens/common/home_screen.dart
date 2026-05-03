import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diaspora_connect/controllers/index.dart';
import 'package:diaspora_connect/screens/expediteur/expediteur_home_screen.dart';
import 'package:diaspora_connect/screens/destinataire/destinataire_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final authController = Get.find<AuthController>();

      print('=== HOME SCREEN BUILD ===');
      print('isLoggedIn: ${authController.isLoggedIn}');
      print('currentUser value: ${authController.currentUser.value}');
      print('profileType: ${authController.currentUser.value?.profileType}');
      print('isExpeditor: ${authController.isExpeditor}');

      if (!authController.isLoggedIn) {
        print('User not logged in, showing placeholder');
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      print('About to check if expeditor...');
      if (authController.isExpeditor) {
        print('Showing ExpediteurHomeScreen');
        return const ExpediteurHomeScreen();
      } else {
        print('Showing DestinatairerHomeScreen');
        return const DestinatairerHomeScreen();
      }
    });
  }
}

