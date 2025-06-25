USE LA_SELECTION
GO

-- Creación de las tablas
/*
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Provincia' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.BI_DIM_Estado_Pedido (
    DIM_Estado_Pedido_id INT IDENTITY(1,1) PRIMARY KEY,
    Estado_pedido NVARCHAR(255)
);
*/