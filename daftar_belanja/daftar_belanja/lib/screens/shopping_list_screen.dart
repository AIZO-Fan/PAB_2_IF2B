import 'package:flutter/material.dart';
import 'package:daftar_belanja/service/shopping_services.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {

  final TextEditingController _controller = TextEditingController();
  final ShoppingService _shoppingService = ShoppingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Belanja"),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan nama barang',
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _shoppingService.addShoppingItem(_controller.text);
                    _controller.clear();
                  },
                ),

              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<Map<String, String>>(
              stream: _shoppingService.getShoppingList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final items = snapshot.data!;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final key = items.keys.elementAt(index);
                      final name = items[key]!;
                      return ListTile(
                        title: Text(name),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _shoppingService.removeShoppingItem(key);
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading shopping list'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}