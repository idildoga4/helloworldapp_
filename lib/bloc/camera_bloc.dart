import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:helloworld/bloc/camera_events.dart';
import 'package:helloworld/bloc/camera_states.dart';
import 'package:image_picker/image_picker.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final ImagePicker _picker = ImagePicker();

  CameraBloc() : super(CameraInitial()) {
    on<SelectFileEvent>(_onSelectFile);
    on<CapturePhotoEvent>(_onCapturePhoto);
  }

  Future<void> _onSelectFile(SelectFileEvent event, Emitter<CameraState> emit) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(FileSelectedState(pickedFile.path));
    }
  }

  Future<void> _onCapturePhoto(CapturePhotoEvent event, Emitter<CameraState> emit) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      emit(PhotoCapturedState(pickedFile.path));
    }
  }
}
