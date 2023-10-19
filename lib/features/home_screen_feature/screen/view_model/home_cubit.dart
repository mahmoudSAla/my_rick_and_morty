

// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import 'package:my_rick_and_morty/core/base/base_usecase.dart';
import 'package:my_rick_and_morty/core/utils/alerts.dart';

import '../../../../core/base/base_response.dart';
import '../../feature_data_layer/model/character_model.dart';
import '../../feature_domain_layer/use_case/home_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase homeUseCase ;
  HomeCubit({required this.homeUseCase}) : super(HomeInitial());

  final GlobalKey<AnimatedListState>? listKey = GlobalKey<AnimatedListState>();
  final ScrollController scrollController = ScrollController(initialScrollOffset: 0.0);
  bool searchState = false ;
    int page = 1;
  bool hasMore = true;

  Future<BaseResponse> getAllCharacters()async{
   final result  = await homeUseCase.call( NoParameters(page: page) );

      
   return result.fold((l) {
     Alerts.showSnackBar("${l.errorMessage}") ;
     return Future.error(l);
   }, (r) {

   if (page <= r.info!.pages!) {
        if (page == r.info!.pages!) {
          hasMore = false;
        }

        page = page + 1;
      } else {
        hasMore = false;

      }
      List<CharacterModel>data = []  ; 
      r.data.forEach(
                (object) => data.add(CharacterModel.fromJson(object)));

     emit(DataLoaded(characters: data));
     return r ;
   });
  }


  changeSearchState(){
    searchState  = !searchState ;
    emit(SearchState(searchState: searchState));
    return searchState ;
  }
}
