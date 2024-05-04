import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mypass/managers/auth_manager.dart';
import 'package:mypass/managers/cache_manager.dart';
import 'package:mypass/models/userModel.dart';
import 'package:mypass/screens/home/homeControll.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionType {
  CAMERA,
  GALERY,
}

class ProfileControl extends GetxController with SharedPrefManager {

  var loadRequest = false.obs;

  Rx<User> user =  User(email: '', name: '', user: '').obs;

  late File image;

  @override
  void onInit() async {
    loadRequest(true);
    HomeControll homeControllData = Get.find<HomeControll>();
    user = Rx(homeControllData.usr.value);
    loadRequest(false);
    super.onInit();
  }

  Future<void> logOut() async {
    try {
      final AuthenticationManager authManager = Get.find<AuthenticationManager>();
      await authManager.logout();
    } catch (e) {
      debugPrint('\nError: $e');
    }
  }

  // continue aqui: https://faun.pub/flutter-upload-image-to-server-from-mobile-d9416f1db972
  // ou esse https://stackoverflow.com/questions/44841729/how-to-upload-images-to-server-in-flutter
  Future<File?> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if ( pickedFile == null ) {
      return null;
    }
    return File(pickedFile.path);
  }

  Future<void> uploadImage() async {
    File? imageFl = await getImageFromGallery();

    if ( imageFl == null ) {
      return;
    }

    try {
      String token = await getItemFromCache('acessToken', TypeKey.String);

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('https://mypass-api.onrender.com/v1/user/changeProfileImage/')
      )..files.add( await http.MultipartFile.fromPath( 'profileImage', imageFl.path ) );

      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        "accept": "application/json",
        "authorization": "Bearer $token"
      };

      request.headers.addAll(headers);

      var res = await request.send();
      http.Response response = await http.Response.fromStream(res);

      debugPrint('Response body: ${jsonDecode(response.body)}');
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<bool> checkCameraPermission() async {
    const permission = Permission.camera;

    if ( await permission.isDenied ) {
      final request = await permission.request();
      if ( request.isGranted ) {
        await setItemFromCache('camera_permission', TypeKey.bool, true );
        return true;
      } else if ( request.isDenied ) {
        // openAppSettings();
        return false;
      } else if ( request.isPermanentlyDenied ) {
        return false;
      } else if ( request.isLimited ) {
        return true;
      }
    }
    return true;
  }

  Future<bool> checkPhotosPermission() async {
    const permission = Permission.photos;

    if ( await permission.isDenied ) {
      final request = await permission.request();
      if ( request.isGranted ) {
        return true;
      } else if ( request.isDenied ) {
        return false;
      } else if ( request.isPermanentlyDenied ) {
        return false;
      } else if ( request.isLimited ) {
        return true;
      }
    }
    return true;
  }
}