// update user by user_id from (shared_pref) the weight (value & unit) + gender
import 'package:watergoal/data_layer/repos/userRepository.dart';
import '../../../../data_layer/models/user.dart';

UserRepository userRepository = new UserRepository();

// -------------------------------------------- USER INFO (gender and weight selection) --------------------------------------

void updateUserById_Weight_Gender(int userId, String weight , String gender){
   userRepository.updateUserWeight(userId, weight);
   userRepository.updateUserGender(userId,gender);
}

Future<User?> getUserByIdData(int userId){
  return userRepository.getUserById(userId);
}
