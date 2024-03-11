import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

// See API doc.: https://app.swaggerhub.com/apis-docs/DAVIDEMANOEL706/MyPass/1.0.0

enum HttpMethod {
  GET,
  POST,
  PATCH,
  DELETE
}

enum Requests {

  //auth endpoints
  signIn("/auth/signin/", HttpMethod.POST),
  forgotPass("/auth/forgotPass/", HttpMethod.PATCH),
  resetPass("/auth/resetPass/", HttpMethod.PATCH),
  checkSecurity("/auth/checkSecurity/", HttpMethod.PATCH),

  //user endpoints
  signUp("/user/signup/", HttpMethod.POST),
  getUser("/uset/get/", HttpMethod.GET),
  updateUser("/user/update/", HttpMethod.PATCH),
  changeProfileImage("/user/changeProfileImage/", HttpMethod.PATCH),
  changeAccountPass("/user/changeUserPass/", HttpMethod.PATCH),
  inactivate("/user/inactivate/", HttpMethod.PATCH),
  deleteUser("/user/del/", HttpMethod.DELETE),

  //pass endpoits
  createPass("/pass/", HttpMethod.POST),
  getAllPass("/pass/alluserpass/", HttpMethod.GET),
  getPass("/pass/", HttpMethod.GET),
  changePass("/pass/changePass/", HttpMethod.PATCH),
  deletePass("/pass/del/", HttpMethod.DELETE);

  final String req;
  final HttpMethod? method;
  const Requests(this.req, this.method);
}

Future<dynamic> fetchData( Requests req, { String? params, dynamic body, String? token }) async {
  const String baseUrl = 'https://mypass-api.onrender.com/v1';

  String endpoint = baseUrl + req.req + (params ?? "");
  var header = getHeaders( req, token: token );

  dynamic response;
  try {
    switch (req.method) {
      case HttpMethod.POST:
        response = await http.post( Uri.parse(endpoint), headers: header, body: jsonEncode(body) );
        break;
      case HttpMethod.GET:
        response = await http.get( Uri.parse(endpoint), headers: header );
        break;
      case HttpMethod.PATCH:
        response = await http.patch( Uri.parse(endpoint), headers: header, body: jsonEncode(body) );
        break;
      case HttpMethod.DELETE:
        response = await http.delete( Uri.parse(endpoint), headers: header );
        break;
      default:
        break;
    }
    return response;

  } catch (e) {
    debugPrint('\n Request failed with error: $e\n'); 
    throw 'Request failed with error: $e';
  }
}

Map<String, String>? getHeaders(Requests req, { String? token }) {
  switch ( req ) {
    case Requests.signIn || Requests.signUp || Requests.forgotPass || Requests.resetPass:
      return
        { 
          "content-type": "application/json",
          "accept": "application/json",
        };
    default:
      return
        { 
          "content-type": "application/json",
          "accept": "application/json",
          "authorization": "Bearer $token"
        };
  }
}