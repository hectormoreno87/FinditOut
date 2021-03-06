USE [master]
GO
/****** Object:  Database [FindItOut]    Script Date: 08/19/2014 18:52:45 ******/
CREATE DATABASE [FindItOut] ON  PRIMARY 
( NAME = N'FindItOut', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\FindItOut.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FindItOut_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\FindItOut_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FindItOut] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FindItOut].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FindItOut] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [FindItOut] SET ANSI_NULLS OFF
GO
ALTER DATABASE [FindItOut] SET ANSI_PADDING OFF
GO
ALTER DATABASE [FindItOut] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [FindItOut] SET ARITHABORT OFF
GO
ALTER DATABASE [FindItOut] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [FindItOut] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [FindItOut] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [FindItOut] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [FindItOut] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [FindItOut] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [FindItOut] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [FindItOut] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [FindItOut] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [FindItOut] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [FindItOut] SET  DISABLE_BROKER
GO
ALTER DATABASE [FindItOut] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [FindItOut] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [FindItOut] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [FindItOut] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [FindItOut] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [FindItOut] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [FindItOut] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [FindItOut] SET  READ_WRITE
GO
ALTER DATABASE [FindItOut] SET RECOVERY FULL
GO
ALTER DATABASE [FindItOut] SET  MULTI_USER
GO
ALTER DATABASE [FindItOut] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [FindItOut] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'FindItOut', N'ON'
GO
USE [FindItOut]
GO
/****** Object:  Table [dbo].[RedSocial]    Script Date: 08/19/2014 18:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RedSocial](
	[idRedSocial] [int] IDENTITY(1,1) NOT NULL,
	[vRedRSocial] [varchar](50) NOT NULL,
	[vLogo] [varchar](55) NULL,
 CONSTRAINT [PK_RedSocial] PRIMARY KEY CLUSTERED 
(
	[idRedSocial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Info]    Script Date: 08/19/2014 18:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Info](
	[idInfo] [int] IDENTITY(1,1) NOT NULL,
	[idCorreo] [int] NOT NULL,
	[vUserName] [varchar](50) NULL,
	[vDescripcion] [varchar](250) NULL,
	[vLogo] [varchar](50) NULL,
 CONSTRAINT [PK_Info] PRIMARY KEY CLUSTERED 
(
	[idInfo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Correo]    Script Date: 08/19/2014 18:52:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Correo](
	[idCorreo] [int] IDENTITY(1,1) NOT NULL,
	[vCorreo] [varchar](100) NOT NULL,
	[vContrasena] [varchar](15) NOT NULL,
	[bVerificado] [bit] NOT NULL,
	[iEstatus] [int] NOT NULL,
	[dFechaSolicitud] [date] NOT NULL,
	[bActivo] [bit] NOT NULL,
 CONSTRAINT [PK_Correo] PRIMARY KEY CLUSTERED 
(
	[idCorreo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[spr_INSERT_Usuario]    Script Date: 08/19/2014 18:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spr_INSERT_Usuario] @mail VARCHAR (100) = '',
                                               @pass VARCHAR(15) = ''
AS
    ------Pruebas---------
    --DECLARE @mail VARCHAR (100) = 'm@hotmail.com',
    --        @pass VARCHAR(8) = '123'
    --        Begin Tran
    ----------------------
    DECLARE @result  VARCHAR (20) = NULL
	,@llave int
    --existe usuario activo
    IF EXISTS (SELECT 1
               FROM   dbo.Correo
               WHERE  @mail = vCorreo)
      BEGIN          
          SET @result = 'yaExiste'
      END
    ELSE
      BEGIN
				--insertar
                INSERT INTO dbo.Correo (vCorreo,vContrasena,dFechaSolicitud,bVerificado,bActivo,iEstatus)
                VALUES (@mail, @pass, getdate(),0,0,0)
                
                SET @result = 'guardado'
                set @llave = SCOPE_IDENTITY ()
            END
    

    SELECT @result  result, @llave llave

-----Pruebas---------
--rollback tran
---------------------
GO
/****** Object:  StoredProcedure [dbo].[spr_INSERT_InfoUser]    Script Date: 08/19/2014 18:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spr_INSERT_InfoUser] @idCorreo INT = 0,
                                     @newUser  VARCHAR (50)='',
                                     @desc     VARCHAR (50)='',
                                     @logo     VARCHAR (50)=''
AS
    DECLARE @result INT = 0

    IF ( @idCorreo > 0 )
      BEGIN
          IF EXISTS (SELECT 1
                     FROM   dbo.Info
                     WHERE  idCorreo = @idCorreo)
            BEGIN
                UPDATE dbo.Info
                SET    vUserName = @newUser,
                       vDescripcion = @desc,
                       vLogo = @logo
                WHERE  idCorreo = @idCorreo

                SET @result= 1
            END
          ELSE
            BEGIN
                INSERT INTO dbo.Info
                            (idCorreo,
                             vUserName,
                             vDescripcion,
                             vLogo)
                VALUES      (@idCorreo,
                             @newUser,
                             @desc,
                             @logo)

                SET @result= 1
            END
      END

    SELECT @result
GO
/****** Object:  StoredProcedure [dbo].[spr_GET_Pass]    Script Date: 08/19/2014 18:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spr_GET_Pass] @mail VARCHAR (100) = ''
                                              
AS
    ------Pruebas---------
    --DECLARE @mail VARCHAR (100) = 'm@hotmail.com'
    ----------------------
    DECLARE @result  VARCHAR (20) = NULL

    --existe usuario activo
    IF EXISTS (SELECT 1
               FROM   dbo.Correo
               WHERE  @mail = vCorreo)
      BEGIN          
          SET @result = (SELECT vContrasena
               FROM   dbo.Correo
               WHERE  @mail = vCorreo)
      END    
    
    ELSE
		SET @result = ''
		
	SELECT @result  result

-----Pruebas---------
rollback tran
---------------------
GO
/****** Object:  StoredProcedure [dbo].[spr_GET_IniciarSesion]    Script Date: 08/19/2014 18:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spr_GET_IniciarSesion] @mail VARCHAR (100) = '',
                                              @pass VARCHAR(15) = ''
AS
	
    ------Pruebas---------
    --DECLARE @mail VARCHAR (100) = 'm.m@hotmail.com',
    --        @pass VARCHAR(8) = 'xxx'
            
    --        --SELECT  *, CAST(vContraseña AS varbinary(100)),CAST(@pass AS varbinary(100))	FROM    Correo
    ----------------------
    DECLARE @result  VARCHAR (20) = NULL,
            @nikname VARCHAR (100)= NULL,
            @idFindOut INT= 0

    --existe usuario con contraseña y esta activo
    IF EXISTS (SELECT 1
               FROM   dbo.Correo
               WHERE  @mail = vCorreo
                      --AND @pass = vContraseña
                      AND CAST(vContrasena AS varbinary(8)) = CAST(@pass AS varbinary(8))
                      AND bVerificado = 1
                      AND bActivo = 1)
      BEGIN
          SET @nikname = isnull ((select vUserName from dbo.Info where idCorreo = (select idCorreo from dbo.Correo where vCorreo = @mail)), 
								  (select vCorreo from dbo.Correo where vCorreo = @mail)) 
          SET @result = 'puedePasar'
          SET @idFindOut = (select idCorreo from dbo.Correo where vCorreo = @mail)
      END
    ELSE
      BEGIN
          --inactivo
          IF EXISTS (SELECT 1
                     FROM   dbo.Correo
                     WHERE  @mail = vCorreo
                            AND bVerificado = 1 --ya fue aceptado una vez
                            AND bActivo = 0)
            BEGIN
                SET @result = 'inactivo'
            END
          ELSE
            BEGIN
                IF EXISTS (SELECT 1
                           FROM   dbo.Correo
                           WHERE  @mail = vCorreo
                                  AND bVerificado = 0 --aun no ha sido activado
                                  AND bActivo = 0)
                  BEGIN
                      SET @result = 'sinConfirmar'
                  END
                ELSE
                  BEGIN
                      --contraseña mal
                      IF EXISTS (SELECT 1
                                 FROM   dbo.Correo
                                 WHERE  @mail = vCorreo
                                        AND bActivo = 1)
                        BEGIN
                            SET @result = 'errorPass'
                        END
                      ELSE
                        --no encuentro correo
                        BEGIN
                            SET @result = 'errorMail'
                        END
                  END
            END
      END

    SELECT @result  result,
           @nikname nikname,
           @idFindOut findOut
GO
/****** Object:  StoredProcedure [dbo].[spr_GET_InfoUser]    Script Date: 08/19/2014 18:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spr_GET_InfoUser] @idCorreo INT = 0
AS
    SELECT vUserName    [user],
           vDescripcion [desc],
           vLogo        logo
    FROM   dbo.Info
    WHERE  idCorreo = @idCorreo
GO
/****** Object:  StoredProcedure [dbo].[spr_ACTIVAR_Usuario]    Script Date: 08/19/2014 18:52:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spr_ACTIVAR_Usuario] @mail VARCHAR (100) = '',
                                             @pass VARCHAR(15) = '',
                                             @id   INT
AS
    ------Pruebas---------
    --DECLARE @mail VARCHAR (100) = 'm@hotmail.com',
    --        @pass VARCHAR(8) = '123'
    --        Begin Tran
    ----------------------
    DECLARE @result VARCHAR (20) = NULL

    --existe usuario activo
    IF EXISTS (SELECT 1
               FROM   dbo.Correo
               WHERE  @mail = vCorreo
                      AND @pass = vContrasena
                      AND @id = idCorreo)
      BEGIN
          UPDATE dbo.Correo
          SET    bActivo = 1,
                 bVerificado = 1,
                 iEstatus = 1
          WHERE  @mail = vCorreo
                 AND @pass = vContrasena
                 AND @id = idCorreo

          SET @result = 'activado'
      END
    ELSE
      BEGIN
          SET @result = 'error'
      END

    SELECT @result result
-----Pruebas---------
--rollback tran
---------------------
GO
