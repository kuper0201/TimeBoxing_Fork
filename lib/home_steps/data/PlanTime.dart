import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:equatable/equatable.dart';

class PlanTime extends FlutterWeekViewEvent with EquatableMixin {
  PlanTime({required super.title, required super.description, required super.start, required super.end, super.backgroundColor});

  @override
  List<Object?> get props => [super.title];
  
  @override
  bool? get stringify => true;
}