import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:templering/screens/blog/component/adds.dart';
import 'package:templering/utils/appscaffold.dart';
import '../../../utils/color.dart';
import 'blog_model.dart';
import 'blogs_controller.dart';
import 'blogs_detail_screen.dart';

class BlogsviewAll extends StatelessWidget {
  final List<BlogItem> items;

  const BlogsviewAll({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final BlogController blogsController = Get.find<BlogController>();
    return AppScaffold(
      appBarTitle: Text(
        "Blogs",
        style:
            primaryTextStyle(color: black, weight: FontWeight.bold, size: 18),
      ),
      body: ListView.builder(
        itemCount: blogsController.items.length +
            (blogsController.items.length ~/ 4),
        itemBuilder: (context, index) {
          final actualIndex = index - (index ~/ 5);
          if ((index + 1) % 5 == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: BannerAdWidget(
                adUnitId: 'ca-app-pub-3940256099942544/6300978111',
              ),
            );
          }

          return Obx(() {
            final item = blogsController.items[actualIndex];
            return Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.008),
              child: InkWell(
                onTap: () {
                  Get.to(() => BlogDetailScreen(
                        subtitle: item.subtitle,
                        time: item.time,
                        image: item.image,
                        paragraph: item.paragraph,
                      ));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.92,
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Hero(
                        tag: item.image ?? "",
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            'https://alarmclock.rukmanimfg.com/${item.image}' ??
                                "",
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.error,
                                    color: Colors.red, size: 40),
                              );
                            },
                          ),
                        ),
                      ).paddingOnly(bottom: 10),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title ?? "",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: adoptifyPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              LimitedBox(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  item.subtitle ?? "",
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ).paddingAll(
                              MediaQuery.of(context).size.height * 0.005),
                        ).paddingOnly(
                            left: MediaQuery.of(context).size.width * 0.02),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
