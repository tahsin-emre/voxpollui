/*

Container(
              height: 40.0,
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.blue, // Set cursor color to blue
                      decoration: InputDecoration(
                        hintText: 'Ara',
                        hintStyle: TextStyle(
                          height: 1.4, // This helps to vertically align the text in the middle
                        ),
                        border: InputBorder.none, // No border for a clean look
                        isCollapsed: true, // Ensures the content and hint stay in the middle
                      ),
                      style: TextStyle(fontSize: 14.0),
                      textAlignVertical: TextAlignVertical.center, // Align text vertically centered
                    ),
                  ),
                ],
              ),
            ),


            */