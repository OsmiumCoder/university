package grading.schemes;

import java.util.ArrayList;

/**
 * Abstract GradingScheme to be implemented by other grading schemes.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public abstract class GradingScheme {

    /**
     * Calculates the weighted average for of a set of scores and a given weight.
     *
     * @param scores the array of scores to find the weighted average of
     * @param weight the weight of the average
     * @return the weighted average of the set of scores
     */
    public double calculateWeightedAverageForScores(ArrayList<Double> scores, double weight) {
        return scores.stream().mapToDouble(x -> x).average().orElse(0) * weight;
    }

    /**
     * Calculates grade given assignment and exam scores.
     *
     * @param assignmentScores the assignment scores
     * @param examScores the exam scores
     * @return the calculated grade
     */
    public abstract double calculateGrade(ArrayList<Double> assignmentScores, ArrayList<Double> examScores);
}
