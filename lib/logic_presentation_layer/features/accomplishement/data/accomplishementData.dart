import 'package:watergoal/data_layer/repos/userRepository.dart';
import '../../../../data_layer/models/user.dart';
import 'package:watergoal/data_layer/repos/accomplishementRepository.dart';
import '../../../../data_layer/models/accomplishement.dart';

AccomplishementRepository accomplishementRepository = new AccomplishementRepository();
UserRepository userRepository = new UserRepository();

// -------------------------------------------- ACCOMPLISHEMENT --------------------------------------


void addAccomplishmentData(Accomplishement accompmlishement){
  accomplishementRepository.addAccomplishment(accompmlishement);
}

Future<List<Accomplishement>> getAccomplishementByuserIdBetweenDatesData(int userId,String from,String to){
  return accomplishementRepository.getAccomplishementByuserIdBetweenDates(userId,from,to);
}

Future<int> getAccomplishementAverageByuserIdBetweenDatesData(int userId,String from,String to){
  return accomplishementRepository.getAverageAccomplishementsUser(userId, from, to);
}

Future<User?> getUserByIdAccData(int userId) {
  return userRepository.getUserById(userId);
}


