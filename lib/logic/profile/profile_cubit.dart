
// import 'package:my_rick_and_morty/core/base/base_states.dart';
// import 'package:my_rick_and_morty/core/base/base_usecase.dart';
// import 'package:my_rick_and_morty/data/datasource/remote/exception/error_widget.dart';

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'profile_state.dart';

// class ProfileCubit extends Cubit<ProfileState> {
//   final ProfileUseCase profileUseCase;
//   ProfileCubit(
//     this.profileUseCase,
//   ) : super(const ProfileState());
//   Future<UserModel> getProfile({bool returnSaved = false}) async {
//     if (returnSaved) {
//       if (state.data != null) return state.data!;
//     }
//     resetState();
//     emit(state.copyWith(state: BaseState.loading));
//     final result = await profileUseCase.call( NoParameters());
//     return result.fold(
//       (error) {
//         emit(state.copyWith(state: BaseState.error, error: error));
//         return Future.error(error);
//       },
//       (data) {
//         emit(state.copyWith(state: BaseState.loaded, data: data));
//         return data;
//       },
//     );
//   }

//   void resetState() {
//     emit(state.copyWith(
//       updateState: BaseState.initial,
//       updatePasswordState: BaseState.initial,
//       error: null,
//     ));
//   }
// }
