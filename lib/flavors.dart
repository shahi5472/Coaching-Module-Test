import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavor { prod, dev }

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static Flavor get currentFlavor => appFlavor;

  static bool get isProduction => (currentFlavor == Flavor.prod);

  static String get title => dotenv.get("TITLE");

  static String get baseUrl => dotenv.get("BASE_URL");

  static String get dotEnvPath {
    switch (appFlavor) {
      case Flavor.prod:
        return "env/.env_prod";
      case Flavor.dev:
        return "env/.env_dev";
    }
  }
}
