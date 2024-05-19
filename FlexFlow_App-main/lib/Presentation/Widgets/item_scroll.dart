import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ItemScroll extends StatefulWidget {
  final String itemImage1;
  final String itemImage2;
  final String itemText1;
  final String itemText2;
  final String itemHeaderText1;
  final String itemHeaderText2;
  final String itemImage3;
  final String itemText3;
  final String itemHeaderText3;

  const ItemScroll({
    required this.itemImage1,
    required this.itemImage2,
    required this.itemText1,
    required this.itemText2,
    required this.itemHeaderText1,
    required this.itemHeaderText2,
    required this.itemImage3,
    required this.itemText3,
    required this.itemHeaderText3,
  });

  @override
  State<StatefulWidget> createState() => _ItemScrollState();
}

class _ItemScrollState extends State<ItemScroll> {
  final CarouselController _carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List imageList = [
      {'id': 0, 'image_path': widget.itemImage1},
      {'id': 1, 'image_path': widget.itemImage2},
      {'id': 2, 'image_path': widget.itemImage3},
    ];
    final List textList = [
      {
        'id': 0,
        'header_text': widget.itemHeaderText1,
        'item_text': widget.itemText1
      },
      {
        'id': 1,
        'header_text': widget.itemHeaderText2,
        'item_text': widget.itemText2
      },
      {
        'id': 2,
        'header_text': widget.itemHeaderText3,
        'item_text': widget.itemText3
      },
    ];

    // Function for auto-play
    // ignore: unused_element
    void autoPlay() {
      final int lastIndex = imageList.length;

      // Check if it's the last item, if so, stop auto-play
      if (currentIndex == lastIndex) {
        return;
      }

      // Increment the currentIndex for the next iteration
      currentIndex++;

      // Call nextPage on the carousel controller to move to the next item
      _carouselController.nextPage(
        duration: const Duration(
            seconds: 2), // Adjust the transition duration as needed
        curve: Curves.easeInOut,
      );

      Future.delayed(const Duration(seconds: 4),
          autoPlay); // Adjust the delay time as needed
    }

    return FlexibleSpaceBar(
      expandedTitleScale: 1,
      stretchModes: const [
        // Define the stretch modes to control the FlexibleSpaceBar behavior
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
        StretchMode.fadeTitle,
      ],
      background: Container(
        color: const Color(0xffFFBE0B),
        child: CarouselSlider(
          items: [
            for (var i = 0; i < imageList.length; i++)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/${imageList[i]['image_path']}',
                    width: MediaQuery.of(context).size.width * 0.88,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      textList[i]['header_text'],
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black, // Black text color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      textList[i]['item_text'],
                    ),
                  ),
                ],
              ),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 78,
                  ),
                  const Text(
                    'Welcome to FlexFlow',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Congratulations on taking the first step towards transforming your fitness journey with FlexFlow! Our innovative fitness chatbot app is here to empower you, inspire you, and guide you towards your health and wellness goals like never before.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 15,
                      shadowColor: const Color.fromARGB(255, 227, 128, 120),
                      backgroundColor: Colors.black,
                      minimumSize: const Size(70.0, 44.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Let’s Start',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xffFFBE0B),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/wave.jpg',
                    fit: BoxFit.fill,
                    height: 240,
                  )
                ],
              ),
            )
          ],
          options: CarouselOptions(
            aspectRatio: .04,
            scrollPhysics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            autoPlay: true,
            reverse: false,
            //   pauseAutoPlayInFiniteScroll: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          carouselController: _carouselController,
        ),
      ),
    );
  }
}
