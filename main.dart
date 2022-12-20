import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int miktar = 0;

  List<Map<String, dynamic>> karisik = [];

  TextEditingController nesneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Ekleme Çıkarma Simülasyonu",
              style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontSize: 25.6),
            ),
            centerTitle: true,
            backgroundColor: Colors.yellowAccent,
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 248, 248, 246)),
                    margin: const EdgeInsets.fromLTRB(5, 35, 40, 0),
                    width: 200,
                    height: 50,
                    child: TextField(
                      controller: nesneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                    width: 140,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    //  color: Colors.amber,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (miktar > 0) miktar--;
                                });
                              },
                              child: const Text("-")),
                        ),
                        Expanded(
                            flex: 2,
                            child: Center(child: Text(miktar.toString()))),
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  miktar++;
                                });
                              },
                              child: const Text("+")),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (karisik.every((element) =>
                            element['nesneAdi'].toString().toLowerCase() !=
                            nesneController.text.trim().toLowerCase())) {
                          karisik.add({
                            'nesneAdi': nesneController.text.trim(),
                            'miktar': miktar,
                            'renk': Color(Random().nextInt(0xffffffff))
                          });
                        } else {
                          int sira = 0;
                          for (var i = 0; i < karisik.length; i++) {
                            if (karisik[i]['nesneAdi']
                                    .toString()
                                    .toLowerCase() ==
                                nesneController.text.trim().toLowerCase()) {
                              sira = i;
                            }
                          }
                          karisik[sira].update('miktar', (value) => miktar);
                        }

                        nesneController.clear();
                        miktar = 0;
                      });
                    },
                    child: const Text("EKLE"),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: karisik.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      const Divider(
                        color: Colors.black,
                        height: 0,
                        thickness: 1.5,
                      ),
                      Container(
                        decoration:
                            BoxDecoration(color: karisik[index]['renk']),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Center(
                                    child: CircleAvatar(
                                  radius: 20,
                                  child:
                                      Text(karisik[index]['miktar'].toString()),
                                ))),
                            Expanded(
                                flex: 3,
                                child: Text(karisik[index]['nesneAdi'])),
                            Expanded(
                              flex: 1,
                              child: FloatingActionButton.small(
                                  child: const Text(
                                    "-",
                                    style: TextStyle(fontSize: 32),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      karisik.removeAt(index);
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
