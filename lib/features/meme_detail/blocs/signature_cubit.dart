import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignatureCubit extends Cubit<Uint8List> {
  SignatureCubit() : super(Uint8List(0));

  void updateSignature(Uint8List signature) {
    emit(signature);
  }
}
