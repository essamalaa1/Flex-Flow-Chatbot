import 'package:flutter/material.dart';

import '../Widgets/item_scroll.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFBE0B),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.chat),
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                ),
              ],
              leading: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              elevation: 0,
              backgroundColor: const Color(0xffFFBE0B),
              centerTitle: true,
              floating: true,
              snap: true,
              // Set the height of the app bar
              expandedHeight: MediaQuery.of(context).size.height,
              flexibleSpace: const ItemScroll(
                itemImage1: 'image1.jpg',
                itemImage2: 'image2.jpg',
                itemText1:
                    'FlexFlow adapts to your fitness level, goals, and preferences to create challenging, yet achievable workout plans.',
                itemText2:
                    'Push yourself to the limit with FlexFlow’s real-time guidance, ensuring proper form and keeping you motivated.',
                itemHeaderText1: 'Customize Your Fitness Journey',
                itemHeaderText2: 'Real-time Guidance and Feedback',
                itemHeaderText3: 'Seamless Integration into Your Lifestyle',
                itemImage3: 'image3.jpg',
                itemText3:
                    'FlexFlow understands that fitness is not just about the time spent at the gym or doing home workouts. It is about creating a sustainable lifestyle that encompasses healthy habits in every aspect of your life. ',
              )),
          SliverList(
            delegate: SliverChildListDelegate(
              [],
            ),
          ),
        ],
      ),
    );
  }
}
