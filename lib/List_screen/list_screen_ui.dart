import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:create_manage_list_firebase/detail_screen/detail_screen.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  ///fetching data from firestore

  CollectionReference taskColl =
  FirebaseFirestore.instance.collection('taskcollection');

  void updateTask(List data) {
    print("hitting");
    taskColl.doc("taskdata").set(
        {
          "array": FieldValue.arrayUnion(data)
        }
    );



  }



  _openPopUpMenu(String title, String desc, String image,int id, int tid, Offset offset, List data) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: const [
        PopupMenuItem(
          value: "progress",
          child: Text("In Progress"),
        ),
        PopupMenuItem(
          value: "pending",
          child: Text("Pending"),
        ),
        PopupMenuItem(
          value: "resolve",
          child: Text("Resolved"),
        ),
        PopupMenuItem(
          value: "close",
          child: Text("Closed"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != "null") {
        data[id]["task_status"]=value.toString();
        updateTask(
          data
        );
      };
    });
  }

  _progressPopUpMenu(String title, String desc, String image,int id, int tid, Offset offset, List data) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: const [
        PopupMenuItem(
          value: "open",
          child: Text("Open"),
        ),
        PopupMenuItem(
          value: "pending",
          child: Text("Pending"),
        ),
        PopupMenuItem(
          value: "resolve",
          child: Text("Resolved"),
        ),
        PopupMenuItem(
          value: "close",
          child: Text("Closed"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

      if (value != "null") {
        data[id]["task_status"]=value.toString();
        updateTask(
            data
        );
      };
    });
  }

  _pendingPopUpMenu(String title, String desc, String image,int id, int tid, Offset offset, List data) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: const [
        PopupMenuItem(
          value: "open",
          child: Text("Open"),
        ),
        PopupMenuItem(
          value: "progress",
          child: Text("In progress"),
        ),
        PopupMenuItem(
          value: "resolve",
          child: Text("Resolved"),
        ),
        PopupMenuItem(
          value: "close",
          child: Text("Closed"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

      if (value != "null") {
        data[id]["task_status"]=value.toString();
        updateTask(
            data
        );
      };
    });
  }

  _resolvePopUpMenu(String title, String desc, String image,int id, int tid, Offset offset, List data) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: const [
        PopupMenuItem(
          value: "open",
          child: Text("Open"),
        ),
        PopupMenuItem(
          value: "progress",
          child: Text("In progress"),
        ),
        PopupMenuItem(
          value: "pending",
          child: Text("Pending"),
        ),
        PopupMenuItem(
          value: "close",
          child: Text("Closed"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

      if (value != "null") {
        data[id]["task_status"]=value.toString();
        updateTask(
            data
        );
      };
    });
  }

  _closePopUpMenu(String title, String desc, String image,int id, int tid, Offset offset, List data) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: const [
        PopupMenuItem(
          value: "open",
          child: Text("Open"),
        ),
        PopupMenuItem(
          value: "progress",
          child: Text("In progress"),
        ),
        PopupMenuItem(
          value: "pending",
          child: Text("Pending"),
        ),
        PopupMenuItem(
          value: "resolve",
          child: Text("Resolved"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

      if (value != "null") {
        data[id]["task_status"]=value.toString();
        updateTask(
            data
        );
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Task"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailScreen()),
                    );
                  },
                  child: const Text("Create Task")),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(height: 20.0),
            DefaultTabController(
              length: 5, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const TabBar(
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(text: 'open'),
                        Tab(text: 'in progress'),
                        Tab(text: 'pending'),
                        Tab(text: 'resolved'),
                        Tab(text: 'close'),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context)
                          .size
                          .height, //height of TabBarView
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.5))),
                      child: TabBarView(
                        children: <Widget>[
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('taskcollection')
                                .doc('taskdata')
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error = ${snapshot.error}');
                              }
                              if (snapshot.hasData) {
                                var mydoc = [];
                                var indexes = [];
                                var docs = snapshot.data!.data()!['array'];
                                print(docs.toString());
                                for (var i = 0; i < docs.length; i++) {
                                  if (docs[i]['task_status'] == "open") {
                                    indexes.add(i);
                                    mydoc.add(snapshot.data!.data()!['array'][i]);
                                  }
                                }
                                print(mydoc.toString());
                                return mydoc.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: mydoc.length,
                                        itemBuilder: (_, i) {
                                          return ExpansionTile(
                                            title: Text(mydoc[i]['title']),
                                            trailing: SizedBox(
                                              height: 100,
                                              width: 50,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTapDown: (TapDownDetails details) {
                                                      _openPopUpMenu(
                                                          mydoc[i]['title'].toString(),
                                                          docs[
                                                          i][
                                                          'Description'],
                                                          mydoc[i]['image']
                                                              .toString()
                                                              .replaceAll(
                                                              '"', ''),
                                                          indexes[
                                                          i],
                                                          mydoc[
                                                          i][
                                                          'task_id'],
                                                          details.globalPosition,
                                                      docs);
                                                    },
                                                    child: const Icon(
                                                      Icons.more_vert,
                                                      color: Colors.black,
                                                    ),
                                                  )),
                                            ),
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black)),
                                                      height: 200,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Image.network(
                                                          docs[i]['image']
                                                              .toString()
                                                              .replaceAll(
                                                                  '"', ''),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black)),
                                                      height: 200,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                  "Description"),
                                                              Expanded(
                                                                  child: Text(docs[
                                                                          i][
                                                                      'Description'])),
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: Text("No Task Found"),
                                      );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('taskcollection')
                                .doc('taskdata')
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error = ${snapshot.error}');
                              }
                              if (snapshot.hasData) {
                                var mydoc = [];
                                var indexes = [];
                                var docs = snapshot.data!.data()!['array'];
                                print(docs.toString());
                                for (var i = 0; i < docs.length; i++) {
                                  if (docs[i]['task_status'] == "progress") {
                                    indexes.add(i);
                                    mydoc.add(snapshot.data!.data()!['array'][i]);
                                  }
                                }
                                print(mydoc.toString());
                                return mydoc.isNotEmpty
                                    ? ListView.builder(
                                  itemCount: mydoc.length,
                                  itemBuilder: (_, i) {
                                    return ExpansionTile(
                                      title: Text(mydoc[i]['title']),
                                      trailing: SizedBox(
                                        height: 100,
                                        width: 50,
                                        child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTapDown: (TapDownDetails details) {
                                                _progressPopUpMenu(
                                                    mydoc[i]['title'].toString(),
                                                    docs[
                                                    i][
                                                    'Description'],
                                                    mydoc[i]['image']
                                                        .toString()
                                                        .replaceAll(
                                                        '"', ''),
                                                    indexes[
                                                    i],
                                                    mydoc[
                                                    i][
                                                    'task_id'],
                                                    details.globalPosition,
                                                    docs);
                                              },
                                              child: const Icon(
                                                Icons.more_vert,
                                                color: Colors.black,
                                              ),
                                            )),
                                      ),
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                margin:
                                                const EdgeInsets.all(
                                                    5.0),
                                                padding:
                                                const EdgeInsets.all(
                                                    3.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black)),
                                                height: 200,
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(8.0),
                                                  child: Image.network(
                                                    docs[i]['image']
                                                        .toString()
                                                        .replaceAll(
                                                        '"', ''),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin:
                                                const EdgeInsets.all(
                                                    5.0),
                                                padding:
                                                const EdgeInsets.all(
                                                    3.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black)),
                                                height: 200,
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        const Text(
                                                            "Description"),
                                                        Expanded(
                                                            child: Text(docs[
                                                            i][
                                                            'Description'])),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                )
                                    : const Center(
                                  child: Text("No Task Found"),
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('taskcollection')
                                .doc('taskdata')
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error = ${snapshot.error}');
                              }
                              if (snapshot.hasData) {
                                var mydoc = [];
                                var indexes = [];
                                var docs = snapshot.data!.data()!['array'];
                                print(docs.toString());
                                for (var i = 0; i < docs.length; i++) {
                                  if (docs[i]['task_status'] == "pending") {
                                    indexes.add(i);
                                    mydoc.add(snapshot.data!.data()!['array'][i]);
                                  }
                                }
                                print(mydoc.toString());
                                return mydoc.isNotEmpty
                                    ? ListView.builder(
                                  itemCount: mydoc.length,
                                  itemBuilder: (_, i) {
                                    return ExpansionTile(
                                      title: Text(mydoc[i]['title']),
                                      trailing: SizedBox(
                                        height: 100,
                                        width: 50,
                                        child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTapDown: (TapDownDetails details) {
                                                _pendingPopUpMenu(
                                                    mydoc[i]['title'].toString(),
                                                    docs[
                                                    i][
                                                    'Description'],
                                                    mydoc[i]['image']
                                                        .toString()
                                                        .replaceAll(
                                                        '"', ''),
                                                    indexes[
                                                    i],
                                                    mydoc[
                                                    i][
                                                    'task_id'],
                                                    details.globalPosition,
                                                    docs);
                                              },
                                              child: const Icon(
                                                Icons.more_vert,
                                                color: Colors.black,
                                              ),
                                            )),
                                      ),
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                margin:
                                                const EdgeInsets.all(
                                                    5.0),
                                                padding:
                                                const EdgeInsets.all(
                                                    3.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black)),
                                                height: 200,
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(8.0),
                                                  child: Image.network(
                                                    docs[i]['image']
                                                        .toString()
                                                        .replaceAll(
                                                        '"', ''),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin:
                                                const EdgeInsets.all(
                                                    5.0),
                                                padding:
                                                const EdgeInsets.all(
                                                    3.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black)),
                                                height: 200,
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        const Text(
                                                            "Description"),
                                                        Expanded(
                                                            child: Text(docs[
                                                            i][
                                                            'Description'])),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                )
                                    : const Center(
                                  child: Text("No Task Found"),
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('taskcollection')
                                .doc('taskdata')
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error = ${snapshot.error}');
                              }
                              if (snapshot.hasData) {
                                var mydoc = [];
                                var indexes = [];
                                var docs = snapshot.data!.data()!['array'];
                                print(docs.toString());
                                for (var i = 0; i < docs.length; i++) {
                                  if (docs[i]['task_status'] == "resolve") {
                                    indexes.add(i);
                                    mydoc.add(snapshot.data!.data()!['array'][i]);
                                  }
                                }
                                print(mydoc.toString());
                                return mydoc.isNotEmpty
                                    ? ListView.builder(
                                  itemCount: mydoc.length,
                                  itemBuilder: (_, i) {
                                    return ExpansionTile(
                                      title: Text(mydoc[i]['title']),
                                      trailing: SizedBox(
                                        height: 100,
                                        width: 50,
                                        child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTapDown: (TapDownDetails details) {
                                                _resolvePopUpMenu(
                                                    mydoc[i]['title'].toString(),
                                                    docs[
                                                    i][
                                                    'Description'],
                                                    mydoc[i]['image']
                                                        .toString()
                                                        .replaceAll(
                                                        '"', ''),
                                                    indexes[
                                                    i],
                                                    mydoc[
                                                    i][
                                                    'task_id'],
                                                    details.globalPosition,
                                                    docs);
                                              },
                                              child: const Icon(
                                                Icons.more_vert,
                                                color: Colors.black,
                                              ),
                                            )),
                                      ),
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                margin:
                                                const EdgeInsets.all(
                                                    5.0),
                                                padding:
                                                const EdgeInsets.all(
                                                    3.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black)),
                                                height: 200,
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(8.0),
                                                  child: Image.network(
                                                    docs[i]['image']
                                                        .toString()
                                                        .replaceAll(
                                                        '"', ''),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin:
                                                const EdgeInsets.all(
                                                    5.0),
                                                padding:
                                                const EdgeInsets.all(
                                                    3.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black)),
                                                height: 200,
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        const Text(
                                                            "Description"),
                                                        Expanded(
                                                            child: Text(docs[
                                                            i][
                                                            'Description'])),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                )
                                    : const Center(
                                  child: Text("No Task Found"),
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('taskcollection')
                                .doc('taskdata')
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error = ${snapshot.error}');
                              }
                              if (snapshot.hasData) {
                                var mydoc = [];
                                var indexes = [];
                                var docs = snapshot.data!.data()!['array'];
                                for (var i = 0; i < docs.length; i++) {
                                  if (docs[i]['task_status'] == "close") {
                                    indexes.add(i);
                                    mydoc.add(snapshot.data!.data()!['array'][i]);
                                  }
                                }
                                return mydoc.isNotEmpty
                                    ? ListView.builder(
                                  itemCount: mydoc.length,
                                  itemBuilder: (_, i) {
                                    return ExpansionTile(
                                      title: Text(mydoc[i]['title']),
                                      trailing: SizedBox(
                                        height: 100,
                                        width: 50,
                                        child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTapDown: (TapDownDetails details) {
                                                _closePopUpMenu(
                                                    mydoc[i]['title'].toString(),
                                                    docs[
                                                    i][
                                                    'Description'],
                                                    mydoc[i]['image']
                                                        .toString()
                                                        .replaceAll(
                                                        '"', ''),
                                                    indexes[
                                                    i],
                                                    mydoc[
                                                    i][
                                                    'task_id'],
                                                    details.globalPosition,
                                                    docs);
                                              },
                                              child: const Icon(
                                                Icons.more_vert,
                                                color: Colors.black,
                                              ),
                                            )),
                                      ),
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                margin:
                                                const EdgeInsets.all(
                                                    5.0),
                                                padding:
                                                const EdgeInsets.all(
                                                    3.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black)),
                                                height: 200,
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(8.0),
                                                  child: Image.network(
                                                    docs[i]['image']
                                                        .toString()
                                                        .replaceAll(
                                                        '"', ''),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                margin:
                                                const EdgeInsets.all(
                                                    5.0),
                                                padding:
                                                const EdgeInsets.all(
                                                    3.0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .black)),
                                                height: 200,
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        const Text(
                                                            "Description"),
                                                        Expanded(
                                                            child: Text(docs[
                                                            i][
                                                            'Description'])),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                )
                                    : const Center(
                                  child: Text("No Task Found"),
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
            )
          ]),
        ));
  }
}
