part of 'projects_list_cubit.dart';

abstract class ProjectsListState extends Equatable {
  const ProjectsListState();

  @override
  List<Object?> get props => [];
}

class ProjectsListInitial extends ProjectsListState {}

class ProjectsListLoading extends ProjectsListState {}

class ProjectsListLoaded extends ProjectsListState {
  final BuiltList<Project> projects;

  const ProjectsListLoaded(this.projects);
  @override
  List<Object?> get props => [projects];
}
