


import 'package:dartz/dartz.dart';
import 'package:my_rick_and_morty/data/datasource/remote/exception/error_widget.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/feature_data_layer/model/character_model.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/feature_domain_layer/repo/home_repo.dart';

import '../../../../core/base/base_response.dart';
import '../../../../core/base/base_usecase.dart';

class HomeUseCase extends BaseUseCase<BaseResponse , NoParameters> {
  final HomeRepo homeRepo;

  HomeUseCase({required this.homeRepo});
  /*
  * USE CASE
  * base on BaseUseCase
  * have Call and Call Test
  * it could some operation here before sending data to the Bloc // Cubit // provider // Get x provider
  *
  * */

  @override
  Future<Either<ErrorModel, BaseResponse>> call(NoParameters parameters) async {
    
   return await homeRepo.getCharacters(parameters: NoParameters(page: parameters.page));
  }

  @override
  Future<Either<ErrorModel, BaseResponse>> callTest(NoParameters  parameters)async  {
    return await homeRepo.getCharacters(parameters: NoParameters(page: parameters.page));
  }
}