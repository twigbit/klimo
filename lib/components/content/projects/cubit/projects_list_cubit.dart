import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:klimo/components/content/projects/project_repository.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo_datamodels/projects.dart';

part 'projects_list_state.dart';

class ProjectsListCubit extends Cubit<ProjectsListState> with ErrorHandling {
  final ProjectRepository _repository = ProjectRepository();
  ProjectsListCubit() : super(ProjectsListInitial());

  StreamSubscription? _projectsSub;

  loadProjects() async {
    emit(ProjectsListLoading());
    try {
      _projectsSub = _repository
          .snapshots()
          .listen(((event) => emit(ProjectsListLoaded(event))));
    } catch (e) {
      debugPrint(e.toString());
      emit(ProjectsListInitial());
    }
  }

  @override
  Future<void> close() {
    _projectsSub?.cancel();
    return super.close();
  }
}
