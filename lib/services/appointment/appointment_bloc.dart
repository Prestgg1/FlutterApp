import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(const AppointmentState()) {
    on<AppointmentDateSelected>((event, emit) {
      emit(state.copyWith(selectedDate: event.date));
    });
  }
}
