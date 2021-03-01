import 'AssertValue.dart';
    
// Implement changeUsername here
Future<String> changeUsername() async{
  try{
    return await fetchNewUsername();
  } catch(e){
    return e.toString();
  }
}

List<String> messages = [];
bool logoutSucceeds = false;
const passed = 'PASSED';
const noCatch = 'NO_CATCH';
const typoMessage = 'Test failed! Check for typos in your return value';
const oneSecond = Duration(seconds: 1);

class UserError implements Exception {
  String errMsg() => 'New username is invalid';
}

Future fetchNewUsername() {
  var str = Future.delayed(oneSecond, () => throw UserError());
  return str;
}

main() async {
  try {
    // ignore: cascade_invocations
    messages
      ..add(makeReadable(
          testLabel: '',
          testResult: await asyncDidCatchException(changeUsername),
          readableErrors: {
            typoMessage: typoMessage,
            noCatch: 'Did you remember to call fetchNewUsername within a try/catch block?',
          }
      ))
      ..add(makeReadable(
          testLabel: '',
          testResult: await asyncErrorEquals(changeUsername),
          readableErrors: {
            typoMessage: typoMessage,
            noCatch: 'Did you remember to call fetchNewUsername within a try/catch block?',
          }
      ))
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
String makeReadable({ String testResult, Map readableErrors, String testLabel }) {
  if (readableErrors.containsKey(testResult)) {
    var readable = readableErrors[testResult];
    return '$testLabel $readable';
  } else {
    return '$testLabel $testResult';
  }
}

void passIfNoMessages(List<String> messages, Map<String, String> readable){
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
Future<String> asyncErrorEquals(Function fn) async {
  var result = await fn();
  if (result == UserError().toString()) {
    return passed;
  } else {
    return 'Test failed! Did you stringify and return the caught error?';
  }
}

Future<String> asyncDidCatchException(Function fn) async {
  var caught = true;
  try {
    await fn();
  } on UserError catch(_) {
    caught = false;
  }

  if (caught == false) {
    return noCatch;
  } else {
    return passed;
  }
}
