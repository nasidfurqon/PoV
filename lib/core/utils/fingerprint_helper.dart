import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
class FingerprintHelper{
  static Future<bool> checkAvailability(LocalAuthentication auth) async{
    try{
      bool available = await auth.canCheckBiometrics;
      return available;
    }
    catch(e){
      print('BIOMETRIC check: $e');
      return false;
    }
  }

  static Future<bool> biometricAuthentication(LocalAuthentication auth ,bool isAvailable) async{
    if(!isAvailable){
      return false;
    }
    try{
      bool authenticate = await auth.authenticate(
        localizedReason: 'login via fingerprint',
        options: AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        )
      );
      return authenticate;
    }
    catch(e){
      print('BIOMETRIC authenticate: $e');
      return false;
    }
  }
}