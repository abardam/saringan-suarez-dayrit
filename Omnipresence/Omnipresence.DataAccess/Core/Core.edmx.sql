
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 08/17/2011 12:41:01
-- Generated from EDMX file: C:\Users\f205\Desktop\Omni Repository\saringan-suarez-dayrit\Omnipresence\Omnipresence.DataAccess\Core\Core.edmx
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
    ALTER TABLE [dbo].[UserAccount] DROP CONSTRAINT [FK_Country_UserAccount];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_EventComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventComment] DROP CONSTRAINT [FK_Event_EventComment];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_Location]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Location] DROP CONSTRAINT [FK_Event_Location];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_MediaElement]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MediaElement] DROP CONSTRAINT [FK_Event_MediaElement];
GO
IF OBJECT_ID(N'[dbo].[FK_EventCategory_Event]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Event] DROP CONSTRAINT [FK_EventCategory_Event];
GO
IF OBJECT_ID(N'[dbo].[FK_LogEventType_LogEvent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LogEvent] DROP CONSTRAINT [FK_LogEventType_LogEvent];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccount_Event]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Event] DROP CONSTRAINT [FK_UserAccount_Event];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccount_EventCategory]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventCategory] DROP CONSTRAINT [FK_UserAccount_EventCategory];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccount_EventComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventComment] DROP CONSTRAINT [FK_UserAccount_EventComment];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccount_Gender]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserAccount] DROP CONSTRAINT [FK_UserAccount_Gender];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccount_LogEventType]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LogEventType] DROP CONSTRAINT [FK_UserAccount_LogEventType];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccountType_UserAccount]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserAccount] DROP CONSTRAINT [FK_UserAccountType_UserAccount];
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
IF OBJECT_ID(N'[dbo].[Gender]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Gender];
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
IF OBJECT_ID(N'[dbo].[UserAccount]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserAccount];
GO
IF OBJECT_ID(N'[dbo].[UserAccountType]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserAccountType];
GO
IF OBJECT_ID(N'[dbo].[VisibilityType]', 'U') IS NOT NULL
    DROP TABLE [dbo].[VisibilityType];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Countries'
CREATE TABLE [dbo].[Countries] (
    [CountryId] int IDENTITY(1,1) NOT NULL,
    [CountryName] varchar(50)  NOT NULL,
    [CountryFlag] varbinary(max)  NULL,
    [CreatedByUserAccountId] int  NOT NULL
);
GO

-- Creating table 'Events'
CREATE TABLE [dbo].[Events] (
    [EventId] int IDENTITY(1,1) NOT NULL,
    [Name] varchar(50)  NULL,
    [Description] varchar(300)  NOT NULL,
    [StartTime] time  NULL,
    [EndTime] time  NULL,
    [Reputation] int  NOT NULL,
    [Duration] int  NULL,
    [CreationTime] datetime  NULL,
    [DeletionTime] datetime  NOT NULL,
    [CreatedByUserAccountId] int  NOT NULL,
    [EventCategoryId] int  NULL,
    [VisibilityTypeId] int  NOT NULL
);
GO

-- Creating table 'EventCategories'
CREATE TABLE [dbo].[EventCategories] (
    [EventCategoryId] int IDENTITY(1,1) NOT NULL,
    [CategoryName] varchar(50)  NOT NULL,
    [Icon] varbinary(max)  NOT NULL,
    [Description] varchar(200)  NULL,
    [CreatedByUserAccountId] int  NOT NULL
);
GO

-- Creating table 'EventComments'
CREATE TABLE [dbo].[EventComments] (
    [EventCommentId] int IDENTITY(1,1) NOT NULL,
    [Comment] varchar(max)  NOT NULL,
    [Timestamp] binary(8)  NOT NULL,
    [CreatedByUserAccountId] int  NOT NULL,
    [EventId] int  NOT NULL
);
GO

-- Creating table 'Genders'
CREATE TABLE [dbo].[Genders] (
    [GenderId] int IDENTITY(1,1) NOT NULL,
    [GenderText] varchar(20)  NOT NULL,
    [GenderDescription] varchar(100)  NULL,
    [CreatedByUserAccountId] int  NOT NULL
);
GO

-- Creating table 'Locations'
CREATE TABLE [dbo].[Locations] (
    [LocationId] int IDENTITY(1,1) NOT NULL,
    [Longitude] float  NOT NULL,
    [Latitude] float  NOT NULL,
    [Name] varchar(100)  NULL,
    [EventId] int  NOT NULL
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
    [CreatedByUserAccountId] int  NULL
);
GO

-- Creating table 'MediaElements'
CREATE TABLE [dbo].[MediaElements] (
    [MediaElementId] int IDENTITY(1,1) NOT NULL,
    [MediaUrl] varchar(200)  NOT NULL,
    [Title] varchar(50)  NOT NULL,
    [Type] int  NOT NULL,
    [Size] float  NOT NULL,
    [EventId] int  NOT NULL,
    [UserAccountId] int  NOT NULL
);
GO

-- Creating table 'UserAccounts'
CREATE TABLE [dbo].[UserAccounts] (
    [UserAccountId] int IDENTITY(1,1) NOT NULL,
    [Username] varchar(32)  NOT NULL,
    [Password] varchar(32)  NOT NULL,
    [Birthdate] datetime  NOT NULL,
    [FirstName] varchar(32)  NOT NULL,
    [LastName] varchar(32)  NOT NULL,
    [GenderId] int  NOT NULL,
    [EmailAddress] varchar(32)  NOT NULL,
    [AlternateEmailAddress] varchar(32)  NULL,
    [Reputation] int  NOT NULL,
    [AvatarImage] varbinary(max)  NULL,
    [Description] varchar(2000)  NULL,
    [CountryId] int  NULL,
    [Timezone] int  NULL,
    [UserAccountTypeId] int  NOT NULL
);
GO

-- Creating table 'UserAccountTypes'
CREATE TABLE [dbo].[UserAccountTypes] (
    [UserAccountTypeId] int IDENTITY(1,1) NOT NULL,
    [UserTypeText] varchar(50)  NOT NULL,
    [UserTypeDescription] varchar(100)  NULL,
    [CreatedByUserAccountId] int  NOT NULL
);
GO

-- Creating table 'VisibilityTypes'
CREATE TABLE [dbo].[VisibilityTypes] (
    [VisibilityTypeId] int IDENTITY(1,1) NOT NULL,
    [VisibilityText] varchar(50)  NOT NULL,
    [VisibilityDescription] varchar(100)  NULL,
    [CreatedByUserAccountId] int  NOT NULL
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

-- Creating primary key on [UserAccountId] in table 'UserAccounts'
ALTER TABLE [dbo].[UserAccounts]
ADD CONSTRAINT [PK_UserAccounts]
    PRIMARY KEY CLUSTERED ([UserAccountId] ASC);
GO

-- Creating primary key on [UserAccountTypeId] in table 'UserAccountTypes'
ALTER TABLE [dbo].[UserAccountTypes]
ADD CONSTRAINT [PK_UserAccountTypes]
    PRIMARY KEY CLUSTERED ([UserAccountTypeId] ASC);
GO

-- Creating primary key on [VisibilityTypeId] in table 'VisibilityTypes'
ALTER TABLE [dbo].[VisibilityTypes]
ADD CONSTRAINT [PK_VisibilityTypes]
    PRIMARY KEY CLUSTERED ([VisibilityTypeId] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [CountryId] in table 'UserAccounts'
ALTER TABLE [dbo].[UserAccounts]
ADD CONSTRAINT [FK_Country_UserAccount]
    FOREIGN KEY ([CountryId])
    REFERENCES [dbo].[Countries]
        ([CountryId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Country_UserAccount'
CREATE INDEX [IX_FK_Country_UserAccount]
ON [dbo].[UserAccounts]
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

-- Creating foreign key on [LocationId] in table 'Locations'
ALTER TABLE [dbo].[Locations]
ADD CONSTRAINT [FK_Event_Location]
    FOREIGN KEY ([LocationId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
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

-- Creating foreign key on [CreatedByUserAccountId] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [FK_UserAccount_Event]
    FOREIGN KEY ([CreatedByUserAccountId])
    REFERENCES [dbo].[UserAccounts]
        ([UserAccountId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserAccount_Event'
CREATE INDEX [IX_FK_UserAccount_Event]
ON [dbo].[Events]
    ([CreatedByUserAccountId]);
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

-- Creating foreign key on [CreatedByUserAccountId] in table 'EventCategories'
ALTER TABLE [dbo].[EventCategories]
ADD CONSTRAINT [FK_UserAccount_EventCategory]
    FOREIGN KEY ([CreatedByUserAccountId])
    REFERENCES [dbo].[UserAccounts]
        ([UserAccountId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserAccount_EventCategory'
CREATE INDEX [IX_FK_UserAccount_EventCategory]
ON [dbo].[EventCategories]
    ([CreatedByUserAccountId]);
GO

-- Creating foreign key on [CreatedByUserAccountId] in table 'EventComments'
ALTER TABLE [dbo].[EventComments]
ADD CONSTRAINT [FK_UserAccount_EventComment]
    FOREIGN KEY ([CreatedByUserAccountId])
    REFERENCES [dbo].[UserAccounts]
        ([UserAccountId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserAccount_EventComment'
CREATE INDEX [IX_FK_UserAccount_EventComment]
ON [dbo].[EventComments]
    ([CreatedByUserAccountId]);
GO

-- Creating foreign key on [GenderId] in table 'UserAccounts'
ALTER TABLE [dbo].[UserAccounts]
ADD CONSTRAINT [FK_UserAccount_Gender]
    FOREIGN KEY ([GenderId])
    REFERENCES [dbo].[Genders]
        ([GenderId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserAccount_Gender'
CREATE INDEX [IX_FK_UserAccount_Gender]
ON [dbo].[UserAccounts]
    ([GenderId]);
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

-- Creating foreign key on [CreatedByUserAccountId] in table 'LogEventTypes'
ALTER TABLE [dbo].[LogEventTypes]
ADD CONSTRAINT [FK_UserAccount_LogEventType]
    FOREIGN KEY ([CreatedByUserAccountId])
    REFERENCES [dbo].[UserAccounts]
        ([UserAccountId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserAccount_LogEventType'
CREATE INDEX [IX_FK_UserAccount_LogEventType]
ON [dbo].[LogEventTypes]
    ([CreatedByUserAccountId]);
GO

-- Creating foreign key on [UserAccountTypeId] in table 'UserAccounts'
ALTER TABLE [dbo].[UserAccounts]
ADD CONSTRAINT [FK_UserAccountType_UserAccount]
    FOREIGN KEY ([UserAccountTypeId])
    REFERENCES [dbo].[UserAccountTypes]
        ([UserAccountTypeId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserAccountType_UserAccount'
CREATE INDEX [IX_FK_UserAccountType_UserAccount]
ON [dbo].[UserAccounts]
    ([UserAccountTypeId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------