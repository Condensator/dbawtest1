SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[SalesTaxRate](
	[SalesTaxRateID] [int] IDENTITY(1,1) NOT NULL,
	[StateProvinceID] [int] NOT NULL,
	[TaxType] [tinyint] NOT NULL,
	[TaxRate] [smallmoney] NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesTaxRate_SalesTaxRateID] PRIMARY KEY CLUSTERED 
(
	[SalesTaxRateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
)

GO
ALTER TABLE [Sales].[SalesTaxRate] ADD  CONSTRAINT [DF_SalesTaxRate_TaxRate]  DEFAULT ((0.00)) FOR [TaxRate]
GO
ALTER TABLE [Sales].[SalesTaxRate] ADD  CONSTRAINT [DF_SalesTaxRate_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
ALTER TABLE [Sales].[SalesTaxRate] ADD  CONSTRAINT [DF_SalesTaxRate_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [Sales].[SalesTaxRate]  WITH CHECK ADD  CONSTRAINT [FK_SalesTaxRate_StateProvince_StateProvinceID] FOREIGN KEY([StateProvinceID])
REFERENCES [Person].[StateProvince] ([StateProvinceID])
GO
ALTER TABLE [Sales].[SalesTaxRate] CHECK CONSTRAINT [FK_SalesTaxRate_StateProvince_StateProvinceID]
GO
ALTER TABLE [Sales].[SalesTaxRate]  WITH CHECK ADD  CONSTRAINT [CK_SalesTaxRate_TaxType] CHECK  (([TaxType]>=(1) AND [TaxType]<=(3)))
GO
ALTER TABLE [Sales].[SalesTaxRate] CHECK CONSTRAINT [CK_SalesTaxRate_TaxType]
GO
