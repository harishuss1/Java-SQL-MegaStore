Create or Replace PACKAGE utility_package as 
--    Procedure add_review;
    FUNCTION calculate_average_review_score(p_product_id NUMBER) RETURN NUMBER;
    FUNCTION GetFlaggedReviews RETURN SYS_REFCURSOR;
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
    FUNCTION GetFlaggedReviews RETURN SYS_REFCURSOR IS
        review_cursor SYS_REFCURSOR;
    BEGIN
        OPEN review_cursor FOR
            SELECT r.review_id, r.description, p.product_name, r.flag, r.customer_id
            FROM Reviews r
            JOIN Products p ON r.product_id = p.product_id
            WHERE r.flag >= 1;
    
        RETURN review_cursor;
    END GetFlaggedReviews;
    


end utility_package;
/


