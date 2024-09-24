import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterpython/function.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String postUrl = "";
  String url = "";
  String putUrl = "";
  String deleteUrl = "";
  var data;
  String output1 = 'Initial Output 1';
  String output2 = 'Initial Output 2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Class App,"),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
                child: TextField(
                  onChanged: (value) {
                    url = "http://10.0.2.2:5000/api?query=" + value.toString();
                  },
                  decoration: InputDecoration(labelText: "Enter query for GET"),
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    data = await fetchdata(url);
                    var decoded = jsonDecode(data);
                    setState(() {
                      output1 = decoded['output1'];
                      output2 = decoded['output2'];
                    });
                  } catch (e) {
                    setState(() {
                      output1 = 'Error fetching data';
                      output2 = e.toString();
                    });
                  }
                },
                child: const Text("Get the Text (GET)"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
                child: TextField(
                  onChanged: (value) {
                    postUrl = value; // Save the input directly for POST
                  },
                  decoration:
                      const InputDecoration(labelText: "Enter query for POST"),
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    data =
                        await postdata("http://10.0.2.2:5000/api/post", postUrl);
                    var decoded = jsonDecode(data);
                    setState(() {
                      output1 = decoded['output1'];
                      output2 = decoded['output2'];
                    });
                  } catch (e) {
                    setState(() {
                      output1 = 'Error fetching data';
                      output2 = e.toString();
                    });
                  }
                },
                child: const Text("Send POST Request"),
              ),
              Text("Output 1: $output1"),
              Text("Output 2: $output2"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
                child: TextField(
                  onChanged: (value) {
                    putUrl = value; // Save the input for PUT
                  },
                  decoration:
                      const InputDecoration(labelText: "Enter query for PUT"),
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    data = await putdata("http://10.0.2.2:5000/api/put", putUrl);
                    var decoded = jsonDecode(data);
                    setState(() {
                      output1 = decoded['output1'];
                      output2 = decoded['output2'];
                    });
                  } catch (e) {
                    setState(() {
                      output1 = 'Error fetching data';
                      output2 = e.toString();
                    });
                  }
                },
                child: const Text("Send PUT Request"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
                child: TextField(
                  onChanged: (value) {
                    deleteUrl = value; // Save the input for DELETE
                  },
                  decoration:
                      const InputDecoration(labelText: "Enter query for DELETE"),
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    data = await deletedata(
                        "http://10.0.2.2:5000/api/delete", deleteUrl);
                    var decoded = jsonDecode(data);
                    setState(() {
                      output1 = decoded['output1'];
                      output2 = decoded['output2'];
                    });
                  } catch (e) {
                    setState(() {
                      output1 = 'Error fetching data';
                      output2 = e.toString();
                    });
                  }
                },
                child: const Text("Send DELETE Request"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
