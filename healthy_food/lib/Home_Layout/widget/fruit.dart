import 'package:flutter/material.dart';

import '../details_page.dart';
class Fruit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 25.0, right: 20.0),
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Container(
            height: MediaQuery.of(context).size.height - 300.0,
            child: ListView(
              children: [
                _buildFruitItem(context,'assets/images/lemon.png',
                    'Lemon', '\$24.00'),
              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildFruitItem(BuildContext context,String imgPath, String foodName, String foodPrice) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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