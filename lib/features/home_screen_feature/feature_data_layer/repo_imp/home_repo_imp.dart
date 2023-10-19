import 'package:dartz/dartz.dart';
import 'package:my_rick_and_morty/core/base/base_response.dart';
import 'package:my_rick_and_morty/core/base/base_usecase.dart';
import 'package:my_rick_and_morty/data/datasource/remote/exception/error_widget.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/feature_data_layer/model/character_model.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/feature_domain_layer/repo/home_repo.dart';

import '../../../../core/services/network/network_client.dart';
import '../../../../data/app_urls/app_url.dart';

class HomeRepoImpl implements HomeRepo {
  final NetworkClient networkClient;
  HomeRepoImpl({required this.networkClient});
  @override
  Future<Either<ErrorModel, BaseResponse>> getCharacters({required NoParameters parameters}) async {
    /*
    * Repo implementation
    * get Url
    * Network call type (get / post /  put / delete)
    * call API
    *fold the data  ( l(Error happened) , r(Data returned successfully ))
    *  */
    String url = AppURL.allCharactersApi;
    NetworkCallType type = NetworkCallType.get;
    Map<String, dynamic> data = {};
    Either<ErrorModel, BaseResponse> result =
        await networkClient(url: "$url?page=${parameters.page}", data: data, type: type);

    return result.fold((l) => Left(l), (r) {
      try {
        BaseResponse userModel = r;
        

        return Right(userModel);
      } catch (e) {
        return Left(ErrorModel(errorMessage: e.toString()));
      }
    });
  }
}
