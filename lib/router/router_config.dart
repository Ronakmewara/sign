import 'dart:ui';

import 'package:go_router/go_router.dart';
import 'package:signup_page/D_Injection/construnctor.dart';
import 'package:signup_page/Module/blocloginapi/bloc/login_bloc.dart';
import 'package:signup_page/model_class/post.dart';
import 'package:signup_page/model_class/user_sharedprefs.dart';
import 'package:signup_page/presentation/apidata_list/apidata_details/apidata_details.dart';
import 'package:signup_page/presentation/apidata_list/homepage/apilist_homepage.dart';
import 'package:signup_page/presentation/beerlist_app_bloc/presentation/screens/beer_details/beer_details.dart';
import 'package:signup_page/presentation/beerlist_app_bloc/presentation/screens/infinite_beer_listing/infinite_list.dart';
import 'package:signup_page/presentation/login/login.dart';
import 'package:signup_page/presentation/mainpagewithbar/mainpagewithbar.dart';
import 'package:signup_page/presentation/signup/signup.dart';
import 'package:signup_page/presentation/splash_screen/splash.dart';
import 'package:signup_page/presentation/updateprofile/updateprofile.dart';
import 'package:signup_page/router/router_constants.dart';

import '../Module/beerlist_app_without_bloc/beer_infinite_listing.dart';
import '../Module/blocloginapi/ui/loginform.dart';
import '../presentation/beerlist_app_bloc/data/model/beer_model/model_beer.dart';

class MyRouter {
  GoRouter router =
      GoRouter(initialLocation: RouterConstants.constructorInjectionPage, routes: [
    GoRoute(
        name: 'splashScreen',
        path: RouterConstants.splashScreenRoute,
        builder: (context, state) {
          return const SplashScreen();
        }),
        GoRoute(
        name: 'Constructor Injection',
        path: RouterConstants.constructorInjectionPage,
        builder: (context, state) {
          return const ConstructorInjection();
        }),
    GoRoute(
        name: 'SignupPage',
        path: RouterConstants.signupPageRoute,
        builder: (context, state) {
          return const Signup();
        }),
    GoRoute(
        name: 'LoginPage',
        path: RouterConstants.loginPageRoute,
        builder: (context, state) {
          return const LoginPage();
        }),
    GoRoute(
        name: 'BeerListWithoutBloc',
        path: RouterConstants.beerListWithoutBlocRoute,
        builder: (context, state) {
          return const InfiniteListWithoutBloc();
        }),
    GoRoute(
        name: 'appListPage',
        path: RouterConstants.appListRoute,
        builder: (context, state) {
          return const MainPage();
        }),
    GoRoute(
        name: 'apiDataList',
        path: RouterConstants.apiDataList,
        builder: (context, state) {
          return const ApiDataList();
        }),
    GoRoute(
        name: 'apiDataDetails',
        path: RouterConstants.apiDataDetails,
        builder: (context, state) {
          final Post post = state.extra! as Post;
          return DetailsPage(post: post);
        }),
    GoRoute(
        name: 'BeerListWithBloc',
        path: RouterConstants.beerListWithBlocRoute,
        builder: (context, state) {
          return const InfiniteList();
        }),
    GoRoute(
        name: 'ApiLoginWithBloc',
        path: RouterConstants.apiLoginWithBloc,
        builder: (context, state) {
          return const LoginFormNew();
        }),
    GoRoute(
        name: 'updateProfile',
        path: RouterConstants.updateProfileRoute,
        builder: (context, state) {
          final data = state.extra!;

          return  UpdateForm(data: data);
        }),
    GoRoute(
        name: 'BeerDetailsPage',
        path: "${RouterConstants.beerDetailsRoute}/:index/:color",
        builder: (context, state) {
          final index = state.pathParameters['index']! as String;
          final String color = state.pathParameters['color']!;

          final Beer beer = state.extra! as Beer;
          return BeerDetailsPage(
            beerDetails: beer,
            index: index,
            color: color,
          );
        }),
  ]);
}
