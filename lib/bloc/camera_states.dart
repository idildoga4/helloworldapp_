abstract class CameraState {}

class CameraInitial extends CameraState {}

class FileSelectedState extends CameraState {
  final String filePath;
  FileSelectedState(this.filePath);
}

class PhotoCapturedState extends CameraState {
  final String filePath;
  PhotoCapturedState(this.filePath);
}
