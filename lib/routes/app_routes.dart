part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const login = _Paths.login;
  static const home = _Paths.home;
  static const coachingDetails = _Paths.coachingDetails;
}

abstract class _Paths {
  _Paths._();

  static const login = '/login';
  static const home = '/home';
  static const coachingDetails = '/coaching-details';
}
