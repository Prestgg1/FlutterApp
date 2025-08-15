import 'package:equatable/equatable.dart';

class AppointmentState extends Equatable {
  final DateTime? selectedDate;

  const AppointmentState({this.selectedDate});

  AppointmentState copyWith({DateTime? selectedDate}) {
    return AppointmentState(selectedDate: selectedDate ?? this.selectedDate);
  }

  @override
  List<Object?> get props => [selectedDate];
}
