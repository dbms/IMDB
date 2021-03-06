USE [master]
GO
/****** Object:  Database [IMDB]    Script Date: 10/21/2018 19:59:59 ******/
CREATE DATABASE [IMDB] ON  PRIMARY 
( NAME = N'IMDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\IMDB.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'IMDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\IMDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [IMDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IMDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IMDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [IMDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [IMDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [IMDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [IMDB] SET ARITHABORT OFF
GO
ALTER DATABASE [IMDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [IMDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [IMDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [IMDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [IMDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [IMDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [IMDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [IMDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [IMDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [IMDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [IMDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [IMDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [IMDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [IMDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [IMDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [IMDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [IMDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [IMDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [IMDB] SET  READ_WRITE
GO
ALTER DATABASE [IMDB] SET RECOVERY SIMPLE
GO
ALTER DATABASE [IMDB] SET  MULTI_USER
GO
ALTER DATABASE [IMDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [IMDB] SET DB_CHAINING OFF
GO
USE [IMDB]
GO
/****** Object:  Table [dbo].[tbl_Actors]    Script Date: 10/21/2018 19:59:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Actors](
	[UID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Sex] [nvarchar](20) NULL,
	[DOB] [date] NULL,
	[Bio] [nvarchar](1000) NULL,
	[InsertDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[InsertedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_tbl_Actors] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 10/21/2018 20:00:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split]
(
    @String NVARCHAR(4000),
    @Delimiter NCHAR(1)
)
RETURNS TABLE
AS
RETURN
(
    WITH Split(stpos,endpos)
    AS(
        SELECT 0 AS stpos, CHARINDEX(@Delimiter,@String) AS endpos
        UNION ALL
        SELECT endpos+1, CHARINDEX(@Delimiter,@String,endpos+1)
            FROM Split
            WHERE endpos > 0
    )
    SELECT 'Id' = ROW_NUMBER() OVER (ORDER BY (SELECT 1)),
        'items' = SUBSTRING(@String,stpos,COALESCE(NULLIF(endpos,0),LEN(@String)+1)-stpos)
    FROM Split
)
GO
/****** Object:  Table [dbo].[tbl_Producers]    Script Date: 10/21/2018 20:00:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Producers](
	[UID] [bigint] IDENTITY(101,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Sex] [nvarchar](20) NULL,
	[DOB] [date] NULL,
	[Bio] [nvarchar](1000) NULL,
	[InsertDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[InsertedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_tbl_Producers] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Movies]    Script Date: 10/21/2018 20:00:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Movies](
	[UID] [bigint] IDENTITY(1001,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[YearOfRelease] [nvarchar](20) NULL,
	[ProducerId] [bigint] NULL,
	[ActorsId] [nvarchar](100) NULL,
	[Plot] [nvarchar](max) NULL,
	[PosterUrl] [nvarchar](300) NULL,
	[InsertDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[InsertedBy] [nvarchar](20) NULL,
	[ModifiedBy] [nvarchar](20) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_tbl_Movies] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Usp_Actors_AddEdit]    Script Date: 10/21/2018 20:00:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- select *from tbl_Actors
-- delete from tbl_actors where uid >15
CREATE proc [dbo].[Usp_Actors_AddEdit]
	@pUID bigint= null,
	@pName nvarchar(100) = null,
	@pSex nvarchar(20) = null,
	@pDOB nvarchar(100)= null,
	@pBio nvarchar(1000) = null,
	@pModifiedBy nvarchar(50) = null,
	@pInsertedBy nvarchar(50) = null,
	@pMsg nvarchar(200)= '' output,
	@pMode nvarchar(50)= null
		
as begin
	
	if(@pMode='Save')
	begin
		begin transaction S
			begin try
				if not exists(select * from tbl_Actors where Name = @pName and Sex = @pSex and DOB = @pDOB)
					begin				
						 insert into tbl_Actors (Name, Sex, DOB, Bio,Insertdate,InsertedBy) 
						 values (@pName, @pSex, CONVERT(DATE, @pDOB, 103), @pBio ,getdate(),@pInsertedBy)
					 end
				else
					begin
						set @pMsg = 'Actor already Exists in our DB!'
					end
			end try
			begin catch
				rollback transaction S
			end catch
		commit transaction S
	end 
	
	if(@pMode='Update')
	begin
		begin transaction U
			begin try
				update tbl_Actors set
				Name = @pName, Sex = @pSex, DOB = CONVERT(DATE, @pDOB, 103),
				Bio = @pBio, ModifiedBy =  'Admin', ModifiedDate = getdate()
				where UID = @pUID
			end try
			begin catch
				rollback transaction U
			end catch
		commit transaction U
	end
	
	if(@pMode='Select')
	begin	
		select *from tbl_Actors
	end
	
	if(@pMode='Search')
	begin
		select *from tbl_Actors where Name like '%' + @pName + '%';
	end
end
GO
/****** Object:  StoredProcedure [dbo].[Usp_Producers_AddEdit]    Script Date: 10/21/2018 20:00:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- select *  from tbl_Producers
-- select *  from tbl_Actors
-- exec Usp_Producers_AddEdit '','Davdid', 'Male', '29/10/2018', '111','','Admin','','Save'
CREATE proc [dbo].[Usp_Producers_AddEdit]
	@pUID bigint= null,
	@pName nvarchar(100) = null,
	@pSex nvarchar(20) = null,
	@pDOB nvarchar(100)= null,
	@pBio nvarchar(1000) = null,
	@pModifiedBy nvarchar(50) = null,
	@pInsertedBy nvarchar(50) = null,
	@pMsg nvarchar(200)= '' output,
	@pMode nvarchar(50)= null
		
as begin
	
	if(@pMode='Save')
	begin
		begin transaction S
			begin try
				if not exists(select * from tbl_Producers where Name = @pName and Sex = @pSex and DOB = @pDOB)
					begin				
						 insert into tbl_Producers (Name, Sex, DOB, Bio,Insertdate,InsertedBy) 
						 values (@pName, @pSex,CONVERT(DATE, @pDOB, 103), @pBio ,getdate(),@pInsertedBy);
					 end
				else
					begin
						set @pMsg = 'Producer already Exists in our DB!'
					end				 
			end try
			begin catch
				rollback transaction S
			end catch
		commit transaction S
	end 
	
	if(@pMode='Update')
	begin
		begin transaction U
			begin try
				update tbl_Producers set
				Name = @pName, Sex = @pSex, DOB = CONVERT(DATE, @pDOB, 103),
				Bio = @pBio, ModifiedBy =  'Admin', ModifiedDate = getdate()
				where UID = @pUID;
			end try
				begin catch
					rollback transaction U
				end catch
		commit transaction U
	end
	
	if(@pMode='Select')
	begin	
		select *from tbl_Producers
	end
	
	if(@pMode='Search')
	begin
		select *from tbl_Producers where Name like '%' + @pName + '%';
	end
end
GO
/****** Object:  StoredProcedure [dbo].[Usp_Movies_AddEdit]    Script Date: 10/21/2018 20:00:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- delete from tbl_Movies;
-- select *  from tbl_Movies; 
-- exec Usp_Movies_AddEdit '','Baazi','1123','9','11','test','ssd','','Admin','','Save'
CREATE proc [dbo].[Usp_Movies_AddEdit]
	@pUID bigint= null,
	@pName nvarchar(100) = null,
	@pYearOfRelease nvarchar(20) = null,
	@pProduderId bigint = null,
	@pActorsID nvarchar(100) = null,
	@pMovieID bigint = null,
	@pPlot nvarchar(max) = null,
	@pPosterPath nvarchar(100) = null,
	@pModifiedBy nvarchar(50) = null,
	@pInsertedBy nvarchar(50) = null,
	@pMsg nvarchar(200)= '' output,
	@pMode nvarchar(50)= null
		
as begin
	
	if(@pMode='Save')
	begin
		begin transaction S
			begin try
				if not exists(select * from tbl_Movies where Name = @pName and ProducerId = @pProduderId and YearOfRelease = @pYearOfRelease)
					begin			
						 insert into tbl_Movies (Name, YearOfRelease,ProducerId,ActorsId, PosterUrl, Plot,Insertdate,InsertedBy) 
						 values (@pName, @pYearOfRelease, @pProduderId, @pActorsID, @pPosterPath, @pPlot ,getdate(),@pInsertedBy)
						 set @pMsg = 'Sucessfully Saved'
					 end
				else
					begin
						set @pMsg = 'Movie already Exists in DB!'
					end							
			end try
			begin catch
				rollback transaction S
			end catch
		commit transaction S	
	end 
	
	if(@pMode='Update')
	begin
		begin transaction U
			begin try
				update tbl_Movies set
				Name = @pName, YearOfRelease = @pYearOfRelease, 
				ProducerId = @pProduderId, ActorsId = @pActorsID,
				PosterUrl = @pPosterPath, Plot =@pPlot, 
				ModifiedBy =  @pModifiedBy, ModifiedDate = getdate()
				where UID = @pUID
				set @pMsg = @pUID
			end try
			begin catch
				rollback transaction U
			end catch
		commit transaction U
	end
			
	if(@pMode='SelectAll')
	begin	
		select MV.UID, MV.Name, MV.YearOfRelease, MV.Plot,MV.PosterUrl, 
		PR.Name as ProducerName, AC.Name as ActorName from tbl_Movies as MV
		inner join tbl_Producers as PR on PR.UID = MV.ProducerId
		outer apply [dbo].[Split](MV.ActorsId, ',') s
		left join tbl_Actors as AC on AC.UID = s.items		
	end
	
	if(@pMode='Search')
	begin
		select MV.UID, MV.Name, MV.YearOfRelease, MV.Plot,MV.PosterUrl, 
		PR.Name as ProducerName, AC.Name as ActorName from tbl_Movies as MV
		inner join tbl_Producers as PR on PR.UID = MV.ProducerId
		outer apply [dbo].[Split](MV.ActorsId, ',') s
		left join tbl_Actors as AC on AC.UID = s.items
		where MV.Name like '%' + @pName + '%';
	end
end
GO
/****** Object:  Default [DF_tbl_Actors_IsActive]    Script Date: 10/21/2018 19:59:59 ******/
ALTER TABLE [dbo].[tbl_Actors] ADD  CONSTRAINT [DF_tbl_Actors_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  Default [DF_tbl_Producers_IsActive]    Script Date: 10/21/2018 20:00:00 ******/
ALTER TABLE [dbo].[tbl_Producers] ADD  CONSTRAINT [DF_tbl_Producers_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  Default [DF_tbl_Movies_IsActive]    Script Date: 10/21/2018 20:00:00 ******/
ALTER TABLE [dbo].[tbl_Movies] ADD  CONSTRAINT [DF_tbl_Movies_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  ForeignKey [FK_tbl_Movies_tbl_Producers]    Script Date: 10/21/2018 20:00:00 ******/
ALTER TABLE [dbo].[tbl_Movies]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Movies_tbl_Producers] FOREIGN KEY([ProducerId])
REFERENCES [dbo].[tbl_Producers] ([UID])
GO
ALTER TABLE [dbo].[tbl_Movies] CHECK CONSTRAINT [FK_tbl_Movies_tbl_Producers]
GO
