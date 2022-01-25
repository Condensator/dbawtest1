SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[BillOfMaterials](
	[BillOfMaterialsID] [int] IDENTITY(1,1) NOT NULL,
	[ProductAssemblyID] [int] NULL,
	[ComponentID] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[UnitMeasureCode] [nchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BOMLevel] [smallint] NOT NULL,
	[PerAssemblyQty] [decimal](8, 2) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_BillOfMaterials_BillOfMaterialsID] PRIMARY KEY NONCLUSTERED 
(
	[BillOfMaterialsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
)

GO
ALTER TABLE [Production].[BillOfMaterials] ADD  CONSTRAINT [DF_BillOfMaterials_StartDate]  DEFAULT (getdate()) FOR [StartDate]
GO
ALTER TABLE [Production].[BillOfMaterials] ADD  CONSTRAINT [DF_BillOfMaterials_PerAssemblyQty]  DEFAULT ((1.00)) FOR [PerAssemblyQty]
GO
ALTER TABLE [Production].[BillOfMaterials] ADD  CONSTRAINT [DF_BillOfMaterials_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [FK_BillOfMaterials_Product_ComponentID] FOREIGN KEY([ComponentID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [FK_BillOfMaterials_Product_ComponentID]
GO
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [FK_BillOfMaterials_Product_ProductAssemblyID] FOREIGN KEY([ProductAssemblyID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [FK_BillOfMaterials_Product_ProductAssemblyID]
GO
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [FK_BillOfMaterials_UnitMeasure_UnitMeasureCode] FOREIGN KEY([UnitMeasureCode])
REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [FK_BillOfMaterials_UnitMeasure_UnitMeasureCode]
GO
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [CK_BillOfMaterials_BOMLevel] CHECK  (([ProductAssemblyID] IS NULL AND [BOMLevel]=(0) AND [PerAssemblyQty]=(1.00) OR [ProductAssemblyID] IS NOT NULL AND [BOMLevel]>=(1)))
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [CK_BillOfMaterials_BOMLevel]
GO
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [CK_BillOfMaterials_EndDate] CHECK  (([EndDate]>[StartDate] OR [EndDate] IS NULL))
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [CK_BillOfMaterials_EndDate]
GO
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [CK_BillOfMaterials_PerAssemblyQty] CHECK  (([PerAssemblyQty]>=(1.00)))
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [CK_BillOfMaterials_PerAssemblyQty]
GO
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [CK_BillOfMaterials_ProductAssemblyID] CHECK  (([ProductAssemblyID]<>[ComponentID]))
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [CK_BillOfMaterials_ProductAssemblyID]
GO
