sealed class ItemStates {}

class ItemInitialState extends ItemStates {}

class ItemChangeNavState extends ItemStates {}

class ItemCheckoutLoadingState extends ItemStates {}

class ItemCheckoutSuccessState extends ItemStates {

}

class ItemCheckoutErrorState extends ItemStates {
  final String message;
  ItemCheckoutErrorState({required this.message});
}
