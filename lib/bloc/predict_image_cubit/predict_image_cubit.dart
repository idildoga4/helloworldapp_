import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';


import '../models/roboflow_response_model.dart';
import '../repository/roboflow_repository.dart';

class PredictImageCubit extends Cubit<PredictImageState> {
  PredictImageCubit() : super(PredictImageInitial());

  RoboflowRepository repository = RoboflowRepository();

  Future<void> predictImage(File image) async {
    emit(PredictImageLoading());
    final result = await repository.predictImage(image);
    if (result != null) {
      emit(PredictImageSuccess(result));
    } else {
      emit(PredictImageError('Bir şeyler ters gitti.'));
    }
  }
}

abstract class PredictImageState {}

class PredictImageInitial extends PredictImageState {}

class PredictImageLoading extends PredictImageState {}

class PredictImageSuccess extends PredictImageState {
  final RoboflowResultResponse result;

  PredictImageSuccess(this.result);
}

class PredictImageError extends PredictImageState {
  String errorMessage;
  PredictImageError(this.errorMessage);
}
