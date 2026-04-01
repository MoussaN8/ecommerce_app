part of 'produit_bloc.dart';

sealed class ProduitEvent extends Equatable {
  const ProduitEvent();

  @override
  List<Object> get props => [];
}

class FetchHomeProduitsEvent extends ProduitEvent{}