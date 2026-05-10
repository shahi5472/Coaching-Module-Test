import '../../../../../app/model/base/errors/failures.dart';
import '../../../../../app/network/api_path.dart';
import '../../../../../app/network/dio_wrapper.dart';
import '../../../../features/auth/services/data/login_response_model.dart';
import '../../../../features/auth/services/data/params/login_request_params.dart';
import 'i_global_remote_datasource.dart';

class GlobalRemoteDatasourceImpl extends IGlobalRemoteDatasource {
  final IDioWrapper _dio;

  GlobalRemoteDatasourceImpl({required IDioWrapper dio}) : _dio = dio;

  @override
  Future<LoginResponseModel> login(LoginRequestParams params) async {
    final result = await _dio.onPost(api: APIPaths.login, data: params.toJson);
    if (result.data != null) {
      return LoginResponseModel.fromJson(result.data);
    }
    throw const ServerFailure("Something went wrong");
  }
}
