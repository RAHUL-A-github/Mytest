import 'package:flutter/material.dart';
import '../details_page.dart';
class Food extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 25.0, right: 20.0),
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: Container(
            height: MediaQuery.of(context).size.height - 300.0,
            child: ListView(
              children: [
                _buildFoodItem(context,'assets/images/plate1.png',
                    'Plate 1', '\$24.00'),
                _buildFoodItem(context,'assets/images/plate2.png',
                    'Plate 2', '\$22.00'),
                _buildFoodItem(context,'assets/images/plate6.png',
                    'Plate 6', '\$26.00'),
                _buildFoodItem(context,'assets/images/plate5.png', 'Plate 5',
                    '\$24.00'),
                _buildFoodItem(context,'assets/images/plate3.png',
                    'Avocado bowl', '\$26.00'),
                _buildFoodItem(context,'assets/images/plate4.png', 'Plate 4',
                    '\$24.00'),
              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildFoodItem(BuildContext context, String imgPath, String foodName, String foodPrice) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsPage(
                  heroTag: imgPath, foodName: foodName, foodPrice: foodPrice)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Hero(
                    tag: imgPath,
                    child: Image(
                        image: AssetImage(imgPath),
                        fit: BoxFit.cover,
                        height: 75.0,
                        width: 75.0),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        foodName,
                        style: TextStyle(
                            fontSize: 2.5 * 7, fontWeight: FontWeight.bold,fontFamily: 'OpenSans'),
                      ),
                      Text(
                        foodPrice,
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.black,
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}