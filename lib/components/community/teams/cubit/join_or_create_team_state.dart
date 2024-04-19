part of 'join_or_create_team_cubit.dart';

abstract class JoinOrCreateTeamState extends Equatable {
  const JoinOrCreateTeamState();

  @override
  List<Object?> get props => [];
}

class JoinOrCreateTeamLoaded extends JoinOrCreateTeamState {
  final TeamRef? selectedTeam;

  const JoinOrCreateTeamLoaded({this.selectedTeam});

  JoinOrCreateTeamLoaded copyWith({TeamRef? selectedTeam}) {
    return JoinOrCreateTeamLoaded(selectedTeam: selectedTeam);
  }

  @override
  List<Object?> get props => [selectedTeam];
}

class CreateTeamLoading extends JoinOrCreateTeamState {}

class CreateTeamSuccess extends JoinOrCreateTeamState {}

class JoinTeamLoading extends JoinOrCreateTeamLoaded {
  JoinTeamLoading(JoinOrCreateTeamLoaded state)
      : super(selectedTeam: state.selectedTeam);
}

class JoinTeamSuccess extends JoinOrCreateTeamLoaded {
  JoinTeamSuccess(JoinOrCreateTeamLoaded state)
      : super(selectedTeam: state.selectedTeam);
}
