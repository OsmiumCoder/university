package grading.schemes;

import java.util.ArrayList;

/**
 * Class to calculate a simple weighted average.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public class SimpleWeightedAverage extends GradingScheme {

    /**
     * Returns the simple weighted average grade. Assignments carry 40% weight and exams carry 60% weight.
     *
     * @param assignmentScores the array of assignment scores
     * @param examScores the array of exam scores
     * @return the weighted average of assignments and exams
     */
    @Override
    public double calculateGrade(ArrayList<Double> assignmentScores, ArrayList<Double> examScores) {
        double assignmentWeightedAverage = calculateWeightedAverageForScores(assignmentScores, 0.4);
        double examWeightedAverage = calculateWeightedAverageForScores(examScores, 0.6);

        return assignmentWeightedAverage + examWeightedAverage;

    }
}
