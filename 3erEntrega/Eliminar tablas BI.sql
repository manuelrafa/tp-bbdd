USE GD1C2025;
GO

-- PASO 1: BORRAR DATOS DE TABLAS DE HECHOS
DELETE FROM LA_SELECTION.BI_HECHO_Venta;
DELETE FROM LA_SELECTION.BI_HECHO_Envio;
DELETE FROM LA_SELECTION.BI_HECHO_Compra;
DELETE FROM LA_SELECTION.BI_HECHO_Pedido;

-- PASO 2: BORRAR DATOS DE TABLAS DE DIMENSIONES
DELETE FROM LA_SELECTION.BI_DIM_Modelo_Sillon;
DELETE FROM LA_SELECTION.BI_DIM_Ubicacion;
DELETE FROM LA_SELECTION.BI_DIM_Tipo_Material;
DELETE FROM LA_SELECTION.BI_DIM_Sucursal;
DELETE FROM LA_SELECTION.BI_DIM_Rango_Etario_Cliente;
DELETE FROM LA_SELECTION.BI_DIM_Tiempo;
DELETE FROM LA_SELECTION.BI_DIM_Turno_Ventas;
DELETE FROM LA_SELECTION.BI_DIM_Estado_Pedido;

-- PASO 3: ELIMINAR TABLAS DE HECHOS (con chequeo de existencia)
IF OBJECT_ID('LA_SELECTION.BI_HECHO_Venta', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_HECHO_Venta;

IF OBJECT_ID('LA_SELECTION.BI_HECHO_Envio', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_HECHO_Envio;

IF OBJECT_ID('LA_SELECTION.BI_HECHO_Compra', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_HECHO_Compra;

IF OBJECT_ID('LA_SELECTION.BI_HECHO_Pedido', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_HECHO_Pedido;

-- PASO 4: ELIMINAR TABLAS DE DIMENSIONES (con chequeo de existencia)
IF OBJECT_ID('LA_SELECTION.BI_DIM_Modelo_Sillon', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_DIM_Modelo_Sillon;

IF OBJECT_ID('LA_SELECTION.BI_DIM_Ubicacion', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_DIM_Ubicacion;

IF OBJECT_ID('LA_SELECTION.BI_DIM_Tipo_Material', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_DIM_Tipo_Material;

IF OBJECT_ID('LA_SELECTION.BI_DIM_Sucursal', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_DIM_Sucursal;

IF OBJECT_ID('LA_SELECTION.BI_DIM_Rango_Etario_Cliente', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_DIM_Rango_Etario_Cliente;

IF OBJECT_ID('LA_SELECTION.BI_DIM_Tiempo', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_DIM_Tiempo;

IF OBJECT_ID('LA_SELECTION.BI_DIM_Turno_Ventas', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_DIM_Turno_Ventas;

IF OBJECT_ID('LA_SELECTION.BI_DIM_Estado_Pedido', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.BI_DIM_Estado_Pedido;
