
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/category/Domain/Entity/category_entity.dart';
import 'package:ecommerce_app/features/category/Domain/use-cases/category_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUseCases categoryUseCases;

  CategoryBloc({required this.categoryUseCases}) : super(CategoryInitial()) {
    on<LoadedCategoriesEvent>((event, emit) async {
      emit(CategoryLoading());
      final Either<Failures, List<CategoryEntity>> categories =
          await categoryUseCases();
      categories.fold(
        (failure) => emit(CategoryFailure(failure.message)),
        (categories) => emit(CategoryLoaded(categories)),
      );
    });
  }
}
