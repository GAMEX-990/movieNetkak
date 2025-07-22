import 'dart:async'; // ใช้สำหรับการตั้งเวลา (Timer)
import 'package:flutter/material.dart';
import 'package:fluttermovie/homepage/movie.dart';
import 'package:fluttermovie/loginpage/login_page.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ตัวควบคุมสำหรับ Scroll และ Page
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final List<Movie> movies = [
    Movie(
      imagePath: 'assets/images/SG.jpg',
      title: 'Squid Game 2',
      description:
          'เรื่องย่อ Squid Game 2 ซีรีส์เกาหลีแนวดราม่าระทึกขวัญลึกลับ Squid Game 2 จะเล่าเรื่องราวสามปีหลังจากชนะสควิดเกม ผู้เล่นหมายเลข 456 ยังคงมุ่งมั่นที่จะตามหาบุคคลผู้อยู่เบื้องหลังเกมและยุติการแข่งขันอันโหดร้ายนี้ กีฮุนทุ่มเงินรางวัลที่เขาได้มาไปกับการค้นหาครั้งนี้',
           videoUrl: 'YOUR_CLOUDINARY_VIDEO_URL_HERE',
    ),
    Movie(
      imagePath: 'assets/images/LM.jpg',
      title: 'หลานม่า',
      description:
          'หลานม่า คือเรื่องราวที่มีเค้าแรงบันดาลใจมาจากเรื่องจริงในครอบครัวสังคมไทย[3] ผ่านตัวละครของ เอ็ม (พุฒิพงศ์ อัสสรัตนกุล) ที่ตัดสินใจลาออกจากงานประจำ กลับมาใช้ชีวิตร่วมกับ อาม่าเหม้งจู (อุษา เสมคำ) ผู้เป็นร่มโพธิ์ร่มไทรของครอบครัว เบื้องหน้าที่ดูเหมือนหลานมาดูแลอาม่าในบั้นปลายชีวิต แต่แท้จริงแล้วเอ็มมีจุดประสงค์บางอย่างซ่อนอยู่ หลังได้รู้ว่า มุ่ย (ต้นตะวัน ตันติเวชกุล) ได้รับมรดกก้อนใหญ่เป็นบ้านราคาสิบล้านบาทจากอากง เอ็มจึงต้องทำทุกอย่างเพื่อให้อาม่าไว้ใจ แต่กำแพงที่อาม่าตั้งไว้ ทำให้เอ็มได้เริ่มเรียนรู้การใช้ชีวิตไปทีละน้อย จนอะไรบางอย่างถูกอาม่าเปลี่ยนไปอย่างสิ้นเชิง',
           videoUrl: 'YOUR_CLOUDINARY_VIDEO_URL_HERE',
      imageAlignment: Alignment.topCenter,
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
           videoUrl: 'YOUR_CLOUDINARY_VIDEO_URL_HERE',
      imageAlignment: Alignment.center,
    ),
    Movie(
      imagePath: 'assets/images/AC.jpg',
      title: 'AC 2',
      description:
          'เรื่องราวต้นกำเนิดของ อาร์เธอร์ เคอร์รี่ ครึ่งมนุษย์และครึ่งแอตแลนเทียน ที่จะต้องพบกับการผจญภัยในชีวิตของเขา ซึ่งไม่ได้ทำให้เขาได้รู้ถึงตัวตนที่แท้จริงของตัวเองเท่านั้น แต่ยังได้พบอีกว่า เขามีเกียรติมากพอที่ได้เกิดมาเป็น "กษัตริย์" แต่หนทางก้าวสู่การเป็นใหญ่ไม่เคยโรยด้วยกลีบกุหลาบ อาร์เธอร์ ต้องเผชิญหน้ากับน้องชายต่างมารดา ออร์ม เมเรียส ผู้ปกครองคาบสมุทรคนปัจจุบัน ทั้งต้องเข้ารับมือกับบททดสอบที่จะพิสูจน์ว่าสามารถครอบครองอาวุธตรีศูลในตำนานที่สืบทอดมาจากราชาคนก่อนและกลายเป็นราชาแห่ง 7 คาบสมุทรอย่างแท้จริงตามประเพณีดั้งเดิมของชาวแอตแลนติก และเขาต้องปกป้องสงครามที่เกิดขึ้นระหว่างโลกมหาสมุทรและพื้นดิน',
           videoUrl: 'YOUR_CLOUDINARY_VIDEO_URL_HERE',
      
    ),
    // เพิ่มหนังอื่นๆ ตามต้องการ
  ];
  Timer? _timer; // ใช้สำหรับตั้งเวลาในการเลื่อนอัตโนมัติ

  // ค่าคงที่ที่ใช้ในการกำหนดขนาดต่าง ๆ
  static const double _mainPosterHeight = 500.0; // ความสูงของภาพหลัก
  static const double _movieSliderHeight = 400.0; // ความสูงของแถบเลื่อนภาพ
  static const double _moviePosterWidth = 300.0; // ความกว้างของโปสเตอร์ภาพยนตร์
  static const double _moviePosterHeight = 350.0; // ความสูงของโปสเตอร์ภาพยนตร์
  static const Color _backgroundColor =
      Color.fromARGB(255, 1, 7, 21); // สีพื้นหลัง

  // ตัวแปรที่ใช้เก็บสถานะ
  int _currentPage = 0; // หน้าแรกที่แสดง
  final List<String> mainPosters = [
    'assets/images/SGN.jpg',
    'assets/images/LMN.jpeg',
    'assets/images/MT.jpg',
    'assets/images/TIT.jpg',
    'assets/images/ACM.jpg',

    // เพิ่มภาพที่ต้องการแสดงในแถบสไลด์
  ];

  // ฟังก์ชันที่ถูกเรียกใช้เมื่อเริ่มต้นสร้าง Widget
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoSlide(); // เริ่มต้นการเลื่อนอัตโนมัติหลังจาก widget ถูกสร้าง
    });
  }

  // ฟังก์ชันเริ่มการเลื่อนภาพอัตโนมัติ
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

  // ฟังก์ชันเลื่อนภาพไปทางซ้าย
  void _scrollLeft() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset - 300, // เลื่อนไปทางซ้าย 300 px
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // ฟังก์ชันเลื่อนภาพไปทางขวา
  void _scrollRight() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + 300, // เลื่อนไปทางขวา 300 px
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // ฟังก์ชันนำทางไปหน้า LoginPage
  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const LoginPage()), // เปิดหน้า LoginPage
    );
  }

  void _showMovieDetails(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            // เพิ่ม SingleChildScrollView ตรงนี้
            child: Container(
              width: 700,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 1, 7, 21),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        alignment: movie
                            .imageAlignment, // ใช้ค่า alignment จาก Movie object
                      ),
                    ),
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

  // ฟังก์ชันสร้าง UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context), // สร้าง AppBar
      body: _buildBody(), // สร้างเนื้อหาของหน้า
    );
  }

  // ฟังก์ชันสร้าง AppBar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Let's watch a movie.",
        style: GoogleFonts.bebasNeue(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      actions: [_buildLoginButton(context)], // เพิ่มปุ่ม Login
      backgroundColor: _backgroundColor, // กำหนดสีพื้นหลังของ AppBar
      bottom: _buildAppBarDivider(), // เส้นแบ่งใต้ AppBar
    );
  }

  // ฟังก์ชันสร้างปุ่ม Login
  Widget _buildLoginButton(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      onPressed: () => _navigateToLogin(context), // เมื่อกดปุ่ม Login
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Login",
          style: GoogleFonts.bebasNeue(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างเส้น Divider ใต้ AppBar
  PreferredSizeWidget _buildAppBarDivider() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(6.0),
      child: Divider(
        height: 1.0,
        color: Colors.white,
      ),
    );
  }

  // ฟังก์ชันสร้างเนื้อหาหลัก
  Widget _buildBody() {
    return Container(
      color: _backgroundColor, // สีพื้นหลังของ body
      child: CustomScrollView(
        slivers: [
          _buildMainPoster(), // สร้างภาพหลัก
          _buildTrendingTitle(), // สร้างชื่อ "Trending Now"
          _buildMovieSlider(), // สร้างแถบเลื่อนภาพภาพยนตร์
          _builAboutText(),
          _buildTextContent(),
        ],
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

  // ฟังก์ชันสร้างจุดเลื่อนสำหรับภาพหลัก
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

  // ฟังก์ชันสร้างชื่อ "Trending Now"
  Widget _buildTrendingTitle() {
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

  Widget _builAboutText() {
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

  // ฟังก์ชันสร้างปุ่มเลื่อน
  Widget _buildScrollButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed, // เมื่อกดปุ่มจะเรียกฟังก์ชันที่กำหนด
      icon: Icon(icon),
      color: Colors.white,
      iconSize: 40,
    );
  }

  // ฟังก์ชันสร้างรายการภาพยนตร์
  Widget _buildMovieList() {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return _buildMoviePoster(movies[index]);
      },
    );
  }

  // ฟังก์ชันสร้างโปสเตอร์ภาพยนตร์
  Widget _buildMoviePoster(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
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
    );
  }
}