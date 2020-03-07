<%@ Page Title="" Language="VB" MasterPageFile="~/admin/Admin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="admin_DB_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <textarea runat="server" id="txtSQL" rows="40" cols="90">
GO
/****** Object:  Table [dbo].[EblastTemplates]    Script Date: 11/14/2011 10:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EblastTemplates](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[subject] [nvarchar](255) NULL,
	[body] [nvarchar](max) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RCEmail]    Script Date: 11/14/2011 10:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RCEmail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[dtAdded] [datetime] NOT NULL,
 CONSTRAINT [PK__RCCEmail__31EC6D26] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RCSeo]    Script Date: 11/14/2011 10:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RCSeo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Seq] [int] NULL,
	[Page] [varchar](1024) NULL,
	[Title] [varchar](1024) NULL,
	[Desc] [varchar](1024) NULL,
	[Keywords] [varchar](1024) NULL,
	[flagSitemap] [varchar](1) NULL,
 CONSTRAINT [PK_RC-Seo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GalleryItem]    Script Date: 11/14/2011 10:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GalleryItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImgName] [varchar](64) NULL,
	[ImgDesc] [varchar](512) NULL,
	[CatName] [varchar](64) NULL,
	[FSLoc] [varchar](1024) NULL,
	[Seq] [int] NULL,
 CONSTRAINT [PK_GalleryItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VideoItem]    Script Date: 11/14/2011 10:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VideoItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VidName] [varchar](64) NULL,
	[VidDesc] [varchar](512) NULL,
	[CatName] [varchar](64) NULL,
	[Code] [varchar](1024) NULL,
	[Seq] [int] NULL,
 CONSTRAINT [PK_VideoItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EblastGroups]    Script Date: 11/14/2011 10:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EblastGroups](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[description] [nvarchar](1024) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EblastGroupsIndex]    Script Date: 11/14/2011 10:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EblastGroupsIndex](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[groupID] [int] NOT NULL,
	[userID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EblastHistory]    Script Date: 11/14/2011 10:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EblastHistory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[emailTemplateID] [int] NULL,
	[dateSent] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Default [DF__RCCEmail__dtAdde__32E0915F]    Script Date: 11/14/2011 10:52:02 ******/
ALTER TABLE [dbo].[RCEmail] ADD  CONSTRAINT [DF__RCCEmail__dtAdde__32E0915F]  DEFAULT (getdate()) FOR [dtAdded]
GO
</textarea>
</asp:Content>

