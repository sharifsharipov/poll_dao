import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poll_dao/src/features/custom_sliver_example/data/models/create_poll_model.dart';
import 'package:poll_dao/src/features/widget_servers/status/status.dart';

part 'create_poll_event.dart';
part 'create_poll_state.dart';

class CreatePollBloc extends Bloc<CreatePollEvent, CreatePollState> {
  CreatePollBloc() : super(const CreatePollState()) {
    on<CreatePollEvent>((event, emit) {
     
    });
  }
}
