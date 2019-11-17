import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/data/model/developer.dart';
import 'package:flutter_achiver/core/presentation/res/assets.dart';
import 'package:flutter_achiver/core/presentation/res/colors.dart';
import 'package:flutter_achiver/core/presentation/res/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Achiver'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Achiver is a pomodoro timer and time tracker, I developed for keeping track of my freelancing projects. It is useful for anyone who wishes to track time spent on each of their project and get a detailed analytics of their time.",style: Theme.of(context).textTheme.subhead, textAlign: TextAlign.justify,),
            const SizedBox(height: 20.0),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.all(16.0),
              onPressed: () async {
                if (await canLaunch(githubRepo)) launch(githubRepo);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        githubIcon,
                        width: 30,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        "Github",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text("Find codes of this app."),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.all(16.0),
              onPressed: () async {
                if (await canLaunch(youtubeChannel)) launch(youtubeChannel);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        youtubeIcon,
                        width: 40,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        "Youtube",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                      "Subscribe our youtube channel for flutter tutorials and resources."),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            _buildHeader(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      color: Theme.of(context).cardColor,
      onPressed: () => _open(dev.github),
      child: Row(
        children: <Widget>[
          Container(
              width: 80.0,
              height: 80.0,
              child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                      radius: 35.0,
                      backgroundImage: NetworkImage(dev.imageUrl)))),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                dev.name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(dev.profession),
              SizedBox(height: 5.0),
              Text(
                dev.address,
              ),
            ],
          )
        ],
      ),
    );
  }

  _open(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    }
  }
}
