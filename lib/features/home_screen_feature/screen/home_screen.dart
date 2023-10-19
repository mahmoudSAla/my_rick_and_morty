import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_rick_and_morty/core/extensions/num_extensions.dart';
import 'package:my_rick_and_morty/core/resources/resources.dart';
import 'package:my_rick_and_morty/core/routing/navigation_services.dart';
import 'package:my_rick_and_morty/core/routing/routes.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/screen/view_model/home_cubit.dart';
import 'package:my_rick_and_morty/widgets/custom_text.dart';
import 'package:my_rick_and_morty/widgets/cutom_shimmer_image.dart';
import 'package:my_rick_and_morty/widgets/spaces.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_rick_and_morty/widgets/tap_effect.dart';


import '../feature_data_layer/model/character_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen0State();
}

class _HomeScreen0State extends State<HomeScreen> {
   List<CharacterModel> characters = [];
  final ScrollController _controller = ScrollController(); 
  int counter = 0;
  final FocusNode _focusNode = FocusNode();
  double searchFieldSize = 140.w;
  final _scrollController = ScrollController() ;
  final GlobalKey<AnimatedListState>? listKey = GlobalKey<AnimatedListState>();
  @override
  void initState() {

    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      final result
       = await BlocProvider.of<HomeCubit>(context).getAllCharacters();
             result.data.forEach(
                (object) => characters.add(CharacterModel.fromJson(object)));

    });
    _controller.addListener(() async { 
       if (_controller.position.maxScrollExtent == _controller.offset) {
            final result
       = await BlocProvider.of<HomeCubit>(context).getAllCharacters();
             result.data.forEach(
                (object) => characters.add(CharacterModel.fromJson(object)));
       }

    }) ; 
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        searchFieldSize = 300.w;
        setState(() {});
      }
    });
  }
    Widget _buildBackground(){
    return   Container(
          width: deviceWidth,
          height: deviceHeight,
          child: Lottie.asset("assets/lottie/ZQaHs1XL9g.json" , fit: BoxFit.cover  , ),
         ) ; 
  } 
  Widget slideIt(BuildContext context, int index) {
    CharacterModel  item = characters[index];

    return  TapEffect(onClick: (){
      NavigationService.push(Routes.characterDetails , arguments: {"characterModel" : item});
    }, child: GridTile(
      footer: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.r) , bottomRight: Radius.circular(15.r)) ,
          color: Colors.primaries[characters[index].id! % Colors.primaries.length],
        ),
        child: Center(
          child: CustomText("${item.name}" , color: Colors.white, size: 20.h,),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child:  CustomShimmerImage(image: "${item.image}" ) ,
      ),
    )) ;
  }
  Widget _buildCubitWidget() {
    return BlocBuilder<HomeCubit, HomeState>(
        builder: (_, state) {
          if(state is DataLoaded){

            return Stack(
              children: [
                _buildBackground() , 
                AnimationLimiter(
                  child:  SizedBox(
                    height: deviceHeight * 0.88,
                    child:
                      GridView.count(
                        childAspectRatio: 1.0,
                        padding:  EdgeInsets.all(10.h),
                        crossAxisCount: 2,
                        controller: _controller,
                        mainAxisSpacing: 15.h,
                        crossAxisSpacing: 15.h,
                        children: List.generate(
                          characters.length,
                              (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: 2,
                              position: index,
                              duration: const Duration(milliseconds: 1000),
                              child:  ScaleAnimation(
                                scale: 0.3,
                                child: FadeInAnimation(
                                  child: slideIt(context ,  index),
                                ),
                              ),
                            );
                          },
                        ),
                      )

                  ),

                ),
              ],
            ) ;
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            ) ;
          }
        });
  }

  Widget _searchBuilder(){
    return  AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: searchFieldSize,

      padding: const EdgeInsets.only(top: 12, right: 18, left: 8),
      child: TextField(
        focusNode: _focusNode,
        autofocus: false,

        style: const TextStyle(fontSize: 22.0, color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search',
          suffixIcon: _focusNode.hasFocus  ?
          TapEffect(onClick: (){setState(() {
            _focusNode.unfocus();
            searchFieldSize = 140.w ;
          });}, child: const Icon(Icons.close)) : SizedBox(),
          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.7),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.7),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(70.h), child: AppBar(

        title:  !_focusNode.hasFocus ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            VerticalSpace(15.h) ,
            CustomText("Rick and Morty" ,size: 22.h,white: false,color: Colors.white
              ,).underline()
          ],
        ): Column(
          children: [
            VerticalSpace(14.h) ,
            Icon(Icons.search , color: Colors.white,size: 44.h,)
          ],
        ),
        backgroundColor: Colors.black,
        actions: [
          HorizontalSpace(10.w) ,
          _searchBuilder()
        ],
      )),
      body: _buildCubitWidget(),
    );
  }
}
