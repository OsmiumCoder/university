import java.util.ArrayList;
import java.util.HashMap;
import java.util.NoSuchElementException;
import java.util.Objects;

/**
 * Class to hold a student and its assignment and exam scores for its courses.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public class Student {
    /**
     * The name of the student.
     */
    private final String name;

    /**
     * The map of assignment scores to the course the assignment is for.
     */
    private final HashMap<Course, ArrayList<Double>> assignmentScores;

    /**
     * The map of exam scores to the course the exam is for.
     */
    private final HashMap<Course, ArrayList<Double>> examScores;

    /**
     * Construct a new Student object.
     *
     * @param name the name of the student
     */
    public Student(String name) {
        this.name = name;
        assignmentScores = new HashMap<>();
        examScores = new HashMap<>();
    }

    /**
     * Adds an assignment score to a given course. Only adds score if student is in course.
     *
     * @param course the course the score is for
     * @param aScore the assignment score to add
     */
    public void addAssignmentScore(Course course, double aScore) {
        addScoreTo(course, aScore, assignmentScores);
    }

    /**
     * Adds an exam score to a given course. Only adds score if student is in course.
     *
     * @param course the course the score is for
     * @param eScore the exam score to add
     */
    public void addExamScore(Course course, double eScore) {
        addScoreTo(course, eScore, examScores);
    }

    /**
     * Adds a score to course based on the given array to add to.
     *
     * @param course the course the score is for
     * @param score the score to add
     * @param scores the HashMap of scores by course to add the score to
     */
    private void addScoreTo(Course course, double score, HashMap<Course, ArrayList<Double>> scores) {
        // make sure student is in course before adding score
        if (!course.hasStudent(this)) return;

        // if score given is first score for course (and score type given)
        // make a new entry in that score map for that course
        if (!scores.containsKey(course)) {
            ArrayList<Double> scoreList = new ArrayList<>();
            scoreList.add(score);
            scores.put(course, scoreList);
        }

        // otherwise just add the score to the course
        else {
            scores.get(course).add(score);
        }
    }

    /**
     * Returns the final grade for the given course if the student is in it.
     *
     * @param course the course to get the final grade for
     * @return the final grade for the given course
     */
    public double finalGradeForCourse(Course course) {
        // the student only has a grade if they are in the course
        if (course.hasStudent(this)){
            return course.calculateFinalGrade(assignmentScores.get(course), examScores.get(course));
        }

        return 0;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Student student = (Student) o;
        return Objects.equals(name, student.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }
}
