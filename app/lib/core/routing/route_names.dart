/// Every path in one place, so links are never typed by hand.
abstract final class Routes {
  static const signIn = '/sign-in';
  static const home = '/';
  static const players = '/players';
  static String player(String id) => '/players/$id';
  static String ratePlayer(String id) => '/players/$id/rate';
  static const tables = '/tables';
  static const credit = '/credit';
  static String creditApplication(String id) => '/credit/$id';
  static const compliance = '/compliance';
  static const evaluate = '/evaluate';
  static const staffing = '/staffing';
  static const library = '/library';
  static const settings = '/settings';
}
