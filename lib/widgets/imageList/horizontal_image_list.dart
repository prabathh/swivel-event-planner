import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/error.dart';
import 'package:event_planner_app/widgets/common/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_planner_app/providers/photos_provider.dart';

class HorizontalImageList extends ConsumerWidget {
  const HorizontalImageList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  Read the photosProvider
    final photosAsyncValue = ref.watch(photosProvider);

    return photosAsyncValue.when(
      data: (photos) {
        return SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final data = photos[index];
              return SizedBox(
                width: 244,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      //  Cached Network Image
                      child: CachedNetworkImage(
                        imageUrl: data.downloadUrl,
                        errorWidget:
                            (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: 244,
                        height: 130,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: const BorderSide(
                            color: AppColors.secondaryBorderColor,
                            width: 1,
                          ),
                          left: const BorderSide(
                            color: AppColors.secondaryBorderColor,
                            width: 1,
                          ),
                          bottom: const BorderSide(
                            color: AppColors.secondaryBorderColor,
                            width: 1,
                          ),
                          right:
                              index == photos.length - 1
                                  ? const BorderSide(
                                    color: AppColors.secondaryBorderColor,
                                    width: 1,
                                  )
                                  : BorderSide.none,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.author,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.commentName,
                            ),
                            const SizedBox(height: 10),
                            // Hardcoded description
                            const Text(
                              'Anyone with symptoms should be tested, wherever possible. People who do not have symptoms but have had close...',
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.subheading,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      //  Show a loading spinner while the photos are loading
      loading: () => LoadingIndicator(height: 300),
      //  Show an error message if the photos fail to load
      error:
          (error, stackTrace) =>
              ErrorView(error: 'Failed to load photos', height: 300),
    );
  }
}
