import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/models/user_model.dart';
import 'package:jealus_ex/custom_exception.dart';
import 'package:jealus_ex/repositories/user_profile_repository.dart';

final userExceptionProvider = StateProvider<CustomException?>((_) => null);

final userControllerProvider = StateNotifierProvider<UserController>(
      (ref) {
    final user = ref.watch(authControllerProvider.state);
    return UserController(ref.read, user?.uid);
  },
);

class UserController extends StateNotifier<AsyncValue<List<UserProfile>>> {

  final Reader _read;
  final String? _userId;

  UserController(this._read,this._userId):super(AsyncValue.loading()){
    retrieveUsers();

  }

  Future<void> retrieveUsers({bool isRefreshing = false}) async{
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final userProfile = await _read(usersRepositoryProvider).retrieveUsers();
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
      final userProfileID = await _read(usersRepositoryProvider).createUser(userId: _userId!, user: userProfile);
      state.whenData((userProfiles) =>
      state = AsyncValue.data(userProfiles..add(userProfile.copyWith(id: userProfileID)))
      );
    } on CustomException catch(e, st){
      _read(userExceptionProvider).state = e;
    }
  }

  Future<void> updateUserProfile({required UserProfile updatedUserProfile}) async {
    try {
      await _read(usersRepositoryProvider).updateUser(user: updatedUserProfile);
      state.whenData((userProfiles) {
        state = AsyncValue.data([
          for (final userProfile in userProfiles)
            if (userProfile.id == updatedUserProfile.id) updatedUserProfile else userProfile
        ]);
      });
    } on CustomException catch (e){
      _read(userExceptionProvider).state = e;
    }
  }

  Future<void> deleteUserProfile({required String userProfileId}) async {
    try {
      await _read(usersRepositoryProvider).deleteUser(userId: userProfileId);
      state.whenData((userProfiles) =>
      state = AsyncValue.data(userProfiles..removeWhere((element) => element.id == userProfileId))
      );
    } on CustomException catch (e){
      _read(userExceptionProvider).state = e;
    }
  }
}