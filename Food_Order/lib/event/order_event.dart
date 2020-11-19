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
  CheckToppingEvent(this.isCheck, this.id);
  final bool isCheck;
  final int id;
}

class TotalEvent extends RemoteEvent {
  TotalEvent(this.total);
  final int total;
}
