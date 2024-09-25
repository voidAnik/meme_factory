import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditImageCubit extends Cubit<Uint8List> {
  EditImageCubit() : super(Uint8List(0));

  void updateImage(Uint8List newImage) {
    emit(newImage);
  }
}
