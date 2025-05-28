# CS3130 Assignment 1 FakeNews (Reader)

- **Due Date:** Feb 09, 2022 @ **12 NOON**

In this assignment you will create a FakeNews reader app.

![app demo](resources/out.gif)

The app will have two screens one of which contains a listing of fake news headlines such that clicking any fake news headline opens a view giving the details of that fake news story.

You should design the two screens to your liking but ensure they are functional. You should be able to scroll the news stories

You are given some starter code that provides a database that calls out to a fake news generator that uses the faker_dart flutter package, and a NewsItem class to represent the required information for a news article. Notice that the NewsItem class uses the `Equatable` package to handle overriding `==` and `hashCode`. This is our first look at that package, but after lab 5 you will see how much less typing it requires.

*Tip*: Get NewsItems with: `NewsDatabase().getNewsItems();`
*You otherwise don't need to spend too much time looking at the `db` or `fetcher` code.*

*Note: Each of the 3 assignments in the course are built upon each other. Each assignment will add complexity and functionality to this news reader type app.*

## Notes, Tips, Tricks and Discussion:

**DO:** Design your own UI, use a pencil and paper and draw out what you'd like the UI to look like. Then write the code yourself to build it. Consult the official flutter documentation to see the constructors for various widgets.

**DON'T:** Start with googling for similar apps. Remember one of the goals of the course is to become a strong mobile developer. That means becoming familiar with the complex flutter and widget api, common coding strategies for managing state, etc. You don't want to be a cut and paste hero when you have the chance to learn and improve for yourself in a low stakes assignment. Who wants to answer a high stakes interview question by asking if *google is allowed?*.

**THINK ABOUT:** Where is state required in the assignment? How are you going to handle it?

## Grading

| Gradable | Points |
|:---|:---|
| Code Readability | 2 |
| Code organization (folder structure) | 1 |  
| State Management            | 2 |
| App Functionality           | 3 |
| Unit Testing                | 1 |
| Above and Beyond            | 1 |
|Total| /10|



**Code Readability:** proper names for variables, methods, classes, and file_names appropriate commenting (non-excessive), separation of tasks, indentation, etc. Ensure all dart source files follow the naming convention: `file_name.dart`

Graded on scale of 0 (poor on most of the above metrics), 1 (irratic or inconsistent naming, long methods, repeated code blocks, etc) or 2 (most / all conventions followed)

**Code organization: Folder Structure:** 1 point for organizing your source files into appropriate folders.

**State Management:** Have you separated UI and Business logic. It is easily recognizable as using Bloc/Cubit, Provider, or another strategy. 0pts: no / poor state management, 1pt: attempt to use one state management style for everything but missing in some functionality or intermixing of business and ui logic, 2pts: consistent state management strategy that separates business and ui logic.

**App Functionality** Does the app work like a FakeNews Reader as described above. Is the functionality similar to what is displayed in the animated gif? 0 - 3pts as compared to the coarse functionality visible in the demo gif (two screen - one with the list, the other the details, scrolling, picture, clicking, text, etc).

**Implement Unit Testing** Have you provided unit-tests for the model classes in your app. 0pts: no unit-tests, 0.5pts: some unit-tests for NewsItem class but not full coverage of the class, 1pt unit-tests for the NewsItem class (constructor, readVersion, ==, and hashCode (ensure two equal items hash to the same, + any other methods, and if you require other model classes then unit-tests for those classes too)

**Above and Beyond** Have you gone above and beyond the demonstration app / explored additional Flutter language features, software development practices, software architecture, widgets or packages? This is graded on a scale as compared to your peers.
