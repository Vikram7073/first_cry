import 'dart:convert';

import 'package:first_cry/constant/apputill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart'as http;

import '../../model/list_model.dart';
import 'login_screen.dart';
class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Data>? postList = [];
  final List<String> imageList = [
    ('fc-logo-s.jpg'),
    ('fc-logo-s.jpg'),
    ('fc-logo-s.jpg'),
  ];
  int currentIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPostApi1().then((value) {
      setState(() {
        postList=value;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.orange,
        ),
        drawer: open(context),

        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children:   [
                SizedBox(
                  height: 100.h,
                  child: PageView.builder(
                      onPageChanged: (index){
                        setState(() {
                          currentIndex=index;
                        });
                      },
                      itemCount: imageList.length,
                      itemBuilder: (context, index){
                        return SizedBox(
                          height: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(height: 20.h,),
                              Image.asset('assets/${imageList[index]}'),
                            ],
                          ),
                        );
                      }
                  ),
                ),
                SizedBox(height: 20.h,),
               GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2/2.2),
                 itemCount: postList?.length,

                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 itemBuilder: (BuildContext context, int index) {
                 return Container(
                   padding: EdgeInsets.symmetric(horizontal: 15.w),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Image.network(postList?[index].avatar??""),
                         Row(
                           children: [
                             Text(postList?[index].firstName??""),
                             Text(postList?[index].lastName??""),
                           ],
                         ),
                         Text(postList?[index].email??""),


                       ],
                     ));

               },),

              ],

            ),
          ),
        ),
      ),
    );
  }
 Widget open(context){
   return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 20.h,),
          Image.asset("assets/fc-logo-s.jpg"),
          SizedBox(height: 30.h,),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text('Logout'),
            onTap: () {
              AppUtils().logout().then((value) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
              });

            },
          ),
        ],
      ),
    );
  }

    Future<List<Data>?>getPostApi1() async {
      postList?.clear();
      final response=await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
      var data =jsonDecode(response.body.toString());
      print(data);
      if(response.statusCode==200){
        for(var i in data['data']){
          postList?.add(Data.fromJson(i));
        }
        // print(postList?.length);
        return postList;
      }
      else{
        return postList;
      }
    }
  }


