import 'package:get/get.dart';
import 'package:transcribe/app/data/model/user_model.dart';
import 'package:transcribe/app/data/repository/user_repository.dart';
import 'package:transcribe/app/modules/auth/auth_controller.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = Get.put(UserRepository());
  final AuthController _authController = Get.find<AuthController>();

  final String firebaseUserUid;
  UserController({required this.firebaseUserUid});

  late UserModel _userModel;
  get userModel => _userModel;

  Future<bool> getUser() async {
    Map<String, dynamic>? user;
    user = await _userRepository.getByUid(firebaseUserUid);
    if (user == null) {
      await createUser();
    } else {
      _userModel = UserModel.fromMap(user);
    }
    return true;
  }

  Future<bool> createUser() async {
    Map<String, dynamic> data = {};
    data['uid'] = _authController.firebaseUser!.uid;
    data['email'] = _authController.firebaseUser!.email;
    data['displayName'] = _authController.firebaseUser?.displayName;
    data['photoURL'] = _authController.firebaseUser?.photoURL;
    data['isActive'] = true;
    data['accessType'] = ['student'];
    Map<String, dynamic> userMap = await _userRepository.create(data);
    _userModel = UserModel.fromMap(userMap);

    return true;
  }
}
