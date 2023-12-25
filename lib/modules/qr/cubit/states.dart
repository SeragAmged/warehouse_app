sealed class ItemByIdStates {}

class ItemByIdInitialState extends ItemByIdStates {}


class ItemByIdGetLoadingState extends ItemByIdStates {}

class ItemByIdGetItemSuccessState extends ItemByIdStates {
  
}

class ItemByIdGetItemErrorState extends ItemByIdStates {
  final String message;
  ItemByIdGetItemErrorState({required this.message});
}
