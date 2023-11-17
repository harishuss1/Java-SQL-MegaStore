Create or Replace PACKAGE utility_package as 
--    Procedure add_review;
--    Function CalculateAverageReviewScore (p_product_id NUMBER) return number;
    PROCEDURE CheckFlaggedReviews;
end utility_package;
/
Create Or REPLACE PACKAGE BODY utility_package as

--Get the Average Review of a product.
FUNCTION calculate_average_review_score(p_product_id NUMBER)
 RETURN NUMBER
 IS
     v_total_score NUMBER := 0;
     v_review_count NUMBER := 0;
     v_average_score NUMBER;
 BEGIN
     -- Calculate the total score and count of reviews for the specified product
     FOR r IN (SELECT review_score FROM Reviews WHERE product_id = p_product_id)
     LOOP
         v_total_score := v_total_score + r.review_score;
         v_review_count := v_review_count + 1;
     END LOOP;

     -- Avoid division by zero
     IF v_review_count > 0 THEN
         v_average_score := v_total_score / v_review_count;
     ELSE
         v_average_score := NULL;
     END IF;

     RETURN v_average_score;
 END;

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

