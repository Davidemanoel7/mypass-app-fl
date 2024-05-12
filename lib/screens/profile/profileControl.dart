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

  Future<XFile?> getUserImages( PermissionType type) async {
    ImageSource src = type == PermissionType.CAMERA ? ImageSource.camera : ImageSource.gallery;
    bool checkPermission = type == PermissionType.CAMERA
      ? await checkCameraPermission()
      : await checkPhotosPermission();
    
    if ( !checkPermission ) {
      return null;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage( source: src );
    
    if ( pickedFile == null ) {
      return null;
    }
    File picked = File( pickedFile.path );

    XFile userImage = XFile.fromData(
      picked.readAsBytesSync(),
      mimeType: await getMimeType( picked ),
      name: user.value.user,
      length: picked.lengthSync(),
      path: picked.path
    );

    debugPrint( userImage.mimeType );

    return userImage;
  }

  Future<String?> getMimeType(File file) async {
    String ext = file.path.split('.').last.toLowerCase();

    Map<String, String> mimeTypes = {
      'png': 'image/png',
      'jpg': 'image/jpg',
      'jpeg': 'image/jpeg',
    };

    return mimeTypes[ext];
  }

  Future<void> uploadImage( PermissionType type) async {
    XFile? imageFl = await getUserImages( type );
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
    PermissionStatus permission = await Permission.camera.status;

    if ( permission.isDenied ) {
      final request = await Permission.camera.request();
      if ( request.isGranted ) {
        await setItemFromCache('camera_permission', TypeKey.bool, true );
        return true;
      } else if ( request.isDenied ) {
        return await openAppSettings();
      } else if ( request.isPermanentlyDenied ) {
        return false;
      } else if ( request.isLimited ) {
        return true;
      }
    }
    return true;
  }

  Future<bool> checkPhotosPermission() async {
    PermissionStatus permission = await Permission.photos.status;

    if ( permission.isDenied ) {
      final request = await Permission.photos.request();
      if ( request.isGranted ) {
        await setItemFromCache('photos_permission', TypeKey.bool, true );
        return true;
      } else if ( request.isDenied ) {
        return await openAppSettings();
      } else if ( request.isPermanentlyDenied ) {
        return false;
      } else if ( request.isLimited ) {
        return true;
      }
    }
    return true;
  }
}