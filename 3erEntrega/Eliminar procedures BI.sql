USE GD1C2025;
GO

-- Eliminar procedimientos de migración si existen
IF OBJECT_ID('LA_SELECTION.migrar_BI_Estados_Pedido', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_BI_Estados_Pedido;
GO

IF OBJECT_ID('LA_SELECTION.migrar_BI_Turnos_Ventas', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_BI_Turnos_Ventas;
GO

IF OBJECT_ID('LA_SELECTION.migrar_BI_Tiempos', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_BI_Tiempos;
GO

IF OBJECT_ID('LA_SELECTION.migrar_BI_Rango_etario_cliente', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_BI_Rango_etario_cliente;
GO

IF OBJECT_ID('LA_SELECTION.migrar_BI_Sucursal', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_BI_Sucursal;
GO

IF OBJECT_ID('LA_SELECTION.migrar_BI_Tipo_Material', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_BI_Tipo_Material;
GO

IF OBJECT_ID('LA_SELECTION.migrar_BI_Ubicacion', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_BI_Ubicacion;
GO

IF OBJECT_ID('LA_SELECTION.migrar_BI_Modelo_Sillon', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_BI_Modelo_Sillon;
GO
