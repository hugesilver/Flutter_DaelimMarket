import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daelim_market/screen/widgets/button.dart';
import 'package:daelim_market/screen/widgets/scroll_behavior.dart';
import 'package:daelim_market/styles/colors.dart';
import 'package:daelim_market/styles/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:daelim_market/main.dart';
import 'package:get/get.dart';
import '../../widgets/named_widget.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  var uidData;
  int watchlistLength = 0;
  int postsLength = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String uidNickName = '';
  String uidProfile = '';
  String uidEmail = '';

  Widget imageBlock(data, index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          'detail',
          parameters: {
            'productId': data[index]['product_id'],
          },
        );
      },
      child: Stack(
        children: [
          CachedNetworkImage(
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            imageUrl: data[index]['images'][0],
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                color: dmGrey,
                borderRadius: BorderRadius.circular(5.r),
              ),
              width: 105.w,
              height: 105.w,
            ),
            placeholder: (context, url) => Container(
              decoration: BoxDecoration(
                color: dmGrey,
                borderRadius: BorderRadius.circular(5.r),
              ),
              width: 105.w,
              height: 105.w,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          ),
          data[index]['status'] == 1 || data[index]['status'] == 2
              ? Container(
                  width: 105.w,
                  height: 105.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: dmBlack.withOpacity(0.75),
                  ),
                  child: Center(
                    child: data[index]['status'] == 1
                        ? Image.asset(
                            'assets/images/status/status_1.png',
                            width: 95.h,
                          )
                        : Image.asset(
                            'assets/images/status/status_2.png',
                            width: 95.h,
                          ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget moreImageBlock(data, index, history) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          'historyscreen',
          parameters: {
            'history': history,
          },
        );
      },
      child: CachedNetworkImage(
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        imageUrl: data[index]['images'][0],
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          width: 105.w,
          height: 105.w,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  color: dmGrey,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: dmBlack.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 50.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 3; i++)
                        Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: dmWhite,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            color: dmGrey,
            borderRadius: BorderRadius.circular(5.r),
          ),
          width: 105.w,
          height: 105.w,
          alignment: Alignment.center,
          child: SizedBox(
            width: 50.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: dmWhite,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            topPadding,
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                '마이페이지',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 28.sp,
                  fontWeight: bold,
                  color: dmBlack,
                ),
              ),
            ),
            SizedBox(height: 17.5.h),
            divider,

            // Content
            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: RefreshIndicator(
                  onRefresh: onRefresh,
                  backgroundColor: dmWhite,
                  color: dmDarkGrey,
                  strokeWidth: 2.w,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 9.5.w, top: 34.5.h),
                            child: Row(
                              children: [
                                uidProfile == ''
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14758,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.14758,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: dmLightGrey,
                                        ),
                                      )
                                    : CachedNetworkImage(
                                        fadeInDuration: Duration.zero,
                                        fadeOutDuration: Duration.zero,
                                        imageUrl: uidProfile,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14758,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.14758,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14758,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14758,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                            shape: BoxShape.circle,
                                            color: dmLightGrey,
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14758,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14758,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: dmLightGrey,
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: EdgeInsets.only(left: 23.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        uidNickName == ''
                                            ? '불러오는 중...'
                                            : uidNickName,
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontSize: 24.sp,
                                          fontWeight: medium,
                                          color: dmBlack,
                                        ),
                                      ),
                                      Text(
                                        uidEmail == '' ? '불러오는 중...' : uidEmail,
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
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/mypage_setting');
                            },
                            child: const BlueButton(
                              text: '프로필 수정',
                            ),
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
                          FutureBuilder(
                            future: getWatchlistDocuments(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null &&
                                  snapshot.data!.isNotEmpty) {
                                return Column(
                                  children: [
                                    Row(
                                      // 관심목록 첫째줄
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (var i = 0; i < 3; i++)
                                          i < snapshot.data!.length
                                              ? imageBlock(snapshot.data!, i)
                                              : SizedBox(
                                                  width: 105.w,
                                                  height: 105.w,
                                                )
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          snapshot.data!.length > 3 ? 18.h : 0,
                                    ),
                                    snapshot.data!.length > 3
                                        ? Row(
                                            // 관심목록 둘째줄
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              for (var i = 3; i < 6; i++)
                                                i < 5
                                                    ? snapshot.data!.length > i
                                                        ? imageBlock(
                                                            snapshot.data!, i)
                                                        : SizedBox(
                                                            width: 105.w,
                                                            height: 105.w,
                                                          )
                                                    : snapshot.data!.length > 5
                                                        ? snapshot.data!
                                                                    .length >
                                                                6
                                                            ? moreImageBlock(
                                                                snapshot.data!,
                                                                i,
                                                                'watchlist')
                                                            : imageBlock(
                                                                snapshot.data!,
                                                                i)
                                                        : SizedBox(
                                                            width: 105.w,
                                                            height: 105.w,
                                                          ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox();
                            },
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
                          FutureBuilder(
                            future: getPostsDocuments(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null &&
                                  snapshot.data!.isNotEmpty) {
                                return Column(
                                  children: [
                                    Row(
                                      // 판매내역 첫째줄
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (var i = 0; i < 3; i++)
                                          i < snapshot.data!.length
                                              ? imageBlock(snapshot.data!, i)
                                              : SizedBox(
                                                  width: 105.w,
                                                  height: 105.w,
                                                )
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          snapshot.data!.length > 3 ? 18.h : 0,
                                    ),
                                    snapshot.data!.length > 3
                                        ? Row(
                                            // 판매내역 둘째줄
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              for (var i = 3; i < 6; i++)
                                                i < 5
                                                    ? snapshot.data!.length > i
                                                        ? imageBlock(
                                                            snapshot.data!, i)
                                                        : SizedBox(
                                                            width: 105.w,
                                                            height: 105.w,
                                                          )
                                                    : snapshot.data!.length > 5
                                                        ? snapshot.data!
                                                                    .length >
                                                                6
                                                            ? moreImageBlock(
                                                                snapshot.data!,
                                                                i,
                                                                'posts')
                                                            : imageBlock(
                                                                snapshot.data!,
                                                                i)
                                                        : SizedBox(
                                                            width: 105.w,
                                                            height: 105.w,
                                                          ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    // 1초 뒤에 setState를 이용하여 새로고침
    return Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {});
    });
  }

  getData() async {
    uidData = await FirebaseFirestore.instance
        .collection('user') // user 컬렉션으로부터
        .doc(uid) // 넘겨받은 uid 필드의 데이터를
        .get();

    var dataMap = uidData.data();
    uidNickName = dataMap!['nickName'];
    uidProfile = dataMap['profile_image'];
    uidEmail = dataMap['email'];

    if (mounted) {
      setState(() {});
    }
  }

  Future<List<DocumentSnapshot>> getWatchlistDocuments() async {
    List<dynamic>? watchlistData = [];
    if (uidData != null) {
      watchlistData = await uidData.data()?['watchlist']; // 검색할 product_id 배열
      List<DocumentSnapshot> documents = [];

      if (watchlistData != null) {
        for (String productId in watchlistData.reversed) {
          QuerySnapshot snapshot = await FirebaseFirestore.instance
              .collection('product')
              .where('product_id', isEqualTo: productId)
              .get();

          documents.addAll(snapshot.docs);
        }
      }
      return documents;
    }
    return [];
  }

  Future<List<DocumentSnapshot>> getPostsDocuments() async {
    List<dynamic>? postsData = [];
    if (uidData != null) {
      postsData = await uidData.data()?['posts']; // 검색할 product_id 배열
      List<DocumentSnapshot> documents = [];

      if (postsData != null) {
        for (String productId in postsData.reversed) {
          QuerySnapshot snapshot = await FirebaseFirestore.instance
              .collection('product')
              .where('product_id', isEqualTo: productId)
              .get();

          documents.addAll(snapshot.docs);
        }
      }
      return documents;
    }
    return [];
  }
}
