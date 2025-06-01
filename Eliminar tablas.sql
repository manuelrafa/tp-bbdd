USE GD1C2025;
GO

-- Eliminación de tablas en orden para no romper las FK

IF OBJECT_ID('LA_SELECTION.DetalleFactura', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.DetalleFactura;

IF OBJECT_ID('LA_SELECTION.Detalle_Compra', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Detalle_Compra;

IF OBJECT_ID('LA_SELECTION.CancelacionPedido', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.CancelacionPedido;

IF OBJECT_ID('LA_SELECTION.DetallePedido', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.DetallePedido;

IF OBJECT_ID('LA_SELECTION.Envio', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Envio;

IF OBJECT_ID('LA_SELECTION.Compra', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Compra;

IF OBJECT_ID('LA_SELECTION.Pedido', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Pedido;

IF OBJECT_ID('LA_SELECTION.Sillon', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Sillon;

IF OBJECT_ID('LA_SELECTION.Factura', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Factura;

IF OBJECT_ID('LA_SELECTION.Proveedor', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Proveedor;

IF OBJECT_ID('LA_SELECTION.Cliente', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Cliente;

IF OBJECT_ID('LA_SELECTION.Sucursal', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Sucursal;

IF OBJECT_ID('LA_SELECTION.Tela', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Tela;

IF OBJECT_ID('LA_SELECTION.Madera', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Madera;

IF OBJECT_ID('LA_SELECTION.Relleno', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Relleno;

IF OBJECT_ID('LA_SELECTION.Material', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Material;

IF OBJECT_ID('LA_SELECTION.TipoMaterial', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.TipoMaterial;

IF OBJECT_ID('LA_SELECTION.Localidad', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Localidad;

IF OBJECT_ID('LA_SELECTION.Provincia', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Provincia;

IF OBJECT_ID('LA_SELECTION.EstadoPedido', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.EstadoPedido;

IF OBJECT_ID('LA_SELECTION.Sillon_Modelo', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Sillon_Modelo;

IF OBJECT_ID('LA_SELECTION.Sillon_Medida', 'U') IS NOT NULL
    DROP TABLE LA_SELECTION.Sillon_Medida;
GO

-- Eliminación del esquema, solo si no tiene objetos

-- Eliminación de stored procedures de manera segura (compatible con versiones antiguas)

IF OBJECT_ID('LA_SELECTION.migrar_detalles_compras', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_detalles_compras;

IF OBJECT_ID('LA_SELECTION.migrar_compras', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_compras;

IF OBJECT_ID('LA_SELECTION.migrar_proveedores', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_proveedores;

IF OBJECT_ID('LA_SELECTION.migrar_envios', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_envios;

IF OBJECT_ID('LA_SELECTION.migrar_detalles_facturas', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_detalles_facturas;

IF OBJECT_ID('LA_SELECTION.migrar_facturas', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_facturas;

IF OBJECT_ID('LA_SELECTION.migrar_cancelaciones_pedidos', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_cancelaciones_pedidos;

IF OBJECT_ID('LA_SELECTION.migrar_detalles_pedidos', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_detalles_pedidos;

IF OBJECT_ID('LA_SELECTION.migrar_pedidos', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_pedidos;

IF OBJECT_ID('LA_SELECTION.migrar_sillones', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_sillones;

IF OBJECT_ID('LA_SELECTION.migrar_sillones_medidas', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_sillones_medidas;

IF OBJECT_ID('LA_SELECTION.migrar_sillones_modelos', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_sillones_modelos;

IF OBJECT_ID('LA_SELECTION.migrar_rellenos', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_rellenos;

IF OBJECT_ID('LA_SELECTION.migrar_maderas', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_maderas;

IF OBJECT_ID('LA_SELECTION.migrar_telas', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_telas;

IF OBJECT_ID('LA_SELECTION.migrar_materiales', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_materiales;

IF OBJECT_ID('LA_SELECTION.migrar_tipoMateriales', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_tipoMateriales;

IF OBJECT_ID('LA_SELECTION.migrar_estadosPedidos', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_estadosPedidos;

IF OBJECT_ID('LA_SELECTION.migrar_sucursales', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_sucursales;

IF OBJECT_ID('LA_SELECTION.migrar_clientes', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_clientes;

IF OBJECT_ID('LA_SELECTION.migrar_localidades', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_localidades;

IF OBJECT_ID('LA_SELECTION.migrar_provincias', 'P') IS NOT NULL
    DROP PROCEDURE LA_SELECTION.migrar_provincias;

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'LA_SELECTION')
BEGIN
    DROP SCHEMA LA_SELECTION;
END
GO
