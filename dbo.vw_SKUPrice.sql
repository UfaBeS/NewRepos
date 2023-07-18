CREATE VIEW dbo.vw_SKUPrice
AS
SELECT s.*, dbo.udf_GetSKUPrice(s.ID) AS SKUPrice
FROM dbo.SKU s;