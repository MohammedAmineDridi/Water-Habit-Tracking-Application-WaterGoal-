import 'package:watergoal/data_layer/repos/userRepository.dart';
import '../../../../data_layer/models/user.dart';

UserRepository userRepository = new UserRepository();

// -------------------------------------------- PROFILE SETTINGS --------------------------------------

Future<User?> getUserByIdData(int userId) async {
  return await userRepository.getUserById(userId);
}