/// Prints a String in reverse order (CS3130 Lab 1, Task 1)

void main(List<String> args) {
  String firstName = 'Jonathon';
  print(firstName[firstName.length-1]);
  for (var i = firstName.length-1; i >= 0; i--) {
    print(firstName[i]);
  }
}