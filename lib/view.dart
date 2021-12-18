import 'package:flutter/material.dart';

class ViewLess extends StatelessWidget {
  const ViewLess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: const Text('Example title'),
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Products',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                ),
                GridView.count(
                  crossAxisCount: 2,
                  //shrinkWrap: ShrinkWrappingViewport(),

                  // children: List.generate(100, (index) {
                  //   return Center(
                  //       child: Text(
                  //     'Item ',
                  //     style: Theme.of(context).textTheme.headline5,
                  //   ));
                  // })
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*Expanded(
                  child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                // children: List.generate(100, (index) {
                //   return Center(
                //     child: Text(
                //       'Item $index',
                //       style: Theme.of(context).textTheme.headline5,
                //     ),
                //   );
                // }),
              ))

 */
