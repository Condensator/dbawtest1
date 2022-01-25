SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Purchasing].[PurchaseOrderDetail](
	[PurchaseOrderID] [int] NOT NULL,
	[PurchaseOrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[OrderQty] [smallint] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[LineTotal]  AS (isnull([OrderQty]*[UnitPrice],(0.00))),
	[ReceivedQty] [decimal](8, 2) NOT NULL,
	[RejectedQty] [decimal](8, 2) NOT NULL,
	[StockedQty]  AS (isnull([ReceivedQty]-[RejectedQty],(0.00))),
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID] PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderID] ASC,
	[PurchaseOrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
)

GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] ADD  CONSTRAINT [DF_PurchaseOrderDetail_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderDetail_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [FK_PurchaseOrderDetail_Product_ProductID]
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID] FOREIGN KEY([PurchaseOrderID])
REFERENCES [Purchasing].[PurchaseOrderHeader] ([PurchaseOrderID])
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID]
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderDetail_OrderQty] CHECK  (([OrderQty]>(0)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [CK_PurchaseOrderDetail_OrderQty]
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderDetail_ReceivedQty] CHECK  (([ReceivedQty]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [CK_PurchaseOrderDetail_ReceivedQty]
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderDetail_RejectedQty] CHECK  (([RejectedQty]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [CK_PurchaseOrderDetail_RejectedQty]
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderDetail_UnitPrice] CHECK  (([UnitPrice]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [CK_PurchaseOrderDetail_UnitPrice]
GO
