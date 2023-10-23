import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/newpost.dart';
import '../../../domain/usecase/newpost_usecase.dart';
import 'newpost_state.dart';

part 'newpost_event.dart';
// part 'newpost_state.dart';

class NewpostBloc extends Bloc<NewpostEvent, NewpostState> {
  final PostNewUseCase postNewUseCase;

  NewpostBloc(this.postNewUseCase) : super(const NewpostState()) {
    on<NewPostRequest>(_handlePostRecuested);
    // on<LocalSingleView>(_handleViewLocal);
    // on<DeleteLocalSingleView>(_handleCloseViewLocal);
    // on<LocalSingleRequest>(_handleSinglePostRecuested);
  }

  Future<void> _handlePostRecuested(
    event,
    Emitter<NewpostState> emit,
  ) async {
    // print("data 1");
    try {
      emit(state.copyWith(
        npStatus: NewPRequest.unknown,
      ));

      final response = await postNewUseCase.execute(event.newPost);
    
      emit(
        state.copyWith(
          npStatus: NewPRequest.requestSuccess,
          newPost: response,
        ),
      );
    } catch (e) {
      print(e);
      emit(state.copyWith(
        npStatus: NewPRequest.requestFailure,
      ));
    }
  }
}
