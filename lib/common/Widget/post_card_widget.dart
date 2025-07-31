import 'package:flutter/material.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';

class PostCardWidget extends StatelessWidget {
  final String imagePath;
  final String category;
  final String title;
  final String date;

  const PostCardWidget({
    Key? key,
    required this.imagePath,
    required this.category,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          // IMAGE
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
  imagePath, // 👈 your network image URL
  width: 100,
  height: 105,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return Icon(
      Icons.broken_image, // 👈 fallback icon
      size: 50,
      color: Colors.grey,
    );
  },
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                (loadingProgress.expectedTotalBytes ?? 1)
            : null,
      ),
    );
  },
)

            ),
          ),
          const SizedBox(width: 10),

          // TEXT SECTION
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // CATEGORY
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Appcolor.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: textTheme.titleMedium!.copyWith(fontSize: 13),
                    ),
                  ),

                  // TITLE
                  Text(
                    title,
                    style: textTheme.headlineSmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // DATE
                  Text(
                    date,
                    style: textTheme.headlineSmall!.copyWith(fontSize: 13,fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
