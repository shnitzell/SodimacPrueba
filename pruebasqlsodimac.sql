USE [master]
GO
/****** Object:  Database [carcenter]    Script Date: 4/03/2021 10:18:25 a. m. ******/
CREATE DATABASE [carcenter]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'carcenter', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\carcenter.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'carcenter_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\carcenter_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [carcenter] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [carcenter].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [carcenter] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [carcenter] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [carcenter] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [carcenter] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [carcenter] SET ARITHABORT OFF 
GO
ALTER DATABASE [carcenter] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [carcenter] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [carcenter] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [carcenter] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [carcenter] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [carcenter] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [carcenter] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [carcenter] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [carcenter] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [carcenter] SET  ENABLE_BROKER 
GO
ALTER DATABASE [carcenter] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [carcenter] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [carcenter] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [carcenter] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [carcenter] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [carcenter] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [carcenter] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [carcenter] SET RECOVERY FULL 
GO
ALTER DATABASE [carcenter] SET  MULTI_USER 
GO
ALTER DATABASE [carcenter] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [carcenter] SET DB_CHAINING OFF 
GO
ALTER DATABASE [carcenter] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [carcenter] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [carcenter] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [carcenter] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'carcenter', N'ON'
GO
ALTER DATABASE [carcenter] SET QUERY_STORE = OFF
GO
USE [carcenter]
GO
/****** Object:  Table [dbo].[CLIENTES]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTES](
	[id] [int] NOT NULL,
	[primer_nombre] [varchar](20) NOT NULL,
	[segundo_nombre] [varchar](20) NULL,
	[primer_apellido] [varchar](20) NOT NULL,
	[segundo_apellido] [varchar](20) NOT NULL,
	[tipo_documento] [varchar](3) NOT NULL,
	[documento] [bigint] NOT NULL,
	[celular] [varchar](20) NOT NULL,
	[direccion] [varchar](40) NULL,
	[email] [varchar](20) NULL,
 CONSTRAINT [PK_CLIENTES] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACTURA_TIENE_SERVICIO]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACTURA_TIENE_SERVICIO](
	[factura_id] [int] NOT NULL,
	[servicio_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACTURAS]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACTURAS](
	[id] [int] NOT NULL,
	[cliente_id] [int] NOT NULL,
	[tienda_id] [int] NOT NULL,
	[fecha_factura] [date] NOT NULL,
	[subtotal] [money] NOT NULL,
	[descuento] [money] NULL,
	[total] [money] NOT NULL,
 CONSTRAINT [PK_FACTURAS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACTURAS_TIENE_REPUESTOS]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACTURAS_TIENE_REPUESTOS](
	[factura_id] [int] NOT NULL,
	[repuesto_id] [int] NOT NULL,
	[cantidad] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MANTENIMIENTOS]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MANTENIMIENTOS](
	[id] [int] NOT NULL,
	[vehiculo] [int] NULL,
	[mecanico] [int] NULL,
	[fecha_inicio] [date] NULL,
	[estado] [varchar](20) NULL,
 CONSTRAINT [PK_MANTENIMIENTOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MANTENIMIENTOS_TIENE_REPUESTOS]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MANTENIMIENTOS_TIENE_REPUESTOS](
	[mantenimiento_id] [int] NULL,
	[repuesto_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MANTENIMIENTOS_TIENE_SERVICIOS]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MANTENIMIENTOS_TIENE_SERVICIOS](
	[mantenimiento_id] [int] NULL,
	[servicio_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MECANICOS]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MECANICOS](
	[id] [int] NOT NULL,
	[primer_nombre] [varchar](20) NOT NULL,
	[segundo_nombre] [varchar](20) NULL,
	[primer_apellido] [varchar](20) NOT NULL,
	[segundo_apellido] [varchar](20) NOT NULL,
	[tipo_documento] [varchar](3) NOT NULL,
	[documento] [bigint] NOT NULL,
	[celular] [varchar](20) NOT NULL,
	[direccion] [varchar](40) NULL,
	[email] [varchar](20) NULL,
	[estado] [varchar](20) NULL,
 CONSTRAINT [PK_MECANICOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REPUESTOS]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REPUESTOS](
	[id] [int] NOT NULL,
	[nombre_repuesto] [varchar](25) NULL,
	[serial] [varchar](50) NOT NULL,
	[precio_unidad] [money] NOT NULL,
	[unidades] [int] NOT NULL,
	[descuento] [int] NOT NULL,
 CONSTRAINT [PK_REPUESTOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SERVICIOS]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SERVICIOS](
	[id] [int] NOT NULL,
	[nombre_servicio] [varchar](50) NULL,
	[precio] [money] NOT NULL,
	[descuento] [int] NULL,
 CONSTRAINT [PK_SERVICIOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIENDAS]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIENDAS](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[direccion] [varchar](50) NULL,
	[gerente] [varchar](50) NULL,
 CONSTRAINT [PK_TIENDAS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VEHICULOS]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VEHICULOS](
	[id] [int] NOT NULL,
	[placa] [varchar](7) NOT NULL,
	[modelo] [int] NULL,
	[marca] [varchar](25) NULL,
	[anio] [varchar](4) NULL,
	[serial] [varchar](25) NULL,
	[color] [varchar](25) NULL,
	[puertas] [int] NOT NULL,
	[motor] [varchar](25) NULL,
	[observacion] [varchar](255) NULL,
	[propietario] [int] NOT NULL,
 CONSTRAINT [PK_VEHICULOS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FACTURA_TIENE_SERVICIO]  WITH CHECK ADD  CONSTRAINT [FK_FACTURA_TIENE_SERVICIO_FACTURAS] FOREIGN KEY([factura_id])
REFERENCES [dbo].[FACTURAS] ([id])
GO
ALTER TABLE [dbo].[FACTURA_TIENE_SERVICIO] CHECK CONSTRAINT [FK_FACTURA_TIENE_SERVICIO_FACTURAS]
GO
ALTER TABLE [dbo].[FACTURA_TIENE_SERVICIO]  WITH CHECK ADD  CONSTRAINT [FK_FACTURA_TIENE_SERVICIO_SERVICIOS] FOREIGN KEY([servicio_id])
REFERENCES [dbo].[SERVICIOS] ([id])
GO
ALTER TABLE [dbo].[FACTURA_TIENE_SERVICIO] CHECK CONSTRAINT [FK_FACTURA_TIENE_SERVICIO_SERVICIOS]
GO
ALTER TABLE [dbo].[FACTURAS]  WITH CHECK ADD  CONSTRAINT [FK_FACTURAS_CLIENTES] FOREIGN KEY([cliente_id])
REFERENCES [dbo].[CLIENTES] ([id])
GO
ALTER TABLE [dbo].[FACTURAS] CHECK CONSTRAINT [FK_FACTURAS_CLIENTES]
GO
ALTER TABLE [dbo].[FACTURAS]  WITH CHECK ADD  CONSTRAINT [FK_FACTURAS_TIENDAS] FOREIGN KEY([tienda_id])
REFERENCES [dbo].[TIENDAS] ([id])
GO
ALTER TABLE [dbo].[FACTURAS] CHECK CONSTRAINT [FK_FACTURAS_TIENDAS]
GO
ALTER TABLE [dbo].[FACTURAS_TIENE_REPUESTOS]  WITH CHECK ADD  CONSTRAINT [FK_FACTURAS_TIENE_REPUESTOS_FACTURAS] FOREIGN KEY([factura_id])
REFERENCES [dbo].[FACTURAS] ([id])
GO
ALTER TABLE [dbo].[FACTURAS_TIENE_REPUESTOS] CHECK CONSTRAINT [FK_FACTURAS_TIENE_REPUESTOS_FACTURAS]
GO
ALTER TABLE [dbo].[FACTURAS_TIENE_REPUESTOS]  WITH CHECK ADD  CONSTRAINT [FK_FACTURAS_TIENE_REPUESTOS_REPUESTOS] FOREIGN KEY([repuesto_id])
REFERENCES [dbo].[REPUESTOS] ([id])
GO
ALTER TABLE [dbo].[FACTURAS_TIENE_REPUESTOS] CHECK CONSTRAINT [FK_FACTURAS_TIENE_REPUESTOS_REPUESTOS]
GO
ALTER TABLE [dbo].[MANTENIMIENTOS]  WITH CHECK ADD  CONSTRAINT [FK_MANTENIMIENTOS_MECANICOS] FOREIGN KEY([mecanico])
REFERENCES [dbo].[MECANICOS] ([id])
GO
ALTER TABLE [dbo].[MANTENIMIENTOS] CHECK CONSTRAINT [FK_MANTENIMIENTOS_MECANICOS]
GO
ALTER TABLE [dbo].[MANTENIMIENTOS]  WITH CHECK ADD  CONSTRAINT [FK_MANTENIMIENTOS_VEHICULOS] FOREIGN KEY([vehiculo])
REFERENCES [dbo].[VEHICULOS] ([id])
GO
ALTER TABLE [dbo].[MANTENIMIENTOS] CHECK CONSTRAINT [FK_MANTENIMIENTOS_VEHICULOS]
GO
ALTER TABLE [dbo].[MANTENIMIENTOS_TIENE_REPUESTOS]  WITH CHECK ADD  CONSTRAINT [FK_MANTENIMIENTO_TIENE_REPUESTO_MANTENIMIENTOS] FOREIGN KEY([mantenimiento_id])
REFERENCES [dbo].[MANTENIMIENTOS] ([id])
GO
ALTER TABLE [dbo].[MANTENIMIENTOS_TIENE_REPUESTOS] CHECK CONSTRAINT [FK_MANTENIMIENTO_TIENE_REPUESTO_MANTENIMIENTOS]
GO
ALTER TABLE [dbo].[MANTENIMIENTOS_TIENE_REPUESTOS]  WITH CHECK ADD  CONSTRAINT [FK_MANTENIMIENTO_TIENE_REPUESTO_REPUESTOS] FOREIGN KEY([repuesto_id])
REFERENCES [dbo].[REPUESTOS] ([id])
GO
ALTER TABLE [dbo].[MANTENIMIENTOS_TIENE_REPUESTOS] CHECK CONSTRAINT [FK_MANTENIMIENTO_TIENE_REPUESTO_REPUESTOS]
GO
ALTER TABLE [dbo].[MANTENIMIENTOS_TIENE_SERVICIOS]  WITH CHECK ADD  CONSTRAINT [FK_MANTENIMIENTO_TIENE_SERVICIO_MANTENIMIENTOS] FOREIGN KEY([mantenimiento_id])
REFERENCES [dbo].[MANTENIMIENTOS] ([id])
GO
ALTER TABLE [dbo].[MANTENIMIENTOS_TIENE_SERVICIOS] CHECK CONSTRAINT [FK_MANTENIMIENTO_TIENE_SERVICIO_MANTENIMIENTOS]
GO
ALTER TABLE [dbo].[MANTENIMIENTOS_TIENE_SERVICIOS]  WITH CHECK ADD  CONSTRAINT [FK_MANTENIMIENTO_TIENE_SERVICIO_SERVICIOS] FOREIGN KEY([servicio_id])
REFERENCES [dbo].[SERVICIOS] ([id])
GO
ALTER TABLE [dbo].[MANTENIMIENTOS_TIENE_SERVICIOS] CHECK CONSTRAINT [FK_MANTENIMIENTO_TIENE_SERVICIO_SERVICIOS]
GO
ALTER TABLE [dbo].[VEHICULOS]  WITH CHECK ADD  CONSTRAINT [FK_Vehiculo_Cliente_id] FOREIGN KEY([propietario])
REFERENCES [dbo].[CLIENTES] ([id])
GO
ALTER TABLE [dbo].[VEHICULOS] CHECK CONSTRAINT [FK_Vehiculo_Cliente_id]
GO
/****** Object:  StoredProcedure [dbo].[VenderProducto]    Script Date: 4/03/2021 10:18:25 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC .[dbo].[VenderProducto] (@idFactura INT)
AS
SET NOCOUNT ON;  
BEGIN 
	DECLARE @cantidadOriginal INT;
	DECLARE @idRepuesto INT;
	DECLARE @vendidos INT;
	DECLARE facturas_cursor CURSOR LOCAL FAST_FORWARD FOR 
							(SELECT FACTURAS_TIENE_REPUESTOS.repuesto_id, FACTURAS_TIENE_REPUESTOS.cantidad 
										FROM FACTURAS_TIENE_REPUESTOS 
										WHERE FACTURAS_TIENE_REPUESTOS.factura_id = @idFactura);
	OPEN facturas_cursor;
	FETCH NEXT FROM facturas_cursor INTO @idRepuesto, @vendidos;
		set @cantidadOriginal = (SELECT REPUESTOS.unidades from REPUESTOS where REPUESTOS.id = @idRepuesto );
		UPDATE REPUESTOS SET REPUESTOS.unidades = @cantidadOriginal - @vendidos WHERE REPUESTOS.id = @idRepuesto;
	WHILE @@FETCH_STATUS = 0
	CLOSE facturas_cursor;

END
GO
USE [master]
GO
ALTER DATABASE [carcenter] SET  READ_WRITE 
GO
