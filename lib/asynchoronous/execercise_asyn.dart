import 'AssertValue.dart';

// Part 1
addHello(String userName) {
  return 'Hello $userName';
}

// Part 2
// You can call the provided async function fetchUsername()
// to return the username.
Future<String> greetUser() async {
  var userName = await fetchUsername();
  return addHello(userName);
}

// Part 3
// You can call the provided async function logoutUser()
// to log out the user.
sayGoodbye() async {
  try {
    String result = await logoutUser();
    if (result != null) {
      return '$result Thanks, see you next time';
    }
  } catch (e) {
    return 'Logout failure';
  }
}

List<String> messages = [];
bool logoutSucceeds = false;
const passed = 'PASSED';
const noCatch = 'NO_CATCH';
const typoMessage = 'Test failed! Check for typos in your return value';
const didNotImplement =
    'Test failed! Did you forget to implement or return from ';
const oneSecond = Duration(seconds: 1);

Future<String> fetchUsername() => Future.delayed(oneSecond, () => 'Jean');

String failOnce() {
  if (logoutSucceeds) {
    return 'Success!';
  } else {
    logoutSucceeds = true;
    throw Exception('Logout failed');
  }
}

logoutUser() => Future.delayed(oneSecond, failOnce);

main() async {
  try {
    // ignore: cascade_invocations
    messages
      ..add(makeReadable(
          testLabel: 'Part 1',
          testResult: await asyncEquals(
              expected: 'Hello Jerry',
              actual: addHello('Jerry'),
              typoKeyword: 'Jerry'),
          readableErrors: {
            typoMessage: typoMessage,
            'null': '$didNotImplement addHello?',
            'Hello Instance of \'Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
            'Hello Instance of \'_Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
          }))
      ..add(makeReadable(
          testLabel: 'Part 2',
          testResult: await asyncEquals(
              expected: 'Hello Jean',
              actual: await greetUser(),
              typoKeyword: 'Jean'),
          readableErrors: {
            typoMessage: typoMessage,
            'null': '$didNotImplement greetUser?',
            'HelloJean':
                'Looks like you forgot the space between \'Hello\' and \'Jean\'',
            'Hello Instance of \'Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
            'Hello Instance of \'_Future<String>\'':
                'Looks like you forgot to use the \'await\' keyword!',
            '{Closure: (String) => dynamic from Function \'addHello\': static.(await fetchUsername())}':
                'Did you place the \'\$\' character correctly?',
            '{Closure \'addHello\'(await fetchUsername())}':
                'Did you place the \'\$\' character correctly?',
          }))
      ..add(makeReadable(
          testLabel: 'Part 3',
          testResult: await asyncDidCatchException(sayGoodbye),
          readableErrors: {
            typoMessage:
                '$typoMessage. Did you add the text \'Thanks, see you next time\'?',
            'null': '$didNotImplement sayGoodbye?',
            noCatch:
                'Did you remember to call logoutUser within a try/catch block?',
            'Instance of \'Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
            'Instance of \'_Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
          }))
      ..add(makeReadable(
          testLabel: 'Part 3',
          testResult: await asyncEquals(
              expected: 'Success! Thanks, see you next time',
              actual: await sayGoodbye(),
              typoKeyword: 'Success'),
          readableErrors: {
            typoMessage:
                '$typoMessage. Did you add the text \'Thanks, see you next time\'?',
            'null': '$didNotImplement sayGoodbye?',
            noCatch:
                'Did you remember to call logoutUser within a try/catch block?',
            'Instance of \'Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
            'Instance of \'_Future<String>\' Thanks, see you next time':
                'Did you remember to use the \'await\' keyword in the sayGoodbye function?',
            'Instance of \'_Exception\'':
                'CAUGHT Did you remember to return a string?',
          }))
      ..removeWhere((m) => m.contains(passed))
      ..toList();

    if (messages.isEmpty) {
      result(true);
    } else {
      result(false, messages);
    }
  } catch (e) {
    result(false, ['Tried to run solution, but received an exception: $e']);
  }
}

////////////////////////////////////////
///////////// Test Helpers /////////////
////////////////////////////////////////
String makeReadable({String testResult, Map readableErrors, String testLabel}) {
  String readable;
  if (readableErrors.containsKey(testResult)) {
    readable = readableErrors[testResult];
    return '$testLabel $readable';
  } else if ((testResult != passed) && (testResult.length < 18)) {
    readable = typoMessage;
    return '$testLabel $readable';
  } else {
    return '$testLabel $testResult';
  }
}

void passIfNoMessages(List<String> messages, Map<String, String> readable) {
  if (messages.isEmpty) {
    result(true);
  } else {
    // ignore: omit_local_variable_types
    List<String> userMessages = messages
        .where((message) => readable.containsKey(message))
        .map((message) => readable[message])
        .toList();
    print(messages);

    result(false, userMessages);
  }
}

///////////////////////////////////////
//////////// Assertions ///////////////
///////////////////////////////////////
Future<String> asyncEquals({expected, actual, String typoKeyword}) async {
  var strActual = actual is String ? actual : actual.toString();
  try {
    if (expected == actual) {
      return passed;
    } else if (strActual.contains(typoKeyword)) {
      return typoMessage;
    } else {
      return strActual;
    }
  } catch (e) {
    return e;
  }
}

Future<String> asyncDidCatchException(Function fn) async {
  var caught = true;
  try {
    await fn();
  } on Exception catch (_) {
    caught = false;
  }

  if (caught == true) {
    return passed;
  } else {
    return noCatch;
  }
}
