part of 'profile_update_cubit.dart';

abstract class ProfileUpdateState extends Equatable {
  final ProfileModel profile;

  const ProfileUpdateState(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileUpdateInitial extends ProfileUpdateState {
  const ProfileUpdateInitial(profile) : super(profile);
}

class ProfileUpdateLoading extends ProfileUpdateState {
  const ProfileUpdateLoading(profile) : super(profile);
}

class ProfileUpdateSuccess extends ProfileUpdateState {
  const ProfileUpdateSuccess(profile) : super(profile);
}

class ProfileUpdateError extends ProfileUpdateState {
  final String message;
  const ProfileUpdateError(profile, this.message) : super(profile);
}
