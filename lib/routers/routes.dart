
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/auth/signInView.dart';
import 'package:mypass/screens/auth/signUpView.dart';
import 'package:mypass/screens/changeData/changeDataView.dart';
import 'package:mypass/screens/forgot/forgotView.dart';
import 'package:mypass/screens/home/homeView.dart';
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
    transition: Transition.native,
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
    transition: Transition.native,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
  GetPage(
    name: '/changeData',
    page: () => ChangeDataView(),
    transition: Transition.native,
    transitionDuration: const Duration( milliseconds: 500 ),
  ),
];