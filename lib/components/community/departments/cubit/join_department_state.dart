part of 'join_department_cubit.dart';

abstract class JoinDepartmentState extends Equatable {
  const JoinDepartmentState();

  @override
  List<Object?> get props => [];
}

class JoinDepartmentInitial extends JoinDepartmentState {}

class DepartmentsLoaded extends JoinDepartmentState {
  final BuiltList<QueryDocumentSnapshot<DepartmentModel>> departments;
  final int? selectedIndex;

  const DepartmentsLoaded(this.departments, {this.selectedIndex});

  DepartmentsLoaded copyWith({int? selectedIndex}) {
    return DepartmentsLoaded(departments, selectedIndex: selectedIndex);
  }

  @override
  List<Object?> get props => [departments, selectedIndex];
}

class JoinDepartmentLoading extends DepartmentsLoaded {
  JoinDepartmentLoading(DepartmentsLoaded state)
      : super(state.departments, selectedIndex: state.selectedIndex);
}

class JoinDepartmentSuccess extends DepartmentsLoaded {
  JoinDepartmentSuccess(DepartmentsLoaded state)
      : super(state.departments, selectedIndex: state.selectedIndex);
}
