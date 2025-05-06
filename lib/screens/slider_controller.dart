import 'dart:convert'; // For JSON decoding
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; 
import 'package:templering/screens/slider_model.dart';

class SliderController extends GetxController {
  final CarouselController carouselController = CarouselController();
  RxList<SliderModel> imageList = RxList();
  RxInt currentindex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSliderImages();
  }

  Future<void> fetchSliderImages() async {
    try {
      var request = http.Request(
        'GET',
        Uri.parse('https://alarmclock.rukmanimfg.com/api/get-slider-image'),
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedData = json.decode(responseBody);

        if (decodedData['success'] == true) {
          List<SliderModel> fetchedImages = (decodedData['posts'] as List)
              .map((post) => SliderModel(
                    title: post['title'] ?? '',
                    description: post['description'] ?? '',
                    image:
                        'https://alarmclock.rukmanimfg.com/${post['images'][0] ?? ''}',
                  ))
              .toList();

          imageList.value = fetchedImages; // Update the RxList
        } else {
          print('Failed to fetch slider images: ${decodedData['message']}');
        }
      } else {
        print('Failed to fetch slider images: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching slider images: $e');
    }
  }
}
