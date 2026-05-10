import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

T sl<T extends Object>({String? instanceName}) => getIt.get<T>(instanceName: instanceName);
