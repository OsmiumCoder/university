import grading.schemes.ExamPortionPassed;

public class Main {
    public static void main(String[] args) {
        Student student = new Student("Jonathon");
        Course course = new Course("Software Design", "3620");

        course.addStudent(student);

        student.addAssignmentScore(course, 100);
        student.addAssignmentScore(course, 92);
        student.addAssignmentScore(course, 87);

        student.addExamScore(course, 32);
        student.addExamScore(course, 53);

        System.out.println(student.finalGradeForCourse(course));

        course.setGradingScheme(new ExamPortionPassed());

        System.out.println(student.finalGradeForCourse(course));
    }
}