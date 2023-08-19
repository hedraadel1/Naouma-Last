/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

class HedraTrace {
  final StackTrace _trace;

  String fileName;
  String functionName;
  String callerFunctionName;
  int lineNumber;
  int columnNumber;

  HedraTrace(this._trace) {
    _parseTrace();
  }

  String _getFunctionNameFromFrame(String frame) {
    var currentTrace = frame;

    var indexOfWhiteSpace = currentTrace.indexOf(' ');

    var subStr = currentTrace.substring(indexOfWhiteSpace);

    var indexOfFunction = subStr.indexOf(RegExp(r'[A-Za-z0-9]'));

    subStr = subStr.substring(indexOfFunction);

    indexOfWhiteSpace = subStr.indexOf(' ');

    subStr = subStr.substring(0, indexOfWhiteSpace);

    return subStr;
  }

  void _parseTrace() {
    var frames = this._trace.toString().split("\n");

    this.functionName = _getFunctionNameFromFrame(frames[0]);

    this.callerFunctionName = _getFunctionNameFromFrame(frames[1]);

    var traceString = frames[0];

    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z]+.dart'));

    var fileInfo = traceString.substring(indexOfFileName);

    var listOfInfos = fileInfo.split(":");

    this.fileName = listOfInfos[0];
    this.lineNumber = int.parse(listOfInfos[1]);
    var columnStr = listOfInfos[2];
    columnStr = columnStr.replaceFirst(")", "");
    this.columnNumber = int.parse(columnStr);
  }
}
