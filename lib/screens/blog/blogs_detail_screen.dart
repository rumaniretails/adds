import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:templering/utils/appscaffold.dart';
import '../../../utils/color.dart';

class BlogDetailScreen extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? date;
  final String? time;
  final String? image;
  final String? paragraph;
  final String? summary;
  final String? content;
  final String? text;
  final String? text2;
  final String? text3;
  final String? text4;
  final String? text5;
  final String? text6;
  final String? text7;
  final String? text8;

  const BlogDetailScreen(
      {this.title,
      this.subtitle,
      this.date,
      this.time,
      this.image,
      this.paragraph,
      this.summary,
      this.content,
      this.text,
      this.text2,
      this.text3,
      this.text4,
      this.text5,
      this.text6,
      this.text7,
      this.text8});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBarTitle: Text(
          "Blog Detail",
          style:
              primaryTextStyle(color: black, weight: FontWeight.bold, size: 18),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: TextStyle(
                    color: adoptifyPrimaryColor,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ).paddingOnly(left: 16, right: 16, bottom: 10),
              Text(
                subtitle ?? "",
                style: TextStyle(
                    color: black, fontSize: 18, fontWeight: FontWeight.bold),
              ).paddingOnly(left: 16, right: 16, bottom: 10),
              Row(
                children: [
                  Text(
                    date ?? "",
                    style: TextStyle(color: grey, fontSize: 12),
                  ),
                  Spacer(),
                  Text(
                    "Read Time : ${time ?? ""}",
                    style: const TextStyle(color: grey, fontSize: 12),
                  )
                ],
              ).paddingOnly(left: 16, right: 16, bottom: 10),
              Hero(
                tag:
                    image ?? "", // Use null-aware operator to handle null image
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    'https://alarmclock.rukmanimfg.com/$image' ??
                        "", // Fallback to empty string if image is null
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Show the image once it has loaded
                      } else {
                        return Center(
                          // Display a loading indicator while the image loads
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
                        // Display an error icon or fallback widget in case of failure
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
              Text(
                paragraph ?? "",
                style: const TextStyle(color: black, fontSize: 16),
              ).paddingOnly(left: 16, right: 16, bottom: 15),
             
            ],
          ),
        ));
  }
}
