CREATE TABLE [dbo].[Books](
    [BookID] [int] IDENTITY(1,1) NOT NULL,
    [BookName] [varchar](50) NULL,
    [Category] [varchar](50) NULL,
    [Price] [numeric](18, 2) NULL,
    [Price_Range] [varchar](20) NULL,
    PRIMARY KEY CLUSTERED ( [BookID] ASC )
) ON [PRIMARY]

GO

INSERT INTO dbo.Books 
    (BookName, Category, Price, Price_Range)
VALUES	
    ('Computer Architecture', 'Computers', 125.6, '100-150'),
    ('Advanced Composite Materials', 'Science', 172.56, '150-200'),
    ('Asp.Net 4 Blue Book', 'Programming', 56.00, '50-100'),
    ('Strategies Unplugged', 'Science', 99.99, '50-100'),
    ('Teaching Science', 'Science', 164.10, '150-200'),
    ('Challenging Times', 'Business', 150.70, '150-200'),
    ('Circuit Bending', 'Science', 112.00, '100-150'),
    ('Popular Science', 'Science', 210.40, '200-250'),
    ('ADOBE Premiere', 'Computers', 62.20, '50-100')