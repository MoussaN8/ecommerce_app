import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:ecommerce_app/features/category/Domain/Entity/category_entity.dart';
import 'package:ecommerce_app/features/category/Presentation/bloc/category_bloc.dart';
import 'package:ecommerce_app/features/produits/presentation/bloc/produit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListwidget extends StatefulWidget {
  const CategoryListwidget({super.key});

  @override
  State<CategoryListwidget> createState() => _CategoryListwidgetState();
}

class _CategoryListwidgetState extends State<CategoryListwidget> {
  @override
  void initState() {
    super.initState();
    // ✅ déclenché une seule fois
    context.read<CategoryBloc>().add(LoadedCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(child: const CircularProgressIndicator());
        }
        if (state is CategoryFailure) {
          return Text(state.message);
        }
        if (state is CategoryLoaded) {
          return SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return _CategoryItem(categoryEntity: category);
              },
              separatorBuilder: (_, _) => SizedBox(width: 16),
              itemCount: state.categories.length,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryEntity categoryEntity;
  const _CategoryItem({required this.categoryEntity});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 1. Récupérer l'état actuel du ProduitBloc (qui contient tous les produits)
        final produitState = context.read<ProduitBloc>().state;
        // 2. Filtrer les produits qui correspondent au category_id de cette icône
        // vérifier categoryEntity.id correspond bien au category_id des produits

        final filteredProduit = produitState.tousLesProduits
            .where(
              (p) =>
                  p.categoryId.toLowerCase() ==
                  categoryEntity.name.toLowerCase(),
            )
            .toList();

        // 3. Naviguer vers ta page générique avec les données filtrées
        Navigator.pushNamed(
          context,
          AppRoutes.categoryProduitPage,
          arguments: {
            'titre': categoryEntity.name,
            'produits': filteredProduit,
          },
        );
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(categoryEntity.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            categoryEntity.name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
