/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [CodigoProd_Grade]
      ,[Codigo_Grade]
      ,[Desc1_Grade]
      ,[Desc2_Grade]
      ,[QtdeEst_Grade]
      ,[CodigoForn_Grade]
      ,[CodigoBar_Grade]
      ,[QtdeEstMax_Grade]
      ,[Atacado_Grade]
      ,[Ativo_Grade]
      ,[CodProdOLD_Grade]
      ,[CodGradeOLD_Grade]
  FROM [SispartsConexao].[dbo].[tabGradeProdutos]
  WHERE [CodigoProd_Grade] = 24000;
  -- where CodigoForn_Grade in ('00.2518.030.011','00.2518.039.010');


  
