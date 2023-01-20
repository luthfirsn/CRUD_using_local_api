import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class NetworkingHttpApp extends StatefulWidget {
  const NetworkingHttpApp({super.key});

  @override
  State<NetworkingHttpApp> createState() => _NetworkingHttpAppState();
}

class _NetworkingHttpAppState extends State<NetworkingHttpApp> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final add1 = TextEditingController();
    final add2 = TextEditingController();
    final add3 = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Get Data From Api"),
        ),
        body: Container(child: UsingTheData()),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Center(
                  child: Text("Input Data"),
                ),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: add1,
                        autofocus: true,
                        decoration:
                            InputDecoration(hintText: "Input your name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please input your Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: add2,
                        autofocus: true,
                        decoration:
                            InputDecoration(hintText: "Input your email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please input Your Email';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: add3,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Input your gender",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please input your Gender';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        postData({
                          "firstname": add1.text,
                          "email": add2.text,
                          "gender": add3.text,
                          // "password": ""
                        });
                        add1.clear();
                        add2.clear();
                        add3.clear();
                        Navigator.of(context).pop();
                      }
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PrintResponseBody extends StatelessWidget {
  const PrintResponseBody({super.key});

  Future<http.Response> getData() async {
    final response =
        await http.get(Uri.parse("http://$localAddress/api/getuser"));
    // await http.get(Uri.parse("https://reqres.in/api/users?per_page=15"));
    // await Future.delayed(const Duration(seconds: 2));
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.body);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(child: const CircularProgressIndicator());
        ;
      },
    );
  }
}

class UsingTheData extends StatefulWidget {
  UsingTheData({super.key});

  @override
  State<UsingTheData> createState() => _UsingTheDataState();
}

class _UsingTheDataState extends State<UsingTheData> {
  // get id => null;

  Future<http.Response> getData() async {
    final response =
        await http.get(Uri.parse("http://$localAddress/api/getuser"));
    // await http.get(Uri.parse("https://reqres.in/api/users?per_page=15"));
    // await Future.delayed(const Duration(seconds: 2));
    setState(() {
      response;
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final add1 = TextEditingController();
    final add2 = TextEditingController();
    final add3 = TextEditingController();

    return FutureBuilder(
        future: getData().then((value) => value.body),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> json = jsonDecode(snapshot.data!);
            // List<dynamic> json = jsonDecode(snapshot.data!)["data"];
            return ListView.builder(
              itemCount: json.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: CircleAvatar(
                        child: Text("${json[index]["firstname"][0]}")),
                    title: Text("${json[index]["firstname"]}"),
                    subtitle: Text("${json[index]["email"]}"),
                    onTap: () {
                      print("firstname : ${json[index]["firstname"]}");
                      print("Email : ${json[index]["email"]}");
                      print("Id : ${index + 1}");
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            add1.text = json[index]["firstname"];
                            add2.text = json[index]["email"];
                            add3.text = json[index]["gender"];
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Center(
                                  child: Text("Input Data"),
                                ),
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: add1,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            hintText: "Input your name"),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please input your Name';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: add2,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            hintText: "Input your email"),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please input Your Email';
                                          }
                                          if (!EmailValidator.validate(value)) {
                                            return 'Please enter a valid email';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: add3,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            hintText: "Input your gender"),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please input your Gender';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        updateData(json[index]["userid"], {
                                          "firstname": add1.text,
                                          "email": add2.text,
                                          "gender": add3.text,
                                          // "password": ""
                                        });
                                        add1.clear();
                                        add2.clear();
                                        add3.clear();
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteData(json[index]["userid"]);
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ],
                    )

                    // PopupMenuButton(
                    //   itemBuilder: (context) {
                    //     return <PopupMenuEntry>[
                    //       PopupMenuItem(
                    //         child: Text("edit"),
                    // onTap: () {
                    //   updateData(index + 1, {
                    //     "name": "${json[index]["name"]}",
                    //     "email": "${json[index]["email"]}"
                    //   });
                    // },
                    //       ),
                    //       PopupMenuItem(
                    //         child: Text("delete"),
                    //         onTap: () {
                    //           deleteData(index + 1);
                    //         },
                    //       )
                    //     ];
                    //   },
                    // ),
                    );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(child: const CircularProgressIndicator());
        });
  }
}

// Future<http.Response> getData() async {
//   final response =
//       await http.get(Uri.parse("http://192.168.96.129:8082/api/user/getAll"));
//   // await http.get(Uri.parse("https://reqres.in/api/users?per_page=15"));
//   // await Future.delayed(const Duration(seconds: 2));
//   return response;
// }

String localAddress = "192.168.137.41:8082";

Future<http.Response> postData(Map<String, String> data) async {
  // data object exampl
  // data = {"name": "post method", "email": "postmethod@test.con"};
  final response =
      await http.post(Uri.parse("http://192.168.137.41:8082/api/createuser"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
  print(response.statusCode);
  print(response.body);
  return response;
}

Future<http.Response> updateData(int id, Map<String, String> data) async {
  // data object example
  // data = {"name": "post method", "email": "postmethod@test.con"};
  final response =
      await http.put(Uri.parse("http://$localAddress/api/updateuser/${id}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
  print(response.statusCode);
  print(response.body);
  return response;
}

Future<http.Response> deleteData(id) async {
  // data object example
  // data = {"name": "post method", "email": "postmethod@test.con"};
  final response = await http.delete(
    Uri.parse("http://$localAddress/api/deleteuser/${id}"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(id);
  print(response.statusCode);
  print(response.body);
  return response;
}
