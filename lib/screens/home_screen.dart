import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/screens/new_detailed_screen.dart';
import 'package:news_app/service/service.dart';
import '../model/new_model.dart';
import '../widgets/category_icon_widget.dart';
import '../widgets/news_file_widget.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final Service _service = Service();
  late Future<List<Article>> futureArticles;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureArticles = _service.fetchArticles() as Future<List<Article>>;
  }

  void _searchArticles(String query) {
    setState(() {
      futureArticles =
          _service.fetchArticles(query: query) as Future<List<Article>>;
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'NEWS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hey, User!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Discover Latest News',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search For News',
                          ),
                          onSubmitted: _searchArticles,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(7)),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () {
                            _searchArticles(_searchController.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CategoryIcon(
                      icon: Icons.mic,
                      label: 'Politics',
                      onTap: () => _searchArticles('Politics'),
                    ),
                    CategoryIcon(
                      icon: Icons.movie,
                      label: 'Movies',
                      onTap: () => _searchArticles('Movies'),
                    ),
                    CategoryIcon(
                      icon: Icons.sports_baseball,
                      label: 'Sports',
                      onTap: () => _searchArticles('Sports'),
                    ),
                    CategoryIcon(
                      icon: Icons.local_police,
                      label: 'Crime',
                      onTap: () => _searchArticles('robber'),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: FutureBuilder<List<Article>>(
                    future: futureArticles,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final articles = snapshot.data!;
                        return ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            DateTime publishedDate =
                                DateTime.parse(article.publishedAt);
                            String formattedPublishedDate =
                                DateFormat('dd MMMM, yyyy')
                                    .format(publishedDate);
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewsDetailScreen(article: article),
                                  ),
                                );
                              },
                              child: NewsItem(
                                imageUrl: article.urlToImage ??
                                    'assets/images/placeholder.png',
                                title: article.title,
                                time: formattedPublishedDate,
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No data available'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
