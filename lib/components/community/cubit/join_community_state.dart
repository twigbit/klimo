part of 'join_community_cubit.dart';

abstract class JoinCommunityState extends Equatable {
  const JoinCommunityState();

  @override
  List<Object?> get props => [];
}

class JoinCommunityInitial extends JoinCommunityState {}

class CommunitiesLoaded extends JoinCommunityState {
  final BuiltList<CommunityRef> communities;
  final int? selectedCommunityIndex;

  const CommunitiesLoaded(this.communities, {this.selectedCommunityIndex});

  @override
  List<Object?> get props => [communities, selectedCommunityIndex];
}

class JoinCommunityLoading extends CommunitiesLoaded {
  JoinCommunityLoading(CommunitiesLoaded state)
      : super(state.communities,
            selectedCommunityIndex: state.selectedCommunityIndex);
}

class JoinCommunitySuccess extends CommunitiesLoaded {
  JoinCommunitySuccess(CommunitiesLoaded state)
      : super(state.communities,
            selectedCommunityIndex: state.selectedCommunityIndex);
}
