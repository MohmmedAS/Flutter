import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Layout/newsapp/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/scinecs/scinecs_screen.dart';
import 'package:news_app/modules/setiting/setiting_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) =>BlocProvider.of(context);
int currentindex=0;
  List<BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'settings',
    ),
  ];

  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];
  void changeBottomNavBar(int index){
    currentindex =index;
    if(index ==1)
      getSports();
    if(index ==2)
      getScience();
    emit(NewsBottmNavState());
  }

  List<dynamic> business=[];
  void getBusiness(){

      emit(NewsGetBusinessLoadingState());

      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',

        },
      ).then((value) {
        // print(value.data['totalResults']);
        business=value?.data['articles'];
        print(business[0]['title']);
        emit(NewsBusinessSuccessState());

      }).catchError((error)
      {
        print(error.toString());
        emit(NewsBusinessErorrerState(error.toString()));
      });


  }


  List<dynamic> Sports=[];
  void getSports(){

    if(Sports.length==0){
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',

        },
      ).then((value) {
        // print(value.data['totalResults']);
        business=value!.data['articles'];
        print(Sports[0]['title']);
        emit(NewsSportsSuccessState());

      }).catchError((error)
      {
        print(error.toString());
        emit(NewsSportsErorrerState(error.toString()));
      });
    } else{
      emit(NewsSportsSuccessState());

    }

  }


  List<dynamic> Science=[];
  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(Science.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',

        },
      ).then((value) {
        // print(value.data['totalResults']);
        business=value!.data['articles'];
        print(Science[0]['title']);
        emit(NewsScienceSuccessState());

      }).catchError((error)
      {
        print(error.toString());
        emit(NewsScienceErorrerState(error.toString()));
      });
    } else{
      emit(NewsScienceSuccessState());

    }

  }

  // List<dynamic> search = [];
  //
  // void getSearch(String value)
  // {
  //   emit(NewsGetSearchLoadingState());
  //
  //   DioHelper.getData(
  //     url: 'v2/everything',
  //     query:
  //     {
  //       'q':'$value',
  //       'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
  //     },
  //   ).then((value)
  //   {
  //     //print(value.data['articles'][0]['title']);
  //     search = value.data['articles'];
  //     print(search[0]['title']);
  //
  //     emit(NewsGetSearchSuccessState());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(NewsGetSearchErrorState(error.toString()));
  //   });
  // }

}