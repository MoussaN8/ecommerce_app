import 'package:ecommerce_app/features/produits/domain/use-cases/produit_use_case.dart';
import 'package:ecommerce_app/features/produits/presentation/bloc/produit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'produit_event.dart';

class ProduitBloc extends Bloc<ProduitEvent, ProduitState> {
  final ProduitUseCase produitUseCase;

  ProduitBloc({required this.produitUseCase}) : super(const ProduitState()) {
    on<FetchHomeProduitsEvent>((event, emit) async {
      // 1. On affiche le chargement
      emit(state.copyWith(isLoading: true, messageErreur: null));

      // 2. On appelle le UseCase (Appel Firebase unique)
      final result = await produitUseCase();

      // 3. On traite le résultat avec fold (fpdart)
      result.fold(
        (failure) => emit(
          state.copyWith(isLoading: false, messageErreur: failure.message),
        ),
        (produitsBruts) {
          // 4. FILTRAGE LOCAL (Ultra rapide)

          // Filtrage Nike + Limite à 4
          final nikes = produitsBruts
              .where((p) => p.categoryId.toLowerCase() == 'nike')
              .take(4)
              .toList();

          // Filtrage Adidas + Limite à 4
          final adidas = produitsBruts
              .where((p) => p.categoryId.toLowerCase() == 'adidas')
              .take(4)
              .toList();

          // Filtrage thsirt
          final tshirts = produitsBruts
              .where((p) => p.categoryId.toLowerCase() == 'tshirt')
              .take(4)
              .toList();

          // Filtrage sneakers
          final sneakers = produitsBruts
              .where((p) => p.categoryId.toLowerCase() == 'sneakers')
              .take(4)
              .toList();

          // Filtrage thsirt
          final costumeAfricain = produitsBruts
              .where((p) => p.categoryId.toLowerCase() == 'costume_africain')
              .take(4)
              .toList();

          // Filtrage thsirt
          final lacostes = produitsBruts
              .where((p) => p.categoryId.toLowerCase() == 'lacoste')
              .take(4)
              .toList();

          // 5. Mise à jour finale du State avec tous les tiroirs remplis
          emit(
            state.copyWith(
              isLoading: false,
              tousLesProduits: produitsBruts,
              nikeProduits: nikes,
              adidasProduits: adidas,
              tshirtProduits: tshirts,
              lacosteProduits: lacostes,
              costumeProduits: costumeAfricain,
              sneakersProduits: sneakers
            ),
          );
        },
      );
    });
  }
}
