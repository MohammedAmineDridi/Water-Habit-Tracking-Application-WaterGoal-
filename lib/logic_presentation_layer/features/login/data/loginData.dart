import 'package:watergoal/data_layer/repos/userRepository.dart';
import '../../../../data_layer/models/user.dart';

UserRepository userRepository = new UserRepository();

// -------------------------------------------- LOGIN --------------------------------------

Future<User?> getUserByUsernamePasswordData(String username , String password){
  return userRepository.getUserByUsernamePassword(username, password);
}
