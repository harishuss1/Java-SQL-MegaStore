Create or Replace Package insert_data AS
procedure add_product(vproduct in PRODUCT_TYP);

end insert_data;

Create or Replace PACKAGE Body insert_data AS
--Adding product
procedure add_product(vproduct in PRODUCT_TYP) is 
BEGIN
insert into Product
Values(vproduct.product_id, vproduct.product_name, vproduct.product_price, vproduct.product_category);
end;

end insert_data;