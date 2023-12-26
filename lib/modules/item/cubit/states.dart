sealed class ItemStates {}

class ItemInitialState extends ItemStates {}

class ItemChangeNavState extends ItemStates {}

class ItemCheckoutLoadingState extends ItemStates {}

class ItemCommentingState extends ItemStates {}

class ItemCheckoutSuccessState extends ItemStates {
  final String message;
  ItemCheckoutSuccessState({required this.message});
}

class ItemCheckoutErrorState extends ItemStates {
  final String message;
  ItemCheckoutErrorState({required this.message});
}
