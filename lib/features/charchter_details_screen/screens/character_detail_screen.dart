import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:my_rick_and_morty/core/extensions/num_extensions.dart';
import 'package:my_rick_and_morty/core/resources/resources.dart';
import 'package:my_rick_and_morty/core/routing/navigation_services.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/feature_data_layer/model/character_model.dart';
import 'package:my_rick_and_morty/widgets/custom_text.dart';
import 'package:my_rick_and_morty/widgets/cutom_shimmer_image.dart';
import 'package:my_rick_and_morty/widgets/spaces.dart';
import 'package:my_rick_and_morty/widgets/tap_effect.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CharacterDetailScreen extends StatefulWidget {
  final CharacterModel characterModel;
  const CharacterDetailScreen({super.key, required this.characterModel});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  Widget _buildBackground() {
    return Container(
      width: deviceWidth,
      height: deviceHeight,
      child: Lottie.asset(
        "assets/lottie/ZQaHs1XL9g.json",
        fit: BoxFit.cover,
      ),
    );
  }

  double infoCardWidthSize = 100.w;
  double epCardWidth = 100.w ; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      
      infoCardWidthSize = 209.w;
      epCardWidth = 380.w ; 
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CustomText(
          "Character Details",
          color: Colors.white,
          size: 20.h,
        ).header(),
        centerTitle: true,
        leading: SizedBox(
          width: 40.w,
          child: TapEffect(
              onClick: () {
                NavigationService.goBack();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
      ),
      body: Stack(children: [
        _buildBackground(),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BuildInfoCard(widget: widget, infoCardWidthSize: infoCardWidthSize) , 
                VerticalSpace(10.h) , 
                AnimatedContainer(duration: const Duration(milliseconds: 1700) , 
                  curve: Curves.linear  ,
                  width: epCardWidth,
               
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3) , 
                    border: Border.all(color: Colors.green  , width: 2),  
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.r) ,  
                      bottomRight: Radius.circular(12.r) , 
                      topRight: Radius.circular(15.r) , 
                    
                    )
                  ),
                  child: Column(
                    children: [
                      CustomText("Eps character that showed in..." , color: Colors.white, size: 20.h,) , 
                      AnimationLimiter(

            child: GridView.count(
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.h,
              children: List.generate(
                widget.characterModel.episode!.length,
                (int index) {
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: 4,
                    position: index,
                    duration: const Duration(milliseconds: 1000),

                    child:  ScaleAnimation(
                      scale: 0.5,
                      child: FadeInAnimation(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.accents[index% Colors.accents.length].withOpacity(0.5) , 
                            border: Border.all(color: Colors.white ) , 
                            borderRadius: BorderRadius.only(
                              bottomLeft: index.isEven ? Radius.circular(0.r ) : Radius.circular(15.r) , 
                              bottomRight: index.isOdd? Radius.circular(15.r) : Radius.circular(0.r) , 
                              topLeft: index.isEven? Radius.circular(0.r) : Radius.circular(15.r) , 
                              topRight: index.isEven? Radius.circular(15.r) : Radius.circular(0.r)
                            )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText("EP" , color: Colors.white,size: 30.h,ph: 0) , 
                              CustomText("${widget.characterModel.episode?[index].split("/").last}" , color: Colors.white,size: 22.h,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class BuildInfoCard extends StatelessWidget {
  const BuildInfoCard({
    super.key,
    required this.widget,
    required this.infoCardWidthSize,

  });

  final CharacterDetailScreen widget;
  final double infoCardWidthSize;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomShimmerImage(
          image: "${widget.characterModel.image}",
          width: 110.w,
 
          boxFit: BoxFit.fill,
        ) , 
        HorizontalSpace(10.w) , 
        AnimatedContainer(
          duration: const Duration(
            milliseconds: 1500,
          ),
          onEnd: (){},
          padding: EdgeInsets.all(10.h),
          width: infoCardWidthSize,
 
          curve: Curves.linear,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            border: Border.all(
              color: Colors.green,
              width: 2,
            ),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(10.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedTextBuilder(
                  widget: """Name: ${widget.characterModel.name}\n\nGender: ${widget.characterModel.gender}\n\nSpecies: ${widget.characterModel.species}\n\nLocation: ${widget.characterModel.location?.name},${widget.characterModel.origin?.name}\n\nStatus: ${widget.characterModel.status}""",
                  keyName: ""),

            ],
          ),
        ),
               
        
      ],
    );
  }
}

class AnimatedTextBuilder extends StatelessWidget {
  const AnimatedTextBuilder(
      {super.key, required this.widget, required this.keyName});

  final String widget;
  final String keyName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360.w,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 20.h,
          fontFamily: 'Creepster',
        ),
        maxLines: 1,
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText('$widget'),
          ],
          displayFullTextOnTap: true,
          isRepeatingAnimation: false,
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
}
