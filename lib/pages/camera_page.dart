import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helloworld/bottomnavbar.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/camera_bloc.dart';
import '../bloc/camera_states.dart';
import '../bloc/predict_image_cubit/predict_image_cubit.dart';
import 'infoPage.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? imageFile;

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picture != null) {
      File tempImageFile = File(picture.path);
      setState(() {
        imageFile = tempImageFile;
      });
      handlePredictImage(tempImageFile);
    }
    pop();
    pushToInfoPage();
  }

  void pop() => Navigator.of(context).pop();

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picture != null) {
      File imageFile = File(picture.path);
      setState(() {
        this.imageFile = imageFile;
      });
      handlePredictImage(imageFile);
    }
    pop();
    pushToInfoPage();
  }

  Future<dynamic> pushToInfoPage() =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => infoPage(
            imageFile: imageFile,
          )));

  void handlePredictImage(File imageFile) {
    context.read<PredictImageCubit>().predictImage(imageFile);
  }

  void _showChoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('choose'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('library'),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('camera'),
                  onTap: () {
                    _openCamera(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Column(
        children: [
          Container(child: Text(
            'img',
            style: TextStyle(color: Color(0xff303F9F),fontSize: 25,fontWeight: FontWeight.w600),
          ),),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imagenotfound.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.47,

          ),
        ],
      );
    } else {
      return SizedBox(
        width: 300,height: 300,
        child: Image.file(
          imageFile!,
          width: 300,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      textStyle: TextStyle(fontSize: 20),
    );

    return  Scaffold(
      body: BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is CameraInitial) ...[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              child: Center(child: Icon(Icons.file_upload, size: 40)),
                            ),
                            const SizedBox(width: 10),
                            RichText(
                              text: const TextSpan(
                                text: 'Yüklemek için ',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'dosyayı',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  TextSpan(text: ' seçin'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Jpg, Png veya Image seçin.',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            _showChoiceDialog(context);
                          },
                          child: const Text(
                            "Seç",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              child: Center(child: Icon(Icons.camera, size: 40)),
                            ),
                            const SizedBox(width: 10),
                            RichText(
                              text: const TextSpan(
                                text: 'Bir fotoğraf ',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'çekin',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Kameranızla fotoğraf çekin',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            _showChoiceDialog(context);
                          },
                          child: const Text(
                            "Çek",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                if (state is FileSelectedState || state is PhotoCapturedState) ...[
                  _decideImageView(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      child: Text(
                        'choose photo',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1,),
    );
  }
}

