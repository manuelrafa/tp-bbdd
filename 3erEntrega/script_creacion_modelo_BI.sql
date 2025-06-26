USE GD1C2025
GO

----------Creación de las Tablas------------------------------------------------------------------------------------

--Dimensiones

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_DIM_Estado_Pedido')
CREATE TABLE LA_SELECTION.BI_DIM_Estado_Pedido (
    DIM_Estado_Pedido_id INT IDENTITY(1,1) PRIMARY KEY,
    Estado_pedido NVARCHAR(255)
);

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_DIM_Turno_Ventas')
CREATE TABLE LA_SELECTION.BI_DIM_Turno_Ventas (
    DIM_Turno_Ventas_id INT IDENTITY(1,1) PRIMARY KEY,
    Turno NVARCHAR(255),
    Hora_desde TIME,
    Hora_hasta TIME
);

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_DIM_Tiempo')
CREATE TABLE LA_SELECTION.BI_DIM_Tiempo (
    DIM_Tiempo_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Anio INT,
    Cuatrimestre INT,
    Mes INT
);

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_DIM_Rango_Etario_Cliente')
CREATE TABLE LA_SELECTION.BI_DIM_Rango_Etario_Cliente (
    DIM_Rango_Etario_Cliente_id INT IDENTITY(1,1) PRIMARY KEY,
    Rango_etario NVARCHAR(20),
    Edad_desde INT,
    Edad_hasta INT
);

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_DIM_Sucursal')
CREATE TABLE LA_SELECTION.BI_DIM_Sucursal (
    DIM_Sucursal_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Numero_sucursal BIGINT
);

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_DIM_Tipo_Material')
CREATE TABLE LA_SELECTION.BI_DIM_Tipo_Material (
    DIM_Tipo_Material_id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255)
);

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_DIM_Ubicacion')
CREATE TABLE LA_SELECTION.BI_DIM_Ubicacion (
    DIM_Ubicacion_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Provincia NVARCHAR(255),
    Localidad NVARCHAR(255)
);

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
               WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_DIM_Modelo_Sillon')
CREATE TABLE LA_SELECTION.BI_DIM_Modelo_Sillon (
    DIM_Modelo_Sillon_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Codigo BIGINT,
    Nombre NVARCHAR(255),
    Descripcion NVARCHAR(255),
    Precio DECIMAL(18, 2)
);

--Hechos

IF NOT EXISTS (
  SELECT * FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_HECHO_Pedido'
)
CREATE TABLE LA_SELECTION.BI_HECHO_Pedido (
    DIM_Tiempo_id BIGINT,
    DIM_Turno_Ventas_id INT,
    DIM_Sucursal_id BIGINT,
    DIM_Estado_Pedido_id INT,
    Cantidad_pedidos INT,
    Porcentaje_segun_estado DECIMAL(5,2),
    PRIMARY KEY (DIM_Tiempo_id, DIM_Turno_Ventas_id, DIM_Sucursal_id, DIM_Estado_Pedido_id),
    FOREIGN KEY (DIM_Tiempo_id) REFERENCES LA_SELECTION.BI_DIM_Tiempo(DIM_Tiempo_id),
    FOREIGN KEY (DIM_Turno_Ventas_id) REFERENCES LA_SELECTION.BI_DIM_Turno_Ventas(DIM_Turno_Ventas_id),
    FOREIGN KEY (DIM_Sucursal_id) REFERENCES LA_SELECTION.BI_DIM_Sucursal(DIM_Sucursal_id),
    FOREIGN KEY (DIM_Estado_Pedido_id) REFERENCES LA_SELECTION.BI_DIM_Estado_Pedido(DIM_Estado_Pedido_id)
);

IF NOT EXISTS (
  SELECT * FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_HECHO_Compra'
)
CREATE TABLE LA_SELECTION.BI_HECHO_Compra (
    DIM_Tiempo_id BIGINT,
    DIM_Sucursal_id BIGINT,
    DIM_Tipo_Material_id INT,
    Costo_total DECIMAL(18,2),
    Promedio_Costo DECIMAL(18,2),
    PRIMARY KEY (DIM_Tiempo_id, DIM_Sucursal_id, DIM_Tipo_Material_id),
    FOREIGN KEY (DIM_Tiempo_id) REFERENCES LA_SELECTION.BI_DIM_Tiempo(DIM_Tiempo_id),
    FOREIGN KEY (DIM_Sucursal_id) REFERENCES LA_SELECTION.BI_DIM_Sucursal(DIM_Sucursal_id),
    FOREIGN KEY (DIM_Tipo_Material_id) REFERENCES LA_SELECTION.BI_DIM_Tipo_Material(DIM_Tipo_Material_id)
);

IF NOT EXISTS (
  SELECT * FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_HECHO_Envio'
)
CREATE TABLE LA_SELECTION.BI_HECHO_Envio (
    DIM_Tiempo_id BIGINT,
    DIM_Ubicacion_id BIGINT,
    Promedio_Costo decimal(18,2),
    Porcentaje_entregados_en_tiempo decimal(5,2),
    PRIMARY KEY (DIM_Tiempo_id, DIM_Ubicacion_id),
    FOREIGN KEY (DIM_Tiempo_id) REFERENCES LA_SELECTION.BI_DIM_Tiempo(DIM_Tiempo_id),
    FOREIGN KEY (DIM_Ubicacion_id) REFERENCES LA_SELECTION.BI_DIM_Ubicacion(DIM_Ubicacion_id)
);

IF NOT EXISTS (
  SELECT * FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_HECHO_Venta'
)
CREATE TABLE LA_SELECTION.BI_HECHO_Venta (
    DIM_Tiempo_id BIGINT,
    DIM_Sucursal_id BIGINT,
    DIM_Ubicacion_id BIGINT,
    DIM_Rango_etario_cliente_id INT,
    DIM_Modelo_Sillon_id BIGINT,
    Importe_total DECIMAL(38,2),
    Cantidad_ventas INT,
    Promedio_importe decimal(38,2),
    Promedio_horas_fabricacion decimal(18,2),
    PRIMARY KEY (DIM_Tiempo_id, DIM_Sucursal_id, DIM_Rango_etario_cliente_id, DIM_Modelo_Sillon_id, DIM_Ubicacion_id),
    FOREIGN KEY (DIM_Tiempo_id) REFERENCES LA_SELECTION.BI_DIM_Tiempo(DIM_Tiempo_id),
    FOREIGN KEY (DIM_Sucursal_id) REFERENCES LA_SELECTION.BI_DIM_Sucursal(DIM_Sucursal_id),
    FOREIGN KEY (DIM_Rango_etario_cliente_id) REFERENCES LA_SELECTION.BI_DIM_Rango_Etario_Cliente(DIM_Rango_Etario_Cliente_id),
    FOREIGN KEY (DIM_Modelo_Sillon_id) REFERENCES LA_SELECTION.BI_DIM_Modelo_Sillon(DIM_Modelo_Sillon_id),
    FOREIGN KEY (DIM_Ubicacion_id) REFERENCES LA_SELECTION.BI_DIM_Ubicacion(DIM_Ubicacion_id)
);

----------Migracion de Datos------------------------------------------------------------------------------------

--Dimensiones
GO
CREATE PROCEDURE LA_SELECTION.migrar_BI_Estados_Pedido
AS
BEGIN
    INSERT INTO LA_SELECTION.BI_DIM_Estado_Pedido (Estado_pedido)
    SELECT DISTINCT Nombre
    FROM LA_SELECTION.EstadoPedido;
END
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_Turnos_Ventas
AS
BEGIN
    INSERT INTO LA_SELECTION.BI_DIM_Turno_Ventas (Turno, Hora_desde, Hora_hasta)
    VALUES 
        ('turno_mañana', '08:00:00', '14:00:00'),
        ('turno_tarde', '14:00:00', '20:00:00');
END
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_Tiempos
AS
BEGIN
    INSERT INTO LA_SELECTION.BI_DIM_Tiempo (Anio, Cuatrimestre, Mes)
    SELECT DISTINCT * 
    FROM
    (
        SELECT DISTINCT YEAR(Fecha) Anio, CEILING(MONTH(Fecha) / 4.0) AS Cuatrimestre, MONTH(Fecha) Mes
        FROM
            LA_SELECTION.Envio

        UNION
        
        SELECT DISTINCT YEAR(Fecha_Programada) Anio, CEILING(MONTH(Fecha_Programada) / 4.0) AS Cuatrimestre, MONTH(Fecha_Programada) Mes
        FROM 
            LA_SELECTION.Envio

        UNION

        SELECT DISTINCT YEAR(Fecha) Anio, CEILING(MONTH(Fecha) / 4.0) AS Cuatrimestre, MONTH(Fecha) Mes
        FROM 
            LA_SELECTION.Factura

        UNION

        SELECT DISTINCT YEAR(FechaNacimiento) Anio, CEILING(MONTH(FechaNacimiento) / 4.0) AS Cuatrimestre, MONTH(FechaNacimiento) Mes
        FROM 
            LA_SELECTION.Cliente

        UNION

        SELECT DISTINCT YEAR(Fecha) Anio, CEILING(MONTH(Fecha) / 4.0) AS Cuatrimestre, MONTH(Fecha) Mes
        FROM 
            LA_SELECTION.Pedido

        UNION

        SELECT DISTINCT YEAR(Fecha) Anio, CEILING(MONTH(Fecha) / 4.0) AS Cuatrimestre, MONTH(Fecha) Mes
        FROM
            LA_SELECTION.CancelacionPedido
    ) AS fechas_unificadas
	ORDER BY Anio, Mes
END
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_Rango_etario_cliente
AS
BEGIN
    INSERT INTO LA_SELECTION.BI_DIM_Rango_Etario_Cliente (Rango_etario, Edad_desde, Edad_hasta)
    VALUES -- (min, max]
        ('< 25', 0, 25),
        ('25 - 35', 25, 35),
        ('35 - 50', 35, 50),
        ('> 50', 50, 1000)
END 
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_Sucursal
AS
BEGIN
    INSERT INTO LA_SELECTION.BI_DIM_Sucursal (Numero_sucursal)
    SELECT DISTINCT NroSucursal
    FROM LA_SELECTION.Sucursal;
END 
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_Tipo_Material
AS
BEGIN
    INSERT INTO LA_SELECTION.BI_DIM_Tipo_Material (Nombre)
    SELECT DISTINCT Nombre
    FROM LA_SELECTION.TipoMaterial;
END 
GO


CREATE PROCEDURE LA_SELECTION.migrar_BI_Ubicacion
AS
BEGIN
    INSERT INTO LA_SELECTION.BI_DIM_Ubicacion (Provincia, Localidad)
    SELECT DISTINCT p.Nombre, l.Nombre
    FROM LA_SELECTION.Provincia p JOIN LA_SELECTION.Localidad l 
    ON p.Provincia_id = l.Provincia_id
END 
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_Modelo_Sillon
AS
BEGIN
    INSERT INTO LA_SELECTION.BI_DIM_Modelo_Sillon (Codigo, Nombre, Descripcion, Precio)
    SELECT DISTINCT Codigo, Nombre, Descripcion, Precio
    FROM LA_SELECTION.Sillon_Modelo;
END
GO

--Hechos

CREATE PROCEDURE LA_SELECTION.migrar_BI_Hecho_Pedidos
AS
BEGIN
    INSERT INTO LA_SELECTION.BI_Hecho_Pedido (DIM_Tiempo_id, DIM_Turno_Ventas_id, DIM_Sucursal_id, DIM_Estado_Pedido_id, Cantidad_pedidos, Porcentaje_segun_estado)
    SELECT
    FROM 
END
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_HECHO_Compra
AS 
BEGIN
    INSERT INTO LA_SELECTION.BI_Hecho_Compra (DIM_Tiempo_id, DIM_Sucursal_id, DIM_Tipo_Material_id,
    Costo_total, Promedio_costo)
    SELECT
    FROM
END 
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_HECHO_Envio
AS 
BEGIN
    INSERT INTO LA_SELECTION.BI_Hecho_Envio (DIM_Tiempo_id, DIM_Ubicacion_id, Promedio_Costo,
    Porcentaje_entregados_en_tiempo)
    SELECT
    FROM
END 
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_HECHO_Venta
AS 
BEGIN
    INSERT INTO LA_SELECTION.BI_Hecho_Venta (DIM_Tiempo_id, DIM_Sucursal_id, DIM_Ubicacion_id, DIM_Rango_Etario_Cliente_id, DIM_Modelo_Sillon_id, Importe_total, Cantidad_ventas,
    Promedio_importe, Promedio_horas_fabricacion)
    SELECT
    FROM
END 
GO

----------Creación de Vistas------------------------------------------------------------------------------------

CREATE VIEW LA_SELECTION.BI_VIEW_Ganancias AS
    SELECT ds.Numero_sucursal Sucursal, dt.Anio "Año", dt.Mes Mes, (SUM(hv.Importe_total) - SUM(hc.Costo_total)) Ganancias
    FROM LA_SELECTION.BI_HECHO_Venta hv
    JOIN LA_SELECTION.BI_HECHO_Compra hc ON hv.DIM_Sucursal_id = hc.DIM_Sucursal_id
    JOIN LA_SELECTION.BI_DIM_Tiempo dt ON hv.DIM_Tiempo_id = dt.DIM_Tiempo_id
    JOIN LA_SELECTION.BI_DIM_Sucursal ds ON hv.DIM_Sucursal_id = ds.DIM_Sucursal_id
    GROUP BY ds.Numero_sucursal, dt.Anio, Mes

GO

CREATE VIEW LA_SELECTION.BI_VIEW_Factura_promedio_mensual AS
    SELECT du.Provincia Provincia, dt.Cuatrimestre Cuatrimestre, hv.Promedio_importe [Promedio mensual]
    FROM LA_SELECTION.BI_HECHO_Venta hv
    JOIN LA_SELECTION.BI_DIM_Ubicacion du ON hv.DIM_Ubicacion_id = du.DIM_Ubicacion_id
    JOIN LA_SELECTION.BI_DIM_Tiempo dt ON hv.DIM_Tiempo_id = dt.DIM_Tiempo_id
    GROUP BY Provincia, Cuatrimestre

GO