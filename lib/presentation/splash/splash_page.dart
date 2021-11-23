import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/splash/splash_bloc.dart';
import '../routes/app_routes.gr.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        state.maybeMap(
          onBoardedCheckCompleted: (result) {
            if(result.isOnboarded){
              context.router.replaceAll([
                const HomeRoute()
              ]);
            }else{
              context.router.replaceAll([
                const OnBoardingRoute()
              ]);
            }
          },
          orElse: () {},
        );
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
