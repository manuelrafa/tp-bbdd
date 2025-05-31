USE GD1C2025
GO

-- Creación del esquema

CREATE SCHEMA LA_SELECTION;
GO

-- Creación de las tablas

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Provincia' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Provincia (
    Provincia_id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Localidad' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Localidad (
    Localidad_id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255),
    Provincia_id INT,
    FOREIGN KEY (Provincia_id) REFERENCES LA_SELECTION.Provincia(Provincia_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EstadoPedido' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.EstadoPedido (
    EstadoPedido_id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Cliente' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Cliente (
    Cliente_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    DNI BIGINT,
    Localidad_id INT,
    Nombre NVARCHAR(255),
    Apellido NVARCHAR(255),
    Telefono NVARCHAR(255),
    Direccion NVARCHAR(255),
    Mail NVARCHAR(255),
    FechaNacimiento DATETIME2(6),
    FOREIGN KEY (Localidad_id) REFERENCES LA_SELECTION.Localidad(Localidad_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Sucursal' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Sucursal (
    Sucursal_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    NroSucursal BIGINT,
    Localidad_id INT,
    Direccion NVARCHAR(255),
    Telefono NVARCHAR(255),
    Mail NVARCHAR(255),
    FOREIGN KEY (Localidad_id) REFERENCES LA_SELECTION.Localidad(Localidad_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TipoMaterial' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.TipoMaterial (
    TipoMaterial_id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255)
);


IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Material' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Material (
    Material_id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255),
    Descripcion NVARCHAR(255),
    Precio DECIMAL(38,2),
    TipoMaterial_id INT,
    FOREIGN KEY (TipoMaterial_id) REFERENCES LA_SELECTION.TipoMaterial(TipoMaterial_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Tela' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Tela (
    Tela_id INT IDENTITY(1,1) PRIMARY KEY,
    Color NVARCHAR(255),
    Textura NVARCHAR(255),
    Material_id INT,
    FOREIGN KEY (Material_id) REFERENCES LA_SELECTION.Material(Material_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Madera' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Madera (
    Madera_id INT IDENTITY(1,1) PRIMARY KEY,
    Color NVARCHAR(255),
    Dureza NVARCHAR(255),
    Material_id INT,
    FOREIGN KEY (Material_id) REFERENCES LA_SELECTION.Material(Material_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Relleno' AND schema_id = SCHEMA_ID('LA_SELECTION'))IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Relleno' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Relleno (
    Relleno_id INT IDENTITY(1,1) PRIMARY KEY,
    Densidad DECIMAL(38,2),
    Material_id INT,
    FOREIGN KEY (Material_id) REFERENCES LA_SELECTION.Material(Material_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Sillon_Modelo' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Sillon_Modelo (
    Sillon_Modelo_id INT IDENTITY(1,1) PRIMARY KEY,
    Sillon_Modelo_Codigo BIGINT,
    Nombre NVARCHAR(255),
    Descripcion NVARCHAR(255),
    Precio DECIMAL(18,2)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Sillon_Medida' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Sillon_Medida (
    Sillon_Medida_id INT IDENTITY(1,1) PRIMARY KEY,
    Alto DECIMAL(18,2),
    Ancho DECIMAL(18,2),
    Profundidad DECIMAL(18,2),
    Precio DECIMAL(18,2)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Sillon' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Sillon (
    Sillon_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Sillon_Codigo INT,
    Sillon_Modelo_id INT,
    Sillon_Medida_id INT,
    Tela_id INT,
    Madera_id INT,
    Relleno_id INT,
    FOREIGN KEY (Sillon_Modelo_id) REFERENCES LA_SELECTION.Sillon_Modelo(Sillon_Modelo_id),
    FOREIGN KEY (Sillon_Medida_id) REFERENCES LA_SELECTION.Sillon_Medida(Sillon_Medida_id),
    FOREIGN KEY (Tela_id) REFERENCES LA_SELECTION.Tela(Tela_id),
    FOREIGN KEY (Madera_id) REFERENCES LA_SELECTION.Madera(Madera_id),
    FOREIGN KEY (Relleno_id) REFERENCES LA_SELECTION.Relleno(Relleno_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Pedido' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Pedido (
    Pedido_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Pedido_Numero DECIMAL(18,0),
    Sucursal_id BIGINT,
    Cliente_id BIGINT,
    Fecha DATETIME2(6),
    Total DECIMAL(18,2),
    EstadoPedido_id INT,
    FOREIGN KEY (Sucursal_id) REFERENCES LA_SELECTION.Sucursal(Sucursal_id),
    FOREIGN KEY (Cliente_id) REFERENCES LA_SELECTION.Cliente(Cliente_id),
    FOREIGN KEY (EstadoPedido_id) REFERENCES LA_SELECTION.EstadoPedido(EstadoPedido_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DetallePedido' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.DetallePedido (
    DetallePedido_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Pedido_id BIGINT,
    Cantidad BIGINT,
    Precio DECIMAL(18,2),
    SubTotal DECIMAL(18,2),
    Sillon_id BIGINT,
    FOREIGN KEY (Pedido_id) REFERENCES LA_SELECTION.Pedido(Pedido_id),
    FOREIGN KEY (Sillon_id) REFERENCES LA_SELECTION.Sillon(Sillon_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CancelacionPedido' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.CancelacionPedido (
    CancelacionPedido_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME2(6),
    Motivo NVARCHAR(255),
    Pedido_id BIGINT,
    FOREIGN KEY (Pedido_id) REFERENCES LA_SELECTION.Pedido(Pedido_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Factura' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Factura (
    Factura_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Factura_Numero BIGINT,
    Fecha DATETIME2(6),
    Total DECIMAL(38,2),
    Cliente_id BIGINT,
    Sucursal_id BIGINT,
    FOREIGN KEY (Cliente_id) REFERENCES LA_SELECTION.Cliente(Cliente_id),
    FOREIGN KEY (Sucursal_id) REFERENCES LA_SELECTION.Sucursal(Sucursal_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DetalleFactura' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.DetalleFactura (
    DetalleFactura_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    DetallePedido_id BIGINT,
    Factura_id BIGINT,
    Precio DECIMAL(18,2),
    Cantidad DECIMAL(18,2),
    SubTotal DECIMAL(18,2),
    FOREIGN KEY (DetallePedido_id) REFERENCES LA_SELECTION.DetallePedido(DetallePedido_id),
    FOREIGN KEY (Factura_id) REFERENCES LA_SELECTION.Factura(Factura_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Envio' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Envio (
    Envio_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Envio_Numero DECIMAL(18,0),
    Fecha_Programada DATETIME2(6),
    Fecha DATETIME2(6),
    ImporteTraslado DECIMAL(18,0),
    importeSubida DECIMAL(18,0),
    Total DECIMAL(18,0),
    Factura_id BIGINT,
    FOREIGN KEY (Factura_id) REFERENCES LA_SELECTION.Factura(Factura_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Proveedor' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Proveedor (
    Proveedor_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    CUIT NVARCHAR(255),
    Localidad_id INT,
    Razon_Social NVARCHAR(255),
    Direccion NVARCHAR(255),
    Telefono NVARCHAR(255),
    Mail NVARCHAR(255),
    FOREIGN KEY (Localidad_id) REFERENCES LA_SELECTION.Localidad(Localidad_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Compra' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Compra (
    Compra_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Compra_Numero DECIMAL(18,0),
    Compra_Fecha DATETIME2(6),
    Sucursal_id BIGINT,
    Compra_Total DECIMAL(18,2),
    Proveedor_id BIGINT,
    FOREIGN KEY (Sucursal_id) REFERENCES LA_SELECTION.Sucursal(Sucursal_id),
    FOREIGN KEY (Proveedor_id) REFERENCES LA_SELECTION.Proveedor(Proveedor_id)
);

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Detalle_Compra' AND schema_id = SCHEMA_ID('LA_SELECTION'))
CREATE TABLE LA_SELECTION.Detalle_Compra (
    Detalle_Compra_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Material_id INT,
    Compra_id BIGINT,
    Precio DECIMAL(18,2),
    Cantidad DECIMAL(18,0),
    SubTotal DECIMAL(18,2),
    FOREIGN KEY (Material_id) REFERENCES LA_SELECTION.Material(Material_id),
    FOREIGN KEY (Compra_id) REFERENCES LA_SELECTION.Compra(Compra_id)
);

GO



-- Stored Procedures



CREATE PROCEDURE LA_SELECTION.migrar_provincias
AS
    BEGIN
        INSERT INTO LA_SELECTION.Provincia (Nombre)
        SELECT Nombre FROM (
                SELECT DISTINCT Sucursal_Provincia AS Nombre FROM gd_esquema.Maestra WHERE Sucursal_Provincia IS NOT NULL
                UNION
                SELECT DISTINCT Cliente_Provincia AS Nombre FROM gd_esquema.Maestra WHERE Cliente_Provincia IS NOT NULL
                UNION
                SELECT DISTINCT Proveedor_Provincia AS Nombre FROM gd_esquema.Maestra WHERE Proveedor_Provincia IS NOT NULL
            ) AS provincias_unicas
            WHERE Nombre NOT IN (SELECT Nombre FROM LA_SELECTION.Provincia);
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_localidades
AS
BEGIN
    INSERT INTO LA_SELECTION.Localidad (Nombre, Provincia_id)
    SELECT DISTINCT L.Nombre, P.Provincia_id
    FROM (
        SELECT DISTINCT  Sucursal_Localidad AS Nombre, Sucursal_Provincia AS ProvinciaNombre
        FROM gd_esquema.Maestra
        WHERE Sucursal_Localidad IS NOT NULL AND Sucursal_Provincia IS NOT NULL

        UNION

        SELECT DISTINCT  Cliente_Localidad AS Nombre, Cliente_Provincia AS ProvinciaNombre
        FROM gd_esquema.Maestra
        WHERE Cliente_Localidad IS NOT NULL AND Cliente_Provincia IS NOT NULL

        UNION

        SELECT DISTINCT  Proveedor_Localidad AS Nombre, Proveedor_Provincia AS ProvinciaNombre
        FROM gd_esquema.Maestra
        WHERE Proveedor_Localidad IS NOT NULL AND Proveedor_Provincia IS NOT NULL
    ) AS L
    INNER JOIN LA_SELECTION.Provincia P
        ON L.ProvinciaNombre = P.Nombre
END
GO


CREATE PROCEDURE LA_SELECTION.migrar_clientes
AS
BEGIN
	INSERT INTO LA_SELECTION.Cliente (DNI, Localidad_id, Nombre, Apellido, Telefono, Direccion, Mail, FechaNacimiento)
	SELECT DISTINCT M.Cliente_Dni DNI, L.Localidad_id Localidad_id, M.Cliente_Nombre Nombre, M.Cliente_Apellido Apellido, M.Cliente_Telefono Telefono,
	M.Cliente_Direccion Direccion, M.Cliente_Mail, Cliente_FechaNacimiento FechaNacimiento
	FROM gd_esquema.Maestra M

	INNER JOIN LA_SELECTION.Localidad L
	ON M.Cliente_Localidad = L.Nombre

	INNER JOIN LA_SELECTION.Provincia P
	ON L.Provincia_id = P.Provincia_id AND M.Cliente_Provincia = P.Nombre
    
	WHERE
    Cliente_Dni IS NOT NULL
    AND M.Cliente_Dni NOT IN ( SELECT DNI FROM LA_SELECTION.Cliente );
END
GO


CREATE PROCEDURE LA_SELECTION.migrar_sucursales
AS
BEGIN
	INSERT INTO LA_SELECTION.Sucursal (NroSucursal, Localidad_id, Direccion, Telefono, Mail)
	SELECT DISTINCT M.Sucursal_NroSucursal, L.Localidad_id, M.Sucursal_Direccion, M.Sucursal_telefono, M.Sucursal_mail
	FROM gd_esquema.Maestra M
    
	INNER JOIN LA_SELECTION.Localidad L
	ON M.Sucursal_Localidad = L.Nombre
    
	INNER JOIN LA_SELECTION.Provincia P
	ON L.Provincia_id = P.Provincia_id AND M.Sucursal_Provincia = P.Nombre
    
	WHERE M.Sucursal_NroSucursal IS NOT NULL AND M.Sucursal_NroSucursal NOT IN ( SELECT NroSucursal FROM LA_SELECTION.Sucursal )
END
GO


CREATE PROCEDURE LA_SELECTION.migrar_estadosPedidos
AS
    BEGIN
        INSERT INTO LA_SELECTION.EstadoPedido (Nombre)
        SELECT DISTINCT Pedido_Estado
        FROM gd_esquema.Maestra
        WHERE Nombre IS NOT NULL AND Pedido_Estado NOT IN ( SELECT Nombre FROM LA_SELECTION.EstadoPedido )
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_tipoMateriales
AS
    BEGIN
        INSERT INTO LA_SELECTION.TipoMaterial (Nombre)
        SELECT DISTINCT Material_Tipo
        FROM gd_esquema.Maestra M
		WHERE Material_Tipo IS NOT NULL AND Material_Tipo NOT IN ( SELECT Nombre FROM LA_SELECTION.TipoMaterial)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_materiales
AS
    BEGIN
    INSERT INTO LA_SELECTION.Material (Nombre , Descripcion , Precio, TipoMaterial_id)
    SELECT DISTINCT M.Material_Nombre , M.Material_Descripcion , M.Material_Precio, T.TipoMaterial_id
        FROM gd_esquema.Maestra
        JOIN LA_SELECTION.TipoMaterial T
            ON M.Material_Tipo = T.Nombre
        WHERE M.Material_Tipo IS NOT NULL
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_telas
AS
    BEGIN
        INSERT INTO LA_SELECTION.Tela (Color, Textura, Material_id)
        SELECT intermedia.Tela_Color, intermedia.Textura, material.Material_id
        FROM
            (
                SELECT DISTINCT Tela_Color, Tela_Textura, Material_Nombre
                FROM gd_esquema.Maestra
            ) intermedia
            JOIN LA_SELECTION.Material material ON (intermedia.Material_Nombre = material.Nombre)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_maderas
AS
    BEGIN
        INSERT INTO LA_SELECTION.Madera (Color, Dureza, Material_id)
        SELECT  intermedia.Madera_Color, intermedia.Madera_Dureza, material.Material_id
        FROM
            (
                SELECT DISTINCT Madera_Color, Madera_Textura, Material_Nombre
                FROM gd_esquema.Maestra
            ) intermedia
            JOIN LA_SELECTION.Material material ON (intermedia.Material_Nombre = material.Nombre)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_rellenos
AS
    BEGIN
        INSERT INTO LA_SELECTION.Relleno (Densidad, Material_id)
        SELECT  intermedia.Densidad, material.Material_id
        FROM
            (
                SELECT DISTINCT Relleno_Densidad, Material_Nombre
                FROM gd_esquema.Maestra
            ) intermedia
            JOIN LA_SELECTION.Material material ON (intermedia.Material_Nombre = material.Nombre)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_sillones_modelos
AS
    BEGIN
        INSERT INTO LA_SELECTION.Sillon_Modelo (Sillon_Modelo_Codigo, Nombre, Descripcion, Precio)
        SELECT DISTINCT Sillon_Modelo_Codigo, Sillon_Modelo, Sillon_Modelo_Descripcion, Sillon_Modelo_Precio
        FROM gd_esquema.Maestra
        WHERE Sillon_Modelo_Codigo IS NOT NULL
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_sillones_medidas
AS
    BEGIN
        INSERT INTO LA_SELECTION.Sillon_Medida (Alto, Ancho, Profundidad, Precio)
        SELECT DISTINCT Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad, Sillon_Medida_Precio
        FROM gd_esquema.Maestra
        WHERE Sillon_Medida_Precio IS NOT NULL
        GROUP BY Sillon_Medida_Alto, Sillon_Medida_Ancho, Sillon_Medida_Profundidad, Sillon_Medida_Precio
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_clientes
AS
    BEGIN
        INSERT INTO LA_SELECTION.Cliente (DNI, Localidad_id, Nombre, Apellido, Telefono, Direccion, Mail, FechaNacimiento)
        SELECT DISTINCT intermedia.Cliente_Dni, l.Localidad_id, intermedia.Cliente_Nombre, intermedia.Cliente_Apellido, intermedia.Cliente_Telefono, intermedia.Cliente_Direccion, intermedia.Cliente_Mail, intermedia.Cliente_FechaNacimiento
        FROM
            (
                SELECT DISTINCT Cliente_Localidad, Cliente_Dni, Cliente_Nombre, Cliente_Apellido, Cliente_Telefono, Cliente_Direccion, Cliente_Mail, Cliente_FechaNacimiento
                FROM gd_esquema.Maestra
                WHERE Cliente_Localidad IS NOT NULL
            ) intermedia
            JOIN LA_SELECTION.Localidad l ON (intermedia.Cliente_Localidad = l.Nombre)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_proveedores
AS
    BEGIN
        INSERT INTO LA_SELECTION.Proveedor (CUIT, Localidad_id, Razon_Social, Direccion, Telefono, Mail)
        SELECT DISTINCT intermedia.Proveedor_Cuit, l.Localidad_id, intermedia.Proveedor_RazonSocial, intermedia.Proveedor_Direccion, intermedia.Proveedor_Telefono, intermedia.Proveedor_Mail
        FROM
            (
                SELECT DISTINCT Proveedor_Localidad, Sucursal_NroSucursal, Sucursal_Direccion, Sucursal_telefono, Sucursal_mail
                FROM gd_esquema.Maestra
                WHERE Sucursal_Localidad IS NOT NULL
            ) intermedia
            JOIN LA_SELECTION.Localidad l ON (intermedia.Proveedor_Localidad = l.Nombre)
    END 
GO

CREATE PROCEDURE LA_SELECTION.migrar_sillones
AS
    BEGIN
        INSERT INTO LA_SELECTION.Sillon (Sillon_Codigo, Sillon_Modelo_id, Sillon_Medida_id, Tela_id, Madera_id, Relleno_id)
        SELECT DISTINCT maestra.Sillon_Codigo, sillon_modelo.Sillon_Modelo_id, sillon_medida.Sillon_Medida_id, tela.Tela_id, madera.Madera_id, relleno.Relleno_id
        FROM 
            gd_esquema.Maestra maestra
            JOIN LA_SELECTION.Sillon_Modelo sillon_modelo ON(maestra.Sillon_Modelo_Codigo = sillon_modelo.Sillon_Modelo_Codigo)
            JOIN LA_SELECTION.Sillon_Medida sillon_medida ON(maestra.Sillon_Medida_Alto = sillon_medida.Sillon_Medida_Alto AND maestra.Sillon_Medida_Ancho = sillon_medida.Sillon_Medida_Ancho AND maestra.Sillon_Medida_Precio = sillon_medida.Sillon_Medida_Precio AND maestra.Sillon_Medida_Profundidad = sillon_medida.Sillon_Medida_Profundidad)
            JOIN LA_SELECTION.Tela tela ON(maestra.Tela_Color = tela.Color AND maestra.Tela_Textura = tela.Textura)
            JOIN LA_SELECTION.Madera madera ON (maestra.Madera_Color = madera.Color AND maestra.Madera_Dureza = madera.Dureza)
            JOIN LA_SELECTION.Relleno relleno ON (maestra.Relleno_Densidad = relleno.Densidad)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_pedidos
AS
    BEGIN
        INSERT INTO LA_SELECTION.Pedido (Pedido_Numero, Sucursal_id, Cliente_id, Fecha, Total, EstadoPedido_id)
        SELECT DISTINCT maestra.Pedido_Numero, sucursal.Sucursal_id, cliente.Cliente_id, maestra.Pedido_Fecha, maestra.Pedido_Total, estado_pedido.EstadoPedido_id
        FROM 
            gd_esquema.Maestra maestra
            JOIN LA_SELECTION.Sucursal sucursal ON (maestra.Sucursal_NroSucursal = sucursal.NroSucursal)
            JOIN LA_SELECTION.Cliente cliente ON (maestra.Cliente_Dni = cliente.DNI)
            JOIN LA_SELECTION.EstadoPedido estado_pedido ON (maestra.Pedido_Estado = estado_pedido.Nombre)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_compras
AS
    BEGIN
        INSERT INTO LA_SELECTION.Compra (Compra_Numero, Compra_Fecha, Sucursal_id, Compra_Total, Proveedor_id)
        SELECT DISTINCT maestra.Compra_Numero, maestra.Compra_Fecha, Sucursal_id, maestra.Compra_Total, proveedor.Proveedor_id
        FROM
            gd_esquema.Maestra maestra
            JOIN LA_SELECTION.Sucursal sucursal ON (maestra.Sucursal_NroSucursal = sucursal.NroSucursal)
            JOIN LA_SELECTION.Proveedor proveedor ON (maestra.Proveedor_Cuit = proveedor.CUIT)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_detalles_pedidos
AS
    BEGIN
        INSERT INTO LA_SELECTION.DetallePedido (Pedido_id, Cantidad, Precio, SubTotal, Sillon_id)
        SELECT DISTINCT pedido.Pedido_id, maestra.Detalle_Pedido_Cantidad, maestra.Detalle_Pedido_Precio, maestra.Detalle_Pedido_SubTotal, sillon.Sillon_id
        FROM
            gd_esquema.Maestra maestra
            JOIN LA_SELECTION.Pedido pedido ON (maestra.Pedido_Numero = pedido.Pedido_Numero)
            JOIN LA_SELECTION.Sillon sillon ON (maestra.Sillon_Codigo = sillon.Sillon_Codigo)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_cancelaciones_pedidos
AS
    BEGIN
        INSERT INTO LA_SELECTION.CancelacionPedido (Fecha, Motivo, Pedido_id)
        SELECT DISTINCT maestra.Pedido_Cancelacion_Fecha, maestra.Pedido_Cancelacion_Motivo, Pedido_id
        FROM
            gd_esquema.Maestra maestra
            JOIN LA_SELECTION.Pedido pedido ON (maestra.Pedido_Numero = pedido.Pedido_Numero)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_facturas (Factura_Numero, Fecha, Total, Cliente_id, Sucursal_id)
AS
    BEGIN
        INSERT INTO LA_SELECTION.Factura
        SELECT maestra.Factura_Numero, maestra.Factura_Fecha, maestra.Factura_Total, cliente.Cliente_id, sucursal.Sucursal_id
        FROM
            gd_esquema.Maestra maestra
            JOIN LA_SELECTION.Cliente cliente ON (maestra.Cliente_Dni = cliente.DNI)
            JOIN LA_SELECTION.Sucursal sucursal ON (maestra.Sucursal_NroSucursal = sucursal.NroSucursal)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_detalles_facturas (DetallePedido_id, Factura_id, Precio, Cantidad, SubTotal)
AS
    BEGIN
        INSERT INTO LA_SELECTION.DetalleFactura
        SELECT detalle_pedido.DetallePedido_id, factura.Factura_id, maestra.Detalle_Factura_Precio, maestra.Detalle_Factura_Cantidad, maestra.Detalle_Factura_SubTotal
        FROM
            gd_esquema.Maestra maestra
            JOIN LA_SELECTION.DetallePedido detalle_pedido ON () --Me falta hacer esta condicion
            JOIN LA_SELECTION.Factura factura ON (maestra.Factura_Numero = factura.Factura_Numero)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_envios (Envio_Numero, Fecha_Programada, Fecha, ImporteTraslado, ImporteSubTotal, Total, Factura_id)
AS
    BEGIN
        INSERT INTO LA_SELECTION.Envio
        SELECT DISTINCT maestra.Envio_Numero, maestra.Envio_Fecha_Programada, maestra.Envio_Fecha,  maestra.Envio_ImporteTraslado,  maestra.Envio_importeSubida, maestra.Envio_Total, factura.Factura_id
        FROM
            gd_esquema.Maestra maestra
            JOIN LA_SELECTION.Factura factura ON (maestra.Factura_Numero = factura.Factura_Numero)
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_detalles_compras
AS
    BEGIN
        INSERT INTO LA_SELECTION.Detalle_Compra (Material_id, Compra_id, Precio, Cantidad, SubTotal)
        SELECT material.Material_id, compra.Compra_id, maestra.Detalle_Compra_Precio, maestra.Detalle_Compra_Cantidad, maestra.Detalle_Compra_SubTotal
        FROM
            gd_esquema.Maestra maestra
            JOIN LA_SELCTION.Material material ON (maestra.Material_Nombre = material.Nombre)
            JOIN LA_SELECTION.Compra compra ON (maestra.Compra_Numero = compra.Compra_Numero)
    END
GO

-- Migración de datos