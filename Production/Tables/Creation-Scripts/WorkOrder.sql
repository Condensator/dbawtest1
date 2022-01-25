SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[WorkOrder](
	[WorkOrderID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[OrderQty] [int] NOT NULL,
	[StockedQty]  AS (isnull([OrderQty]-[ScrappedQty],(0))),
	[ScrappedQty] [smallint] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[DueDate] [datetime] NOT NULL,
	[ScrapReasonID] [smallint] NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WorkOrder_WorkOrderID] PRIMARY KEY CLUSTERED 
(
	[WorkOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
)

GO
ALTER TABLE [Production].[WorkOrder] ADD  CONSTRAINT [DF_WorkOrder_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [Production].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrder_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[WorkOrder] CHECK CONSTRAINT [FK_WorkOrder_Product_ProductID]
GO
ALTER TABLE [Production].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrder_ScrapReason_ScrapReasonID] FOREIGN KEY([ScrapReasonID])
REFERENCES [Production].[ScrapReason] ([ScrapReasonID])
GO
ALTER TABLE [Production].[WorkOrder] CHECK CONSTRAINT [FK_WorkOrder_ScrapReason_ScrapReasonID]
GO
ALTER TABLE [Production].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrder_EndDate] CHECK  (([EndDate]>=[StartDate] OR [EndDate] IS NULL))
GO
ALTER TABLE [Production].[WorkOrder] CHECK CONSTRAINT [CK_WorkOrder_EndDate]
GO
ALTER TABLE [Production].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrder_OrderQty] CHECK  (([OrderQty]>(0)))
GO
ALTER TABLE [Production].[WorkOrder] CHECK CONSTRAINT [CK_WorkOrder_OrderQty]
GO
ALTER TABLE [Production].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrder_ScrappedQty] CHECK  (([ScrappedQty]>=(0)))
GO
ALTER TABLE [Production].[WorkOrder] CHECK CONSTRAINT [CK_WorkOrder_ScrappedQty]
GO
