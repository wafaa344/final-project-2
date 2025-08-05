import 'package:get/get.dart';
import '../bottom_nav/bottom_nav.dart';
import '../homepage/home_page_screen.dart';
import '../login/login_binding.dart';
import '../login/loginscreen.dart';
import '../logout/logout_binding.dart';
import '../profile/profile_binding.dart';
import '../profile/profile_page.dart';
import '../search/search_binding.dart';
import '../signup/signup_binding.dart';
import '../signup/signup_screen.dart';
import '../splash/splash_binding.dart';
import '../splash/splash_screen.dart';
import '../survey/cost/cost_binding.dart';
import '../survey/cost/cost_dialog.dart';
import '../survey/survey_binding.dart';
import '../survey/survey_page.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
  static const homepage = '/homepage';
  static const String main = '/';
  static const String home = '/home';
  static const String company_details = "/company_details";
  static const String survey = '/survey';
  static const String cost = '/cost';
  static const profilepage = '/profilepage';


  static final routes = [
    GetPage(
      name: splash,
      page: () => Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: signup,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        SearchBindings().dependencies();
        LogoutBinding().dependencies();
      }),
    ),
    GetPage(
      name: survey,
      page: () => SurveyPage(),
      binding: SurveyBinding(),
    ),
    GetPage(
      name: cost,
      page: () => CostDialog(),
      binding: CostBinding(),
    ),
    GetPage(
      name: profilepage,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(name: main, page: () => const BottomNav()),
  ];
}
