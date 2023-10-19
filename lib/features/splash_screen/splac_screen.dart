


import 'package:flutter/material.dart' ; 
import 'package:my_rick_and_morty/core/extensions/num_extensions.dart';
import 'package:my_rick_and_morty/core/resources/resources.dart';
import 'package:my_rick_and_morty/core/routing/navigation_services.dart';
import 'package:my_rick_and_morty/core/routing/routes.dart';
import 'package:my_rick_and_morty/widgets/custom_text.dart';
import 'package:my_rick_and_morty/widgets/spaces.dart';
import 'package:lottie/lottie.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5) , ()async{
      NavigationService.pushNamedAndRemoveUntil(Routes.home);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/6dd2536db9b64a62df9ac64ed2a01efc.jpg") , fit: BoxFit.cover)
        ),
        child: Column(
          crossAxisAlignment: 
          CrossAxisAlignment.center,

          children: [
            // VerticalSpace(100.h) ,
            Lottie.asset("assets/lottie/animation_ln905xmy.json" , width: 300.w) , 
            
            CustomText("""Rick And Morty""" , color: AppColorLight().kErrorColor,size: 40.h,)
          
          
          ],
        ),
      ),
    );
  }
}

