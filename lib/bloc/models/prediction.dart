class Prediction {
  final double x;
  final double y;
  final double width;
  final double height;
  final double confidence;
  final String className;
  final int classId;
  final String detectionId;

  Prediction({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.confidence,
    required this.className,
    required this.classId,
    required this.detectionId,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      x: json['x'] as double,
      y: json['y'] as double ,
      width: json['width'] as double,
      height: json['height'] as double ,
      confidence: json['confidence'] as double ,
      className: json['class'] as String,
      classId: json['class_id'] as int,
      detectionId: json['detection_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'confidence': confidence,
      'class': className,
      'class_id': classId,
      'detection_id': detectionId,
    };
  }
}
