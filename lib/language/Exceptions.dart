import 'Component.dart';

typedef VoidFunction = void Function();

class ExceptionWithMessage {
  final String message;

  const ExceptionWithMessage(this.message);
}

// Call logException to log an exception, and doneLogging when finished.
abstract class Logger {
  void logException(Type t, [String msg]);

  void doneLogging();
}

void tryFunction(VoidFunction untrustworthy, Logger logger) {
  // Invoking this method might cause an exception. Catch and handle
  // them using try-on-catch-finally.
  try {
    untrustworthy();
  } on ExceptionWithMessage catch (e) {
    logger.logException(ExceptionWithMessage, e.message);
  } on Exception {
    logger.logException(Exception);
  } finally {
    logger.doneLogging();
  }
}

class MyLogger extends Logger {
  Type lastType;
  String lastMessage = '';
  bool done = false;

  void logException(Type t, [String message]) {
    lastType = t;
    lastMessage = message ?? lastMessage;
  }

  void doneLogging() => done = true;
}

void main() {
  final errs = <String>[];
  var logger = MyLogger();

  try {
    tryFunction(() => throw Exception(), logger);

    if ('${logger.lastType}' != 'Exception' && '${logger.lastType}' != '_Exception') {
      errs.add('Untrustworthy threw an Exception, but a different type was logged: ${logger.lastType}.');
    }

    if (logger.lastMessage != '') {
      errs.add('Untrustworthy threw an Exception with no message, but a message was logged anyway: \'${logger.lastMessage}\'.');
    }

    if (!logger.done) {
      errs.add('Untrustworthy threw an Exception, and doneLogging() wasn\'t called afterward.');
    }
  } catch (e) {
    Component.result(false, ['Untrustworthy threw an exception, and an exception of type ${e.runtimeType} was unhandled by tryFunction.']);
  }

  logger = MyLogger();

  try {
    tryFunction(() => throw ExceptionWithMessage('Hey!'), logger);

    if (logger.lastType != ExceptionWithMessage) {
      errs.add('Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), but a different type was logged: ${logger.lastType}.');
    }

    if (logger.lastMessage != 'Hey!') {
      errs.add('Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), but a different message was logged: \'${logger.lastMessage}\'.');
    }

    if (!logger.done) {
      errs.add('Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), and doneLogging() wasn\'t called afterward.');
    }
  } catch (e) {
    Component.result(false, ['Untrustworthy threw an ExceptionWithMessage(\'Hey!\'), and an exception of type ${e.runtimeType} was unhandled by tryFunction.']);
  }

  logger = MyLogger();
  bool caughtStringException = false;

  try {
    tryFunction(() => throw 'A String', logger);
  } on String {
    caughtStringException = true;
  }

  if (!caughtStringException) {
    errs.add('Untrustworthy threw a string, and it was incorrectly handled inside tryFunction().');
  }

  logger = MyLogger();

  try {
    tryFunction(() {}, logger);

    if (logger.lastType != null) {
      errs.add('Untrustworthy didn\'t throw an Exception, but one was logged anyway: ${logger.lastType}.');
    }

    if (logger.lastMessage != '') {
      errs.add('Untrustworthy didn\'t throw an Exception with no message, but a message was logged anyway: \'${logger.lastMessage}\'.');
    }

    if (!logger.done) {
      errs.add('Untrustworthy didn\'t throw an Exception, but doneLogging() wasn\'t called afterward.');
    }
  } catch (e) {
    Component.result(false, ['Untrustworthy didn\'t throw an exception, but an exception of type ${e.runtimeType} was unhandled by tryFunction anyway.']);
  }

  if (errs.isEmpty) {
    Component.result(true);
  } else {
    Component.result(false, errs);
  }
}

