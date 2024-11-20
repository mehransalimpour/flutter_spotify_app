class ChooseModeEvent {}

class ChangeModeEvent extends ChooseModeEvent {
  final bool isdark;
  ChangeModeEvent(this.isdark);
}
