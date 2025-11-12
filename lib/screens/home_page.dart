import 'package:flutter/material.dart';
import '../services/news_service.dart';
import '../widgets/news_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsService _service = NewsService();
  List<dynamic> news = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final result = await _service.fetchNews('us');

      final filtered = result.where((item) {
        final url = item['urlToImage'];
        return url != null && url.isNotEmpty && url.startsWith('http');
      }).toList();

      setState(() {
        news = filtered;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color navyBlue = Color(0xFF0A2342);

    if (loading) {
      return Scaffold(
        backgroundColor: const Color(0xFFF4F6FA),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(color: navyBlue),
              SizedBox(height: 16),
              Text(
                'Cargando noticias...',
                style: TextStyle(
                  fontSize: 16,
                  color: navyBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(child: Text('Error: $error')),
      );
    }

    if (news.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No hay noticias disponibles')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text(
          'Noticias recientes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        backgroundColor: navyBlue,
        centerTitle: true,
        elevation: 4,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 14,
          childAspectRatio: 0.75,
        ),
        itemCount: news.length,
        itemBuilder: (context, index) {
          final item = news[index];
          return NewsCard(
            title: item['title'] ?? 'Sin título',
            description: item['description'] ?? 'Sin descripción',
            imageUrl: item['urlToImage'] ?? '',
            url: item['url'] ?? '',
          );
        },
      ),
    );
  }
}
