import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helloworld/bloc/camera_bloc.dart';
import 'package:helloworld/pages/infoPage.dart';
import 'package:helloworld/pages/map_Page.dart';
import 'package:helloworld/pages/sec_homepage.dart';
import 'package:helloworld/pages/homepage.dart';
import 'package:helloworld/pages/camera_page.dart';
import 'package:helloworld/bloc/welcome/welcome_bloc.dart';
import 'package:helloworld/bloc/welcome/welcome_states.dart';

import 'bloc/models/firebase_options.dart';

import 'bloc/predict_image_cubit/predict_image_cubit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PageBloc>(
          create: (context) => PageBloc(),
        ),
        BlocProvider<CameraBloc>(
          create: (context) => CameraBloc(),
        ),
        BlocProvider<PredictImageCubit>(
          create: (_) => PredictImageCubit(),
        ),


      ],
      child: MaterialApp(
        home: HomePage(),
        initialRoute: '/',
        routes: {
          
          '/homepage':(context) => HomePageWidget(),
          '/camera': (context) => CameraPage(),
          '/mappage':(context)=> MapPage(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(

      body: BlocBuilder<PageBloc, PageState>(
        builder: (context, state) {
          if (state is Page1State) {
            return HomePageWidget();
          } else if (state is Page2State) {
            return SecHomePage();
          } else {
            return Container();
          }
        },
      ),
      
    );
  }
}