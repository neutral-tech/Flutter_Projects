import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/helper/news.dart';

class Home extends StatefulWidget {
  const Home({super.key});



  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<NewsModel> storeNews=<NewsModel>[];
  bool _loading=true;
  News abc=News();

  @override
  void initState(){
    super.initState();
    gets();
  }
  gets() async{

    await abc.getNews();
    setState(() {
      storeNews=abc.news;
      _loading=false;
    });
  }
  void search(String value) {
    setState(()  {
      storeNews=  abc.news.where((element) => element.title!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                "NEWS",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 1,),
            Text(
                "Dose",
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontFamily: "Protest",
              ),
            ),
          ],
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _loading? Center(
        child: Container(
          child: const CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      ):
      Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(12,8,12,0),
            child: TextField(
              onChanged: (value) => search(value),
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white60,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.red,
                  )
                ),
                hintText: "eg: Business",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.blue,
                )
              ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: storeNews.isEmpty? const Center(
              child: Text(
                "NO results found!!",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ):
            ListView.builder(
                itemCount: storeNews.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context,index){
                  return NewsTile(
                    imageUrl: storeNews[index].urlToImage,
                    title: storeNews[index].title,
                    desc: storeNews[index].description,
                  );
                }
            ),
          ),
        ],
      )
    );
  }
}
class NewsTile extends StatelessWidget {
   final String? imageUrl,title,desc;
  const NewsTile({super.key, required this.imageUrl,required this.title,required this.desc});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12,2,12,6),
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.fromLTRB(6,0,6,0),
        child: Column(
            children: <Widget>[
              SizedBox(height: 7,),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl!),
              ),
              const SizedBox(height: 8,),
              Text(title!,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8,),
              Text(desc!,
              style: const TextStyle(
                color: Colors.black54,
              ),
              ),
              SizedBox(height: 8,)
            ],
          ),
      ),
    );
  }
}

