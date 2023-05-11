import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daelim_market/screen/widgets/main_appbar.dart';
import 'package:emoji_regex/emoji_regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../../styles/colors.dart';
import '../../../styles/fonts.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/scroll_behavior.dart';

class ChatScreen extends StatelessWidget {
  final String userUID;

  ChatScreen({super.key, required this.userUID});

  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 50), () {
        if (scrollController.hasClients) {
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent,
          );
        }
      });
    });
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // 키보드 위에 입력 창 띄우기 여부
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('user')
                .doc(userUID)
                .get(),
            builder: (context, userData) {
              String userNickname;

              if (userData.data?.exists == false) {
                userNickname = '알 수 없음';
              } else {
                userNickname = userData.data?['id'] ?? '';
              }

              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chat') // product 컬렉션으로부터
                    .doc(uid) // uid 문서의
                    .snapshots(), // 데이터
                builder: ((context, snapshot) {
                  return Column(
                    children: [
                      // Title
                      MainAppbar.show(
                        title: userNickname,
                        leading: GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: Image.asset(
                            'assets/images/icons/icon_back.png',
                            alignment: Alignment.topLeft,
                            height: 18.h,
                          ),
                        ),
                        action: GestureDetector(
                          onTap: () {
                            AlertDialogWidget.twoButtons(
                              context: context,
                              content: "정말로 나가시겠습니까?",
                              button: ["취소", "나갈래요."],
                              color: [dmGrey, dmRed],
                              action: [
                                () {
                                  Navigator.pop(context);
                                },
                                () {
                                  FirebaseFirestore.instance
                                      .collection('chat') // chat 컬렉션에서
                                      .doc(uid) // 자신의 UID 문서 내
                                      .update({userUID: FieldValue.delete()});
                                  Navigator.pop(context);
                                  context.pop();
                                }
                              ],
                            );
                          },
                          child: Text(
                            "나가기",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 18.sp,
                              fontWeight: medium,
                              color: dmRed,
                            ),
                          ),
                        ),
                      ),

                      // Content
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('chat')
                                .doc(uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.data()![userUID] != null) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  if (scrollController.position.pixels >=
                                      (scrollController
                                              .position.maxScrollExtent -
                                          (MediaQuery.of(context).size.height *
                                              0.05865))) {
                                    Timer(const Duration(milliseconds: 50), () {
                                      if (scrollController.hasClients) {
                                        scrollController.jumpTo(
                                          scrollController
                                              .position.maxScrollExtent,
                                        );
                                      }
                                    });
                                  }
                                });
                                return ScrollConfiguration(
                                  behavior: MyBehavior(),
                                  child: ListView.builder(
                                    controller: scrollController,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        snapshot.data!.data()![userUID].length,
                                    itemBuilder: ((context, index) {
                                      if (snapshot.data!.data()![userUID][index]
                                              ['sender'] ==
                                          uid) {
                                        return Column(
                                          children: [
                                            index == 0 ||
                                                    snapshot.data!
                                                            .data()![userUID]
                                                                [index - 1]
                                                                ['send_time']
                                                            .toDate()
                                                            .day !=
                                                        snapshot.data!
                                                            .data()![userUID]
                                                                [index]
                                                                ['send_time']
                                                            .toDate()
                                                            .day
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        top: index == 0
                                                            ? 27.5.h
                                                            : 22.5.h,
                                                        bottom: 22.5.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.52162,
                                                          height: 30.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: dmGrey,
                                                            borderRadius:
                                                                // 타원형
                                                                BorderRadius
                                                                    .circular(
                                                                        3.40e+38),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            DateFormat(
                                                                    'yyyy년 M월 d일 EEEE',
                                                                    'ko_KR')
                                                                .format(
                                                              snapshot.data!
                                                                  .data()![
                                                                      userUID]
                                                                      [index][
                                                                      'send_time']
                                                                  .toDate(),
                                                            ),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Pretendard',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  medium,
                                                              color: dmWhite,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        index == snapshot.data!.data()![userUID].length - 1 ||
                                                                snapshot.data!.data()![userUID][index][
                                                                        'sender'] !=
                                                                    snapshot.data!.data()![userUID]
                                                                            [index + 1][
                                                                        'sender'] ||
                                                                snapshot.data!
                                                                        .data()![userUID]
                                                                            [index][
                                                                            'send_time']
                                                                        .toDate()
                                                                        .minute !=
                                                                    snapshot.data!
                                                                        .data()![userUID]
                                                                            [index + 1]
                                                                            ['send_time']
                                                                        .toDate()
                                                                        .minute
                                                            ? Text(
                                                                DateFormat(
                                                                        'a h:mm',
                                                                        'ko_KR')
                                                                    .format(
                                                                  snapshot.data!
                                                                      .data()![
                                                                          userUID]
                                                                          [
                                                                          index]
                                                                          [
                                                                          'send_time']
                                                                      .toDate(),
                                                                ),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Pretendard',
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      medium,
                                                                  color:
                                                                      dmDarkGrey,
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    snapshot.data!
                                                                    .data()![
                                                                        userUID]
                                                                        [index]
                                                                        ['text']
                                                                    .length ==
                                                                2 &&
                                                            snapshot.data!
                                                                .data()![
                                                                    userUID]
                                                                    [index]
                                                                    ['text']
                                                                .contains(
                                                                    emojiRegex())
                                                        ? Text(
                                                            snapshot.data!
                                                                        .data()![
                                                                    userUID]
                                                                [index]['text'],
                                                            style: TextStyle(
                                                              fontSize: 60.sp,
                                                            ),
                                                          )
                                                        : Container(
                                                            constraints: BoxConstraints(
                                                                maxWidth: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6234),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: dmBlue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10.w,
                                                                      vertical:
                                                                          10.h),
                                                              child: Text(
                                                                snapshot.data!
                                                                            .data()![
                                                                        userUID]
                                                                    [
                                                                    index]['text'],
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Pretendard',
                                                                  fontSize:
                                                                      18.sp,
                                                                  fontWeight:
                                                                      medium,
                                                                  color:
                                                                      dmWhite,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                  ]),
                                            )
                                          ],
                                        );
                                      } else {
                                        return Column(
                                          children: [
                                            index == 0 ||
                                                    snapshot.data!
                                                            .data()![userUID]
                                                                [index - 1]
                                                                ['send_time']
                                                            .toDate()
                                                            .day !=
                                                        snapshot.data!
                                                            .data()![userUID]
                                                                [index]
                                                                ['send_time']
                                                            .toDate()
                                                            .day
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        top: index == 0
                                                            ? 27.5.h
                                                            : 22.5.h,
                                                        bottom: 22.5.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.52162,
                                                          height: 30.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: dmGrey,
                                                            borderRadius:
                                                                // 타원형
                                                                BorderRadius
                                                                    .circular(
                                                                        3.40e+38),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            DateFormat(
                                                                    'yyyy년 M월 d일 EEEE',
                                                                    'ko_KR')
                                                                .format(snapshot
                                                                    .data!
                                                                    .data()![
                                                                        userUID]
                                                                        [index][
                                                                        'send_time']
                                                                    .toDate()),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Pretendard',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  medium,
                                                              color: dmWhite,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  snapshot.data!
                                                                  .data()![
                                                                      userUID]
                                                                      [index]
                                                                      ['text']
                                                                  .length ==
                                                              2 &&
                                                          snapshot.data!
                                                              .data()![userUID]
                                                                  [index]
                                                                  ['text']
                                                              .contains(
                                                                  emojiRegex())
                                                      ? Text(
                                                          snapshot.data!
                                                                      .data()![
                                                                  userUID]
                                                              [index]['text'],
                                                          style: TextStyle(
                                                            fontSize: 60.sp,
                                                          ),
                                                        )
                                                      : Container(
                                                          constraints: BoxConstraints(
                                                              maxWidth: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.6234),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: dmLightGrey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.w,
                                                                    vertical:
                                                                        10.h),
                                                            child: Text(
                                                              snapshot.data!
                                                                          .data()![
                                                                      userUID][
                                                                  index]['text'],
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Pretendard',
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    medium,
                                                                color: dmBlack,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  index == snapshot.data!.data()![userUID].length - 1 ||
                                                          snapshot.data!.data()![userUID]
                                                                      [index]
                                                                  ['sender'] !=
                                                              snapshot.data!.data()![userUID]
                                                                      [index + 1]
                                                                  ['sender'] ||
                                                          snapshot.data!
                                                                  .data()![userUID]
                                                                      [index][
                                                                      'send_time']
                                                                  .toDate()
                                                                  .minute !=
                                                              snapshot.data!
                                                                  .data()![userUID]
                                                                      [index + 1]
                                                                      ['send_time']
                                                                  .toDate()
                                                                  .minute
                                                      ? Text(
                                                          DateFormat('a h:mm',
                                                                  'ko_KR')
                                                              .format(
                                                            snapshot.data!
                                                                .data()![
                                                                    userUID]
                                                                    [index][
                                                                    'send_time']
                                                                .toDate(),
                                                          ),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontSize: 14.sp,
                                                            fontWeight: medium,
                                                            color: dmDarkGrey,
                                                          ),
                                                        )
                                                      : const SizedBox()
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    }),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    '채팅이 존재하지 않아요.',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 14.sp,
                                      fontWeight: bold,
                                      color: dmLightGrey,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),

                      // Bottom
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Container(
                          width: double.infinity,
                          // Android 대응
                          height:
                              window.viewPadding.bottom > 0 ? 60.5.h : 75.5.h,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: dmGrey,
                                width: 1.w,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              // Android 대응
                              top: window.viewPadding.bottom > 0 ? 10.h : 0.h,
                              left: 20.w,
                              right: 20.w,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    'assets/images/icons/icon_chat_plus.png',
                                    width: 25.w,
                                    height: 25.h,
                                  ),
                                ),
                                SizedBox(width: 18.w),
                                Container(
                                  width: 2.w,
                                  height: 29.h,
                                  color: dmDarkGrey,
                                ),
                                SizedBox(width: 18.w),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.60914,
                                  height: 33.h,
                                  child: TextField(
                                    controller: chatController,
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 16.sp,
                                      fontWeight: medium,
                                      color: dmBlack,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 7.h,
                                        horizontal: 12.w,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: BorderSide(
                                          width: 1.w,
                                          color: dmDarkGrey,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: BorderSide(
                                          width: 1.w,
                                          color: dmDarkGrey,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(
                                          width: 1.w,
                                          color: dmBlack,
                                        ),
                                      ),
                                    ),
                                    cursorColor: dmBlack,
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (chatController.text != '' &&
                                        !RegExp(r'^\s*$')
                                            .hasMatch(chatController.text)) {
                                      FirebaseFirestore.instance
                                          .collection('chat') // chat 컬렉션에서
                                          .doc(uid) // 자신의 UID 문서 내
                                          .update({
                                        userUID: FieldValue.arrayUnion([
                                          {
                                            'type': 'text',
                                            'send_time': DateTime.now(),
                                            'sender': uid,
                                            'text': chatController.text,
                                          }
                                        ])
                                      });
                                      FirebaseFirestore.instance
                                          .collection('chat') // chat 컬렉션에서
                                          .doc(userUID) // 상대 UID의 문서 내
                                          .update({
                                        uid!: FieldValue.arrayUnion([
                                          {
                                            'type': 'text',
                                            'send_time': DateTime.now(),
                                            'sender': uid,
                                            'text': chatController.text,
                                          }
                                        ])
                                      });
                                      chatController.text = '';
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Timer(const Duration(milliseconds: 50),
                                            () {
                                          if (scrollController.hasClients) {
                                            scrollController.jumpTo(
                                              scrollController
                                                  .position.maxScrollExtent,
                                            );
                                          }
                                        });
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 35.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: dmBlue,
                                    ),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/images/icons/icon_chat_arrow_up.png',
                                      height: 18.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
