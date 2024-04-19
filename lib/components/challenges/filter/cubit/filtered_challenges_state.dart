part of 'filtered_challenges_cubit.dart';

abstract class FilteredChallengesState extends Equatable with Castable {
  const FilteredChallengesState();

  @override
  List<Object> get props => [];
}

class FilteredChallengesInitial extends FilteredChallengesState {}

class FiltersLoaded extends FilteredChallengesState {
  final BuiltSet<String> categories;
  final BuiltSet<String> filters;
  final BuiltList<DocumentSnapshot<Challenge>> challenges;

  const FiltersLoaded(this.categories, this.filters, this.challenges);

  FiltersLoaded copyWith(BuiltSet<String> filters,
      BuiltList<DocumentSnapshot<Challenge>> challenges) {
    return FiltersLoaded(categories, filters, challenges);
  }

  @override
  List<Object> get props => [categories, filters, challenges];
}
