import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/widgets/top_image_slider.dart';
import 'package:event_planner_app/widgets/event/event.dart';
import 'package:event_planner_app/widgets/imageList/photos_list.dart';
import 'package:event_planner_app/widgets/post/post_count.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          // Fixed Image Slider at the top
          const ImageSlider(),
          // Scrollable content below the image slider
          Expanded(
            // SingleChildScrollView to make the content scrollable
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Event(),
                    const PhotosList(),
                    const PostList(),
                  ],
                ),
              ),
            ),
          ),
          const Space(space: 20),
        ],
      ),
    );
  }
}
