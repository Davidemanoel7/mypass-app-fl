
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/auth/signInView.dart';
import 'package:mypass/screens/auth/signUpView.dart';
import 'package:mypass/screens/home/homeView.dart';

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
];