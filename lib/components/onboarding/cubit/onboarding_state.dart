part of 'onboarding_cubit.dart';

abstract class OnboardingState extends Equatable with Castable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingInitial {}

class OnboardingStepWelcome extends OnboardingState {}

class OnboardingStepTutorial extends OnboardingState {}

class OnboardingStepAuth extends OnboardingState {}

class OnboardingStepConsent extends OnboardingState {}

class OnboardingStepDeletionRequestPending extends OnboardingState {
  final DocumentSnapshot<DeletionRequest> deletionRequest;

  const OnboardingStepDeletionRequestPending(this.deletionRequest);

  @override
  List<Object?> get props => [deletionRequest];
}

class OnboardingStepCommunity extends OnboardingState {}

class OnboardingStepDepartment extends OnboardingState {}

class OnboardingStepProfile extends OnboardingState {}

class OnboardingStepFootprint extends OnboardingState {}

class OnboardingStepCalculatingFootprint extends OnboardingState {}

class OnboardingDone extends OnboardingState {}
