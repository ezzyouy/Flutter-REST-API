import 'package:api_flutter/models/post.dart';
import 'package:api_flutter/services/remote_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: Visibility(
          visible: isLoaded,
          child: ListView.builder(
              itemCount: posts?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.green[300]
                        ),
                      ),
                      SizedBox(width: 16,),
                     Expanded(
                         child: Column(
                           children: [
                             Text(
                               posts![index].title,
                               maxLines: 2,
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(
                                   fontSize: 24,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                             Text(
                               posts![index].body ?? '',
                               maxLines: 3,
                               overflow: TextOverflow.ellipsis,
                             ),
                           ],
                         ),
                     )
                    ],
                  ),
                );
              }),
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
