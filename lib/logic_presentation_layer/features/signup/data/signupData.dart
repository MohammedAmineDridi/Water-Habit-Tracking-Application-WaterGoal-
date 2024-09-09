import 'package:watergoal/data_layer/repos/userRepository.dart';
import 'package:watergoal/data_layer/repos/accomplishementRepository.dart';
import '../../../../data_layer/models/user.dart';
import '../../../../data_layer/models/accomplishement.dart';

UserRepository userRepository = new UserRepository();
AccomplishementRepository accomplishementRepository = new AccomplishementRepository();


// -------------------------------------------- SIGN UP --------------------------------------

void addUserData(User user){
   userRepository.addUser(user);
}

Future<User?> getLastUserData(){
  return userRepository.getLastUser();
}

Future<int> getPercentageWaterByUserIdData(int userId){
  return userRepository.getPercentageWaterByUserId(userId);
}


void addAccomplishmentSignUpData(Accomplishement accompmlishement){
   accomplishementRepository.addAccomplishment(accompmlishement);
}