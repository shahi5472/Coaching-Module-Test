import '../../../../features/auth/services/data/login_response_model.dart';
import '../../../../features/auth/services/data/params/login_request_params.dart';

abstract class IGlobalRemoteDatasource {
  ///##########################################[Login]##########################################

  Future<LoginResponseModel> login(LoginRequestParams params);

  ///##########################################[Login]##########################################
}
