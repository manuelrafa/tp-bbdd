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
    Cantidad_compras int,
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
    Total_costo decimal(18,2),
    Cantidad_entregas int,
    Cantidad_entregas_a_tiempo int,
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
    Total_horas_fabricacion INT,
    PRIMARY KEY (DIM_Tiempo_id, DIM_Sucursal_id, DIM_Rango_etario_cliente_id, DIM_Modelo_Sillon_id, DIM_Ubicacion_id),
    FOREIGN KEY (DIM_Tiempo_id) REFERENCES LA_SELECTION.BI_DIM_Tiempo(DIM_Tiempo_id),
    FOREIGN KEY (DIM_Sucursal_id) REFERENCES LA_SELECTION.BI_DIM_Sucursal(DIM_Sucursal_id),
    FOREIGN KEY (DIM_Rango_etario_cliente_id) REFERENCES LA_SELECTION.BI_DIM_Rango_Etario_Cliente(DIM_Rango_Etario_Cliente_id),
    FOREIGN KEY (DIM_Modelo_Sillon_id) REFERENCES LA_SELECTION.BI_DIM_Modelo_Sillon(DIM_Modelo_Sillon_id),
    FOREIGN KEY (DIM_Ubicacion_id) REFERENCES LA_SELECTION.BI_DIM_Ubicacion(DIM_Ubicacion_id)
);

GO

----------Funciones --------------------------------------------------------------------------------------------

CREATE FUNCTION LA_SELECTION.fn_obtener_nombre_turno_ventas (@fecha DATETIME2)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @hora TIME = CAST(@fecha AS TIME);
    DECLARE @turno NVARCHAR(50);

    IF @hora >= '08:00:00' AND @hora < '14:00:00'
        SET @turno = 'turno_mañana';
    ELSE IF @hora >= '14:00:00' AND @hora <= '20:00:00'
        SET @turno = 'turno_tarde';
    ELSE
        SET @turno = NULL; -- Fuera de turno

    RETURN @turno;
END

GO

CREATE FUNCTION LA_SELECTION.fn_calcular_edad_respecto_a (@fecha_nacimiento DATETIME2, @fecha_referencia DATETIME2)
RETURNS INT
AS
BEGIN
    DECLARE @edad INT;

    SET @edad = DATEDIFF(YEAR, @fecha_nacimiento, @fecha_referencia);

    IF DATEADD(YEAR, @edad, @fecha_nacimiento) > CAST(@fecha_referencia AS DATE)
        SET @edad = @edad - 1;

    RETURN @edad;
END

GO

CREATE FUNCTION LA_SELECTION.fn_rango_etario(@edad INT)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @rango NVARCHAR(20);

    IF @edad < 25
        SET @rango = '< 25';
    ELSE IF @edad < 35
        SET @rango = '25 - 35';
    ELSE IF @edad <= 50
        SET @rango = '35 - 50';
    ELSE
        SET @rango = '> 50';

    RETURN @rango;
END

GO

----------Migracion de Datos------------------------------------------------------------------------------------

--Dimensiones

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
    SELECT DISTINCT Sillon_Modelo_Codigo, Nombre, Descripcion, Precio
    FROM LA_SELECTION.Sillon_Modelo;
END
GO

--Hechos

CREATE PROCEDURE LA_SELECTION.migrar_BI_HECHO_Pedidos
AS
BEGIN
    INSERT INTO LA_SELECTION.BI_Hecho_Pedido (DIM_Tiempo_id, DIM_Turno_Ventas_id, DIM_Sucursal_id, DIM_Estado_Pedido_id, Cantidad_pedidos)
    SELECT
        dt.DIM_Tiempo_id,
        dtv.DIM_Turno_Ventas_id,
        ds.DIM_Sucursal_id,
        dep.DIM_Estado_Pedido_id, 
        COUNT(DISTINCT p.Pedido_id)
    FROM LA_SELECTION.Pedido p
	JOIN LA_SELECTION.BI_DIM_Tiempo dt ON YEAR(p.Fecha) = dt.Anio AND MONTH(p.Fecha) = dt.Mes
	JOIN LA_SELECTION.BI_DIM_Turno_Ventas dtv ON LA_SELECTION.fn_obtener_nombre_turno_ventas(p.Fecha) = dtv.Turno
    JOIN LA_SELECTION.Sucursal s ON p.Sucursal_id = s.Sucursal_id
    JOIN LA_SELECTION.BI_DIM_Sucursal ds ON s.NroSucursal = ds.Numero_sucursal
    JOIN LA_SELECTION.EstadoPedido ep ON p.EstadoPedido_id = ep.EstadoPedido_id
    JOIN LA_SELECTION.BI_DIM_Estado_Pedido dep ON ep.Nombre = dep.Estado_pedido
	WHERE NOT EXISTS (
        SELECT 1
        FROM LA_SELECTION.BI_Hecho_Pedido h
        WHERE h.DIM_Tiempo_id = dt.DIM_Tiempo_id
          AND h.DIM_Turno_Ventas_id = dtv.DIM_Turno_Ventas_id
          AND h.DIM_Sucursal_id = ds.DIM_Sucursal_id
          AND h.DIM_Estado_Pedido_id = dep.DIM_Estado_Pedido_id
    )
	GROUP BY dt.DIM_Tiempo_id, dtv.DIM_Turno_Ventas_id, ds.DIM_Sucursal_id, dep.DIM_Estado_Pedido_id
END
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_HECHO_Compra
AS 
BEGIN
    INSERT INTO LA_SELECTION.BI_Hecho_Compra (DIM_Tiempo_id, DIM_Sucursal_id, DIM_Tipo_Material_id, Costo_total, Cantidad_compras)
    SELECT
		dt.DIM_Tiempo_id,
		ds.DIM_Sucursal_id,
		dtm.DIM_Tipo_Material_id,
		SUM(det_c.SubTotal),
		COUNT(DISTINCT c.Compra_id)
    FROM LA_SELECTION.Detalle_Compra det_c
	JOIN LA_SELECTION.Compra c ON det_c.Compra_id = c.Compra_id
	JOIN LA_SELECTION.BI_DIM_Tiempo dt ON dt.Anio = YEAR(c.Compra_Fecha) AND dt.Mes = MONTH(c.Compra_Fecha)
	JOIN LA_SELECTION.Sucursal s ON c.Sucursal_id = s.Sucursal_id
	JOIN LA_SELECTION.BI_DIM_Sucursal ds ON s.NroSucursal = ds.Numero_sucursal
	JOIN LA_SELECTION.Material m ON det_c.Material_id = m.Material_id
	JOIN LA_SELECTION.TipoMaterial tm ON m.TipoMaterial_id = tm.TipoMaterial_id
	JOIN LA_SELECTION.BI_DIM_Tipo_Material dtm ON tm.Nombre = dtm.Nombre
	WHERE NOT EXISTS (
    SELECT 1
    FROM LA_SELECTION.BI_Hecho_Compra h
    WHERE h.DIM_Tiempo_id = dt.DIM_Tiempo_id
      AND h.DIM_Sucursal_id = ds.DIM_Sucursal_id
      AND h.DIM_Tipo_Material_id = dtm.DIM_Tipo_Material_id
	)
    GROUP BY dt.DIM_Tiempo_id, ds.DIM_Sucursal_id, dtm.DIM_Tipo_Material_id
END 
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_HECHO_Envio
AS 
BEGIN
    INSERT INTO LA_SELECTION.BI_Hecho_Envio (DIM_Tiempo_id, DIM_Ubicacion_id, Total_costo, Cantidad_entregas, Cantidad_entregas_a_tiempo)
	SELECT
		dt.DIM_Tiempo_id,
		du.DIM_Ubicacion_id,
		SUM(e.Total) Total_costo,
		COUNT(*) Cantidad_entregas,
		SUM(CASE WHEN e.Fecha <= e.Fecha_Programada THEN 1 ELSE 0 END) Cantidad_entregas_a_tiempo
	FROM LA_SELECTION.Envio e
	JOIN LA_SELECTION.BI_DIM_Tiempo dt ON dt.Anio = YEAR(e.Fecha) AND dt.Mes = MONTH(e.Fecha)
	JOIN LA_SELECTION.Factura f ON e.Factura_id = f.Factura_id
	JOIN LA_SELECTION.Cliente c ON f.Cliente_id = c.Cliente_id
	JOIN LA_SELECTION.Localidad l ON c.Localidad_id = l.Localidad_id
	JOIN LA_SELECTION.Provincia p ON l.Provincia_id = p.Provincia_id
	JOIN LA_SELECTION.BI_DIM_Ubicacion du ON du.Localidad = l.Nombre AND du.Provincia = p.Nombre
	GROUP BY dt.DIM_Tiempo_id, du.DIM_Ubicacion_id
    HAVING NOT EXISTS (
        SELECT 1 
        FROM LA_SELECTION.BI_Hecho_Envio b
        WHERE b.DIM_Tiempo_id = dt.DIM_Tiempo_id
          AND b.DIM_Ubicacion_id = du.DIM_Ubicacion_id
    )
END
GO

CREATE PROCEDURE LA_SELECTION.migrar_BI_HECHO_Venta
AS 
BEGIN
	WITH PedidoPorFactura AS (
		SELECT
			f.Factura_id,
			MIN(pe.Fecha) AS FechaPedido
		FROM LA_SELECTION.Factura f
		JOIN LA_SELECTION.DetalleFactura detf ON detf.Factura_id = f.Factura_id
		JOIN LA_SELECTION.DetallePedido detp ON detp.DetallePedido_id = detf.DetallePedido_id
		JOIN LA_SELECTION.Pedido pe ON pe.Pedido_id = detp.Pedido_id
		GROUP BY f.Factura_id
	),
	HorasPorFactura AS (
		SELECT
			f.Factura_id,
			DATEDIFF(HOUR, ppf.FechaPedido, f.Fecha) AS HorasFabricacion
		FROM LA_SELECTION.Factura f
		JOIN PedidoPorFactura ppf ON ppf.Factura_id = f.Factura_id
	)
    INSERT INTO LA_SELECTION.BI_HECHO_Venta (DIM_Tiempo_id, DIM_Sucursal_id, DIM_Ubicacion_id, DIM_Rango_Etario_Cliente_id, DIM_Modelo_Sillon_id, Importe_total, Cantidad_ventas, Total_horas_fabricacion)
    SELECT
		dt.DIM_Tiempo_id,
		ds.DIM_Sucursal_id,
		du.DIM_Ubicacion_id,
		drec.DIM_Rango_Etario_Cliente_id,
		dms.DIM_Modelo_Sillon_id,
		SUM(detf.SubTotal),
		COUNT(DISTINCT f.Factura_id),
		SUM(hpf.HorasFabricacion)
    FROM LA_SELECTION.Factura f 
	JOIN HorasPorFactura hpf ON hpf.Factura_id = f.Factura_id
    JOIN LA_SELECTION.BI_DIM_Tiempo dt ON dt.Anio = YEAR(f.Fecha) AND dt.Mes = MONTH(f.Fecha)
    JOIN LA_SELECTION.Sucursal s ON f.Sucursal_id = s.Sucursal_id
	JOIN LA_SELECTION.BI_DIM_Sucursal ds ON s.NroSucursal = ds.Numero_sucursal
    JOIN LA_SELECTION.Localidad l ON s.Localidad_id = l.Localidad_id
    JOIN LA_SELECTION.Provincia p ON l.Provincia_id = p.Provincia_id
    JOIN LA_SELECTION.BI_DIM_Ubicacion du ON du.Localidad = l.Nombre AND du.Provincia = p.Nombre
	JOIN LA_SELECTION.Cliente c ON f.Cliente_id = c.Cliente_id
	JOIN LA_SELECTION.BI_DIM_Rango_Etario_Cliente drec
		ON LA_SELECTION.fn_rango_etario(LA_SELECTION.fn_calcular_edad_respecto_a(c.FechaNacimiento, f.Fecha)) = drec.Rango_etario
	JOIN LA_SELECTION.DetalleFactura detf ON f.Factura_id = detf.Factura_id
	JOIN LA_SELECTION.DetallePedido detp ON detf.DetallePedido_id = detp.DetallePedido_id
	JOIN LA_SELECTION.Sillon si ON detp.Sillon_id = si.Sillon_id
	JOIN LA_SELECTION.Sillon_Modelo sm ON si.Sillon_Modelo_id = sm.Sillon_Modelo_id
	JOIN LA_SELECTION.BI_DIM_Modelo_Sillon dms ON sm.Sillon_Modelo_Codigo = dms.Codigo
	JOIN LA_SELECTION.Pedido pe ON detp.Pedido_id = pe.Pedido_id
	WHERE NOT EXISTS (
    SELECT 1
    FROM LA_SELECTION.BI_HECHO_Venta b
    WHERE
        b.DIM_Tiempo_id = dt.DIM_Tiempo_id
        AND b.DIM_Sucursal_id = ds.DIM_Sucursal_id
        AND b.DIM_Ubicacion_id = du.DIM_Ubicacion_id
        AND b.DIM_Rango_Etario_Cliente_id = drec.DIM_Rango_Etario_Cliente_id
        AND b.DIM_Modelo_Sillon_id = dms.DIM_Modelo_Sillon_id
)
	GROUP BY dt.DIM_Tiempo_id, ds.DIM_Sucursal_id, du.DIM_Ubicacion_id, drec.DIM_Rango_Etario_Cliente_id, dms.DIM_Modelo_Sillon_id
END

GO

----------Creación de Vistas------------------------------------------------------------------------------------

CREATE VIEW LA_SELECTION.BI_VIEW_Ganancias AS --1
    SELECT ds.Numero_sucursal Sucursal, dt.Anio "Año", dt.Mes Mes, (SUM(hv.Importe_total) - SUM(hc.Costo_total)) Ganancias
    FROM LA_SELECTION.BI_HECHO_Venta hv
    JOIN LA_SELECTION.BI_HECHO_Compra hc ON hv.DIM_Sucursal_id = hc.DIM_Sucursal_id
    JOIN LA_SELECTION.BI_DIM_Tiempo dt ON hv.DIM_Tiempo_id = dt.DIM_Tiempo_id
    JOIN LA_SELECTION.BI_DIM_Sucursal ds ON hv.DIM_Sucursal_id = ds.DIM_Sucursal_id
    GROUP BY ds.Numero_sucursal, dt.Anio, Mes
GO

CREATE VIEW LA_SELECTION.BI_VIEW_Factura_promedio_mensual AS --2
    SELECT du.Provincia Provincia, dt.Anio "Año", dt.Cuatrimestre Cuatrimestre, CAST(SUM(hv.Importe_total) / 4 AS DECIMAL(38, 2)) [Promedio mensual]
    FROM LA_SELECTION.BI_HECHO_Venta hv
    JOIN LA_SELECTION.BI_DIM_Ubicacion du ON hv.DIM_Ubicacion_id = du.DIM_Ubicacion_id
    JOIN LA_SELECTION.BI_DIM_Tiempo dt ON hv.DIM_Tiempo_id = dt.DIM_Tiempo_id
    GROUP BY du.Provincia, dt.Anio, dt.Cuatrimestre
GO

CREATE VIEW LA_SELECTION.BI_VIEW_Rendimiento_de_modelos AS --3
WITH Modelos_Rankeados AS (
    SELECT 
        dt.Anio,
        dt.Cuatrimestre,
        du.Localidad,
        rec.Rango_etario,
        ms.Nombre AS Modelo,
        SUM(hv.Cantidad_Ventas) AS Total_Vendido,
        ROW_NUMBER() OVER (
            PARTITION BY dt.Anio, dt.Cuatrimestre, du.Localidad, rec.Rango_etario
            ORDER BY SUM(hv.Cantidad_Ventas) DESC
        ) AS Posicion
    FROM 
        LA_SELECTION.BI_HECHO_Venta hv
    JOIN LA_SELECTION.BI_DIM_Tiempo dt ON hv.DIM_Tiempo_id = dt.DIM_Tiempo_id
    JOIN LA_SELECTION.BI_DIM_Modelo_Sillon ms ON hv.DIM_Modelo_Sillon_id = ms.DIM_Modelo_Sillon_id
    JOIN LA_SELECTION.BI_DIM_Ubicacion du ON hv.DIM_Ubicacion_id = du.DIM_Ubicacion_id
    JOIN LA_SELECTION.BI_DIM_Rango_Etario_Cliente rec ON hv.DIM_Rango_Etario_Cliente_id = rec.DIM_Rango_Etario_Cliente_id
    GROUP BY 
        dt.Anio, dt.Cuatrimestre, du.Localidad, rec.Rango_etario, ms.Nombre
)
SELECT 
    Anio "Año",
    Cuatrimestre,
    Localidad,
    Rango_etario,
    Modelo,
    Total_Vendido
FROM Modelos_Rankeados
WHERE Posicion <= 3
GO
GO

CREATE VIEW LA_SELECTION.BI_VIEW_Volumen_de_Pedidos AS --4
SELECT 
    dt.Anio "Año",
    dt.Mes Mes,
    ds.Numero_sucursal Sucursal,
    dtv.Turno Turno,
    COUNT(*) AS Cantidad_Pedidos
FROM 
    LA_SELECTION.BI_HECHO_Pedido hp
	JOIN  LA_SELECTION.BI_DIM_Tiempo dt ON hp.DIM_Tiempo_id = dt.DIM_Tiempo_id
	JOIN  LA_SELECTION.BI_DIM_Sucursal ds ON hp.DIM_Sucursal_id = ds.DIM_Sucursal_id
	JOIN  LA_SELECTION.BI_DIM_Turno_Ventas dtv ON hp.DIM_Turno_Ventas_id = dtv.DIM_Turno_Ventas_id
	GROUP BY 
    dt.Anio, dt.Mes, ds.Numero_sucursal, dtv.Turno;
GO

CREATE VIEW LA_SELECTION.BI_VIEW_Conversion_de_pedidos AS --5
    SELECT dt.Anio "Año", dt.Cuatrimestre Cuatrimestre, ds.Numero_sucursal,
	(1.0 * COUNT(dep.Estado_pedido) / SUM(hp.Cantidad_pedidos)) "Porcentaje de Entregados"
    FROM LA_SELECTION.BI_HECHO_Pedido hp
    JOIN LA_SELECTION.BI_DIM_Estado_Pedido dep ON hp.DIM_Estado_pedido_id = dep.DIM_Estado_pedido_id
    JOIN LA_SELECTION.BI_DIM_TIEMPO dt ON hp.DIM_Tiempo_id = dt.DIM_Tiempo_id
    JOIN LA_SELECTION.BI_DIM_Sucursal ds ON hp.DIM_Sucursal_id = ds.DIM_Sucursal_id
    GROUP BY dt.Anio, dt.Cuatrimestre, ds.Numero_sucursal
GO

CREATE VIEW LA_SELECTION.BI_VIEW_Tiempo_promedio_de_fabricacion AS --6
SELECT 
    dt.Anio AS "Año",
    dt.Cuatrimestre,
    ds.Numero_sucursal AS Sucursal,
    CAST(AVG(1.0 * hv.Total_horas_fabricacion) AS DECIMAL(18,2)) AS Promedio_horas_fabricacion
FROM 
    LA_SELECTION.BI_HECHO_Venta hv
JOIN 
    LA_SELECTION.BI_DIM_Tiempo dt ON hv.DIM_Tiempo_id = dt.DIM_Tiempo_id
JOIN 
    LA_SELECTION.BI_DIM_Sucursal ds ON hv.DIM_Sucursal_id = ds.DIM_Sucursal_id
GROUP BY 
    dt.Anio, dt.Cuatrimestre, ds.Numero_sucursal;
GO

CREATE VIEW LA_SELECTION.BI_VIEW_Promedio_de_compras_por_mes AS --7
    SELECT dt.Anio "Año", dt.Mes, CAST(SUM (hc.Costo_total) / SUM(hc.Cantidad_compras) AS DECIMAL(18, 2)) Importe_promedio_compras
    FROM LA_SELECTION.BI_HECHO_Compra hc 
    JOIN LA_SELECTION.BI_DIM_TIEMPO dt ON hc.DIM_Tiempo_id = dt.DIM_Tiempo_id
    GROUP BY dt.Anio, dt.Mes
GO

CREATE VIEW LA_SELECTION.BI_VIEW_Compras_por_tipo_de_material AS --8
    SELECT ds.Numero_sucursal Sucursal, dt.Anio "Año", dt.Cuatrimestre, tm.Nombre Tipo_Material, SUM(hc.Costo_total) Importe_total
    FROM LA_SELECTION.BI_HECHO_Compra hc 
    JOIN LA_SELECTION.BI_DIM_Tipo_Material tm ON hc.DIM_Tipo_Material_id = tm.DIM_Tipo_Material_id
    JOIN LA_SELECTION.BI_DIM_Sucursal ds ON hc.DIM_Sucursal_id = ds.DIM_Sucursal_id
    JOIN LA_SELECTION.BI_DIM_TIEMPO dt ON hc.DIM_Tiempo_id = dt.DIM_Tiempo_id
    GROUP BY ds.Numero_sucursal, dt.Anio, dt.Cuatrimestre, tm.Nombre
GO

CREATE VIEW LA_SELECTION.BI_VIEW_Porcentaje_de_entregas_en_tiempo AS --9
SELECT dt.Anio 'Año', dt.Mes Mes, CAST((1.0 * SUM(he.Cantidad_entregas_a_tiempo) / SUM(he.Cantidad_entregas))*100 AS decimal(5, 2)) porcentaje_cumplimiento_envios
    FROM 
        LA_SELECTION.BI_HECHO_Envio he
        JOIN LA_SELECTION.BI_DIM_Tiempo dt ON (he.DIM_Tiempo_id = dt.DIM_Tiempo_id)
		GROUP BY dt.Anio, dt.Mes
GO

CREATE VIEW LA_SELECTION.BI_VIEW_Localidades_que_pagan_mayor_costo_de_envio AS --10
    SELECT TOP 3 du.Provincia Provincia, du.Localidad Localidad, CAST(SUM(he.Total_costo) * 1.0 / NULLIF(SUM(he.Cantidad_entregas), 0) AS DECIMAL(10,2)) AS Promedio_costo_de_envio
    FROM 
        LA_SELECTION.BI_HECHO_Envio he
        JOIN LA_SELECTION.BI_DIM_Ubicacion du ON (he.DIM_Ubicacion_id = du.DIM_Ubicacion_id)
    GROUP BY du.Provincia, du.Localidad
    ORDER BY Promedio_costo_de_envio DESC
GO

----------EJECUCION DE PROCEDURES-------------------------------------------------------------------------------------
BEGIN TRANSACTION
 BEGIN TRY
	EXEC LA_SELECTION.migrar_BI_Estados_Pedido;
    EXEC LA_SELECTION.migrar_BI_Turnos_Ventas;
    EXEC LA_SELECTION.migrar_BI_Tiempos;
    EXEC LA_SELECTION.migrar_BI_Rango_etario_cliente;
    EXEC LA_SELECTION.migrar_BI_Sucursal;
    EXEC LA_SELECTION.migrar_BI_Tipo_Material;
    EXEC LA_SELECTION.migrar_BI_Ubicacion;
    EXEC LA_SELECTION.migrar_BI_Modelo_Sillon;
    EXEC LA_SELECTION.migrar_BI_HECHO_Pedidos;
    EXEC LA_SELECTION.migrar_BI_HECHO_Compra;
    EXEC LA_SELECTION.migrar_BI_HECHO_Envio;
    EXEC LA_SELECTION.migrar_BI_HECHO_Venta;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
	THROW 50001, 'Hubo un error en la transferencia de datos.',1;
END CATCH
   IF (
    EXISTS (SELECT 1 FROM LA_SELECTION.BI_DIM_Estado_Pedido)
    AND EXISTS (SELECT 1 FROM LA_SELECTION.BI_DIM_Turno_Ventas)
    AND EXISTS (SELECT 1 FROM LA_SELECTION.BI_DIM_Tiempo)
    AND EXISTS (SELECT 1 FROM LA_SELECTION.BI_DIM_Rango_Etario_Cliente)
    AND EXISTS (SELECT 1 FROM LA_SELECTION.BI_DIM_Sucursal)
    AND EXISTS (SELECT 1 FROM LA_SELECTION.BI_DIM_Tipo_Material)
    AND EXISTS (SELECT 1 FROM LA_SELECTION.BI_DIM_Ubicacion)
    AND EXISTS (SELECT 1 FROM LA_SELECTION.BI_DIM_Modelo_Sillon)

    AND EXISTS (SELECT 1 FROM LA_SELECTION.BI_HECHO_Pedido)
    AND EXISTS (SELECT 1 FROM LA_SELECTION.BI_HECHO_Compra)
    AND EXISTS (SELECT 1 FROM LA_SELECTION.BI_HECHO_Envio)
    AND EXISTS (SELECT 1 FROM LA_SELECTION.BI_HECHO_Venta)
)

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