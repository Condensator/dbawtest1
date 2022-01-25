SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[TransactionHistory](
	[TransactionID] [int] IDENTITY(100000,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ReferenceOrderID] [int] NOT NULL,
	[ReferenceOrderLineID] [int] NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[TransactionType] [nchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Quantity] [int] NOT NULL,
	[ActualCost] [money] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TransactionHistory_TransactionID] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
)

GO
ALTER TABLE [Production].[TransactionHistory] ADD  CONSTRAINT [DF_TransactionHistory_ReferenceOrderLineID]  DEFAULT ((0)) FOR [ReferenceOrderLineID]
GO
ALTER TABLE [Production].[TransactionHistory] ADD  CONSTRAINT [DF_TransactionHistory_TransactionDate]  DEFAULT (getdate()) FOR [TransactionDate]
GO
ALTER TABLE [Production].[TransactionHistory] ADD  CONSTRAINT [DF_TransactionHistory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [Production].[TransactionHistory]  WITH CHECK ADD  CONSTRAINT [FK_TransactionHistory_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[TransactionHistory] CHECK CONSTRAINT [FK_TransactionHistory_Product_ProductID]
GO
ALTER TABLE [Production].[TransactionHistory]  WITH CHECK ADD  CONSTRAINT [CK_TransactionHistory_TransactionType] CHECK  ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W'))
GO
ALTER TABLE [Production].[TransactionHistory] CHECK CONSTRAINT [CK_TransactionHistory_TransactionType]
GO
