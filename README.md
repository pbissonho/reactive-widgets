# Reactive Widgets

A set of widgets to make it more easier to build reactive interfaces.

# How To Use 

## 1º Create a StreamController 

    ``` dart
    // Dart StreamController
    _controller = StreamController<String>();

    // RxDart BehaviourController
    _behaviourController = BehaviourController<String>();
    ```

## 2º Replace StreamBuilder with some ReactiveWidget

    ``` dart
    ReactiveBuilder<String>(
        stream: _controller.stream,
        builder: (BuildContext context, int data) => Text(data.toString()),
    ),

    ReactiveText<String>(
        stream: _controller.stream,
    ),
    ```
