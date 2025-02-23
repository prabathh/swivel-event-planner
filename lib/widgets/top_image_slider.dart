import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/error.dart';
import 'package:event_planner_app/widgets/common/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_planner_app/providers/image_provider.dart';

class ImageSlider extends ConsumerWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the imageSliderProvider and imageSliderIndexProvider
    final imagesAsyncValue = ref.watch(imageSliderProvider);
    final currentIndex = ref.watch(imageSliderIndexProvider);

    return imagesAsyncValue.when(
      data: (images) {
        return SizedBox(
          height: 220,
          child: Stack(
            children: [
              //  Carousel Slider
              CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  return ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: images[index],
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 220,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    ref.read(imageSliderIndexProvider.notifier).state = index;
                  },
                ),
              ),
              // Image Counter
              Positioned(
                right: 16,
                bottom: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    '${currentIndex + 1} / ${images.length}',
                    style: AppTextStyles.input,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      // Show a loading spinner while the images are loading
      loading: () => LoadingIndicator(height: 220),
      // Show an error message if the images fail to load
      error:
          (error, stackTrace) =>
              ErrorView(error: 'Failed to load image', height: 220),
    );
  }
}
