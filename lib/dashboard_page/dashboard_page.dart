import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttermovie/dashboard_page/VideoPlayerScreen%20.dart';
import 'package:fluttermovie/firebase_service.dart';
import 'package:fluttermovie/homepage/movie.dart';
import 'package:google_fonts/google_fonts.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin{
  String? userDisplayName;
  late AnimationController _heartAnimationController;
  late Animation<double> _heartAnimation;
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  final List<Movie> movies = [
    Movie(
      imagePath: 'assets/images/SG.jpg',
      title: 'Squid Game 2',
      description:
          'เรื่องย่อ Squid Game 2 ซีรีส์เกาหลีแนวดราม่าระทึกขวัญลึกลับ Squid Game 2 จะเล่าเรื่องราวสามปีหลังจากชนะสควิดเกม ผู้เล่นหมายเลข 456 ยังคงมุ่งมั่นที่จะตามหาบุคคลผู้อยู่เบื้องหลังเกมและยุติการแข่งขันอันโหดร้ายนี้ กีฮุนทุ่มเงินรางวัลที่เขาได้มาไปกับการค้นหาครั้งนี้',
           videoUrl: 'https://res.cloudinary.com/dahxleyg6/video/upload/v1739723890/Squid_Game_mfr9ae.mp4',
          
    ),
       Movie(
      imagePath: 'assets/images/LM.jpg',
      title: 'หลานม่า',
      description:
          'หลานม่า คือเรื่องราวที่มีเค้าแรงบันดาลใจมาจากเรื่องจริงในครอบครัวสังคมไทย[3] ผ่านตัวละครของ เอ็ม (พุฒิพงศ์ อัสสรัตนกุล) ที่ตัดสินใจลาออกจากงานประจำ กลับมาใช้ชีวิตร่วมกับ อาม่าเหม้งจู (อุษา เสมคำ) ผู้เป็นร่มโพธิ์ร่มไทรของครอบครัว เบื้องหน้าที่ดูเหมือนหลานมาดูแลอาม่าในบั้นปลายชีวิต แต่แท้จริงแล้วเอ็มมีจุดประสงค์บางอย่างซ่อนอยู่ หลังได้รู้ว่า มุ่ย (ต้นตะวัน ตันติเวชกุล) ได้รับมรดกก้อนใหญ่เป็นบ้านราคาสิบล้านบาทจากอากง เอ็มจึงต้องทำทุกอย่างเพื่อให้อาม่าไว้ใจ แต่กำแพงที่อาม่าตั้งไว้ ทำให้เอ็มได้เริ่มเรียนรู้การใช้ชีวิตไปทีละน้อย จนอะไรบางอย่างถูกอาม่าเปลี่ยนไปอย่างสิ้นเชิง',
      imageAlignment: Alignment.topCenter,
       videoUrl: 'https://res.cloudinary.com/dahxleyg6/video/upload/v1739724000/%E0%B8%95%E0%B8%B1%E0%B8%A7%E0%B8%AD%E0%B8%A2%E0%B9%88%E0%B8%B2%E0%B8%87%E0%B8%A0%E0%B8%B2%E0%B8%9E%E0%B8%A2%E0%B8%99%E0%B8%95%E0%B8%A3%E0%B9%8C_%E0%B8%AB%E0%B8%A5%E0%B8%B2%E0%B8%99%E0%B8%A1%E0%B9%88%E0%B8%B2___Official_Trailer_uyrgl9.mp4',
    ),
     Movie(
      imagePath: 'assets/images/MEG.jpg',
      title: 'MEG 2',
      description:
          'โจนัส เทย์เลอร์ กำลังทำการวิจัยลูกฉลามเมกาโลดอนที่ถูกนำมากักไว้เพื่อวิจัย ในขณะที่ทีมวิจัยคนอื่นกลับออกไปสำรวจร่องมหาสมุทรมาเรียนน่าซึ่งเป็นที่ที่พวกเขาพบกับเมกาโลดอนเป็นครั้งแรก ที่นั่นทีมวิจัยสำรวจพบกับสิ่งมีชีวิตดึกดำบรรพ์อีกตัวหนึ่งคือ โครโนซอรัส สัตว์เลื้อยคลานในทะเลขนาดใหญ่ที่วิวัฒนาการมาเพื่อล่าสัตว์ซึ่งมันอาศัยอยู่ในร่องน้ำมรณะแห่งนี้ ทีมวิจัยและโจนัสจะต้องเผชิญหน้ากับสัตว์ดึกดำบรรพ์ตัวโหดตัวใหม่ รวมถึงการกลับมาของเมกาโลดอนด้วย',
           videoUrl: 'YOUR_CLOUDINARY_VIDEO_URL_HERE',
    ),
     Movie(
      imagePath: 'assets/images/IT.jpg',
      title: 'IT 2',
      description:
          'IT Chapter 2 อิท โผล่จากนรก 2 นั้น จะเป็นเหตุการณ์หลังจากภาคแรกเป็นเวลา 27 ปี แก๊งขี้แพ้ (Losers Club) ที่เติบโตเป็นผู้ใหญ่ กลับมารวมตัวกันอีกครั้งที่เมืองเดอร์รี บ้านเกิดของพวกเขา เพื่อหาทางกำจัดตัวตลกเพนนีไวส์ ปีศาจตัวตลกที่สร้างความเขย่าขวัญให้กับทั้งเด็กและผู้ใหญ่ให้สิ้นซาก',
      imageAlignment: Alignment.center,
       videoUrl: 'YOUR_CLOUDINARY_VIDEO_URL_HERE',
    ),
    Movie(
      imagePath: 'assets/images/AC.jpg',
      title: 'AC 2',
      description:
          'เรื่องราวต้นกำเนิดของ อาร์เธอร์ เคอร์รี่ ครึ่งมนุษย์และครึ่งแอตแลนเทียน ที่จะต้องพบกับการผจญภัยในชีวิตของเขา ซึ่งไม่ได้ทำให้เขาได้รู้ถึงตัวตนที่แท้จริงของตัวเองเท่านั้น แต่ยังได้พบอีกว่า เขามีเกียรติมากพอที่ได้เกิดมาเป็น "กษัตริย์" แต่หนทางก้าวสู่การเป็นใหญ่ไม่เคยโรยด้วยกลีบกุหลาบ อาร์เธอร์ ต้องเผชิญหน้ากับน้องชายต่างมารดา ออร์ม เมเรียส ผู้ปกครองคาบสมุทรคนปัจจุบัน ทั้งต้องเข้ารับมือกับบททดสอบที่จะพิสูจน์ว่าสามารถครอบครองอาวุธตรีศูลในตำนานที่สืบทอดมาจากราชาคนก่อนและกลายเป็นราชาแห่ง 7 คาบสมุทรอย่างแท้จริงตามประเพณีดั้งเดิมของชาวแอตแลนติก และเขาต้องปกป้องสงครามที่เกิดขึ้นระหว่างโลกมหาสมุทรและพื้นดิน',
           videoUrl: 'YOUR_CLOUDINARY_VIDEO_URL_HERE',
      
    ),
  ];
   Timer? _timer;

  Set<String> favoriteMovies = {}; // Store favorite movie titles
   bool showFavoritesOnly = false; // เพิ่มตัวแปรสำหรับการกรองรายการโปรด

  static const double _mainPosterHeight = 500.0;
  static const double _movieSliderHeight = 400.0;
  static const double _moviePosterWidth = 300.0;
  static const double _moviePosterHeight = 350.0;
  static const Color _backgroundColor = Color.fromARGB(255, 1, 7, 21);

  int _currentPage = 0;
  final List<String> mainPosters = [
    'assets/images/SGN.jpg',
    'assets/images/LMN.jpeg',
    'assets/images/MT.jpg',
    'assets/images/TIT.jpg',
    'assets/images/ACM.jpg',
  ];

  

@override
  void initState() {
    super.initState();
    _loadFavorites();
    _loadUserData();
    // ตั้งค่าแอนิเมชั่นสำหรับหัวใจ
    _heartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heartAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _heartAnimationController,
        curve: Curves.easeOut,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoSlide();
    });
  }

@override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }
  
  // เพิ่มเมธอดสำหรับโหลดข้อมูลรายการโปรด
    Future<void> _loadFavorites() async {
    List<String> favorites = await FirebaseService.getFavorites();
    setState(() {
      favoriteMovies = Set<String>.from(favorites);
    });
  }

  // ปรับปรุงเมธอด _toggleFavorite
  void _toggleFavorite(String movieTitle) async {
  try {
    if (favoriteMovies.contains(movieTitle)) {
      await FirebaseService.removeFromFavorites(movieTitle);
      setState(() {
        favoriteMovies.remove(movieTitle);
      });
    } else {
      await FirebaseService.addToFavorites(movieTitle);
      setState(() {
        favoriteMovies.add(movieTitle);
      });
    }
    _heartAnimationController.forward().then((_) {
      _heartAnimationController.reverse();
    });
  } catch (e) {
    // แสดง error message ให้ user ทราบ
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
    );
  }
}

 Future<void> _loadUserData() async {
    try {
      Map<String, dynamic>? userData = await FirebaseService.getUserData();
      if (userData != null && userData.containsKey('displayName')) {
        setState(() {
          userDisplayName = userData['displayName'];
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }


  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!mounted) return; // ตรวจสอบว่า widget ยังไม่ถูกลบ
      setState(() {
        _currentPage =
            (_currentPage + 1) % mainPosters.length; // เปลี่ยนหน้าภาพที่แสดง
      });

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage, // เลื่อนไปยังหน้าที่เลือก
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut, // การเคลื่อนที่แบบนุ่มนวล
        );
      }
    });
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการออกจากระบบ'),
          content: const Text('คุณต้องการออกจากระบบใช่หรือไม่?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิด dialog
              },
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิด dialog
                Navigator.pushReplacementNamed(context, '/'); // กลับไปหน้า HomePage
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('ออกจากระบบ'),
            ),
          ],
        );
      },
    );
  }

  void _scrollLeft() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset - 300,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollRight() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + 300,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }



  void _showMovieDetails(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Container(
              width: 700,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 1, 7, 21),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withAlpha((0.2*255).round())),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: SizedBox(
                          height: 400,
                          width: double.infinity,
                          child: Image.asset(
                            movie.imagePath,
                            fit: BoxFit.cover,
                            alignment: movie.imageAlignment,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(
                            favoriteMovies.contains(movie.title)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () => _toggleFavorite(movie.title),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movie.description,
                          style: TextStyle(
                            color: Colors.white.withAlpha((0.8*255).round()),
                            fontSize: 16,
                          ),
                        ),
                     const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPlayerScreen(
                                    videoUrl: movie.videoUrl,
                                    title: movie.title,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Watch Movie',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Close',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

//สร้างAppBar
 PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        showFavoritesOnly ? "รายการหนังที่ชอบ" : "หน้าหลัก",
        style: GoogleFonts.bebasNeue(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      actions: [
        // แสดงชื่อผู้ใช้
        if (userDisplayName != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.account_circle, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  userDisplayName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        // Switch แสดงรายการโปรด
        Row(
          children: [
            const Text(
              "แสดงรายการโปรด",
              style: TextStyle(color: Colors.white),
            ),
            _buildFavoriteToggle(),
          ],
        ),
        // ปุ่มล็อกเอาท์
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () => _handleLogout(context),
          tooltip: 'ออกจากระบบ',
        ),
        const SizedBox(width: 16),
      ],
      backgroundColor: _backgroundColor,
      bottom: _buildAppBarDivider(),
    );
  }

  PreferredSizeWidget _buildAppBarDivider() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(6.0),
      child: Divider(
        height: 1.0,
        color: Colors.white,
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: _backgroundColor,
      child: CustomScrollView(
        slivers: [
          _buildMainPoster(),
          _buildFavoriteCount(),
          _buildTrendingNowMoviesTitle(),
          _buildMovieSlider(),
          _buildAboutText(),
          _buildTextContent(),
        ],
      ),
    );
  }


  // Rest of the methods remain the same as HomePage, just rename _buildTrendingTitle to _buildFavoriteMoviesTitle
  // and update the text to "My Favorite Movies"

  Widget _buildTrendingNowMoviesTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 50),
        child: Text(
          'Trending Now',
          style: GoogleFonts.bebasNeue(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างภาพหลัก
  Widget _buildMainPoster() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: _mainPosterHeight,
        child: Stack(
          children: [
            _buildMainPosterSlider(), // สร้างแถบเลื่อนภาพหลัก
            _buildPaginationDots(), // สร้างจุดเลื่อน
          ],
        ),
      ),
    );
  }

  Widget _buildPaginationDots() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          mainPosters.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index
                  ? Colors.white
                  : Colors.white.withAlpha((0.4*255).round()),
            ),
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างแถบเลื่อนภาพหลัก
  Widget _buildMainPosterSlider() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (int page) {
        setState(() {
          _currentPage = page; // เปลี่ยนหน้าเมื่อมีการเลื่อน
        });
      },
      itemCount: mainPosters.length,
      itemBuilder: (context, index) {
        return Image.asset(
          mainPosters[index],
          // fit: BoxFit.cover,
          // width: double.infinity,
        );
      },
    );
  }

  // ฟังก์ชันสร้างแถบเลื่อนภาพยนตร์
  Widget _buildMovieSlider() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: _movieSliderHeight,
        child: Row(
          children: [
            _buildScrollButton(
                Icons.arrow_back_ios, _scrollLeft), // ปุ่มเลื่อนไปทางซ้าย
            Expanded(child: _buildMovieList()), // แสดงรายการภาพยนตร์
            _buildScrollButton(
                Icons.arrow_forward_ios, _scrollRight), // ปุ่มเลื่อนไปทางขวา
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างรายการภาพยนตร์
Widget _buildMovieList() {
    var displayedMovies = showFavoritesOnly
        ? movies.where((movie) => favoriteMovies.contains(movie.title)).toList()
        : movies;

    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      itemCount: displayedMovies.length,
      itemBuilder: (context, index) {
        return _buildMoviePoster(displayedMovies[index]);
      },
    );
  }

  // ฟังก์ชันสร้างโปสเตอร์ภาพยนตร์
  Widget _buildMoviePoster(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => _showMovieDetails(context, movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                movie.imagePath,
                height: _moviePosterHeight,
                width: _moviePosterWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha((0.5*255).round()),
                borderRadius: BorderRadius.circular(20),
              ),
              child: _buildHeartIcon(movie.title),
            ),
          ),
        ],
      ),
    );
  }

// ฟังก์ชันสร้างปุ่มเลื่อน
Widget _buildScrollButton(IconData icon, VoidCallback onPressed) {
  return IconButton(
    onPressed: onPressed, // เมื่อกดปุ่มจะเรียกฟังก์ชันที่กำหนด
    icon: Icon(icon),
    color: Colors.white,
    iconSize: 40,
  );
}

Widget _buildAboutText() {
  return SliverToBoxAdapter(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('About the website',
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              )),
        ),
      ],
    ),
  );
}

Widget _buildTextContent() {
  return SliverToBoxAdapter(
    child: Text(
      'This website is for educational purposes only and no copyright infringement is intended.',
      style: GoogleFonts.bebasNeue(
          color: Colors.white.withAlpha((0.5*255).round()), fontSize: 16),
      textAlign: TextAlign.center,
    ),
  );
}

 // ฟังก์ชันสร้าง Widget สำหรับแสดงไอคอนหัวใจ
  Widget _buildHeartIcon(String movieTitle) {
    bool isFavorite = favoriteMovies.contains(movieTitle);
    return AnimatedBuilder(
      animation: _heartAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isFavorite ? _heartAnimation.value : 1.0,
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
              size: 35,
            ),
            onPressed: () => _toggleFavorite(movieTitle),
          ),
        );
      },
    );
  }

  // ฟังก์ชันสร้างปุ่มสลับการแสดงรายการโปรด
  Widget _buildFavoriteToggle() {
    return Switch(
      value: showFavoritesOnly,
      onChanged: (value) {
        setState(() {
          showFavoritesOnly = value;
        });
      },
      activeColor: Colors.red,
    );
  }

    // เพิ่มส่วนแสดงจำนวนรายการโปรด
  Widget _buildFavoriteCount() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'หนังที่คุณชอบ: ${favoriteMovies.length} เรื่อง',
          style: GoogleFonts.bebasNeue(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


