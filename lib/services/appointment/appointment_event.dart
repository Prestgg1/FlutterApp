import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

class AppointmentDateSelected extends AppointmentEvent {
  final DateTime date;
  const AppointmentDateSelected(this.date);

  @override
  List<Object?> get props => [date];
}
