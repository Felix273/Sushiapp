import 'package:felix/components/button.dart';
import 'package:felix/models/food.dart';
import 'package:felix/models/shop.dart';
import 'package:felix/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;
  const FoodDetailsPage({
    super.key,
    required this.food,
  });

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  //quantity
  int quantityCount = 0;

  //decrement quantity
  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  //increment quantity
  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  //add to cart
  void addToCart() {
    //only add to cart if there is something in the cart
    if (quantityCount > 0) {
      //get access to the shop
      final shop = context.read<Shop>();

      //add to cart
      shop.addToCart(widget.food, quantityCount);

      //let the user know it was succesful
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: const Text(
            "Succesfully Added to Cart",
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            //okay button
            IconButton(
                onPressed: () {
                  //pop once to remove dialog box
                  Navigator.pop(context);

                  //pop again to go to previous screen
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.done))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          //List view of food details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  //image
                  Image.asset(
                    widget.food.imagePath,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //rating
                  Row(
                    children: [
                      //star icon
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      //rating number
                      Text(
                        widget.food.rating,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //food name
                  Text(
                    widget.food.name,
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  //description
                  Text(
                    "Descripton",
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "A Japanese dish that typically consists of vinegared rice combined with various ingredients such as seafood, vegetables, and occasionally tropical fruits. It is often presented in bite-sized portions and is known for its artistic and meticulous preparation. Sushi comes in various forms, including Nigiri (a small bed of rice topped with ingredients like fish or seafood), Sashimi (thin slices of raw fish), Maki (rolled sushi with rice and ingredients wrapped in seaweed), and Temaki (hand-rolled cones). The combination of fresh, high-quality ingredients, precise knife skills, and the delicate balance of flavors makes sushi a popular and revered cuisine worldwide. It not only showcases the culinary excellence of Japan but has also gained international acclaim for its unique and diverse offerings.",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //price + quantity + add to cart button
          Container(
            color: primaryColor,
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                //price + quality
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //price
                    Text(
                      "\$" + widget.food.price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    //quantity
                    Row(
                      children: [
                        //minus button
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.remove),
                            color: Colors.white,
                            onPressed: decrementQuantity,
                          ),
                        ),

                        //quantity count
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              quantityCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                        //plus button

                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            color: Colors.white,
                            onPressed: incrementQuantity,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),

                //add to cart button
                MyButton(
                  text: "Add To Cart",
                  onTap: addToCart,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
