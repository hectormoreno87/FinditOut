USE [FindItOut];
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

SET IDENTITY_INSERT [dbo].[Correo] ON;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Correo]([idCorreo], [vCorreo], [vContrasena], [bVerificado], [iEstatus], [dFechaSolicitud], [bActivo])
SELECT 3, N'm@hotmail.com', N'1', 1, 1, '20140805 00:00:00.000', 1 UNION ALL
SELECT 4, N'h@h.com', N'14', 0, 0, '20140805 00:00:00.000', 0 UNION ALL
SELECT 5, N's@s.com.mx', N'1', 0, 0, '20140805 00:00:00.000', 0 UNION ALL
SELECT 6, N'a@a.com.mx', N'1', 0, 0, '20140805 00:00:00.000', 0 UNION ALL
SELECT 7, N'f@f.com', N'1', 0, 0, '20140805 00:00:00.000', 0 UNION ALL
SELECT 8, N'r@r.com.mx', N'1', 0, 0, '20140805 00:00:00.000', 0 UNION ALL
SELECT 9, N's@s.com', N'1', 0, 0, '20140805 00:00:00.000', 0 UNION ALL
SELECT 10, N'r@r.com', N'1', 0, 0, '20140806 00:00:00.000', 0 UNION ALL
SELECT 11, N'd@d.com', N'1', 0, 0, '20140806 00:00:00.000', 0 UNION ALL
SELECT 12, N't@t.com', N'1', 0, 0, '20140806 00:00:00.000', 0 UNION ALL
SELECT 13, N'y@y.com', N'1', 0, 0, '20140806 00:00:00.000', 0 UNION ALL
SELECT 14, N'u@u.com', N'1', 0, 0, '20140806 00:00:00.000', 0 UNION ALL
SELECT 15, N'i@i.com', N'1', 0, 0, '20140806 00:00:00.000', 0 UNION ALL
SELECT 16, N'o@o.com', N'1', 0, 0, '20140806 00:00:00.000', 0 UNION ALL
SELECT 17, N'q@q.com', N'as', 0, 0, '20140806 00:00:00.000', 0 UNION ALL
SELECT 18, N'z@z.com', N'1427a', 0, 0, '20140806 00:00:00.000', 0 UNION ALL
SELECT 19, N'b@b.com', N'martin', 1, 1, '20140806 00:00:00.000', 1 UNION ALL
SELECT 20, N'sa@sa.com', N'1', 0, 0, '20140806 00:00:00.000', 0 UNION ALL
SELECT 21, N'n@n.com', N'q', 0, 0, '20140812 00:00:00.000', 0 UNION ALL
SELECT 22, N'p@hotmail.com', N'1', 0, 0, '20140818 00:00:00.000', 0 UNION ALL
SELECT 23, N'o@hotmail.com', N'o', 0, 0, '20140818 00:00:00.000', 0
COMMIT;
RAISERROR (N'[dbo].[Correo]: Insert Batch: 1.....Done!', 10, 1) WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[Correo] OFF;

SET IDENTITY_INSERT [dbo].[Info] ON;

BEGIN TRANSACTION;
INSERT INTO [dbo].[Info]([idInfo], [idCorreo], [vUserName], [vDescripcion], [vLogo])
SELECT 1, 3, N'Maritza', N'este es un comentario de prueba a ver que pasa...', N''
COMMIT;
RAISERROR (N'[dbo].[Info]: Insert Batch: 1.....Done!', 10, 1) WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[Info] OFF;

SET IDENTITY_INSERT [dbo].[RedSocial] ON;

BEGIN TRANSACTION;
INSERT INTO [dbo].[RedSocial]([idRedSocial], [vRedRSocial], [vLogo])
SELECT 1, N'FaceBook', NULL UNION ALL
SELECT 2, N'Twitter', NULL UNION ALL
SELECT 3, N'WhatsApp', NULL
COMMIT;
RAISERROR (N'[dbo].[RedSocial]: Insert Batch: 1.....Done!', 10, 1) WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[RedSocial] OFF;

