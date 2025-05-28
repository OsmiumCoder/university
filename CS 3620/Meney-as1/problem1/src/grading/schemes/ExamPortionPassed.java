package grading.schemes;

import java.util.ArrayList;

/**
 * Class to calculate weighted average, where exam weight must be over 50% (of weight).
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public class ExamPortionPassed extends GradingScheme {

    /**
     * Returns the weighted average grade. Assignments carry 40% weight and exams carry 60% weight.
     * If the weighted average of exams is less than 30% (50% of 60% weight),
     * the grade will be the minimum of 45 or the calculated weighted average grade.
     *
     * @param assignmentScores the array of assignment scores
     * @param examScores the array of exam scores
     * @return the weighted average of assignments and exams
     */
    @Override
    public double calculateGrade(ArrayList<Double> assignmentScores, ArrayList<Double> examScores) {
        double assignmentWeightedAverage = calculateWeightedAverageForScores(assignmentScores, 0.4);
        double examWeightedAverage = calculateWeightedAverageForScores(examScores, 0.6);

        double finalGrade = assignmentWeightedAverage + examWeightedAverage;

        // exams carry 60%, if the exam weighted average is less than 30% (50% of weight)
        // then choose the minimum of 45 or the calculated weighted average grade
        if (examWeightedAverage < 30) {
            finalGrade = Math.min(45, finalGrade);
        }

        return finalGrade;
    }
}
