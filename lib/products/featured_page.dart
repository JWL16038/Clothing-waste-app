import 'package:flutter/material.dart';

int numberColumns = 2;

class FeaturedPage extends StatelessWidget {
  const FeaturedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numberColumns,
      ),
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: clickItem,
          child: Container(
            margin: const EdgeInsets.all(7.5),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Image(
                    image: NetworkImage(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                    width: 50,
                    height: 50,
                  ),
                  Text('test'),
                  //Icon(Icons.settings),
                ]),
          ),
        );
      },
    ));
  }
}

void clickItem() {
  print("test");
}
