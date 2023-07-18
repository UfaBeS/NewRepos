
CREATE TRIGGER dbo.TR_Basket_insert_update
AFTER INSERT, UPDATE
ON dbo.Basket
AS
BEGIN
  IF EXISTS (
    SELECT ID_SKU
    FROM dbo.Basket
    WHERE ID_SKU IN (SELECT ID_SKU FROM inserted)
    GROUP BY ID_SKU
    HAVING COUNT(*) >= 2
  )
  BEGIN
    UPDATE b
    SET DiscountValue = b.Value * 0.05
    FROM dbo.Basket b
    INNER JOIN inserted i ON b.ID = i.ID
    WHERE b.ID_SKU = i.ID_SKU;
  END
  ELSE
  BEGIN
    UPDATE b
    SET DiscountValue = 0
    FROM dbo.Basket b
    INNER JOIN inserted i ON b.ID = i.ID
    WHERE b.ID_SKU = i.ID_SKU;
  END;
END;