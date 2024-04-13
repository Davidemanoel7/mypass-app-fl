import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mypass/managers/auth_manager.dart';
import 'package:mypass/managers/cache_manager.dart';
import 'package:mypass/screens/home/homeControll.dart';

class ProfileControl extends GetxController with SharedPrefManager {
  var user = ''.obs;
  var email = ''.obs;
  var userName = ''.obs;
  var profileImageUrl = ''.obs;

  var loadRequest = false.obs;

  late File image;

  @override
  void onInit() async {
    loadRequest(true);
    HomeControll homeControllData = Get.find<HomeControll>();
    user(homeControllData.user.value);
    userName(homeControllData.userName.value);
    email(homeControllData.email.value);
    profileImageUrl(homeControllData.profile.value);
    loadRequest(false);
    super.onInit();
  }

  Future<bool> logOut() async {
    try {
      final AuthenticationManager authManager =
          Get.find<AuthenticationManager>();
      await authManager.logout();
      return true;
    } catch (e) {
      debugPrint('\nError: $e');
      return false;
    }
  }

  // continue aqui: https://faun.pub/flutter-upload-image-to-server-from-mobile-d9416f1db972
  // ou esse https://stackoverflow.com/questions/44841729/how-to-upload-images-to-server-in-flutter
  Future<dynamic> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    return image = File(pickedFile.path);
  }

  Future<void> uploadImage() async {
    File imageFl = await getImageFromGallery();
    var stream = http.ByteStream(imageFl.openRead());
    var length = await imageFl.length();

    String? filesize = await getFileSize(imageFl.path, 1);
    debugPrint(filesize);

    try {
      String token = await getItemFromCache('acessToken', TypeKey.String);

      var request = http.MultipartRequest(
          'PATCH',
          Uri.parse(
              'https://mypass-api.onrender.com/v1/user/changeProfileImage/'));

      debugPrint('Image path: ${imageFl.path}');
      debugPrint('Image split: ${imageFl.path.split('/').last}');

      var multipartFile = http.MultipartFile(
        'profileImage',
        stream,
        length,
        filename: imageFl.path.split('/').last,
      );

      request.files.add(multipartFile);

      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        // "content-type": "application/json",
        "accept": "application/json",
        "authorization": "Bearer $token"
      };

      request.headers.addAll(headers);
      debugPrint('request: $request');
      var res = await request.send();
      http.Response response = await http.Response.fromStream(res);

      debugPrint('Response body: ${jsonDecode(response.body)}');
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<String> getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = file.lengthSync();
    if (bytes < 0) return "0 B";
    const sufix = ['B', 'KB', 'MB'];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)}${sufix[i]}';
  }
}
