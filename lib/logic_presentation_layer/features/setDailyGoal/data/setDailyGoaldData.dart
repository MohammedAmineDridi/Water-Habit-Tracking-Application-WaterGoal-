import 'package:watergoal/data_layer/repos/userRepository.dart';
import '../../../../data_layer/models/user.dart';

UserRepository userRepository = new UserRepository();

// -------------------------------------------- DAILY GOAL --------------------------------------

Future<int> updateUserDailyGoalData(int userId , String newDailyGoal){
  return userRepository.updateUserDailyGoal(userId, newDailyGoal);
}

Future<User?> getUserByIdData(int userId){
  return userRepository.getUserById(userId);
}
