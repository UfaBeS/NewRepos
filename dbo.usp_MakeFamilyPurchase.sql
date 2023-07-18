CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
  @FamilySurName VARCHAR(255)
AS
BEGIN
  DECLARE @FamilyID INT;
  
  -- Получаем ID семьи по фамилии
  SELECT @FamilyID = ID
  FROM dbo.Family
  WHERE SurName = @FamilySurName;
  
  -- Обновляем BudgetValue семьи по логике
  UPDATE dbo.Family
  SET BudgetValue = BudgetValue - (SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = @FamilyID)
  WHERE ID = @FamilyID;
END;