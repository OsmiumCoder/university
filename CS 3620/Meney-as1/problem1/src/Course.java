import grading.schemes.GradingScheme;
import grading.schemes.SimpleWeightedAverage;

import java.util.ArrayList;
import java.util.Objects;

/**
 * Holds a course which has many students and a particular grading scheme.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public class Course {

    /**
     * The name of the course.
     */
    private final String courseName;


    /**
     * The course number.
     */
    private final String courseNumber;

    /**
     * The list of students in the course.
     */
    private final ArrayList<Student> students;

    /**
     * The grading scheme for the course.
     */
    private GradingScheme gradingScheme;

    /**
     * Construct a new course object. Defaults grading scheme to SimpleWeightedAverage.
     *
     * @param name the name of the course
     * @param number the course number
     */
    public Course(String name, String number) {
        this.courseName = name;
        this.courseNumber = number;
        students = new ArrayList<>();
        gradingScheme = new SimpleWeightedAverage();
    }

    /**
     * Construct a new course object with the given grading scheme.
     *
     * @param name the name of the course
     * @param number the course number
     * @param gradingScheme the grading scheme for the course
     */
    public Course(String name, String number, GradingScheme gradingScheme) {
        this.courseName = name;
        this.courseNumber = number;
        students = new ArrayList<>();
        this.gradingScheme = gradingScheme;
    }

    /**
     * Returns the name of the course.
     *
     * @return the course name
     */
    public String getCourseName() {
        return courseName;
    }

    /**
     * Adds a student to the course.
     *
     * @param student the student to be added to the course
     */
    public void addStudent(Student student) {
        students.add(student);
    }

    /**
     * Determines if a given student is in the course.
     *
     * @param student the student to look for in the course
     * @return true if the student is in the class, false otherwise
     */
    public boolean hasStudent(Student student) {
        return students.contains(student);
    }

    /**
     * Changes the grading scheme of the course to the given scheme.
     *
     * @param gradingScheme the new grading scheme
     */
    public void setGradingScheme(GradingScheme gradingScheme) {
        this.gradingScheme = gradingScheme;
    }

    /**
     * Calculates the final grade based of the course grading scheme.
     *
     * @param assignmentScores the array list of assignment scores for the course
     * @param examScores the array list of exam scores for the course
     * @return the final grade for the course
     */
    public double calculateFinalGrade(ArrayList<Double> assignmentScores, ArrayList<Double> examScores) {
        return gradingScheme.calculateGrade(assignmentScores, examScores);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Course course = (Course) o;
        return Objects.equals(courseName, course.courseName) && Objects.equals(courseNumber, course.courseNumber);
    }

    @Override
    public int hashCode() {
        return Objects.hash(courseName, courseNumber);
    }
}
