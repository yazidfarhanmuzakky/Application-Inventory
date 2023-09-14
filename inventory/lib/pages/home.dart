import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inventory/pages/stock_barang.dart';
import 'package:inventory/pages/add_stock_barang.dart';

class home extends StatefulWidget {
  final token;

  const home({@required this.token,Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<home> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 4000), (_) {
      _goToNextPage();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void _goToNextPage() {
    if (_currentPageIndex < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      _pageController.jumpToPage(0);
    }
  }

  void _goToPreviousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      _pageController.jumpToPage(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Data Barang Toko Tunas Baru'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! > 0) {
                        _goToPreviousPage();
                      } else if (details.primaryVelocity! < 0) {
                        _goToNextPage();
                      }
                      stopTimer();
                      startTimer();
                    },
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                      children: [
                        Container(
                          width: double.infinity,
                          child: Image.asset(
                            'lib/images/home1.png',
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Image.asset(
                            'lib/images/home5.png',
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Image.asset(
                            'lib/images/home4.png',
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 6,
                    child: InkWell(
                      onTap: () {
                        _goToPreviousPage();
                        stopTimer();
                        startTimer();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 6,
                    child: InkWell(
                      onTap: () {
                        _goToNextPage();
                        stopTimer();
                        startTimer();
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Stock_barang(token: widget.token),
                  ),
                ),
                child: Text('Lihat Stok Barang'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBarangPage(token: widget.token),
                  ),
                ),
                child: Text('Tambahkan Barang'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black38),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
