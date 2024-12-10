import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterpython/function.dart';


// Main Function to run the app
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Screen that shows on the device is Home()
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

  // defining url for GET, POST, PUT, and DELETE function
  String postUrl = "";
  String url = "";
  String putUrl = "";
  String deleteUrl = "";

  // Defining variable to store the data
  var data;

  // Outputs that will store the data
  // Initially the output1 and output2 will be 
  // "Initial Output 1" and "Initial Output 2"
  String output1 = 'Initial Output 1';
  String output2 = 'Initial Output 2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Simple Appbar with the text title
      appBar: AppBar(
        title: const Text("Simple Class App,"),
        centerTitle: true,
      ),
      body: Center(
        // Body will be the List with SingleChildScrollView widget used to 
        // prevent the overflow error when the keyboard appears
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
                child: TextField(
                  // when the query is added in the text field, value is changed to string
                  // and concatenated wwith "http://10.0.2.2:5000/api?query=" to form the url
                  onChanged: (value) {
                    url = "http://10.0.2.2:5000/api?query=$value";
                  },
                  decoration: const InputDecoration(labelText: "Enter query for GET"),
                ),
              ),

              // This TextButton is used for performing GET operation
              TextButton(
                onPressed: () async {
                  // Try-Except block for error handling
                  try {
                    // data will be stored to data variable
                    // if statuscode == 200, then it will store the response
                    // else it will store the error 
                    data = await fetchdata(url);
                    // decode the json file and store in decoded
                    var decoded = jsonDecode(data);
                    // Set output1 and output2 to outputs generated in decoded
                    setState(() {
                      output1 = decoded['output1'];
                      output2 = decoded['output2'];
                    });
                  } catch (e) {
                    // If an error is generated,
                    // output1 is "Error fetching data" and output2 is the error in string format
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
                // TextField to store the query that has to be added through POST
                child: TextField(
                  onChanged: (value) {
                    postUrl = value; // Save the input directly for POST
                  },
                  decoration:
                      const InputDecoration(labelText: "Enter query for POST"),
                ),
              ),
              
              // This TextButton is used for performing POST operation
              TextButton(
                onPressed: () async {
                  // Try-Except block for error handling
                  try {
                    // data runs the postdata function and stores the data response
                    // if any error, it will store the error 
                    data =
                        await postdata("http://10.0.2.2:5000/api/post", postUrl);
                    // decode data json and store in decoded
                    var decoded = jsonDecode(data);
                    // Store the outputs in output1 and output2
                    setState(() {
                      output1 = decoded['output1'];
                      output2 = decoded['output2'];
                    });
                  } catch (e) {
                    // Store the error if any
                    setState(() {
                      // output1 is "Error fetching data" and output2 is the error
                      output1 = 'Error fetching data';
                      output2 = e.toString();
                    });
                  }
                },
                child: const Text("Send POST Request"),
              ),
              // Returns the Output1 and output2 as text widget
              Text("Output 1: $output1"),
              Text("Output 2: $output2"),
              
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
                // Text field to store the query on which PUT operation will be performed
                child: TextField(
                  onChanged: (value) {
                    putUrl = value; // Save the input for PUT
                  },
                  decoration:
                      const InputDecoration(labelText: "Enter query for PUT"),
                ),
              ),

              // TextButton which when clicked will perform PUT operation
              TextButton(
                onPressed: () async {
                  // Try-except for error handling
                  try {
                    // putdata function runs and stores the return value to data
                    // data stores the error if any
                    data = await putdata("http://10.0.2.2:5000/api/put", putUrl);
                    // Decode the json data and store in decoded
                    var decoded = jsonDecode(data);
                    setState(() {
                      // output1 and output2 will be outputs from outputs in decoded
                      output1 = decoded['output1'];
                      output2 = decoded['output2'];
                    });
                  } catch (e) {
                    setState(() {
                      // If any error, output1 is "Error fetching data" and output2 is string
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
                // Stores the query for DELETE operation
                child: TextField(
                  onChanged: (value) {
                    deleteUrl = value; // Save the input for DELETE
                  },
                  decoration:
                      const InputDecoration(labelText: "Enter query for DELETE"),
                ),
              ),

              //TextButton performs the DELETE operation
              TextButton(
                onPressed: () async {
                  // Try-Except block for Error Handling
                  try {
                    //deletedata function runs and the return value is stored in data
                    data = await deletedata(
                        "http://10.0.2.2:5000/api/delete", deleteUrl);
                    // Decode the json data and store in decoded
                    var decoded = jsonDecode(data);
                    setState(() {
                      // Store the output in output1 and output2
                      output1 = decoded['output1'];
                      output2 = decoded['output2'];
                    });
                  } catch (e) {
                    setState(() {
                      // If any error, output1 is "Error fetching data" and output2 is error
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
