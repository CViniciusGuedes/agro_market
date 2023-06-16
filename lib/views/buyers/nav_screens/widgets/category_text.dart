import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final List<String> _categorylabel = [
    'Fruta',
    'Verdura',
    'Legume',
    'Líquido',
    'Outros'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categorias',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categorylabel.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActionChip(
                            backgroundColor: Color.fromARGB(255, 201, 153, 135),
                            onPressed: () {},
                            label: Center(
                              child: Text(
                                _categorylabel[index],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                /*IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right))*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
