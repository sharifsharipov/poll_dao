part of 'create_poll_bloc.dart';

@immutable
class CreatePollState extends Equatable {
  final String? statusText;
  final FormStatus? status;
  final CreatedPollModel? createdPollModel;
  const CreatePollState({this.statusText, this.status = FormStatus.pure, this.createdPollModel});
  CreatePollState copyWith({String? statusText, FormStatus? status, CreatedPollModel? createdPollModel}) {
    return CreatePollState(
      statusText: statusText ?? this.statusText,
      status: status ?? this.status,
      createdPollModel: createdPollModel ?? this.createdPollModel
    );
  }
  @override
  List<Object?> get props => [
    statusText,
    status,
    createdPollModel
  ];
}
