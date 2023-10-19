
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/screen/view_model/home_cubit.dart';

import 'base_injection.dart';

class GenerateMultiBloc extends StatelessWidget {
  final Widget child;

  const GenerateMultiBloc({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:  [
        // BlocProvider<HomeCubit>(create: (BuildContext context) => HomeCubit()),
        // //*Profile
        BlocProvider<HomeCubit>(
            create: (BuildContext context) => HomeCubit( homeUseCase: getIt())),
      ],
      child: child,
    );
  }
}
