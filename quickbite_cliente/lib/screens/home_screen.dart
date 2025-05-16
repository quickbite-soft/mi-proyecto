import 'package:flutter/material.dart';
import 'restaurante_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _addressController =
      TextEditingController(text: 'Main Ave 123, City');
  final TextEditingController _searchController = TextEditingController();
  
  // Lista completa de restaurantes
  final List<Map<String, dynamic>> _restaurants = [
    {
      'name': 'Pizza Planet',
      'rating': '4.5 ★',
      'image': 'pizza.jpg',
      'category': 'Pizza',
      'promotions': [
        {
          'title': 'Family Pizza + Soda',
          'image': 'pizza_familiar.jpg',
          'price': '\$24.900',
          'restaurant': 'Pizza Planet'
        },
        {
          'title': 'Margherita Pizza',
          'image': 'margarita.jpg',
          'price': '\$18.900',
          'restaurant': 'Pizza Planet'
        },
      ]
    },
    {
      'name': 'Sushi World',
      'rating': '4.8 ★',
      'image': 'sushi.jpg',
      'category': 'Sushi',
      'promotions': [
        {
          'title': 'Sushi Lovers Combo',
          'image': 'sushi_lovers.jpg',
          'price': '\$29.900',
          'restaurant': 'Sushi World'
        },
        {
          'title': 'Salmon Sashimi',
          'image': 'salmon.jpg',
          'price': '\$19.900',
          'restaurant': 'Sushi World'
        },
      ]
    },
    {
      'name': 'The King',
      'rating': '4.3 ★',
      'image': 'burger.jpg',
      'category': 'Burgers',
      'promotions': [
        {
          'title': 'Combo King',
          'image': 'burger_combo.jpg',
          'price': '\$15.900',
          'restaurant': 'The King'
        },
      ]
    },
    {
      'name': 'Taco Party',
      'rating': '4.2 ★',
      'image': 'tacos.jpg',
      'category': 'Tacos',
      'promotions': [
        {
          'title': 'Tacomadre',
          'image': 'tacomadre.jpg',
          'price': '\$26.900',
          'restaurant': 'Taco Party'
        },
      ]
    },
  ];

  List<Map<String, dynamic>> _filteredRestaurants = [];
  List<Map<String, dynamic>> _filteredPromotions = [];
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = _restaurants;
    _filteredPromotions = _getAllPromotions();
    _searchController.addListener(_filterContent);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getAllPromotions() {
    return _restaurants.expand<Map<String, dynamic>>(
  (restaurant) => List<Map<String, dynamic>>.from(restaurant['promotions'])
).toList();
  }

  void _filterContent() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      // Filtrar restaurantes
      _filteredRestaurants = _restaurants.where((restaurant) {
        final matchesSearch = restaurant['name']!.toLowerCase().contains(query) ||
            restaurant['category']!.toLowerCase().contains(query);
        final matchesCategory = _selectedCategory == 'All' ||
            restaurant['category'] == _selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();

      // Filtrar promociones
      _filteredPromotions = _getAllPromotions().where((promo) {
        final matchesSearch = promo['title']!.toLowerCase().contains(query) ||
            promo['restaurant']!.toLowerCase().contains(query);
        final matchesCategory = _selectedCategory == 'All' ||
            _restaurants.firstWhere((r) => r['name'] == promo['restaurant'])['category'] == _selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6F00),
        title: const Text('QuickBite - Delivery App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Acción del carrito
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dirección y búsqueda (se mantiene igual)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Address:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your address...',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for restaurants or dishes...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Categorías (se mantiene igual)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategory('All'),
                        _buildCategory('Pizza'),
                        _buildCategory('Sushi'),
                        _buildCategory('Burgers'),
                        _buildCategory('Tacos'),
                        _buildCategory('Barbecue'),
                        _buildCategory('Vegan'),
                        _buildCategory('Gourmet'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Promociones filtradas
            if (_filteredPromotions.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Promotions',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _filteredPromotions.map((promo) => 
                          _buildPromotionCard(
                            promo['title']!,
                            promo['image']!,
                            promo['price']!,
                            promo['restaurant']!,
                          )).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            if (_filteredPromotions.isNotEmpty) const SizedBox(height: 16),

            // Restaurantes filtrados
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _searchController.text.isEmpty
                        ? 'Featured Restaurants'
                        : 'Search Results (${_filteredRestaurants.length})',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ..._filteredRestaurants.map((restaurant) => _buildRestaurantCard(
                        restaurant['name']!,
                        restaurant['rating']!,
                        restaurant['image']!,
                      )),
                  if (_filteredRestaurants.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'No restaurants found',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: 'Support'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.filter_list), label: 'Filters'),
        ],
        selectedItemColor: const Color(0xFFFF6F00),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Navegación por índice
        },
      ),
    );
  }

  Widget _buildCategory(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () => _selectCategory(name),
        child: Chip(
          label: Text(name),
          backgroundColor: _selectedCategory == name
              ? const Color(0xFFFF6F00)
              : Colors.orange.shade100,
          labelStyle: TextStyle(
            color: _selectedCategory == name ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildPromotionCard(String title, String imagePath, String price, String restaurant) {
    return GestureDetector(
      onTap: () {
        // Navegar al restaurante de esta promoción
        final restaurantData = _restaurants.firstWhere((r) => r['name'] == restaurant);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestauranteScreen(
              nombre: restaurant,
              imagen: restaurantData['image'],
              calificacion: restaurantData['rating'],
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage('assets/$imagePath'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                restaurant,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantCard(String name, String rating, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestauranteScreen(
              nombre: name,
              imagen: imagePath,
              calificacion: rating,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage('assets/$imagePath'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                rating,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}