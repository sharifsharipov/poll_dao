part of 'image_text_edition_controller_cubit.dart';

@immutable
abstract class ImageTextEditionControllerState extends Equatable {
  @override
  
  List<Object?> get props => throw UnimplementedError();
}

class ImageTextEditionControllerInitial extends ImageTextEditionControllerState {}

class ImageTextEditionControllerLoading extends ImageTextEditionControllerState {}

class ImageTextEditionControllerLoaded extends ImageTextEditionControllerState {
  final int index;
  final TextEditingController controllers;
  ImageTextEditionControllerLoaded({required this.index, required this.controllers});
}

class ImageTextEditionControllerSuccess extends ImageTextEditionControllerState {}

class ImageTextEditionControllerError extends ImageTextEditionControllerState {
  final String message;
  ImageTextEditionControllerError({required this.message});
}


