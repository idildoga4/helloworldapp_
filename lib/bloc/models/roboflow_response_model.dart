import 'package:helloworld/bloc/models/prediction.dart';

import 'image_data.dart';

class RoboflowResultResponse {

  RoboflowResultResponse({
    required this.time,
    required this.image,
    required this.predictions,
  });

  factory RoboflowResultResponse.fromJson(Map<String, dynamic> json) {
    return RoboflowResultResponse(
      time: json['time'] as double,
      image: ImageData.fromJson(json['image'] as Map<String, dynamic>),
      predictions: (json['predictions'] as List<dynamic>)
          .map((x) => Prediction.fromJson(x as Map<String, dynamic>))
          .toList(),
    );
  }
  final double time;
  final ImageData image;
  final List<Prediction> predictions;

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'image': image.toJson(),
      'predictions': List<dynamic>.from(predictions.map((x) => x.toJson())),
    };
  }
}
