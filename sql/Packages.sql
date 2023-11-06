Create or Replace PACKAGE review_package as 
Procedure add_review;
Function CalculateAverageReviewScore ( )

end review_package;
/
Create Or REPLACE PACKAGE BODY review_package as

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

end review_package;
/