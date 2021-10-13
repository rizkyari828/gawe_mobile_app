import 'package:gaweid2/modules/media/bindings/mediaBinding.dart';
import 'package:gaweid2/modules/media/bindings/tipsBinding.dart';
import 'package:gaweid2/modules/media/view/newsNew.dart';
import 'package:gaweid2/modules/media/view/news_detail.dart';
import 'package:gaweid2/modules/media/view/tipsNew.dart';
import 'package:gaweid2/routes/routes_pages.dart';
import 'package:get/get.dart';

class MediaPages {
  static final pages = [
    GetPage(
      name: RouteName.news,
      page: () => NewsNew(),
      binding: MediaBinding(),
    ),
    GetPage(
      name: RouteName.tips,
      page: () => TipsNew(),
      binding: TipsBinding(),
    ),
    GetPage(
      name: RouteName.detailMedia,
      page: () => NewsDetail(),
    ),
  ];
}