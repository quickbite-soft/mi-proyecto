import 'package:flutter/material.dart';

class RestauranteScreen extends StatelessWidget {
  final String nombre;
  final String imagen;
  final String calificacion;

  const RestauranteScreen({
    super.key,
    required this.nombre,
    required this.imagen,
    required this.calificacion,
  });

  @override
  Widget build(BuildContext context) {
    final menu = _getMenuItems(nombre);
    final promociones = _getPromotions(nombre);

    return Scaffold(
      appBar: AppBar(
        title: Text(nombre),
        backgroundColor: const Color(0xFFFF6F00),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Acción del carrito
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del restaurante con overlay de información
          Stack(
            children: [
              Image.asset(
                'assets/$imagen',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nombre,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6F00),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              calificacion,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Promociones (si existen)
          if (promociones.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Current Promotions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 140, // Aumenté ligeramente para dar espacio al padding
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: promociones.map((promo) => _buildPromotionCard(promo)).toList(),
                ),
                ),
                const Divider(height: 30, thickness: 1),
                ],

          // Menú
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Lista de platillos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: menu.length,
              itemBuilder: (context, index) {
                final item = menu[index];
                return _buildMenuItem(
                  context,
                  item['title']!,
                  item['description']!,
                  item['price']!,
                  item['image']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getMenuItems(String restaurante) {
    if (restaurante == 'Sushi World') {
      return [
        {
          'title': 'Sushi Lovers Combo',
          'price': '\$29,900',
          'image': 'sushi_lovers.jpg',
          'description': '12 pieces + free miso soup'
        },
        {
          'title': 'Salmon Sashimi',
          'price': '\$19,900',
          'image': 'salmon.jpg',
          'description': '8 slices of fresh salmon with wasabi',
        },
        {
          'title': 'Special Uramaki',
          'description': 'Roll filled with crab, avocado, and cream cheese',
          'price': '\$24,900',
          'image': 'uramaki.webp',
        },
      ];
    } else if (restaurante == 'Pizza Planet') {
      return [
        {
          'title': 'Family Pizza + Soda',
          'price': '\$24,900',
          'image': 'pizza_familiar.jpg',
          'description': 'Save \$5,000'
        },
        {
          'title': 'Margherita Pizza',
          'price': '\$18.900',
          'image': 'margarita.jpg',
          'description': 'Pizza with Cheese + Basil'
        },
        {
          'title': 'Pepperoni Pizza',
          'description': 'Delicious pepperoni pizza',
          'price': '\$24,900',
          'image': 'pepperoni.jpg',
        },
        {
          'title': 'Ham pizza',
          'description': 'Delicious Ham and cheese pizza',
          'price': '\$26,500',
          'image': 'jamon.jpg',
        },
      ];
    } else if (restaurante == 'The King') {
      return [
        {
          'title': 'Combo King',
          'price': '\$15,900',
          'image': 'burger_combo.jpg',
          'description': 'Burger + fries + drink'
        },
        {
          'title': 'King Burger',
          'description': 'Signature burger with double meat and special sauce',
          'price': '\$18,900',
          'image': 'king_burger.jpg',
        },
        {
          'title': 'Cheese Burger',
          'description': 'Classic burger with cheddar cheese',
          'price': '\$15,900',
          'image': 'cheese_burger.jpg',
        },
      ];
    } else if (restaurante == 'Taco Party') {
      return [
        {
          'title': 'Tacomadre',
          'price': '\$26.900',
          'image': 'tacomadre.jpg',
          'description': 'Tortilla + meat + the homemade touch'
        },
        {
          'title': 'Taco Party Pack',
          'description': '5 tacos with your choice of meat',
          'price': '\$26,900',
          'image': 'taco_party.jpg',
        },
        {
          'title': 'Burrito Supreme',
          'description': 'Large burrito with all the toppings',
          'price': '\$19,900',
          'image': 'burrito.jpg',
        },
      ];
    }
    return [];
  }

  List<Map<String, String>> _getPromotions(String restaurante) {
    if (restaurante == 'Sushi World') {
      return [
        {
          'title': 'Sushi Lovers Combo',
          'price': '\$29,900',
          'image': 'sushi_lovers.jpg',
          'description': '12 pieces + free miso soup'
        },
        {
          'title': 'Salmon Sashimi',
          'price': '\$19,900',
          'image': 'salmon.jpg',
          'description': '8 slices of fresh salmon with wasabi',
        },
      ];
    } else if (restaurante == 'Pizza Planet') {
      return [
        {
          'title': 'Family Pizza + Soda',
          'price': '\$24,900',
          'image': 'pizza_familiar.jpg',
          'description': 'Save \$5,000'
        },
        {
          'title': 'Margherita Pizza',
          'price': '\$18.900',
          'image': 'margarita.jpg',
          'description': 'Pizza with Cheese + Basil'
        },
      ];
    } else if (restaurante == 'The King') {
      return [
        {
          'title': 'Combo King',
          'price': '\$15,900',
          'image': 'burger_combo.jpg',
          'description': 'Burger + fries + drink'
        },
      ];
    }else if (restaurante == 'Taco Party') {
      return [
        {
          'title': 'Tacomadre',
          'price': '\$26.900',
          'image': 'tacomadre.jpg',
          'description': 'Tortilla + meat + the homemade touch'
        },
      ];
    }
    return [];
  }

Widget _buildPromotionCard(Map<String, String> promo) {
  return Container(
    width: 220,
    height: 120, // Altura fija para evitar overflow
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.orange[50],
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(12),
          ),
          child: Image.asset(
            'assets/${promo['image']}',
            width: 80,
            height: 120, // Misma altura que el contenedor
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  promo['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1, // Evitar overflow de texto
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  promo['description']!,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                  maxLines: 2, // Limitar líneas de descripción
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  promo['price']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6F00),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    String description,
    String price,
    String imagePath,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/$imagePath',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6F00),
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$title added to cart'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart, size: 18),
                        label: const Text('Add'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6F00),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
    );
  }
}