USE LA_SELECTION --nombre de DB. chequear
GO
--USAMOS EL MISMO SCHEMA?

----------Creación de las Tablas------------------------------------------------------------------------------------

--Dimensiones
--creo q no deberiamos importar los ids de las tablas!!
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
    Año INT,
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
    Material NVARCHAR(255)
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

--Hechos (REVISARLOS POR QUE MODIFICAMOS COSAS EN EL DER!!)

IF NOT EXISTS (
  SELECT * FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA = 'LA_SELECTION' AND TABLE_NAME = 'BI_HECHO_Pedido'
)
CREATE TABLE LA_SELECTION.BI_HECHO_Pedido (
    DIM_Tiempo_id BIGINT,
    DIM_Turno_Venta_id INT,
    DIM_Sucursal_id BIGINT,
    DIM_Estado_Pedido_id INT,
    Cantidad_pedidos INT,
    Porcentaje_segun_estado DECIMAL(5,2),
    PRIMARY KEY (DIM_Tiempo_id, DIM_Turno_Venta_id, DIM_Sucursal_id, DIM_Estado_Pedido_id),
    FOREIGN KEY (DIM_Tiempo_id) REFERENCES LA_SELECTION.BI_DIM_Tiempo(DIM_Tiempo_id),
    FOREIGN KEY (DIM_Turno_Venta_id) REFERENCES LA_SELECTION.BI_DIM_Turno_Venta(DIM_Turno_Venta_id),
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
    Importe_total DECIMAL(18,2),
    Cantidad_ventas INT,
    Promedio_importe decimal(18,2),
    Promedio_horas_fabricacion decimal(18,2),
    PRIMARY KEY (DIM_Tiempo_id, DIM_Sucursal_id, DIM_Rango_etario_cliente_id, DIM_Modelo_Sillon_id, DIM_Ubicacion_id),
    FOREIGN KEY (DIM_Tiempo_id) REFERENCES LA_SELECTION.BI_DIM_Tiempo(DIM_Tiempo_id),
    FOREIGN KEY (DIM_Sucursal_id) REFERENCES LA_SELECTION.BI_DIM_Sucursal(DIM_Sucursal_id),
    FOREIGN KEY (DIM_Rango_etario_cliente_id) REFERENCES LA_SELECTION.BI_DIM_Rango_Etario_Cliente(DIM_Rango_Etario_Cliente_id),
    FOREIGN KEY (DIM_Modelo_Sillon_id) REFERENCES LA_SELECTION.BI_DIM_Modelo_Sillon(DIM_Modelo_Sillon_id),
    FOREIGN KEY (DIM_Ubicacion_id) REFERENCES LA_SELECTION.BI_DIM_Ubicacion(DIM_Ubicacion_id)
);

----------Migracion de Datos------------------------------------------------------------------------------------



----------Creación de Vistas------------------------------------------------------------------------------------
