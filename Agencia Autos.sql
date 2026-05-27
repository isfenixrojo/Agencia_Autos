-- Crear la base de datos
CREATE DATABASE AgenciaAutos;
GO

-- Usar la base de datos
USE AgenciaAutos;
GO

CREATE TABLE Marcas(
IdMarca INT IDENTITY(1,1),   
Marca NVARCHAR(100) NOT NULL, 
DescripcionMarca NVARCHAR(100) NOT NULL, 
Activo BIT NOT NULL,
CONSTRAINT PK_Marca PRIMARY KEY (IdMarca),
CONSTRAINT UQ_Marcas_Marcas UNIQUE (Marca))
GO

CREATE TABLE Modelos(
IdModelo INT IDENTITY(1,1),   
Modelo NVARCHAR(100) NOT NULL,    
DescripcionModelo NVARCHAR(100) NOT NULL,    
Activo BIT NOT NULL,
CONSTRAINT PK_Modelo PRIMARY KEY (IdModelo),
CONSTRAINT UQ_Modelos_Modelo UNIQUE (Modelo))
GO

CREATE TABLE Anio(
IdAnio INT IDENTITY(1,1),   
Anio NVARCHAR(100) NOT NULL,    
DescripcionAnio NVARCHAR(100) NOT NULL,    
Activo BIT NOT NULL,
CONSTRAINT PK_Anio PRIMARY KEY (IdAnio),
CONSTRAINT UQ_Anio_Anio UNIQUE (Anio))
GO

CREATE TABLE Tamanos(
IdTamano INT IDENTITY(1,1),   
Tamano NVARCHAR(100) NOT NULL, 
DescripcionTamano NVARCHAR(100) NOT NULL, 
Activo BIT NOT NULL,
CONSTRAINT PK_Tamano PRIMARY KEY (IdTamano),
CONSTRAINT UQ_Tamanos_Tamano UNIQUE (Tamano))
GO

CREATE TABLE Colores(
IdColor INT IDENTITY(1,1),   
Color NVARCHAR(50) NOT NULL,    
DescripcionColor NVARCHAR(100) NOT NULL,    
Activo BIT NOT NULL,
CONSTRAINT PK_Colores PRIMARY KEY (IdColor),
CONSTRAINT UQ_Colores_Color UNIQUE (Color))
GO

CREATE TABLE Motores(
IdMotor INT IDENTITY(1,1),   
Motor NVARCHAR(100) NOT NULL, 
DescripcionMotor NVARCHAR(100) NOT NULL, 
Activo BIT NOT NULL,
CONSTRAINT PK_Motor PRIMARY KEY (IdMotor),
CONSTRAINT UQ_Motores_Motor UNIQUE (Motor))
GO

CREATE TABLE TipoCombustible(
IdCombustible INT IDENTITY(1,1),   
TipoCombustible NVARCHAR(100) NOT NULL,    
DescripcionCombustible NVARCHAR(100) NOT NULL,    
Activo BIT NOT NULL,
CONSTRAINT PK_TipoCombustible PRIMARY KEY (IdCombustible),
CONSTRAINT UQ_TipoCombustible_TipoCombustible UNIQUE (TipoCombustible))
GO

CREATE TABLE TipoTransmision( ---
IdTransmision INT IDENTITY(1,1),   
TipoTransmision NVARCHAR(100) NOT NULL,    
DescripcionTransmision NVARCHAR(100) NOT NULL,    
Activo BIT NOT NULL,
CONSTRAINT PK_TipoTransmision PRIMARY KEY (IdTransmision),
CONSTRAINT UQ_TipoTransmision_TipoTransmision UNIQUE (TipoTransmision))
GO

CREATE TABLE Autos(
IdAuto INT IDENTITY(1,1) NOT NULL,
IdMarca INT NOT NULL,
IdModelo INT NOT NULL,
IdAnio INT NOT NULL,
IdTamano INT NOT NULL,
IdColor INT NOT NULL,
IdMotor INT NOT NULL,
IdNumeroSerie NVARCHAR(100) NOT NULL,    
IdTipoCombustible INT NOT NULL,
IdTipoTransmision INT NOT NULL,
Precio DECIMAL(12,2) NOT NULL,
Activo BIT NOT NULL,
CONSTRAINT PK_Autos PRIMARY KEY (IdAuto),
CONSTRAINT UQ_Autos_NumeroSerie UNIQUE (IdNumeroSerie),
CONSTRAINT FK_Autos_Marca FOREIGN KEY (IdMarca) REFERENCES Marcas(IdMarca),
CONSTRAINT FK_Autos_Modelos FOREIGN KEY (IdModelo) REFERENCES Modelos(IdModelo),
CONSTRAINT FK_Autos_Anio FOREIGN KEY (IdAnio) REFERENCES Anio(IdAnio),
CONSTRAINT FK_Autos_Tamanos FOREIGN KEY (IdTamano) REFERENCES Tamanos(IdTamano),
CONSTRAINT FK_Autos_Colores FOREIGN KEY (IdColor) REFERENCES Colores(IdColor),
CONSTRAINT FK_Autos_Motores FOREIGN KEY (IdMotor) REFERENCES Motores(IdMotor),
CONSTRAINT FK_Autos_TipoCombustible FOREIGN KEY (IdTipoCombustible) REFERENCES TipoCombustible(IdCombustible),
CONSTRAINT FK_Autos_TipoTransmision FOREIGN KEY (IdTipoTransmision) REFERENCES TipoTransmision(IdTransmision))
GO

CREATE TABLE Clientes (
IdCliente INT IDENTITY(1,1),
NombreCliente VARCHAR(100) NOT NULL,
ApellidoPaterno VARCHAR(100) NOT NULL,
ApellidoMaterno VARCHAR(100),
Telefono VARCHAR(20),
Correo VARCHAR(150),
Direccion TEXT,
Activo BIT NOT NULL,
CONSTRAINT PK_Clientes PRIMARY KEY (IdCliente),
CONSTRAINT UQ_Clientes_Correo UNIQUE (Correo));
GO

CREATE TABLE Empleados (
IdEmpleado INT IDENTITY(1,1),
NombreEmpleados VARCHAR(100) NOT NULL,
ApellidoPaterno VARCHAR(100) NOT NULL,
ApellidoMaterno VARCHAR(100),
Puesto VARCHAR(100) NOT NULL,
Telefono VARCHAR(20),
Correo VARCHAR(150),
Salario DECIMAL(10,2) NOT NULL,
Activo BIT NOT NULL,
CONSTRAINT PK_Empleados PRIMARY KEY (IdEmpleado),
CONSTRAINT UQ_Empleados_Correo UNIQUE (correo));
GO

CREATE TABLE Metodo_Pago (
IdMetodoPago INT IDENTITY(1,1),
MetodoPago VARCHAR(50) NOT NULL,
Activo BIT NOT NULL,
CONSTRAINT PK_MetodosPago PRIMARY KEY (IdMetodoPago),
CONSTRAINT UQ_MetodosPago_ UNIQUE (MetodoPago));
GO

CREATE TABLE Ventas (
IdVenta INT IDENTITY(1,1),
Cliente INT NOT NULL,
Empleado INT NOT NULL,
FechaVenta DATETIME DEFAULT CURRENT_TIMESTAMP,
Total DECIMAL(12,2) NOT NULL,
Activo BIT NOT NULL,
CONSTRAINT PK_Ventas PRIMARY KEY (IdVenta),
CONSTRAINT FK_Ventas_clientes FOREIGN KEY (Cliente) REFERENCES Clientes(IdCliente),
CONSTRAINT FK_Ventas_empleados FOREIGN KEY (Empleado) REFERENCES Empleados(IdEmpleado));
GO

CREATE TABLE Detalle_Venta (
IdDetalleVenta INT IDENTITY(1,1),
IdVenta INT NOT NULL,
IdAuto INT NOT NULL,
Comentarios VARCHAR(100),
PrecioVenta DECIMAL(12,2) NOT NULL,
Activo BIT NOT NULL,
CONSTRAINT PK_DetalleVenta PRIMARY KEY (IdDetalleVenta),
CONSTRAINT FK_DetalleVenta_Ventas FOREIGN KEY (IdVenta) REFERENCES Ventas(IdVenta),
CONSTRAINT FK_DetalleVenta_Autos FOREIGN KEY (IdAuto) REFERENCES Autos(IdAuto),
CONSTRAINT UQ_DetalleVenta_Autos UNIQUE (IdAuto));
GO

CREATE TABLE Pagos (
IdPago INT IDENTITY(1,1),
IdVenta INT NOT NULL,
IdMetodoPago INT NOT NULL,
Monto DECIMAL(12,2) NOT NULL,
FechaPago DATETIME NOT NULL,
Activo BIT NOT NULL,
CONSTRAINT PK_Pagos PRIMARY KEY (IdPago),
CONSTRAINT FK_Pagos_Ventas FOREIGN KEY (IdVenta) REFERENCES Ventas(IdVenta),
CONSTRAINT FK_Pagos_MetodoPago FOREIGN KEY (IdMetodoPago) REFERENCES Metodo_Pago(IdMetodoPago));
GO