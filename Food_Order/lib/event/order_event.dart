abstract class RemoteEvent {}

class IncrementEvent extends RemoteEvent {
  IncrementEvent(this.increment);

  final int increment;
}

class DecrementEvent extends RemoteEvent {
  DecrementEvent(this.decrement);

  final int decrement;
}

class SelectAttributeValueEvent extends RemoteEvent {
  SelectAttributeValueEvent(this.value);
  final int value;
}

class CheckToppingEvent extends RemoteEvent {
  CheckToppingEvent(this.value, this.index);
  final bool value;
  final int index;
}

class TotalEvent extends RemoteEvent {
  TotalEvent(this.total);
  final int total;
}

class SetLengthListToppingEvent extends RemoteEvent {
  SetLengthListToppingEvent(this.length);
  final int length;
}
