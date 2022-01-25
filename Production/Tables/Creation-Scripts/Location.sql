SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[Location](
	[LocationID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[CostRate] [smallmoney] NOT NULL,
	[Availability] [decimal](8, 2) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Location_LocationID] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
)

GO
ALTER TABLE [Production].[Location] ADD  CONSTRAINT [DF_Location_CostRate]  DEFAULT ((0.00)) FOR [CostRate]
GO
ALTER TABLE [Production].[Location] ADD  CONSTRAINT [DF_Location_Availability]  DEFAULT ((0.00)) FOR [Availability]
GO
ALTER TABLE [Production].[Location] ADD  CONSTRAINT [DF_Location_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [Production].[Location]  WITH CHECK ADD  CONSTRAINT [CK_Location_Availability] CHECK  (([Availability]>=(0.00)))
GO
ALTER TABLE [Production].[Location] CHECK CONSTRAINT [CK_Location_Availability]
GO
ALTER TABLE [Production].[Location]  WITH CHECK ADD  CONSTRAINT [CK_Location_CostRate] CHECK  (([CostRate]>=(0.00)))
GO
ALTER TABLE [Production].[Location] CHECK CONSTRAINT [CK_Location_CostRate]
GO
