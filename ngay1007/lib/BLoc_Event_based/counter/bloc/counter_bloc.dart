import 'package:bloc/bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0)) {
    // Đăng ký xử lý từng Event
    on<IncrementEvent>((event, emit) {
      emit(CounterState(state.value + 1));
    });

    on<DecrementEvent>((event, emit) {
      emit(CounterState(state.value - 1));
    });

    on<ResetEvent>((event, emit) {
      emit(CounterState(0));
    });
  }
}