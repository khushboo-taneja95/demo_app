import 'package:floor/floor.dart';
import 'package:tres_connect/features/auth/domain/entities/user_profile_info_entity.dart';

@dao
abstract class UserProfileInfoDao {
  @Query('SELECT * FROM UserProfile LIMIT 1')
  Future<UserProfileEntiry?> getUserProfile();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUserProfile(UserProfileEntiry userProfileInfo);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserProfile(UserProfileEntiry userProfileInfo);

  @Query('DELETE FROM UserProfile')
  Future<void> deleteUserProfile();
}
