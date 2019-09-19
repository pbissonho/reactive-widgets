# Reactive Widgets

[![Build Status](https://travis-ci.com/PedroBissonho/reactive-widgets.svg?branch=master)](https://travis-ci.com/PedroBissonho/reactive-widgets)

A set of widgets to make it more easier to build reactive interfaces.

# How To Use 

## 1º Create a StreamController 


``` dart
class Bloc {
  // Create a Dart StreamController
  StreamController<String> _controller = StreamController<String>();
  Stream<String> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}

```

## 2º Replace StreamBuilder with some ReactiveWidget

``` dart
class Example extends StatelessWidget {
  final Bloc bloc;

  Example(this.bloc);

  @override
  Widget build(BuildContext context) {
    
    // Replace this for some ReactiveWidget
    //StreamBuilder(
    //  builder: (BuildContext context, AsyncSnapshot snapshot) {
    //    if (snapshot.hasError) return Text("Error");
    //    if (snapshot.hasData) return Text(snapshot.data);
    //    return Center(
    //      child: CircularProgressIndicator(),
    //    );
    // },
    //);
   
    return ReactiveBuilder(
      stream: bloc.stream,
      builder: (BuildContext context, data) {
        return Text(data);
      },
    );
  }
}

```
