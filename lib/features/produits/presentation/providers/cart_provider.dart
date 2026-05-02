import 'package:ecommerce_app/core/services/cart_service.dart';
import 'package:ecommerce_app/features/produits/presentation/widgets/cart_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = AsyncNotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);

// pour afficher le prix total des produits
final cartTotalprovider = Provider<int>((ref) {
  // on surveille l'état du panier
  final cartAsync = ref.watch(cartProvider);

  return cartAsync.maybeWhen(
    data: (items) => items.fold(0, (som, item) => som + item.produit.prix),
    orElse: () => 0,
  );
});

class CartNotifier extends AsyncNotifier<List<CartItem>> {
  @override
  //on récupère le panier via cart service
  Future<List<CartItem>> build() async {
    return await CartService.getCart();
  }

  //Pour ajouter un élément au panier
  Future<void> ajouterProduit(CartItem item) async {
    // on récupère l'etat actuel du panier
    final current = state.value ?? [];
    final updated = [...current, item];
    state = const AsyncLoading();

    try {
      //on sauvegarde également les données via le cart service
      await CartService.saveCart(updated);
      //on dit à riverpod voici les nouvelles données
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // supprimer un élément de la liste
  Future<void> supprimerProduit(int index) async {
    final current = state.value ?? [];

    final updated = [
      for (int i = 0; i < current.length; i++)
        if (i != index) current[i],
    ];
    state = const AsyncLoading();
    try {
      await CartService.saveCart(updated);
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> viderToutLePanier() async {
    // 1. On vide le stockage physique
    await CartService.clearCart();

    // 2. On met à jour l'état de Riverpod avec une liste vide
    // Cela va déclencher instantanément le passage à l'écran "_buildEmptyState"
    state = const AsyncData([]);
  }
}
