import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/repositories/user_profile_repository.dart';

final userProfileExceptionProvider = StateProvider<CustomException?>((_) => null);

final userProfileControllerProvider = StateNotifierProvider<UserProfileController>(
      (ref) {
    final user = ref.watch(authControllerProvider.state);
    return UserProfileController(ref.read, user?.uid);
  },
);

class UserProfileController extends StateNotifier<AsyncValue<List<UserProfile>>> {

  final Reader _read;
  final String? _userId;

  UserProfileController(this._read,this._userId):super(AsyncValue.loading()){
    retrieveUserProfiles();

  }

  Future<void> retrieveUserProfiles({bool isRefreshing = false}) async{
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final userProfile = await _read(userProfileRepositoryProvider).retrieveUserProfile();
      if (mounted){
        state = AsyncValue.data(userProfile);
      }
    } on CustomException catch(e, st){
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addUserProfile({required String name,
    required String phone}) async{
    try {
      final userProfile = UserProfile(name: name, phone: phone);
      final userProfileID = await _read(userProfileRepositoryProvider).createUserProfile(userId: _userId!, user: userProfile);
      state.whenData((userProfiles) =>
      state = AsyncValue.data(userProfiles..add(userProfile.copyWith(id: userProfileID)))
      );
    } on CustomException catch(e, st){
      _read(userProfileExceptionProvider).state = e;
    }
  }

  Future<void> updateUserProfile({required UserProfile updatedUserProfile}) async {
    try {
      await _read(userProfileRepositoryProvider).updateUserProfile(user: updatedUserProfile);
      state.whenData((userProfiles) {
        state = AsyncValue.data([
          for (final userProfile in userProfiles)
            if (userProfile.id == updatedUserProfile.id) updatedUserProfile else userProfile
        ]);
      });
    } on CustomException catch (e){
      _read(userProfileExceptionProvider).state = e;
    }
  }

  Future<void> deleteUserProfile({required String userProfileId}) async {
    try {
      await _read(userProfileRepositoryProvider).deleteUserProfile(userId: userProfileId);
      state.whenData((userProfiles) =>
      state = AsyncValue.data(userProfiles..removeWhere((element) => element.id == userProfileId))
      );
    } on CustomException catch (e){
      _read(userProfileExceptionProvider).state = e;
    }
  }
}