import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/new_model.dart';

class NewsDetailScreen extends StatefulWidget {
  final Article article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime publishedDate = DateTime.parse(widget.article.publishedAt);
    String formattedPublishedDate =
        DateFormat('dd MMMM, yyyy').format(publishedDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(
                    widget.article.author![0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedPublishedDate,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      widget.article.author!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.article.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            if (widget.article.author != null)
              Text(
                'By ${widget.article.author}',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              widget.article.description ?? '',
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // You can implement the functionality for reading the full story here
                  },
                  child: Row(
                    children: [
                      const Text('Read Story',
                          style: TextStyle(color: Colors.black)),
                      const SizedBox(width: 5),
                      Container(
                        height: 2,
                        width: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // You can implement the share functionality here
                  },
                  child: const Text('Share Now',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            widget.article.urlToImage != null
                ? Image.network(
                    widget.article.urlToImage!, // Article image
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Image.asset(
                    'assets/images/street_view.jpg', // Fallback image
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ],
        ),
      ),
    );
  }
}
