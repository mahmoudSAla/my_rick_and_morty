


import 'package:dartz/dartz.dart';
import 'package:my_rick_and_morty/core/base/base_usecase.dart';
import 'package:my_rick_and_morty/data/datasource/remote/exception/error_widget.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/feature_data_layer/model/character_model.dart';

import '../../../../core/base/base_response.dart';

abstract class HomeRepo {


   //get home data
  /*
  * add new repo feature  ; 
  * get all characters in home  ;
  * Either returns all characters or return Error model
  * if no connextion go to no connextion page
  * */
  Future<Either<ErrorModel , BaseResponse>> getCharacters (  { required NoParameters parameters}) ;
}