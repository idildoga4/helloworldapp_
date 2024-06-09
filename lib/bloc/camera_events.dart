import 'package:equatable/equatable.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class TogglePage extends CameraEvent {}
class SelectFileEvent extends CameraEvent {}
class CapturePhotoEvent extends CameraEvent {}
