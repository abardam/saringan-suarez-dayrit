
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 09/26/2011 15:37:04
-- Generated from EDMX file: C:\Users\Mr Suarez\Documents\Visual Studio 2010\Projects\Omnipresence\Omnipresence.DataAccess\Core\Core.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [omnidev];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Event_Category]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_Event_Category];
GO
IF OBJECT_ID(N'[dbo].[FK_Location_Country]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Locations] DROP CONSTRAINT [FK_Location_Country];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_Location]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_Event_Location];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_VisibilityType]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_Event_VisibilityType];
GO
IF OBJECT_ID(N'[dbo].[FK_UserProfiles_Gender]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserProfiles] DROP CONSTRAINT [FK_UserProfiles_Gender];
GO
IF OBJECT_ID(N'[dbo].[FK_UserProfile_User]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserProfiles] DROP CONSTRAINT [FK_UserProfile_User];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Categories]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Categories];
GO
IF OBJECT_ID(N'[dbo].[Countries]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Countries];
GO
IF OBJECT_ID(N'[dbo].[Events]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Events];
GO
IF OBJECT_ID(N'[dbo].[Genders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Genders];
GO
IF OBJECT_ID(N'[dbo].[Locations]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Locations];
GO
IF OBJECT_ID(N'[dbo].[UserProfiles]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserProfiles];
GO
IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[VisibilityTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[VisibilityTypes];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Categories'
CREATE TABLE [dbo].[Categories] (
    [CategoryId] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(32)  NOT NULL,
    [Description] nvarchar(128)  NULL,
    [Icon] varbinary(max)  NULL
);
GO

-- Creating table 'Countries'
CREATE TABLE [dbo].[Countries] (
    [CountryId] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(64)  NOT NULL,
    [Flag] varbinary(max)  NULL,
    [Description] nvarchar(128)  NULL
);
GO

-- Creating table 'Events'
CREATE TABLE [dbo].[Events] (
    [EventId] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(64)  NOT NULL,
    [Description] nvarchar(1024)  NULL,
    [Rating] int  NULL,
    [Created] datetime  NULL,
    [LastModified] datetime  NULL,
    [StartTime] datetime  NULL,
    [EndTime] datetime  NULL,
    [IsActive] bit  NULL,
    [VisibilityTypeId] int  NULL,
    [LocationId] int  NULL,
    [CategoryId] int  NULL
);
GO

-- Creating table 'Genders'
CREATE TABLE [dbo].[Genders] (
    [GenderId] int IDENTITY(1,1) NOT NULL,
    [GenderText] nvarchar(16)  NULL,
    [Description] nvarchar(32)  NULL
);
GO

-- Creating table 'Locations'
CREATE TABLE [dbo].[Locations] (
    [LocationId] int IDENTITY(1,1) NOT NULL,
    [Latitude] float  NOT NULL,
    [Longitude] float  NOT NULL,
    [Name] nvarchar(128)  NULL,
    [CountryId] int  NULL
);
GO

-- Creating table 'UserProfiles'
CREATE TABLE [dbo].[UserProfiles] (
    [UserProfileId] int  NOT NULL,
    [FirstName] nvarchar(128)  NOT NULL,
    [LastName] nvarchar(128)  NOT NULL,
    [Birthdate] datetime  NULL,
    [Description] nvarchar(1024)  NULL,
    [Avatar] varbinary(max)  NULL,
    [Reputation] int  NULL,
    [Timezone] int  NULL,
    [GenderId] int  NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [UserId] int IDENTITY(1,1) NOT NULL,
    [Username] nvarchar(32)  NULL,
    [Password] nvarchar(128)  NOT NULL,
    [PasswordSalt] nvarchar(128)  NOT NULL,
    [Email] nvarchar(128)  NOT NULL,
    [AlternateEmail] nvarchar(128)  NULL,
    [Comments] nvarchar(256)  NULL,
    [CreatedDate] datetime  NOT NULL,
    [LastModifiedDate] datetime  NULL,
    [LastLoginDate] datetime  NOT NULL,
    [LastLoginIp] nvarchar(64)  NULL,
    [IsActivated] bit  NOT NULL,
    [IsLockedOut] bit  NOT NULL,
    [LastLockedOutDate] datetime  NOT NULL,
    [LastLockedOutReason] nvarchar(256)  NULL,
    [NewPasswordKey] nvarchar(128)  NULL,
    [NewPasswordRequested] datetime  NULL,
    [NewEmail] nvarchar(128)  NULL,
    [NewEmailKey] nvarchar(128)  NULL,
    [NewEmailRequested] datetime  NULL,
    [SecurityQuestion] nvarchar(256)  NULL,
    [SecurityAnswer] nvarchar(256)  NULL
);
GO

-- Creating table 'VisibilityTypes'
CREATE TABLE [dbo].[VisibilityTypes] (
    [VisibilityTypeId] int IDENTITY(1,1) NOT NULL,
    [Type] nvarchar(32)  NULL,
    [Description] nvarchar(128)  NULL,
    [Icon] varbinary(max)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [CategoryId] in table 'Categories'
ALTER TABLE [dbo].[Categories]
ADD CONSTRAINT [PK_Categories]
    PRIMARY KEY CLUSTERED ([CategoryId] ASC);
GO

-- Creating primary key on [CountryId] in table 'Countries'
ALTER TABLE [dbo].[Countries]
ADD CONSTRAINT [PK_Countries]
    PRIMARY KEY CLUSTERED ([CountryId] ASC);
GO

-- Creating primary key on [EventId] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [PK_Events]
    PRIMARY KEY CLUSTERED ([EventId] ASC);
GO

-- Creating primary key on [GenderId] in table 'Genders'
ALTER TABLE [dbo].[Genders]
ADD CONSTRAINT [PK_Genders]
    PRIMARY KEY CLUSTERED ([GenderId] ASC);
GO

-- Creating primary key on [LocationId] in table 'Locations'
ALTER TABLE [dbo].[Locations]
ADD CONSTRAINT [PK_Locations]
    PRIMARY KEY CLUSTERED ([LocationId] ASC);
GO

-- Creating primary key on [UserProfileId] in table 'UserProfiles'
ALTER TABLE [dbo].[UserProfiles]
ADD CONSTRAINT [PK_UserProfiles]
    PRIMARY KEY CLUSTERED ([UserProfileId] ASC);
GO

-- Creating primary key on [UserId] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([UserId] ASC);
GO

-- Creating primary key on [VisibilityTypeId] in table 'VisibilityTypes'
ALTER TABLE [dbo].[VisibilityTypes]
ADD CONSTRAINT [PK_VisibilityTypes]
    PRIMARY KEY CLUSTERED ([VisibilityTypeId] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [CategoryId] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [FK_Event_Category]
    FOREIGN KEY ([CategoryId])
    REFERENCES [dbo].[Categories]
        ([CategoryId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Event_Category'
CREATE INDEX [IX_FK_Event_Category]
ON [dbo].[Events]
    ([CategoryId]);
GO

-- Creating foreign key on [CountryId] in table 'Locations'
ALTER TABLE [dbo].[Locations]
ADD CONSTRAINT [FK_Location_Country]
    FOREIGN KEY ([CountryId])
    REFERENCES [dbo].[Countries]
        ([CountryId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Location_Country'
CREATE INDEX [IX_FK_Location_Country]
ON [dbo].[Locations]
    ([CountryId]);
GO

-- Creating foreign key on [LocationId] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [FK_Event_Location]
    FOREIGN KEY ([LocationId])
    REFERENCES [dbo].[Locations]
        ([LocationId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Event_Location'
CREATE INDEX [IX_FK_Event_Location]
ON [dbo].[Events]
    ([LocationId]);
GO

-- Creating foreign key on [VisibilityTypeId] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [FK_Event_VisibilityType]
    FOREIGN KEY ([VisibilityTypeId])
    REFERENCES [dbo].[VisibilityTypes]
        ([VisibilityTypeId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Event_VisibilityType'
CREATE INDEX [IX_FK_Event_VisibilityType]
ON [dbo].[Events]
    ([VisibilityTypeId]);
GO

-- Creating foreign key on [GenderId] in table 'UserProfiles'
ALTER TABLE [dbo].[UserProfiles]
ADD CONSTRAINT [FK_UserProfiles_Gender]
    FOREIGN KEY ([GenderId])
    REFERENCES [dbo].[Genders]
        ([GenderId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserProfiles_Gender'
CREATE INDEX [IX_FK_UserProfiles_Gender]
ON [dbo].[UserProfiles]
    ([GenderId]);
GO

-- Creating foreign key on [UserProfileId] in table 'UserProfiles'
ALTER TABLE [dbo].[UserProfiles]
ADD CONSTRAINT [FK_UserProfile_User]
    FOREIGN KEY ([UserProfileId])
    REFERENCES [dbo].[Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------