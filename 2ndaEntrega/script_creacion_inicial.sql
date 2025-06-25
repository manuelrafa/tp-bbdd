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

	INNER JOIN LA_SELECTION.Provincia P
	ON M.Cliente_Provincia = P.Nombre

	INNER JOIN LA_SELECTION.Localidad L
	ON L.Provincia_id = P.Provincia_id AND M.Cliente_Localidad = L.Nombre
    
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

	JOIN LA_SELECTION.Provincia P
	ON M.Sucursal_Provincia = P.Nombre

	JOIN LA_SELECTION.Localidad L
	ON L.Provincia_id = P.Provincia_id AND M.Sucursal_Localidad = L.Nombre
    
    
	WHERE M.Sucursal_NroSucursal IS NOT NULL AND NOT EXISTS ( SELECT 1 FROM LA_SELECTION.Sucursal S WHERE S.NroSucursal = M.Sucursal_NroSucursal )
END
GO


CREATE PROCEDURE LA_SELECTION.migrar_estadosPedidos
AS
    BEGIN
        INSERT INTO LA_SELECTION.EstadoPedido (Nombre)
        SELECT DISTINCT Pedido_Estado
        FROM gd_esquema.Maestra
        WHERE Pedido_Estado IS NOT NULL AND Pedido_Estado NOT IN ( SELECT Nombre FROM LA_SELECTION.EstadoPedido )
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
        FROM gd_esquema.Maestra M
        JOIN LA_SELECTION.TipoMaterial T
        ON M.Material_Tipo = T.Nombre
        WHERE M.Material_Tipo IS NOT NULL
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_telas
AS
    BEGIN
        INSERT INTO LA_SELECTION.Tela (Color, Textura, Material_id)
        SELECT DISTINCT Maestra.Tela_Color, Maestra.Tela_Textura, material.Material_id
        FROM gd_esquema.Maestra Maestra
        JOIN LA_SELECTION.Material Material ON (Maestra.Material_Nombre = Material.Nombre)
		WHERE Maestra.Tela_Color IS NOT NULL AND Material.Material_id NOT IN ( SELECT Material_id FROM LA_SELECTION.Tela )
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_maderas
AS
    BEGIN
        INSERT INTO LA_SELECTION.Madera (Color, Dureza, Material_id)
        SELECT DISTINCT Maestra.Madera_Color, Maestra.Madera_Dureza, material.Material_id
        FROM gd_esquema.Maestra Maestra
        JOIN LA_SELECTION.Material Material ON (Maestra.Material_Nombre = Material.Nombre)
		WHERE Maestra.Madera_Color IS NOT NULL AND Material.Material_id NOT IN ( SELECT Material_id FROM LA_SELECTION.Madera )
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_rellenos
AS
    BEGIN
        INSERT INTO LA_SELECTION.Relleno (Densidad, Material_id)
        SELECT DISTINCT Maestra.Relleno_Densidad, material.Material_id
        FROM gd_esquema.Maestra Maestra
        JOIN LA_SELECTION.Material Material ON (Maestra.Material_Nombre = Material.Nombre)
		WHERE Maestra.Relleno_Densidad IS NOT NULL AND Material.Material_id NOT IN ( SELECT Material_id FROM LA_SELECTION.Relleno )
    END
GO

CREATE PROCEDURE LA_SELECTION.migrar_sillones_modelos
AS
    BEGIN
        INSERT INTO LA_SELECTION.Sillon_Modelo (Sillon_Modelo_Codigo, Nombre, Descripcion, Precio)
        SELECT DISTINCT Sillon_Modelo_Codigo, Sillon_Modelo, Sillon_Modelo_Descripcion, Sillon_Modelo_Precio
        FROM gd_esquema.Maestra
        WHERE Sillon_Modelo_Codigo IS NOT NULL AND Sillon_Modelo_Codigo NOT IN ( SELECT Sillon_Modelo_Codigo FROM LA_SELECTION.Sillon_Modelo )
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


CREATE PROCEDURE LA_SELECTION.migrar_sillones
AS
    BEGIN
        INSERT INTO LA_SELECTION.Sillon (Sillon_Codigo, Sillon_Modelo_id, Sillon_Medida_id, Tela_id, Madera_id, Relleno_id)
        SELECT
			aux.Sillon_Codigo,
			sm.Sillon_Modelo_id,
			medida.Sillon_Medida_id,
			t.Tela_id,
			ma.Madera_id,
			r.Relleno_id
		FROM
		(SELECT
            -- Usamos los MAX para asegurar que devuelve un solo valor para cada columna
			m.Sillon_Codigo,
			MAX(m.Sillon_Modelo_Codigo) AS Sillon_Modelo_Codigo,
			MAX(m.Sillon_Medida_Alto) AS Alto,
			MAX(m.Sillon_Medida_Ancho) AS Ancho,
			MAX(m.Sillon_Medida_Profundidad) AS Profundidad,
			MAX(CASE WHEN m.Material_Tipo = 'Tela' THEN m.Material_Nombre END) AS Tela_Material,
			MAX(CASE WHEN m.Material_Tipo = 'Madera' THEN m.Material_Nombre END) AS Madera_Material,
			MAX(CASE WHEN m.Material_Tipo = 'Relleno' THEN m.Material_Nombre END) AS Relleno_Material
		FROM gd_esquema.Maestra m
		WHERE m.Sillon_Codigo IS NOT NULL
		GROUP BY m.Sillon_Codigo) AS aux
		LEFT JOIN LA_SELECTION.Material mat_t ON mat_t.Nombre = aux.Tela_Material
		LEFT JOIN LA_SELECTION.Material mat_m ON mat_m.Nombre = aux.Madera_Material
		LEFT JOIN LA_SELECTION.Material mat_r ON mat_r.Nombre = aux.Relleno_Material

		LEFT JOIN LA_SELECTION.Tela t ON t.Material_id = mat_t.Material_id
		LEFT JOIN LA_SELECTION.Madera ma ON ma.Material_id = mat_m.Material_id
		LEFT JOIN LA_SELECTION.Relleno r ON r.Material_id = mat_r.Material_id

		LEFT JOIN LA_SELECTION.Sillon_Modelo sm ON sm.Sillon_Modelo_Codigo = aux.Sillon_Modelo_Codigo

		LEFT JOIN LA_SELECTION.Sillon_Medida medida
		ON medida.Alto = aux.Alto AND medida.Ancho = aux.Ancho AND medida.Profundidad = aux.Profundidad

		WHERE sm.Sillon_Modelo_id IS NOT NULL
		AND medida.Sillon_Medida_id IS NOT NULL
		AND t.Tela_id IS NOT NULL
		AND ma.Madera_id IS NOT NULL
		AND r.Relleno_id IS NOT NULL
		AND NOT EXISTS ( SELECT 1 FROM LA_SELECTION.Sillon s WHERE s.Sillon_Codigo = aux.Sillon_Codigo )
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
			WHERE NOT EXISTS ( SELECT 1 FROM LA_SELECTION.Pedido p WHERE p.Pedido_Numero = maestra.Pedido_Numero )
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
			WHERE NOT EXISTS ( SELECT 1 FROM LA_SELECTION.DetallePedido dp WHERE dp.Pedido_id = pedido.Pedido_id AND dp.Sillon_id = sillon.Sillon_id )
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
		WHERE Pedido_Cancelacion_Fecha IS NOT NULL AND Pedido_Cancelacion_Motivo IS NOT NULL
		AND NOT EXISTS ( SELECT 1 FROM LA_SELECTION.CancelacionPedido cp WHERE cp.Pedido_id = pedido.Pedido_id )
    END
GO


CREATE PROCEDURE LA_SELECTION.migrar_facturas
AS
    BEGIN
        INSERT INTO LA_SELECTION.Factura (Factura_Numero, Fecha, Total, Cliente_id, Sucursal_id)
        SELECT DISTINCT maestra.Factura_Numero, maestra.Factura_Fecha, maestra.Factura_Total, cliente.Cliente_id, sucursal.Sucursal_id
        FROM
            gd_esquema.Maestra maestra
            JOIN LA_SELECTION.Cliente cliente ON (maestra.Cliente_Dni = cliente.DNI)
            JOIN LA_SELECTION.Sucursal sucursal ON (maestra.Sucursal_NroSucursal = sucursal.NroSucursal)
			WHERE maestra.Factura_Numero IS NOT NULL
			AND NOT EXISTS ( SELECT 1 FROM LA_SELECTION.Factura f  WHERE f.Factura_Numero = maestra.Factura_Numero )
    END
GO


CREATE PROCEDURE LA_SELECTION.migrar_detalles_facturas
AS
BEGIN
    INSERT INTO LA_SELECTION.DetalleFactura (DetallePedido_id, Factura_id, Precio, Cantidad, SubTotal)
	SELECT dp.DetallePedido_id, f.Factura_id, m.Detalle_Factura_Precio, m.Detalle_Factura_Cantidad, m.Detalle_Factura_SubTotal
	FROM gd_esquema.Maestra m
	JOIN LA_SELECTION.Factura f ON m.Factura_Numero = f.Factura_Numero
	JOIN LA_SELECTION.Pedido p ON m.Pedido_Numero = p.Pedido_Numero
	JOIN LA_SELECTION.DetallePedido dp 
		ON dp.Pedido_id = p.Pedido_id 
		AND dp.Precio = m.Detalle_Factura_Precio
		AND dp.Cantidad = m.Detalle_Factura_Cantidad
		AND dp.SubTotal = m.Detalle_Factura_SubTotal
	WHERE m.Detalle_Factura_Precio IS NOT NULL AND m.Detalle_Factura_Cantidad IS NOT NULL AND m.Detalle_Factura_SubTotal IS NOT NULL
		AND NOT EXISTS ( SELECT 1 FROM LA_SELECTION.DetalleFactura dfact WHERE dfact.DetallePedido_id = dp.DetallePedido_id AND dfact.Factura_id = f.Factura_id )
END
GO

CREATE PROCEDURE LA_SELECTION.migrar_envios
AS
    BEGIN
        INSERT INTO LA_SELECTION.Envio (Envio_Numero, Fecha_Programada, Fecha, ImporteTraslado, ImporteSubida, Total, Factura_id)
        SELECT DISTINCT maestra.Envio_Numero, maestra.Envio_Fecha_Programada, maestra.Envio_Fecha,  maestra.Envio_ImporteTraslado,  maestra.Envio_importeSubida, maestra.Envio_Total, factura.Factura_id
        FROM
            gd_esquema.Maestra maestra
            JOIN LA_SELECTION.Factura factura ON (maestra.Factura_Numero = factura.Factura_Numero)
			WHERE maestra.Envio_Numero IS NOT NULL AND maestra.Envio_Fecha_Programada IS NOT NULL AND maestra.Envio_Total IS NOT NULL
			AND NOT EXISTS ( SELECT 1 FROM LA_SELECTION.Envio e WHERE e.Envio_Numero = maestra.Envio_Numero AND e.Factura_id = factura.Factura_id )
    END
GO


CREATE PROCEDURE LA_SELECTION.migrar_proveedores
AS
    BEGIN
        INSERT INTO LA_SELECTION.Proveedor (Cuit, Localidad_id, Razon_Social, Direccion, Telefono, Mail)
        SELECT DISTINCT m.Proveedor_Cuit, l.Localidad_id, m.Proveedor_RazonSocial, m.Proveedor_Direccion, m.Proveedor_Telefono, m.Proveedor_Mail
        FROM gd_esquema.Maestra m
		JOIN LA_SELECTION.Provincia p ON m.Proveedor_Provincia = p.Nombre
		JOIN LA_SELECTION.Localidad l ON m.Proveedor_Localidad = l.Nombre AND l.Provincia_id = p.Provincia_id
		WHERE NOT EXISTS ( SELECT 1 FROM LA_SELECTION.Proveedor prov WHERE prov.Cuit = m.Proveedor_Cuit )
    END 
GO


CREATE PROCEDURE LA_SELECTION.migrar_compras
AS
    BEGIN
        INSERT INTO LA_SELECTION.Compra (Compra_Numero, Compra_Fecha, Sucursal_id, Compra_Total, Proveedor_id)
        SELECT DISTINCT maestra.Compra_Numero, maestra.Compra_Fecha, sucursal.Sucursal_id, maestra.Compra_Total, proveedor.Proveedor_id
        FROM
            gd_esquema.Maestra maestra
            JOIN LA_SELECTION.Sucursal sucursal ON (maestra.Sucursal_NroSucursal = sucursal.NroSucursal)
            JOIN LA_SELECTION.Proveedor proveedor ON (maestra.Proveedor_Cuit = proveedor.CUIT)
			WHERE NOT EXISTS ( SELECT 1 FROM LA_SELECTION.Compra c WHERE c.Compra_Numero = maestra.Compra_Numero AND c.Sucursal_id = sucursal.Sucursal_id )
    END
GO


CREATE PROCEDURE LA_SELECTION.migrar_detalles_compras
AS
    BEGIN
        INSERT INTO LA_SELECTION.Detalle_Compra (Material_id, Compra_id, Precio, Cantidad, SubTotal)
        SELECT material.Material_id, compra.Compra_id, maestra.Detalle_Compra_Precio, maestra.Detalle_Compra_Cantidad, maestra.Detalle_Compra_SubTotal
        FROM
            gd_esquema.Maestra maestra
			JOIN LA_SELECTION.TipoMaterial tm ON maestra.Material_Tipo = tm.Nombre
            JOIN LA_SELECTION.Material material ON maestra.Material_Nombre = material.Nombre AND material.TipoMaterial_id = tm.TipoMaterial_id
            JOIN LA_SELECTION.Compra compra ON maestra.Compra_Numero = compra.Compra_Numero
		WHERE maestra.Detalle_Compra_Precio IS NOT NULL
			AND maestra.Detalle_Compra_Cantidad IS NOT NULL
			AND maestra.Detalle_Compra_SubTotal IS NOT NULL
			AND NOT EXISTS (
					SELECT 1 FROM LA_SELECTION.Detalle_Compra dc
					WHERE dc.Compra_id = compra.Compra_id AND dc.Material_id = material.Material_id
					AND dc.Precio = maestra.Detalle_Compra_Precio
					AND dc.Cantidad = maestra.Detalle_Compra_Cantidad
					AND dc.SubTotal = maestra.Detalle_Compra_SubTotal
			)
    END
GO




-- Migración de datos
BEGIN TRANSACTION
 BEGIN TRY
	EXECUTE LA_SELECTION.migrar_provincias
    EXECUTE LA_SELECTION.migrar_localidades
    EXECUTE LA_SELECTION.migrar_clientes
    EXECUTE LA_SELECTION.migrar_sucursales  
    EXECUTE LA_SELECTION.migrar_estadosPedidos
    EXECUTE LA_SELECTION.migrar_tipoMateriales
    EXECUTE LA_SELECTION.migrar_materiales
    EXECUTE LA_SELECTION.migrar_telas
    EXECUTE LA_SELECTION.migrar_maderas
    EXECUTE LA_SELECTION.migrar_rellenos
    EXECUTE LA_SELECTION.migrar_sillones_modelos
    EXECUTE LA_SELECTION.migrar_sillones_medidas
    EXECUTE LA_SELECTION.migrar_proveedores
    EXECUTE LA_SELECTION.migrar_sillones
    EXECUTE LA_SELECTION.migrar_pedidos
    EXECUTE LA_SELECTION.migrar_compras
    EXECUTE LA_SELECTION.migrar_detalles_pedidos
    EXECUTE LA_SELECTION.migrar_cancelaciones_pedidos
    EXECUTE LA_SELECTION.migrar_facturas
    EXECUTE LA_SELECTION.migrar_detalles_facturas
    EXECUTE LA_SELECTION.migrar_envios
    EXECUTE LA_SELECTION.migrar_detalles_compras
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
	THROW 50001, 'Hubo un error en la transferencia de datos.',1;
END CATCH
    --ajustar esto a ls correspondientes tablas
   IF (EXISTS (SELECT 1 FROM LA_SELECTION.Provincia)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Localidad)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Cliente)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Sucursal)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.EstadoPedido)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.TipoMaterial)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Material)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Tela)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Madera)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Relleno)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Sillon_Modelo)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Sillon_Medida)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Proveedor)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Sillon)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Pedido)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Compra)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.DetallePedido)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.CancelacionPedido)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Factura)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.DetalleFactura)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Envio)
   AND EXISTS (SELECT 1 FROM LA_SELECTION.Detalle_Compra))
   BEGIN
	PRINT 'Tablas y datos transferidos correctamente.';
	COMMIT TRANSACTION;
   END
	 ELSE
   BEGIN
    ROLLBACK TRANSACTION;
	THROW 50002, 'Hubo un error al transferir una o más tablas. Todos los cambios fueron revertidos.',1;
   END
   
GO
