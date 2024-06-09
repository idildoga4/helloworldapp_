import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/predict_image_cubit/predict_image_cubit.dart';

class infoPage extends StatefulWidget {
  const infoPage({Key? key, this.imageFile});

  @override
  State<infoPage> createState() => _infoPageState();

  final File? imageFile;
}

class _infoPageState extends State<infoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Make body extend behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove shadow under app bar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Colors.blue,
          onPressed: () {
            // İkona basıldığında yapılacak işlemler buraya yazılır
Navigator.pop(context);
            print('Geri butonuna basıldı!');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Kalp ikonuna basıldığında yapılacak işlemler buraya yazılır
              print('Kalp ikonuna basıldı!');
            },
            icon: Icon(Icons.favorite),
            color: Colors.red, // İkonun rengini kırmızı yapar
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: Image.memory(
                widget.imageFile!.readAsBytesSync(),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.42, // Adjust as needed
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height:
                  MediaQuery.of(context).size.height * 55, // Adjust as needed
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  PredictedImageText(),
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left:28.0),
                    child: Container(decoration:BoxDecoration(borderRadius:BorderRadius.circular(10),color: Color(0xff303F9F)),child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Ayrıntılar',style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w700),),
                    ),),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(10.0),


                      ),
                      child: SingleChildScrollView(
                        child: Center(
                          child: const PredictedDesc(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PredictedImageText extends StatelessWidget {
  const PredictedImageText({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictImageCubit, PredictImageState>(
      builder: (context, state) {
        if (state is PredictImageLoading) {
          return const CircularProgressIndicator();
        }
        if (state is PredictImageError) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                state.errorMessage,
                style: GoogleFonts.merriweather(
                  textStyle:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }
        if (state is PredictImageSuccess) {
          var result = '';

          if (state.result.predictions.isEmpty) {
            result = 'bulunamadı';
          } else {
            result = state.result.predictions.first.className;
          }

          return Container(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                result,
                style: GoogleFonts.merriweather(
                  textStyle:
                      TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class PredictedDesc extends StatelessWidget {
  const PredictedDesc({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictImageCubit, PredictImageState>(
      builder: (context, state) {
        if (state is PredictImageLoading) {
          return const CircularProgressIndicator();
        }
        if (state is PredictImageError) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                state.errorMessage,
                style: GoogleFonts.merriweather(
                  textStyle:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }
        if (state is PredictImageSuccess) {
          var result = '';
          FirebaseFirestore obje = FirebaseFirestore.instance;
          CollectionReference ObjectCollectionRef =
              FirebaseFirestore.instance.collection(('objects'));

          if (state.result.predictions.isEmpty) {
            result = 'Açıklama Bulunamadı';
          } else {
            if (state.result.predictions.first.confidence > 0.64) {
              print(
                  "confidence level: ${state.result.predictions.first.confidence}"); //Kontrol için yazdık.
              result = state.result.predictions.first.className;
              return FutureBuilder<String>(
                future: readDesc(result),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Hata: ${snapshot.error}');
                  } else {
                    return Text(
                      snapshot.data ?? 'Veri bulunamadı',
                      style: GoogleFonts.merriweather(
                        textStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                    );
                  }
                },
              );
            } else {
              result = "bulunamadı";
            }
          }

          return Container(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                result,
                style: GoogleFonts.merriweather(
                  textStyle:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<String> readDesc(String result) async {
    FirebaseFirestore obje = FirebaseFirestore.instance;
    CollectionReference objectCollectionRef = obje.collection('objects');

    if (result == 'truva') {
      var truvaRef = objectCollectionRef.doc('Truva');
      var response = await truvaRef.get();
      var rData = (response.data() as Map<String, dynamic>)['Desc'];
      print(rData); //kontrol için yazdım.
      return rData
          .toString(); // Firestore'dan gelen veriyi stringe dönüştürüp döndürüyoruz
    } else if (result == 'marcus') {
      var artemisRef = objectCollectionRef.doc('Artemis');
      var response = await artemisRef.get();
      var rData = (response.data() as Map<String, dynamic>)['Desc'];
      print(rData); //kontrol için yazdım.
      return rData
          .toString(); // Firestore'dan gelen veriyi stringe dönüştürüp döndürüyoruz
    } else {
      return 'Veri bulunamadı';
    }
  }
}
