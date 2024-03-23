
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/auth/signInView.dart';
import 'package:mypass/screens/auth/signUpView.dart';
import 'package:mypass/screens/changeData/changeDataView.dart';
import 'package:mypass/screens/forgot/forgotView.dart';
import 'package:mypass/screens/home/homeView.dart';
import 'package:mypass/screens/passwords/create/create_pass_view.dart';
import 'package:mypass/screens/passwords/create/help_pass_view.dart';
import 'package:mypass/screens/passwords/save/save_pass_view.dart';
import 'package:mypass/screens/profile/deleteAccount/delete_view.dart';
import 'package:mypass/screens/profile/profileView.dart';
import '../screens/onboard/onboard_view.dart';

appRoutes () => [
  GetPage(
    name: '/onboard',
    page: () => OnboardView(),
    transition: Transition.native,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
  GetPage(
    name: '/signIn',
    page: () => SignInView(),
    transition: Transition.native,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
  GetPage(
    name: '/home',
    page: () => HomeView(),
    transition: Transition.downToUp,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
  GetPage(
    name: '/signUp',
    page: () => SignUpView(),
    transition: Transition.native,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
  GetPage(
    name: '/forgot',
    page: () => ForgorView(),
    transition: Transition.native,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
  GetPage(
    name: '/profile',
    page: () => ProfileView(),
    transition: Transition.cupertino,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
  GetPage(
    name: '/changeData',
    page: () => ChangeDataView(),
    transition: Transition.cupertino,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
  GetPage(
    name: '/create/password',
    page: () => PasswordView(),
    transition: Transition.cupertino,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
  GetPage(
    name: '/helpPass',
    page: () => HelpPassView(),
    transition: Transition.cupertino,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
  GetPage(
    name: '/savePass',
    page: () => SavePassView(),
    transition: Transition.cupertino,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
  GetPage(
    name: '/deleteAccount',
    page: () => DeleteView(),
    transition: Transition.native,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
];