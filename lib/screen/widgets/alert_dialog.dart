import 'package:daelim_market/styles/colors.dart';
import 'package:daelim_market/styles/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertDialogWidget {
  static void oneButton({
    required BuildContext context,
    required String content,
    required String button,
    required VoidCallback action,
  }) {
    int nextLineCount = 0;
    for (int i = 0; i < content.length; i++) {
      if (content[i] == '\n') {
        nextLineCount++;
      }
    }
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          elevation: 0,
          content: Container(
            width: 319.w,
            height: (145 + (25 * nextLineCount)).h,
            decoration: BoxDecoration(
              border: Border.all(
                color: dmBlack,
                width: 2.w,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 33.h,
                ),
                Text(
                  content,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 21.sp,
                    fontWeight: bold,
                    color: dmBlack,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: action,
                          child: Container(
                            height: 38.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5.r,
                              ),
                              color: dmBlue,
                            ),
                            child: Center(
                              child: Text(
                                button,
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 18.sp,
                                  fontWeight: medium,
                                  color: dmWhite,
                                  height: 1.2.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void twoButtons({
    required BuildContext context,
    required String content,
    // List<String>도 고밈했는데 그냥 String 2개 쓰겠습니다.
    required List<String> button,
    required List<Color> color,
    required List<VoidCallback> action,
  }) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          elevation: 0,
          content: Container(
            width: 319.w,
            // content는 3줄 이상 쓰지 않기!
            height: content.contains('\n') ? 170.h : 145.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: dmBlack,
                width: 2.w,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 33.h,
                ),
                Text(
                  content,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 21.sp,
                    fontWeight: bold,
                    color: dmBlack,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: action[0],
                        child: Container(
                          width: 132.w,
                          height: 38.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.r,
                            ),
                            color: color[0],
                          ),
                          child: Center(
                            child: Text(
                              button[0],
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 18.sp,
                                fontWeight: medium,
                                color: dmWhite,
                                height: 1.2.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      GestureDetector(
                        onTap: action[1],
                        child: Container(
                          width: 132.w,
                          height: 38.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.r,
                            ),
                            color: color[1],
                          ),
                          child: Center(
                            child: Text(
                              button[1],
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 18.sp,
                                fontWeight: medium,
                                color: dmWhite,
                                height: 1.2.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}