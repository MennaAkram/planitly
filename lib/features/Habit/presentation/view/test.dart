import 'package:flutter/material.dart';

class CustomScreen extends StatefulWidget {
  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  int selectedIndex = 0; // Set default selection to the first container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                      print('Container 1 clicked');
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.blue, width: 2),
                          bottom: selectedIndex == 0
                              ? BorderSide(color: Colors.red, width: 2)
                              : BorderSide(color: Colors.green, width: 2), // Green border when not selected
                          right: BorderSide.none,
                        ),
                      ),
                      height: 100,
                      child: Center(
                        child: Text(
                          'Container 1',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                      print('Container 2 clicked');
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.blue, width: 2),
                          bottom: selectedIndex == 1
                              ? BorderSide(color: Colors.red, width: 2)
                              : BorderSide(color: Colors.green, width: 2), // Green border when not selected
                          right: BorderSide.none,
                        ),
                      ),
                      height: 100,
                      child: Center(
                        child: Text(
                          'Container 2',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: selectedIndex == 0 ? null : 400,
              color: selectedIndex == 0 ? Colors.blue[100] : Colors.green[100],
              child: selectedIndex == 0
                  ? Container(
                    height: 600,
                    child: Center(
                        child: Text(
                          'Content for Container 1',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                  )
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.green[200],
                          child: Center(
                            child: Text(
                              'Item ${index + 1}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
