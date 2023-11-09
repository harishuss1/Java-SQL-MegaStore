Create or Replace Package delete_data AS
procedure add_product(vproduct in PRODUCT_TYP);

end delete_data;

Create or Replace PACKAGE Body delete_data AS
--Adding product
procedure delete_product(vproduct in number) is 
BEGIN
Delete from Product
Where product_id = vproduct
end;

end delete_data;