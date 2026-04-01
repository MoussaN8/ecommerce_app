import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';
import 'package:equatable/equatable.dart';

class ProduitState extends Equatable {
  final bool isLoading;
  final List<ProduitEntity> tousLesProduits;
  final List<ProduitEntity> tshirtProduits; // La liste brute de Firebase
  final List<ProduitEntity> nikeProduits;
  final List<ProduitEntity> adidasProduits;
  final List<ProduitEntity> sneakersProduits;
  final List<ProduitEntity> costumeProduits;
  final List<ProduitEntity> lacosteProduits;
  final String? messageErreur;

  const ProduitState({
    this.isLoading = false,
    this.tousLesProduits = const [],
    this.tshirtProduits = const [],
    this.nikeProduits = const [],
    this.adidasProduits = const [],
    this.sneakersProduits = const [],
    this.costumeProduits = const [],
    this.lacosteProduits = const [],
    this.messageErreur,
  });

  ProduitState copyWith({
    bool? isLoading,
    List<ProduitEntity>? tousLesProduits,
    List<ProduitEntity>? tshirtProduits,
    List<ProduitEntity>? nikeProduits,
    List<ProduitEntity>? adidasProduits,
    List<ProduitEntity>? sneakersProduits,
    List<ProduitEntity>? costumeProduits,
    List<ProduitEntity>? lacosteProduits,
    String? messageErreur,
  }) {
    return ProduitState(
      isLoading: isLoading ?? this.isLoading,
      tousLesProduits: tousLesProduits ?? this.tousLesProduits,
      tshirtProduits:    tshirtProduits?? this.tshirtProduits,
      nikeProduits: nikeProduits ?? this.nikeProduits,
      adidasProduits: adidasProduits ?? this.adidasProduits,
      sneakersProduits: sneakersProduits ?? this.sneakersProduits,
      costumeProduits: costumeProduits ?? this.costumeProduits,
      lacosteProduits: lacosteProduits ?? this.lacosteProduits,
      messageErreur: messageErreur ?? this.messageErreur,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    tousLesProduits,
    tshirtProduits,
    nikeProduits,
    adidasProduits,
    sneakersProduits,
    costumeProduits,
    lacosteProduits,
    messageErreur,
  ];
}
