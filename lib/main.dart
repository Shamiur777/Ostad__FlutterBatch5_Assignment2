import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCart(),
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int pulloverCount = 0;
  int tshirtCount = 0;
  int sportDressCount = 0;
  double pulloverPrice = 51.0;
  double tshirtPrice = 30.0;
  double sportDressPrice = 43.0;

  @override
  Widget build(BuildContext context) {
    double totalAmount = (pulloverCount * pulloverPrice) +
        (tshirtCount * tshirtPrice) +
        (sportDressCount * sportDressPrice);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Bag',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Search Bar Pressed"),
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductCard(
              name: 'Pullover',
              price: pulloverPrice,
              count: pulloverCount,
              onIncrement: () => handleIncrement('Pullover'),
              onDecrement: () => handleDecrement('Pullover'),
              imageUrl:
              'https://img.sonofatailor.com/images/customizer/product/knitting/zwp/Navy_O_Neck.jpg',
              color: 'Black',
              size: 'L',
            ),
            ProductCard(
              name: 'T-Shirt',
              price: tshirtPrice,
              count: tshirtCount,
              onIncrement: () => handleIncrement('T-Shirt'),
              onDecrement: () => handleDecrement('T-Shirt'),
              imageUrl:
              'https://i5.walmartimages.com/asr/a0629e62-5b1f-44d9-b0d0-942ee75a510c.396e4e7b056232f0a89f6d82c7d043e3.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF',
              color: 'Gray',
              size: 'L',
            ),
            ProductCard(
              name: 'Sport Dress',
              price: sportDressPrice,
              count: sportDressCount,
              onIncrement: () => handleIncrement('Sport Dress'),
              onDecrement: () => handleDecrement('Sport Dress'),
              imageUrl:
              'https://5.imimg.com/data5/IJ/PD/PI/SELLER-24353599/sports-jersey1-500x500.jpg',
              color: 'Black',
              size: 'M',
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => showCheckoutDialog(),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('CHECK OUT'),
            ),
            SizedBox(height: 16.0),
            Spacer(), // Added spacer to push total amount to the bottom
            Text(
              'Total Amount: \$$totalAmount',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleIncrement(String itemName) {
    setState(() {
      switch (itemName) {
        case 'Pullover':
          pulloverCount++;
          break;
        case 'T-Shirt':
          tshirtCount++;
          break;
        case 'Sport Dress':
          sportDressCount++;
          break;
      }

      if (getItemCount(itemName) == 5) {
        showItemAddedDialog(itemName);
      }
    });
  }

  void handleDecrement(String itemName) {
    setState(() {
      switch (itemName) {
        case 'Pullover':
          if (pulloverCount > 0) pulloverCount--;
          break;
        case 'T-Shirt':
          if (tshirtCount > 0) tshirtCount--;
          break;
        case 'Sport Dress':
          if (sportDressCount > 0) sportDressCount--;
          break;
      }
    });
  }

  int getItemCount(String itemName) {
    switch (itemName) {
      case 'Pullover':
        return pulloverCount;
      case 'T-Shirt':
        return tshirtCount;
      case 'Sport Dress':
        return sportDressCount;
      default:
        return 0;
    }
  }

  void showItemAddedDialog(String itemName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Item Added'),
          content: Text('You have added 5 $itemName to your bag!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  void showCheckoutDialog() {
    int totalItems = pulloverCount + tshirtCount + sportDressCount;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have added $totalItems items to your bag!\n'
              'Details:\n'
              'Pullovers: $pulloverCount\n'
              'T-Shirts: $tshirtCount\n'
              'Sport Dresses: $sportDressCount'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Text('Okay'),
            ),
          ],
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final int count;
  final Function onIncrement;
  final Function onDecrement;
  final String imageUrl;
  final String color;
  final String size;

  const ProductCard({super.key,
    required this.name,
    required this.price,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    required this.imageUrl,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(name),
                  subtitle: Text('Color: $color Size: $size',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  title: Text('\$$price'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => onDecrement(),
                      ),
                      Text(count.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => onIncrement(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
