import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding

import 'blog_model.dart';

class BlogController extends GetxController {
  var items = <BlogItem>[].obs; // Reactive list of blog items
  var isLoading = true.obs; // Reactive loading state

  @override
  void onInit() {
    super.onInit();
    fetchBlogs(); // Fetch blogs when the controller initializes
  }

  // Fetch blogs from the API and update the items list
  Future<void> fetchBlogs() async {
    try {
      isLoading(true); // Set loading state to true
      var request = http.Request(
          'GET', Uri.parse('https://alarmclock.rukmanimfg.com/api/getallblog'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Parse the response body as JSON
        String responseString = await response.stream.bytesToString();
        Map<String, dynamic> data = jsonDecode(responseString);

        if (data['success']) {
          // Convert the list of posts to a list of BlogItem
          List<dynamic> posts = data['posts'];
          items.value = posts.map((post) => BlogItem.fromJson(post)).toList();
        } else {
          print("Failed to fetch blogs: ${data['message']}");
        }
      } else {
        print("Failed to load blogs: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching blogs: $e");
    } finally {
      isLoading(false); // Set loading state to false regardless of success or failure
    }
  }
}
