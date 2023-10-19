
// import 'package:my_rick_and_morty/core/base/base_states.dart';
// import 'package:my_rick_and_morty/logic/profile/profile_cubit.dart';
// import 'package:my_rick_and_morty/widgets/error_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<ProfileCubit, ProfileState>(
//         builder: (context, state) {
//           if (state.state == BaseState.loading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.state == BaseState.loaded) {
//             return _buildProfile(context);
//           } else if (state.state == BaseState.error) {
//             return ErrorLayout(
//               errorModel: state.error,
//               onRetry: () => context.read<ProfileCubit>().getProfile(),
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );s
//   }

//   Widget _buildProfile(BuildContext context) {
//     return Container();
//   }
// }
