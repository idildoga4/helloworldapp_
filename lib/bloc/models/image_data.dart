class ImageData {
  final int width;
  final int height;

  ImageData({
    required this.width,
    required this.height,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      width: json['width'] as int,
      height: json['height'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
    };
  }
}