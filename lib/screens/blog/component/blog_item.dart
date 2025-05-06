import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/color.dart';
import '../blogs_controller.dart';
import '../blogs_detail_screen.dart';

class BlogsItem extends StatelessWidget {
  final BlogController blogsController = Get.put(BlogController());

  BlogsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // Display a loader if items are still loading
        if (blogsController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Show a message if no items are available
        if (blogsController.items.isEmpty) {
          return const Center(
            child: Text(
              "No blogs available.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }

        // Display the list of blog items
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: blogsController.items.length,
          itemBuilder: (context, index) {
            final item = blogsController.items[index];
            return GestureDetector(
              onTap: () {
                Get.to(
                  () => BlogDetailScreen(
                    title: item.title,
                    subtitle: item.subtitle,
                    time: item.time,
                    image: item.image,
                    paragraph: item.paragraph,
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: boxDecorationDefault(
                    color: context.cardColor, borderRadius: radius(15)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: item.image ?? "",
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          'https://alarmclock.rukmanimfg.com/${item.image}' ?? "",
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ?? 1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ).paddingOnly(bottom: 10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        8.height,
                        Text(
                          item.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: secondaryTextStyle(
                            color: adoptifyPrimaryColor,
                            weight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        4.height,
                        Text(
                          item.subtitle ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: primaryTextStyle(
                              color: Colors.grey, weight: FontWeight.bold),
                        ),
                        4.height,
                      ],
                    ).paddingSymmetric(horizontal: 16).expand(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
