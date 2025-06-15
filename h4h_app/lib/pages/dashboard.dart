import 'package:flutter/material.dart';
import 'package:h4h_app/components/appbar.dart';
import 'package:h4h_app/components/itemscroll.dart';
import 'package:h4h_app/components/shoplist.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              
              itemListView(),
              
              const SizedBox(height: 20),

              // PageView de imágenes
              SizedBox(
                height: 90,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    // _buildImage('assets/images/img1.png'),
                    _buildImage('assets/images/img2.png'),
                    _buildImage('assets/images/img3.png'),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // AnimatedSmoothIndicator con ExpandingDotsEffect
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentIndex,
                  count: 2,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 3.5,
                    activeDotColor: Color.fromARGB(255, 219, 7, 35),
                    dotColor: Color.fromARGB(255,215, 213, 209),
                    spacing: 12,
                  ),
                ),
              ),

              const SizedBox(height: 12),
              shopList(),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(path, fit: BoxFit.cover),
      ),
    );
  }
}
