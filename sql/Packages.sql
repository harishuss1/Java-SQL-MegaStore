Create or Replace PACKAGE utility_package as 
--    Procedure add_review;
--    Function CalculateAverageReviewScore (p_product_id NUMBER) return number;
    PROCEDURE CheckFlaggedReviews;
end utility_package;
/
Create Or REPLACE PACKAGE BODY utility_package as

--    FUNCTION CalculateAverageReviewScore(
--        p_product_id NUMBER
--    )
--    RETURN NUMBER AS
--        v_total_reviews NUMBER;
--        v_total_score NUMBER;
--        v_average_score NUMBER;
--    BEGIN
--        SELECT COUNT(review_id), SUM(flag) INTO v_total_reviews, v_total_score
--        FROM Reviews
--        WHERE product_id = p_product_id;
--    
--        IF v_total_reviews > 0 THEN
--            v_average_score := v_total_score / v_total_reviews;
--        ELSE
--            v_average_score := 0; 
--        END IF;
--    
--        RETURN v_average_score;
--    END CalculateAverageReviewScore;
    
    /* Checks for reviews that are flagged */
    PROCEDURE CheckFlaggedReviews AS
    BEGIN
        FOR review_rec IN (SELECT r.review_id, r.description, p.product_name, r.flag
                          FROM Reviews r
                          JOIN Products p ON r.product_id = p.product_id
                          WHERE r.flag >= 1)
        LOOP
            DBMS_OUTPUT.PUT_LINE('Review ID: ' || review_rec.review_id);
            DBMS_OUTPUT.PUT_LINE('Flag: ' || review_rec.flag);
            DBMS_OUTPUT.PUT_LINE('Review Description: ' || review_rec.description);
            DBMS_OUTPUT.PUT_LINE('Product Name: ' || review_rec.product_name);
            DBMS_OUTPUT.PUT_LINE('------------------------------------');
        END LOOP;
    END CheckFlaggedReviews;

end utility_package;
/

BEGIN
    utility_package.CheckFlaggedReviews;
END;
/

