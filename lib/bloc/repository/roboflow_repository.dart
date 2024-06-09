import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../models/roboflow_response_model.dart';

class RoboflowRepository {


  Future<RoboflowResultResponse?> predictImage(File image) async {
    String apiUrl =
        'https://detect.roboflow.com/eser-tanima/2?api_key=dTD0dIx6yJFwtzsGqxJH';

    final bytes = await image.readAsBytes();
    String base64Image = base64Encode(bytes);

    Dio dio = Dio();
    try {
      Response response = await dio.post(
        apiUrl,
        data: base64Image,
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return RoboflowResultResponse.fromJson(data as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
