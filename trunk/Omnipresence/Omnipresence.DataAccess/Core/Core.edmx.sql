
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 09/22/2011 15:17:04
-- Generated from EDMX file: H:\saringan-suarez-dayrit\Omnipresence\Omnipresence.DataAccess\Core\Core.edmx
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

IF OBJECT_ID(N'[dbo].[FK_Country_UserAccount]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserProfile] DROP CONSTRAINT [FK_Country_UserAccount];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_EventComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventComment] DROP CONSTRAINT [FK_Event_EventComment];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_Location]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Event] DROP CONSTRAINT [FK_Event_Location];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_MediaElement]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MediaElement] DROP CONSTRAINT [FK_Event_MediaElement];
GO
IF OBJECT_ID(N'[dbo].[FK_EventCategory_Event]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Event] DROP CONSTRAINT [FK_EventCategory_Event];
GO
IF OBJECT_ID(N'[dbo].[FK_EventComment_User]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventComment] DROP CONSTRAINT [FK_EventComment_User];
GO
IF OBJECT_ID(N'[dbo].[FK_LogEventType_LogEvent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LogEvent] DROP CONSTRAINT [FK_LogEventType_LogEvent];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccountTypeUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[User] DROP CONSTRAINT [FK_UserAccountTypeUser];
GO
IF OBJECT_ID(N'[dbo].[FK_UserEvent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Event] DROP CONSTRAINT [FK_UserEvent];
GO
IF OBJECT_ID(N'[dbo].[FK_UserUserProfile]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserProfile] DROP CONSTRAINT [FK_UserUserProfile];
GO
IF OBJECT_ID(N'[dbo].[FK_VisibilityType_Event]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Event] DROP CONSTRAINT [FK_VisibilityType_Event];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Country]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Country];
GO
IF OBJECT_ID(N'[dbo].[Event]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Event];
GO
IF OBJECT_ID(N'[dbo].[EventCategory]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EventCategory];
GO
IF OBJECT_ID(N'[dbo].[EventComment]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EventComment];
GO
IF OBJECT_ID(N'[dbo].[Location]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Location];
GO
IF OBJECT_ID(N'[dbo].[LogEvent]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LogEvent];
GO
IF OBJECT_ID(N'[dbo].[LogEventType]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LogEventType];
GO
IF OBJECT_ID(N'[dbo].[MediaElement]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MediaElement];
GO
IF OBJECT_ID(N'[dbo].[User]', 'U') IS NOT NULL
    DROP TABLE [dbo].[User];
GO
IF OBJECT_ID(N'[dbo].[UserProfile]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserProfile];
GO
IF OBJECT_ID(N'[dbo].[UserType]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserType];
GO
IF OBJECT_ID(N'[dbo].[VisibilityTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[VisibilityTypes];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Countries'
CREATE TABLE [dbo].[Countries] (
    [CountryId] int IDENTITY(1,1) NOT NULL,
    [CountryName] varchar(50)  NOT NULL,
    [CountryFlag] varbinary(max)  NULL
);
GO

-- Creating table 'Events'
CREATE TABLE [dbo].[Events] (
    [EventId] int IDENTITY(1,1) NOT NULL,
    [Name] varchar(50)  NULL,
    [Description] varchar(300)  NOT NULL,
    [StartTime] datetime  NOT NULL,
    [EndTime] datetime  NOT NULL,
    [Reputation] int  NOT NULL,
    [Duration] int  NULL,
    [CreationTime] datetime  NULL,
    [DeletionTime] datetime  NOT NULL,
    [EventCategoryId] int  NULL,
    [VisibilityTypeId] int  NOT NULL,
    [LocationId] int  NOT NULL,
    [UserId] int  NOT NULL
);
GO

-- Creating table 'EventCategories'
CREATE TABLE [dbo].[EventCategories] (
    [EventCategoryId] int IDENTITY(1,1) NOT NULL,
    [CategoryName] varchar(50)  NOT NULL,
    [Icon] varbinary(max)  NOT NULL,
    [Description] varchar(200)  NULL
);
GO

-- Creating table 'EventComments'
CREATE TABLE [dbo].[EventComments] (
    [EventCommentId] int IDENTITY(1,1) NOT NULL,
    [Comment] varchar(max)  NOT NULL,
    [Timestamp] binary(8)  NOT NULL,
    [EventId] int  NOT NULL,
    [UserId] int  NOT NULL
);
GO

-- Creating table 'Locations'
CREATE TABLE [dbo].[Locations] (
    [LocationId] int IDENTITY(1,1) NOT NULL,
    [Longitude] float  NOT NULL,
    [Latitude] float  NOT NULL,
    [Name] varchar(100)  NULL
);
GO

-- Creating table 'LogEvents'
CREATE TABLE [dbo].[LogEvents] (
    [LogEventId] int IDENTITY(1,1) NOT NULL,
    [Timestamp] binary(8)  NOT NULL,
    [LogMessage] varchar(1000)  NOT NULL,
    [LogEventTypeId] int  NOT NULL
);
GO

-- Creating table 'LogEventTypes'
CREATE TABLE [dbo].[LogEventTypes] (
    [LogEventTypeId] int IDENTITY(1,1) NOT NULL,
    [LogEventTypeText] varchar(50)  NOT NULL,
    [LogEventDescription] varchar(100)  NULL
);
GO

-- Creating table 'MediaElements'
CREATE TABLE [dbo].[MediaElements] (
    [MediaElementId] int IDENTITY(1,1) NOT NULL,
    [MediaUrl] varchar(200)  NOT NULL,
    [Title] varchar(50)  NOT NULL,
    [Type] int  NOT NULL,
    [Size] float  NOT NULL,
    [EventId] int  NOT NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [UserId] int IDENTITY(1,1) NOT NULL,
    [UserName] nvarchar(32)  NOT NULL,
    [Email] nvarchar(100)  NOT NULL,
    [Password] nvarchar(32)  NOT NULL,
    [PasswordSalt] nvarchar(100)  NOT NULL,
    [Comments] nvarchar(32)  NULL,
    [CreatedDate] datetime  NOT NULL,
    [LastModifiedDate] datetime  NULL,
    [LastLoginDate] datetime  NOT NULL,
    [LastLoginIp] datetime  NULL,
    [IsActivated] bit  NOT NULL,
    [IsLockedOut] bit  NOT NULL,
    [LastLockedOutDate] datetime  NOT NULL,
    [LastLockedOutReason] datetime  NULL,
    [NewPasswordKey] nvarchar(256)  NULL,
    [NewPasswordRequested] datetime  NULL,
    [NewEmail] nvarchar(100)  NULL,
    [NewEmailKey] nvarchar(128)  NULL,
    [NewEmailRequested] datetime  NULL,
    [UserTypeId] int  NULL
);
GO

-- Creating table 'UserProfiles'
CREATE TABLE [dbo].[UserProfiles] (
    [UserProfileId] int IDENTITY(1,1) NOT NULL,
    [UserName] varchar(32)  NOT NULL,
    [FirstName] varchar(32)  NOT NULL,
    [LastName] varchar(32)  NOT NULL,
    [Birthdate] datetime  NOT NULL,
    [AlternateEmailAddress] varchar(32)  NULL,
    [Reputation] int  NULL,
    [AvatarImage] varbinary(max)  NULL,
    [Description] varchar(2000)  NULL,
    [CountryId] int  NULL,
    [Timezone] int  NULL,
    [Gender] bit  NULL
);
GO

-- Creating table 'UserTypes'
CREATE TABLE [dbo].[UserTypes] (
    [UserTypeId] int IDENTITY(1,1) NOT NULL,
    [UserTypeText] varchar(50)  NOT NULL,
    [UserTypeDescription] varchar(100)  NULL
);
GO

-- Creating table 'VisibilityTypes'
CREATE TABLE [dbo].[VisibilityTypes] (
    [VisibilityTypeId] int IDENTITY(1,1) NOT NULL,
    [VisibilityText] varchar(50)  NOT NULL,
    [VisibilityDescription] varchar(100)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

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

-- Creating primary key on [EventCategoryId] in table 'EventCategories'
ALTER TABLE [dbo].[EventCategories]
ADD CONSTRAINT [PK_EventCategories]
    PRIMARY KEY CLUSTERED ([EventCategoryId] ASC);
GO

-- Creating primary key on [EventCommentId] in table 'EventComments'
ALTER TABLE [dbo].[EventComments]
ADD CONSTRAINT [PK_EventComments]
    PRIMARY KEY CLUSTERED ([EventCommentId] ASC);
GO

-- Creating primary key on [LocationId] in table 'Locations'
ALTER TABLE [dbo].[Locations]
ADD CONSTRAINT [PK_Locations]
    PRIMARY KEY CLUSTERED ([LocationId] ASC);
GO

-- Creating primary key on [LogEventId] in table 'LogEvents'
ALTER TABLE [dbo].[LogEvents]
ADD CONSTRAINT [PK_LogEvents]
    PRIMARY KEY CLUSTERED ([LogEventId] ASC);
GO

-- Creating primary key on [LogEventTypeId] in table 'LogEventTypes'
ALTER TABLE [dbo].[LogEventTypes]
ADD CONSTRAINT [PK_LogEventTypes]
    PRIMARY KEY CLUSTERED ([LogEventTypeId] ASC);
GO

-- Creating primary key on [MediaElementId] in table 'MediaElements'
ALTER TABLE [dbo].[MediaElements]
ADD CONSTRAINT [PK_MediaElements]
    PRIMARY KEY CLUSTERED ([MediaElementId] ASC);
GO

-- Creating primary key on [UserId] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([UserId] ASC);
GO

-- Creating primary key on [UserProfileId] in table 'UserProfiles'
ALTER TABLE [dbo].[UserProfiles]
ADD CONSTRAINT [PK_UserProfiles]
    PRIMARY KEY CLUSTERED ([UserProfileId] ASC);
GO

-- Creating primary key on [UserTypeId] in table 'UserTypes'
ALTER TABLE [dbo].[UserTypes]
ADD CONSTRAINT [PK_UserTypes]
    PRIMARY KEY CLUSTERED ([UserTypeId] ASC);
GO

-- Creating primary key on [VisibilityTypeId] in table 'VisibilityTypes'
ALTER TABLE [dbo].[VisibilityTypes]
ADD CONSTRAINT [PK_VisibilityTypes]
    PRIMARY KEY CLUSTERED ([VisibilityTypeId] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [CountryId] in table 'UserProfiles'
ALTER TABLE [dbo].[UserProfiles]
ADD CONSTRAINT [FK_Country_UserAccount]
    FOREIGN KEY ([CountryId])
    REFERENCES [dbo].[Countries]
        ([CountryId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Country_UserAccount'
CREATE INDEX [IX_FK_Country_UserAccount]
ON [dbo].[UserProfiles]
    ([CountryId]);
GO

-- Creating foreign key on [EventId] in table 'EventComments'
ALTER TABLE [dbo].[EventComments]
ADD CONSTRAINT [FK_Event_EventComment]
    FOREIGN KEY ([EventId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Event_EventComment'
CREATE INDEX [IX_FK_Event_EventComment]
ON [dbo].[EventComments]
    ([EventId]);
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

-- Creating foreign key on [EventId] in table 'MediaElements'
ALTER TABLE [dbo].[MediaElements]
ADD CONSTRAINT [FK_Event_MediaElement]
    FOREIGN KEY ([EventId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Event_MediaElement'
CREATE INDEX [IX_FK_Event_MediaElement]
ON [dbo].[MediaElements]
    ([EventId]);
GO

-- Creating foreign key on [EventCategoryId] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [FK_EventCategory_Event]
    FOREIGN KEY ([EventCategoryId])
    REFERENCES [dbo].[EventCategories]
        ([EventCategoryId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_EventCategory_Event'
CREATE INDEX [IX_FK_EventCategory_Event]
ON [dbo].[Events]
    ([EventCategoryId]);
GO

-- Creating foreign key on [UserId] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [FK_UserEvent]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserEvent'
CREATE INDEX [IX_FK_UserEvent]
ON [dbo].[Events]
    ([UserId]);
GO

-- Creating foreign key on [VisibilityTypeId] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [FK_VisibilityType_Event]
    FOREIGN KEY ([VisibilityTypeId])
    REFERENCES [dbo].[VisibilityTypes]
        ([VisibilityTypeId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_VisibilityType_Event'
CREATE INDEX [IX_FK_VisibilityType_Event]
ON [dbo].[Events]
    ([VisibilityTypeId]);
GO

-- Creating foreign key on [UserId] in table 'EventComments'
ALTER TABLE [dbo].[EventComments]
ADD CONSTRAINT [FK_EventComment_User]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_EventComment_User'
CREATE INDEX [IX_FK_EventComment_User]
ON [dbo].[EventComments]
    ([UserId]);
GO

-- Creating foreign key on [LogEventTypeId] in table 'LogEvents'
ALTER TABLE [dbo].[LogEvents]
ADD CONSTRAINT [FK_LogEventType_LogEvent]
    FOREIGN KEY ([LogEventTypeId])
    REFERENCES [dbo].[LogEventTypes]
        ([LogEventTypeId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_LogEventType_LogEvent'
CREATE INDEX [IX_FK_LogEventType_LogEvent]
ON [dbo].[LogEvents]
    ([LogEventTypeId]);
GO

-- Creating foreign key on [UserTypeId] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [FK_UserAccountTypeUser]
    FOREIGN KEY ([UserTypeId])
    REFERENCES [dbo].[UserTypes]
        ([UserTypeId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserAccountTypeUser'
CREATE INDEX [IX_FK_UserAccountTypeUser]
ON [dbo].[Users]
    ([UserTypeId]);
GO

-- Creating foreign key on [UserProfileId] in table 'UserProfiles'
ALTER TABLE [dbo].[UserProfiles]
ADD CONSTRAINT [FK_UserUserProfile]
    FOREIGN KEY ([UserProfileId])
    REFERENCES [dbo].[Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------