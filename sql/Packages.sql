Create or Replace PACKAGE review_package as 
Procedure add_review;
Function CalculateAverageReviewScore (p_product_id NUMBER) return number;

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
Create or Replace PACKAGE product_package AS
procedure add_product(vproduct in PRODUCT_TYP)
end product_package;

Create Or REPLACE PACKAGE BODY product_package as
--Adding a product
procedure add_product(vproduct in PRODUCT_TYP) is 
BEGIN
insert into Product
Values(vproduct.product_id, vproduct.product_name, vproduct.product_price, vproduct.product_category);
end;
/


end product_package;
