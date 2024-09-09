import 'package:watergoal/data_layer/repos/userRepository.dart';
import '../../../../data_layer/models/user.dart';

UserRepository userRepository = new UserRepository();


// -------------------------------------------- STAY HYDRATED --------------------------------------

Future<User?> getUserByIdData(int userId){
  return userRepository.getUserById(userId);
}

void updateCurrentWaterPercentage(int userId,int currentWaterPercentage){
   userRepository.updateUserCurrentPercentage(userId,currentWaterPercentage);
}
