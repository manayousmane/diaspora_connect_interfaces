import 'package:get/get.dart';
import 'package:diaspora_connect/models/index.dart';
import 'package:diaspora_connect/services/index.dart';

class AuthController extends GetxController {
  Rxn<User> currentUser = Rxn<User>();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Vérifier si un utilisateur est déjà connecté
    final user = StorageService.getCurrentUser();
    if (user != null) {
      currentUser.value = user;
    }
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final user = await AuthService.login(email, password);
      if (user != null) {
        currentUser.value = user;
        isLoading.value = false;
        return true;
      } else {
        errorMessage.value = 'Email ou mot de passe incorrect';
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Erreur de connexion: $e';
      isLoading.value = false;
      return false;
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
    currentUser.value = null;
  }

  bool get isLoggedIn => currentUser.value != null;
  bool get isExpeditor =>
      currentUser.value?.profileType == 'expediteur';
  bool get isDestinataire =>
      currentUser.value?.profileType == 'destinataire';
  bool get isVerified => currentUser.value?.isVerified ?? false;
}
