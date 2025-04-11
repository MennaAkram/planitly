import 'package:flutter/material.dart';

class GraphView {
  final int id;
  final DateTime date;
  final List<Node> nodes;

  GraphView({
    required this.id,
    required this.date,
    required this.nodes,
  });

  int addNode(Node node) {
    nodes.add(node);
    return nodes.length - 1;
  }

  Node getNode(String name) {
    return nodes.firstWhere(
        (element) => element.name == name && element.relations.length < 4);
  }

  void pupNode() {
    nodes.removeLast();
  }

  GraphView clone() {
    return GraphView(
      id: id,
      date: date,
      nodes: nodes.map((node) => node.clone()).toList(),
    );
  }
}

class Node {
  final int id;
  String name;
  GlobalKey key;
  Size size;
  Offset position;
  Map<Directions, Relation?> relations;
  final _diractionPriorityOrder = const [
    Directions.right,
    Directions.down,
    Directions.left,
    Directions.up,
  ];

  Node(
      {required this.id,
      required this.name,
      this.size = const Size(0, 0),
      this.position = const Offset(0, 0),
      GlobalKey? key,
      Map<Directions, Relation?>? relations})
      : key = key ?? GlobalKey(),
        relations = relations ?? {};

  Directions? addRelation(
      Relation relation, List<Node> sibling, Size screenSize,
      {Directions? direction}) {
    if (direction != null) {
      relations[direction] = relation;
      return _oppositeDirection(direction);
    }

    double nodeSpace = 100;
    for (Directions diraction in _diractionPriorityOrder) {
      if (relations[diraction] == null &&
          !_isOutOfBoundes(diraction, screenSize, nodeSpace) &&
          !_isOverlap(diraction, nodeSpace, sibling)) {
        relations[diraction] = relation;
        return _oppositeDirection(diraction);
      }
    }

    return null;
  }

  static Directions _oppositeDirection(Directions direction) {
    switch (direction) {
      case Directions.right:
        return Directions.left;
      case Directions.down:
        return Directions.up;
      case Directions.left:
        return Directions.right;
      case Directions.up:
        return Directions.down;
    }
  }

  bool _isOverlap(Directions direction, double nodeSpace, List<Node> sibling) {
    switch (direction) {
      case Directions.right:
        return sibling.any((node) =>
            node.position.dx > position.dx &&
            node.position.dy == position.dy &&
            node.position.dx < position.dx + size.width + nodeSpace);
      case Directions.down:
        return sibling.any((node) =>
            node.position.dy > position.dy &&
            (node.position.dx - position.dx).abs() < nodeSpace / 2 &&
            node.position.dy <= position.dy + size.height + nodeSpace);

      case Directions.left:
        return sibling.any((node) =>
            node.position.dx < position.dx &&
            node.position.dy == position.dy &&
            node.position.dx > position.dx - nodeSpace - size.width);
      case Directions.up:
        return sibling.any((node) =>
            node.position.dy < position.dy &&
            (node.position.dx - position.dx).abs() < nodeSpace / 2 &&
            node.position.dy <= position.dy - nodeSpace);
    }
  }

  bool _isOutOfBoundes(
      Directions direction, Size screenSize, double nodeSpace) {
    switch (direction) {
      case Directions.right:
        return position.dx + size.width + nodeSpace > screenSize.width + 850;
      case Directions.down:
        return position.dy + size.height + nodeSpace > screenSize.height + 850;
      case Directions.left:
        return position.dx - nodeSpace < -1000;
      case Directions.up:
        return position.dy - nodeSpace < -1000;
    }
  }

  bool isLeaf() {
    return relations.values.every((relation) => relation?.nextNodeIndex == -1);
  }

  Node clone() {
    return Node(
      id: id,
      name: name,
      key: GlobalKey(),
      position: position,
      relations: Map.from(relations),
    );
  }
}

class Relation {
  final int nextNodeIndex;
  Offset position;
  String relation;

  Relation(
      {required this.relation,
      required this.nextNodeIndex,
      this.position = const Offset(0, 0)});
}

enum Directions {
  left,
  right,
  up,
  down,
}

class GraphViewOP {
  final List<GraphView> _graphViews = [];
  Size screenSize = const Size(0, 0);
  int _graphId = 0;
  int _nodeId = 0;

  int _generateGraphId() => _graphId++;

  int _generateNodeId() => _nodeId++;

  bool isEmpty({DateTime? date}) {
    if (date == null) {
      return _graphViews.isEmpty;
    }
    return !_graphViews.any((graph) =>
        graph.date.day == date.day &&
        graph.date.month == date.month &&
        graph.date.year == date.year);
  }

  List<GraphView> getGraphViews({DateTime? date}) {
    if (date == null) {
      return _graphViews;
    }
    return _graphViews
        .where((graph) =>
            graph.date.day == date.day &&
            graph.date.month == date.month &&
            graph.date.year == date.year)
        .toList();
  }

  void addRelation(DateTime date, String firstNodeName, String secondNodeName,
      String relationName) {
    GraphView graphView = _getGraphViewByNodeName(date, firstNodeName);
    Node firstNode = Node(id: _generateNodeId(), name: firstNodeName);
    Node secondNode = Node(id: _generateNodeId(), name: secondNodeName);

    if (graphView.id == -1 || firstNode.relations.length == 4) {
      _processNewGraph(
          date, firstNode, secondNode, relationName, graphView.nodes);
    } else {
      int secondNodeIndex = graphView.addNode(secondNode);
      Relation relation =
          Relation(relation: relationName, nextNodeIndex: secondNodeIndex);

      Directions? direction = graphView
          .getNode(firstNodeName)
          .addRelation(relation, graphView.nodes, screenSize);
      if (direction == null) {
        graphView.pupNode();
        _processNewGraph(
            date, firstNode, secondNode, relationName, graphView.nodes);
      } else {
        graphView.nodes.last.addRelation(
            Relation(relation: relationName, nextNodeIndex: -1),
            graphView.nodes,
            screenSize,
            direction: direction);
      }
    }
  }

  void _processNewGraph(DateTime date, Node firstNode, Node secondNode,
      String relationName, List<Node> nodes) {
    Directions direction = firstNode.addRelation(
        Relation(relation: relationName, nextNodeIndex: 1), nodes, screenSize)!;
    secondNode.addRelation(
        Relation(relation: relationName, nextNodeIndex: -1), nodes, screenSize,
        direction: direction);
    _addGraphView(date, nodes: [firstNode, secondNode]);
  }

  GraphView _getGraphViewByNodeName(DateTime date, String nodeName) {
    return getGraphViews(date: date).firstWhere(
        (element) => element.nodes
            .any((node) => node.name == nodeName && node.relations.length < 4),
        orElse: () => GraphView(id: -1, date: DateTime.now(), nodes: []));
  }

  void _addGraphView(DateTime date, {List<Node> nodes = const []}) {
    _graphViews
        .add(GraphView(id: _generateGraphId(), date: date, nodes: nodes));
  }
}
