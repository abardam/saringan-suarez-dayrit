
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 11/20/2011 00:12:14
-- Generated from EDMX file: C:\Users\emanuel\Desktop\omni\saringan-suarez-dayrit\Omnipresence\Omnipresence.DataAccess\Core\Core.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Omnipresence];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Event_Category]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_Event_Category];
GO
IF OBJECT_ID(N'[dbo].[FK_Comment_Events]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_Comment_Events];
GO
IF OBJECT_ID(N'[dbo].[FK_Comment_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_Comment_Users];
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
IF OBJECT_ID(N'[dbo].[FK_UserProfileFriendship]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Friendships] DROP CONSTRAINT [FK_UserProfileFriendship];
GO
IF OBJECT_ID(N'[dbo].[FK_UserProfileFriendship1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Friendships] DROP CONSTRAINT [FK_UserProfileFriendship1];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Categories]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Categories];
GO
IF OBJECT_ID(N'[dbo].[Comments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Comments];
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
IF OBJECT_ID(N'[dbo].[Friendships]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Friendships];
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

-- Creating table 'Comments'
CREATE TABLE [dbo].[Comments] (
    [CommentId] int  NOT NULL,
    [CommentText] nvarchar(1024)  NOT NULL,
    [Timestamp] datetime  NOT NULL,
    [UserProfileId] int  NOT NULL,
    [EventId] int  NOT NULL
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

-- Creating table 'Friendships'
CREATE TABLE [dbo].[Friendships] (
    [AdderId] int IDENTITY(1,1) NOT NULL,
    [AddedId] int  NOT NULL
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

-- Creating primary key on [CommentId] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [PK_Comments]
    PRIMARY KEY CLUSTERED ([CommentId] ASC);
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

-- Creating primary key on [AdderId], [AddedId] in table 'Friendships'
ALTER TABLE [dbo].[Friendships]
ADD CONSTRAINT [PK_Friendships]
    PRIMARY KEY NONCLUSTERED ([AdderId], [AddedId] ASC);
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

-- Creating foreign key on [EventId] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [FK_Comment_Events]
    FOREIGN KEY ([EventId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Comment_Events'
CREATE INDEX [IX_FK_Comment_Events]
ON [dbo].[Comments]
    ([EventId]);
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

-- Creating foreign key on [AdderId] in table 'Friendships'
ALTER TABLE [dbo].[Friendships]
ADD CONSTRAINT [FK_UserProfileFriendship]
    FOREIGN KEY ([AdderId])
    REFERENCES [dbo].[UserProfiles]
        ([UserProfileId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [AddedId] in table 'Friendships'
ALTER TABLE [dbo].[Friendships]
ADD CONSTRAINT [FK_UserProfileFriendship1]
    FOREIGN KEY ([AddedId])
    REFERENCES [dbo].[UserProfiles]
        ([UserProfileId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserProfileFriendship1'
CREATE INDEX [IX_FK_UserProfileFriendship1]
ON [dbo].[Friendships]
    ([AddedId]);
GO

-- Creating foreign key on [UserProfileId] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [FK_UserProfileComment]
    FOREIGN KEY ([UserProfileId])
    REFERENCES [dbo].[UserProfiles]
        ([UserProfileId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserProfileComment'
CREATE INDEX [IX_FK_UserProfileComment]
ON [dbo].[Comments]
    ([UserProfileId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------