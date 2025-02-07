import 'package:daelim_market/screen/widgets/button.dart';
import 'package:daelim_market/screen/widgets/named_widget.dart';
import 'package:daelim_market/screen/widgets/scroll_behavior.dart';
import 'package:daelim_market/screen/widgets/snackbar.dart';
import 'package:daelim_market/screen/widgets/welcome_appbar.dart';
import 'package:daelim_market/styles/colors.dart';
import 'package:daelim_market/styles/fonts.dart';
import 'package:daelim_market/styles/input_deco.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final RxBool _isLoading = false.obs;

  final RxString _email = ''.obs;
  final RxString _password = ''.obs;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        // 키보드 위에 입력 창 띄우기 여부
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: CustomScrollView(
              scrollBehavior: MyBehavior(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      WelcomeAppbar(
                        widget: Obx(
                          () => _isLoading.value
                              ? SizedBox(
                                  height: 18.h,
                                )
                              : Image.asset(
                                  'assets/images/icons/icon_close.png',
                                  height: 18.h,
                                ),
                        ),
                        title: '로그인',
                        onTap: () {
                          Get.toNamed('/welcome');
                        },
                      ),

                      // Contents
                      SizedBox(
                        height: 101.h,
                      ),
                      Text(
                        '이메일',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 21.sp,
                          fontWeight: bold,
                          color: dmBlack,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Obx(
                        () => TextField(
                          enabled: _isLoading.value ? false : true,
                          cursorHeight: 24.h,
                          style: welcomeInputTextDeco,
                          decoration: welcomeInputDeco(),
                          cursorColor: dmBlack,
                          onChanged: (value) {
                            _email.value = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        '@email.daelim.ac.kr',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 24.sp,
                          fontWeight: bold,
                          color: dmBlack,
                        ),
                      ),
                      SizedBox(
                        height: 46.h,
                      ),
                      Text(
                        '비밀번호',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 21.sp,
                          fontWeight: bold,
                          color: dmBlack,
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Obx(
                        () => TextField(
                          enabled: _isLoading.value ? false : true,
                          cursorHeight: 24.h,
                          obscureText: true, // 비밀번호 가리기
                          style: welcomeInputTextDeco,
                          decoration: welcomeInputDeco(),
                          cursorColor: dmBlack,
                          onChanged: (value) {
                            _password.value = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 29.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/login/forgot');
                        },
                        child: Text(
                          '비밀번호를 잊으셨나요?',
                          style: TextStyle(
                            fontWeight: bold,
                            fontSize: 13.sp,
                            color: dmGrey,
                          ),
                        ),
                      ),

                      // Bottom
                      const Expanded(child: SizedBox()),
                      // 이메일 TextField의 글자 수가 3 글자 이상
                      Obx(
                        () => _email.value.length >= 3 &&
                                // 비밀번호 TextField의 글자 수가 4 글자 이상
                                _password.value.length >= 4
                            ? GestureDetector(
                                onTap: onTapLogin,
                                child: _isLoading.value
                                    ? const LoadingButton(
                                        color: dmLightGrey,
                                      )
                                    : const BlueButton(text: '로그인'),
                              )
                            : const BlueButton(text: '로그인', color: dmLightGrey),
                      ),
                      bottomPadding,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapLogin() async {
    // 이메일 유효성 검사
    if (!_email.value.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
      WarningSnackBar.show(text: '이메일에 포함할 수 없는 문자가 있어요.');
    } else {
      try {
        // Loading 상태를 true로 변경
        _isLoading.value = true;
        // Firebase에 이메일/패스워드 형식의 로그인 요청
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: '${_email.value}@email.daelim.ac.kr',
                password: _password.value)
            .then(
          // 성공 시
          (value) async {
            // Loading 상태를 false로 변경
            _isLoading.value = false;
            // 이메일 링크를 눌러 인증이 완료된 계정이면,
            if (value.user!.emailVerified == true) {
              // FlutterSecureStorage 내의 데이터를 삭제하여 초기화
              await const FlutterSecureStorage().deleteAll();
              // FlutterSecureStorage에 이메일 주소 저장
              await const FlutterSecureStorage().write(
                  key: 'email', value: '${_email.value}@email.daelim.ac.kr');
              // FlutterSecureStorage에 비밀번호 저장
              await const FlutterSecureStorage()
                  .write(key: 'password', value: _password.value);
              // FlutterSecureStorage에 ID 저장
              await const FlutterSecureStorage()
                  .write(key: 'id', value: _email.value);
              // FlutterSecureStorage에 UID 저장
              await const FlutterSecureStorage()
                  .write(key: 'uid', value: value.user!.uid);
              // MainScreen으로 이동
              Get.offAllNamed('/');
            }
            // 만약 인증이 안 된 계정이면,
            else {
              WarningSnackBar.show(text: '이메일 인증이 안 된 계정이에요.');
            }
            return value;
          },
        );
      } on FirebaseAuthException catch (e) {
        // 실패(Exception) 시
        switch (e.code) {
          case 'user-not-found':
          case 'wrong-password':
            WarningSnackBar.show(text: '일치하는 정보가 없어요.');
            _isLoading.value = false;
            break;
          case 'user-disabled':
            WarningSnackBar.show(text: '사용할 수 없는 계정이에요.');
            _isLoading.value = false;
            break;
          case 'invalid-email':
            WarningSnackBar.show(text: '이메일 주소 형식을 다시 확인해주세요.');
            _isLoading.value = false;
            break;
          default:
            WarningSnackBar.show(text: e.code.toString());
            _isLoading.value = false;
            break;
        }
      }
    }
  }
}
