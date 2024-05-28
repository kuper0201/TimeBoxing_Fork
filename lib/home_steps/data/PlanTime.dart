import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PlanTime extends Equatable {
  PlanTime(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  
  @override
  List<Object?> get props => [eventName];
}