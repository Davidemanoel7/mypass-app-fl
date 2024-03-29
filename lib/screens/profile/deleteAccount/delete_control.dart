import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/profile/profileControl.dart';
import 'package:mypass/services/fetchData.dart';

class DeleteControll extends GetxController {
  var loadRequest = false.obs;
  var valid = false.obs;
  ProfileControl profileC = Get.find();

  Future<Map<String, dynamic>> checkSecurity( String pass) async {
    try {
      loadRequest(true);
      dynamic resp = await fetchData(
        Requests.checkSecurity,
        body: {
          "password" : pass
        }
      );
      loadRequest(false);

      switch ( resp.statusCode ) {
        case 200:
          return {
            "auth":true,
          };
        case 401:
          return {
            "auth": false,
            "message": 'A senha informada está errada...'
          };
        case 404:
          return {
            "auth": false,
            "message": 'Não encontramos nenhum usuário...'
          };
        default:
          return {
            "auth": false,
            "message": "Algum erro ocorreu. Tente novamente mais tarde!"
          };
      }
    } catch (e) {
      debugPrint('$e');
      return {"auth": false};
    } finally {
      loadRequest(false);
    }
  }

  Future<Map<String, dynamic>> deleteAccount() async {
    try {
      dynamic resp = await fetchData(
        Requests.deleteUser,
      );
      profileC.logOut();
      switch( resp.statusCode ) {
        case 200:
          return {
            "deleted": true,
          };
        case 401:
          return {
            "deleted": false,
            "message": 'Não foi possível completar a ação pois você não está autenticado(a).'
          };
        case 404:
          return {
            "deleted": false,
            "message": 'Algo deu errado. Não foi possível encontrar seu perfil...'
          };
        default:
          return {
            "deleted": false
          };
      }
    } catch (e) {
      debugPrint('$e');
      return {
        "deleted": false,
        "message": 'Algo deu errado. Tente novamente mais tarde!'
      };
    }
  }

  Future<bool> inactivateAccount() async {
    dynamic resp = await fetchData(
      Requests.inactivate,
    );
    profileC.logOut();
    switch (resp.statusCode ){
      case 200:
        return true;
      default:
        return false;
    }
  }
}