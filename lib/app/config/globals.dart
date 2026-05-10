import 'package:logger/logger.dart';

import '../../routes/navigator.dart';
import '../../utils/dependency_injection/custom_getit.dart';

final Logger logger = Logger();

INavigator get iNavigator => sl<INavigator>();
