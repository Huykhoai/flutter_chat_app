import 'package:flutter/material.dart';
import 'package:flutter_chat_app/baseScreen/baseScreen.dart';
import 'package:flutter_chat_app/item/item_list_user_online.dart';
import 'package:flutter_chat_app/model/user_response.dart';
import 'package:flutter_chat_app/screen/searchScreen.dart';
import 'package:flutter_chat_app/services/api_service.dart';
class Home extends Basescreen{
  const Home(this.user, {Key? key}) : super(key: key);
  final User user;
  @override
  _HomeState createState() => _HomeState();

}
class _HomeState extends BaseScreenState<Home>{
  List<User> users = [];

  Future<void> fetchData() async {
    final response = await ApiService.getAllUser();
    if (response['status'] == 200) {
      setState(() {
        users = parseUsers(response);
      });
    } else {
      setState(() {
        users = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 10,
          backgroundColor: Colors.white,
          leading: const SizedBox(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: CircleAvatar(backgroundImage: NetworkImage(replaceLocalhost(widget.user.avatar)),)
              ),
              const SizedBox(width: 20),
              const Text("Danh Sách Tin Nhắn"),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // Thanh tìm kiếm
            Container(
              height: 35,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.4
                ),
                borderRadius: BorderRadius.circular(25)
              ),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const SearchPage();
                  }));
                },
                borderRadius: BorderRadius.circular(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(Icons.search,
                          color: Colors.grey,),
                        ),
                        Text("Find Products", style: TextStyle(
                            color: Colors.grey
                        ),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      height: 32,
                      width: 75,
                      child: const Center(
                        child: Text(
                          "Search",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ItemListUserOnline(user);
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(
                      user.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(replaceLocalhost(user.avatar)),
                      radius: 30,
                    ),
                    subtitle: Text(
                      user.numberPhone,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
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
