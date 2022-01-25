SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Purchasing].[PurchaseOrderHeader](
	[PurchaseOrderID] [int] IDENTITY(1,1) NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[VendorID] [int] NOT NULL,
	[ShipMethodID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NULL,
	[SubTotal] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[TotalDue]  AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))) PERSISTED NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PurchaseOrderHeader_PurchaseOrderID] PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
)

GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_RevisionNumber]  DEFAULT ((0)) FOR [RevisionNumber]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_SubTotal]  DEFAULT ((0.00)) FOR [SubTotal]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_TaxAmt]  DEFAULT ((0.00)) FOR [TaxAmt]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_Freight]  DEFAULT ((0.00)) FOR [Freight]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID] FOREIGN KEY([EmployeeID])
REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY([ShipMethodID])
REFERENCES [Purchasing].[ShipMethod] ([ShipMethodID])
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID] FOREIGN KEY([VendorID])
REFERENCES [Purchasing].[Vendor] ([BusinessEntityID])
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_Freight] CHECK  (([Freight]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_Freight]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_ShipDate] CHECK  (([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL))
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_ShipDate]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_Status] CHECK  (([Status]>=(1) AND [Status]<=(4)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_Status]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_SubTotal] CHECK  (([SubTotal]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_SubTotal]
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_TaxAmt] CHECK  (([TaxAmt]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_TaxAmt]
GO
