import 'package:daelim_market/screen/widgets/button.dart';
import 'package:daelim_market/styles/colors.dart';
import 'package:daelim_market/styles/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/named_widget.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topPadding,
            Padding(
              padding: EdgeInsets.only(left: 21.w, top: 5.h),
              child: Text(
                "마이페이지",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 28.sp,
                  fontWeight: bold,
                  color: dmBlack,
                ),
              ),
            ),
            SizedBox(
              height: 22.5.h,
            ),
            divider,
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 9.5.w, top: 34.5.h),
                        child: Row(
                          children: [
                            Container(
                              width: 58.w,
                              height: 58.h,
                              decoration: BoxDecoration(
                                // image: _pickedImage != null
                                //     ? DecorationImage(
                                //         image:
                                //             Image.file(File(_pickedImage!.path))
                                //                 .image,
                                //         fit: BoxFit.cover,
                                //       )
                                //     : null,
                                shape: BoxShape.circle,
                                color: dmLightGrey,
                                border: Border.all(
                                  color: dmDarkGrey,
                                  width: 1.w,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 23.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sung_Feeeel",
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 24.sp,
                                      fontWeight: medium,
                                      color: dmBlack,
                                    ),
                                  ),
                                  Text(
                                    "heopill@naver.com",
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 16.sp,
                                      fontWeight: medium,
                                      color: dmDarkGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      const BlueButton(
                        text: '프로필 수정',
                        color: dmGrey,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      divider,
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              'assets/images/icons/icon_heart.png',
                              height: 22.h,
                              width: 24.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 11.w),
                            child: Text(
                              '관심목록',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 20.sp,
                                fontWeight: medium,
                                color: dmDarkGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: dmRed,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: dmRed,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: dmRed,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: dmRed,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: dmRed,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: dmRed,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      divider,
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              'assets/images/icons/icon_paper.png',
                              height: 22.h,
                              width: 24.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 11.w),
                            child: Text(
                              '판매내역',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 20.sp,
                                fontWeight: medium,
                                color: dmDarkGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: dmBlue,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: dmBlue,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: dmBlue,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: dmBlue,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: dmBlue,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: dmBlue,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            width: 105.w,
                            height: 105.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
