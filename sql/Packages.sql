Create or Replace PACKAGE utility_package as 
Procedure add_review;
Function CalculateAverageReviewScore (p_product_id NUMBER) return number;

end utility_package;
/
Create Or REPLACE PACKAGE BODY utility_package as

FUNCTION CalculateAverageReviewScore(
    p_product_id NUMBER
)
RETURN NUMBER AS
    v_total_reviews NUMBER;
    v_total_score NUMBER;
    v_average_score NUMBER;
BEGIN
    SELECT COUNT(review_id), SUM(flag) INTO v_total_reviews, v_total_score
    FROM Reviews
    WHERE product_id = p_product_id;

    IF v_total_reviews > 0 THEN
        v_average_score := v_total_score / v_total_reviews;
    ELSE
        v_average_score := 0; 
    END IF;

    RETURN v_average_score;
END CalculateAverageReviewScore;
/

end utility_package;

