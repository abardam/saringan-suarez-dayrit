
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 08/24/2011 15:39:14
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
    ALTER TABLE [dbo].[UserAccounts] DROP CONSTRAINT [FK_Country_UserAccount];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_EventComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventComments] DROP CONSTRAINT [FK_Event_EventComment];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_Location]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_Event_Location];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_MediaElement]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MediaElements] DROP CONSTRAINT [FK_Event_MediaElement];
GO
IF OBJECT_ID(N'[dbo].[FK_EventCategory_Event]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_EventCategory_Event];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccount_Event]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_UserAccount_Event];
GO
IF OBJECT_ID(N'[dbo].[FK_VisibilityType_Event]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_VisibilityType_Event];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccount_EventCategory]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventCategories] DROP CONSTRAINT [FK_UserAccount_EventCategory];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccount_EventComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventComments] DROP CONSTRAINT [FK_UserAccount_EventComment];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccount_Gender]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserAccounts] DROP CONSTRAINT [FK_UserAccount_Gender];
GO
IF OBJECT_ID(N'[dbo].[FK_LogEventType_LogEvent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LogEvents] DROP CONSTRAINT [FK_LogEventType_LogEvent];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccount_LogEventType]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LogEventTypes] DROP CONSTRAINT [FK_UserAccount_LogEventType];
GO
IF OBJECT_ID(N'[dbo].[FK_UserAccountType_UserAccount]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserAccounts] DROP CONSTRAINT [FK_UserAccountType_UserAccount];
GO
IF OBJECT_ID(N'[dbo].[FK__aspnet_Me__Appli__44FF419A]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[aspnet_Membership] DROP CONSTRAINT [FK__aspnet_Me__Appli__44FF419A];
GO
IF OBJECT_ID(N'[dbo].[FK__aspnet_Pa__Appli__7E37BEF6]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[aspnet_Paths] DROP CONSTRAINT [FK__aspnet_Pa__Appli__7E37BEF6];
GO
IF OBJECT_ID(N'[dbo].[FK__aspnet_Ro__Appli__6754599E]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[aspnet_Roles] DROP CONSTRAINT [FK__aspnet_Ro__Appli__6754599E];
GO
IF OBJECT_ID(N'[dbo].[FK__aspnet_Us__Appli__30F848ED]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[aspnet_Users] DROP CONSTRAINT [FK__aspnet_Us__Appli__30F848ED];
GO
IF OBJECT_ID(N'[dbo].[FK__aspnet_Me__UserI__45F365D3]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[aspnet_Membership] DROP CONSTRAINT [FK__aspnet_Me__UserI__45F365D3];
GO
IF OBJECT_ID(N'[dbo].[FK__aspnet_Pe__PathI__05D8E0BE]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers] DROP CONSTRAINT [FK__aspnet_Pe__PathI__05D8E0BE];
GO
IF OBJECT_ID(N'[dbo].[FK__aspnet_Pe__PathI__0B91BA14]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] DROP CONSTRAINT [FK__aspnet_Pe__PathI__0B91BA14];
GO
IF OBJECT_ID(N'[dbo].[FK__aspnet_Pe__UserI__0C85DE4D]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] DROP CONSTRAINT [FK__aspnet_Pe__UserI__0C85DE4D];
GO
IF OBJECT_ID(N'[dbo].[FK__aspnet_Pr__UserI__5BE2A6F2]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[aspnet_Profile] DROP CONSTRAINT [FK__aspnet_Pr__UserI__5BE2A6F2];
GO
IF OBJECT_ID(N'[dbo].[FK_aspnet_UsersInRoles_aspnet_Roles]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[aspnet_UsersInRoles] DROP CONSTRAINT [FK_aspnet_UsersInRoles_aspnet_Roles];
GO
IF OBJECT_ID(N'[dbo].[FK_aspnet_UsersInRoles_aspnet_Users]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[aspnet_UsersInRoles] DROP CONSTRAINT [FK_aspnet_UsersInRoles_aspnet_Users];
GO
IF OBJECT_ID(N'[dbo].[FK_aspnet_UsersUserAccount]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[UserAccounts] DROP CONSTRAINT [FK_aspnet_UsersUserAccount];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Countries]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Countries];
GO
IF OBJECT_ID(N'[dbo].[Events]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Events];
GO
IF OBJECT_ID(N'[dbo].[EventCategories]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EventCategories];
GO
IF OBJECT_ID(N'[dbo].[EventComments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EventComments];
GO
IF OBJECT_ID(N'[dbo].[Genders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Genders];
GO
IF OBJECT_ID(N'[dbo].[Locations]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Locations];
GO
IF OBJECT_ID(N'[dbo].[LogEvents]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LogEvents];
GO
IF OBJECT_ID(N'[dbo].[LogEventTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LogEventTypes];
GO
IF OBJECT_ID(N'[dbo].[MediaElements]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MediaElements];
GO
IF OBJECT_ID(N'[dbo].[UserAccounts]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserAccounts];
GO
IF OBJECT_ID(N'[dbo].[UserAccountTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserAccountTypes];
GO
IF OBJECT_ID(N'[dbo].[VisibilityTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[VisibilityTypes];
GO
IF OBJECT_ID(N'[dbo].[aspnet_Applications]', 'U') IS NOT NULL
    DROP TABLE [dbo].[aspnet_Applications];
GO
IF OBJECT_ID(N'[dbo].[aspnet_Membership]', 'U') IS NOT NULL
    DROP TABLE [dbo].[aspnet_Membership];
GO
IF OBJECT_ID(N'[dbo].[aspnet_Paths]', 'U') IS NOT NULL
    DROP TABLE [dbo].[aspnet_Paths];
GO
IF OBJECT_ID(N'[dbo].[aspnet_PersonalizationAllUsers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[aspnet_PersonalizationAllUsers];
GO
IF OBJECT_ID(N'[dbo].[aspnet_PersonalizationPerUser]', 'U') IS NOT NULL
    DROP TABLE [dbo].[aspnet_PersonalizationPerUser];
GO
IF OBJECT_ID(N'[dbo].[aspnet_Profile]', 'U') IS NOT NULL
    DROP TABLE [dbo].[aspnet_Profile];
GO
IF OBJECT_ID(N'[dbo].[aspnet_Roles]', 'U') IS NOT NULL
    DROP TABLE [dbo].[aspnet_Roles];
GO
IF OBJECT_ID(N'[dbo].[aspnet_SchemaVersions]', 'U') IS NOT NULL
    DROP TABLE [dbo].[aspnet_SchemaVersions];
GO
IF OBJECT_ID(N'[dbo].[aspnet_Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[aspnet_Users];
GO
IF OBJECT_ID(N'[dbo].[aspnet_WebEvent_Events]', 'U') IS NOT NULL
    DROP TABLE [dbo].[aspnet_WebEvent_Events];
GO
IF OBJECT_ID(N'[dbo].[aspnet_UsersInRoles]', 'U') IS NOT NULL
    DROP TABLE [dbo].[aspnet_UsersInRoles];
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
    [VisibilityTypeId] int  NOT NULL,
    [LocationId] int  NOT NULL
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
    [UserAccountTypeId] int  NOT NULL,
    [aspnet_UserId] uniqueidentifier  NOT NULL
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

-- Creating table 'aspnet_Applications'
CREATE TABLE [dbo].[aspnet_Applications] (
    [ApplicationName] nvarchar(256)  NOT NULL,
    [LoweredApplicationName] nvarchar(256)  NOT NULL,
    [ApplicationId] uniqueidentifier  NOT NULL,
    [Description] nvarchar(256)  NULL
);
GO

-- Creating table 'aspnet_Membership'
CREATE TABLE [dbo].[aspnet_Membership] (
    [ApplicationId] uniqueidentifier  NOT NULL,
    [UserId] uniqueidentifier  NOT NULL,
    [Password] nvarchar(128)  NOT NULL,
    [PasswordFormat] int  NOT NULL,
    [PasswordSalt] nvarchar(128)  NOT NULL,
    [MobilePIN] nvarchar(16)  NULL,
    [Email] nvarchar(256)  NULL,
    [LoweredEmail] nvarchar(256)  NULL,
    [PasswordQuestion] nvarchar(256)  NULL,
    [PasswordAnswer] nvarchar(128)  NULL,
    [IsApproved] bit  NOT NULL,
    [IsLockedOut] bit  NOT NULL,
    [CreateDate] datetime  NOT NULL,
    [LastLoginDate] datetime  NOT NULL,
    [LastPasswordChangedDate] datetime  NOT NULL,
    [LastLockoutDate] datetime  NOT NULL,
    [FailedPasswordAttemptCount] int  NOT NULL,
    [FailedPasswordAttemptWindowStart] datetime  NOT NULL,
    [FailedPasswordAnswerAttemptCount] int  NOT NULL,
    [FailedPasswordAnswerAttemptWindowStart] datetime  NOT NULL,
    [Comment] nvarchar(max)  NULL
);
GO

-- Creating table 'aspnet_Paths'
CREATE TABLE [dbo].[aspnet_Paths] (
    [ApplicationId] uniqueidentifier  NOT NULL,
    [PathId] uniqueidentifier  NOT NULL,
    [Path] nvarchar(256)  NOT NULL,
    [LoweredPath] nvarchar(256)  NOT NULL
);
GO

-- Creating table 'aspnet_PersonalizationAllUsers'
CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers] (
    [PathId] uniqueidentifier  NOT NULL,
    [PageSettings] varbinary(max)  NOT NULL,
    [LastUpdatedDate] datetime  NOT NULL
);
GO

-- Creating table 'aspnet_PersonalizationPerUser'
CREATE TABLE [dbo].[aspnet_PersonalizationPerUser] (
    [Id] uniqueidentifier  NOT NULL,
    [PathId] uniqueidentifier  NULL,
    [UserId] uniqueidentifier  NULL,
    [PageSettings] varbinary(max)  NOT NULL,
    [LastUpdatedDate] datetime  NOT NULL
);
GO

-- Creating table 'aspnet_Profile'
CREATE TABLE [dbo].[aspnet_Profile] (
    [UserId] uniqueidentifier  NOT NULL,
    [PropertyNames] nvarchar(max)  NOT NULL,
    [PropertyValuesString] nvarchar(max)  NOT NULL,
    [PropertyValuesBinary] varbinary(max)  NOT NULL,
    [LastUpdatedDate] datetime  NOT NULL
);
GO

-- Creating table 'aspnet_Roles'
CREATE TABLE [dbo].[aspnet_Roles] (
    [ApplicationId] uniqueidentifier  NOT NULL,
    [RoleId] uniqueidentifier  NOT NULL,
    [RoleName] nvarchar(256)  NOT NULL,
    [LoweredRoleName] nvarchar(256)  NOT NULL,
    [Description] nvarchar(256)  NULL
);
GO

-- Creating table 'aspnet_SchemaVersions'
CREATE TABLE [dbo].[aspnet_SchemaVersions] (
    [Feature] nvarchar(128)  NOT NULL,
    [CompatibleSchemaVersion] nvarchar(128)  NOT NULL,
    [IsCurrentVersion] bit  NOT NULL
);
GO

-- Creating table 'aspnet_Users'
CREATE TABLE [dbo].[aspnet_Users] (
    [ApplicationId] uniqueidentifier  NOT NULL,
    [UserId] uniqueidentifier  NOT NULL,
    [UserName] nvarchar(256)  NOT NULL,
    [LoweredUserName] nvarchar(256)  NOT NULL,
    [MobileAlias] nvarchar(16)  NULL,
    [IsAnonymous] bit  NOT NULL,
    [LastActivityDate] datetime  NOT NULL
);
GO

-- Creating table 'aspnet_WebEvent_Events'
CREATE TABLE [dbo].[aspnet_WebEvent_Events] (
    [EventId] char(32)  NOT NULL,
    [EventTimeUtc] datetime  NOT NULL,
    [EventTime] datetime  NOT NULL,
    [EventType] nvarchar(256)  NOT NULL,
    [EventSequence] decimal(19,0)  NOT NULL,
    [EventOccurrence] decimal(19,0)  NOT NULL,
    [EventCode] int  NOT NULL,
    [EventDetailCode] int  NOT NULL,
    [Message] nvarchar(1024)  NULL,
    [ApplicationPath] nvarchar(256)  NULL,
    [ApplicationVirtualPath] nvarchar(256)  NULL,
    [MachineName] nvarchar(256)  NOT NULL,
    [RequestUrl] nvarchar(1024)  NULL,
    [ExceptionType] nvarchar(256)  NULL,
    [Details] nvarchar(max)  NULL
);
GO

-- Creating table 'aspnet_UsersInRoles'
CREATE TABLE [dbo].[aspnet_UsersInRoles] (
    [aspnet_Roles_RoleId] uniqueidentifier  NOT NULL,
    [aspnet_Users_UserId] uniqueidentifier  NOT NULL
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

-- Creating primary key on [ApplicationId] in table 'aspnet_Applications'
ALTER TABLE [dbo].[aspnet_Applications]
ADD CONSTRAINT [PK_aspnet_Applications]
    PRIMARY KEY CLUSTERED ([ApplicationId] ASC);
GO

-- Creating primary key on [UserId] in table 'aspnet_Membership'
ALTER TABLE [dbo].[aspnet_Membership]
ADD CONSTRAINT [PK_aspnet_Membership]
    PRIMARY KEY CLUSTERED ([UserId] ASC);
GO

-- Creating primary key on [PathId] in table 'aspnet_Paths'
ALTER TABLE [dbo].[aspnet_Paths]
ADD CONSTRAINT [PK_aspnet_Paths]
    PRIMARY KEY CLUSTERED ([PathId] ASC);
GO

-- Creating primary key on [PathId] in table 'aspnet_PersonalizationAllUsers'
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers]
ADD CONSTRAINT [PK_aspnet_PersonalizationAllUsers]
    PRIMARY KEY CLUSTERED ([PathId] ASC);
GO

-- Creating primary key on [Id] in table 'aspnet_PersonalizationPerUser'
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]
ADD CONSTRAINT [PK_aspnet_PersonalizationPerUser]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [UserId] in table 'aspnet_Profile'
ALTER TABLE [dbo].[aspnet_Profile]
ADD CONSTRAINT [PK_aspnet_Profile]
    PRIMARY KEY CLUSTERED ([UserId] ASC);
GO

-- Creating primary key on [RoleId] in table 'aspnet_Roles'
ALTER TABLE [dbo].[aspnet_Roles]
ADD CONSTRAINT [PK_aspnet_Roles]
    PRIMARY KEY CLUSTERED ([RoleId] ASC);
GO

-- Creating primary key on [Feature], [CompatibleSchemaVersion] in table 'aspnet_SchemaVersions'
ALTER TABLE [dbo].[aspnet_SchemaVersions]
ADD CONSTRAINT [PK_aspnet_SchemaVersions]
    PRIMARY KEY CLUSTERED ([Feature], [CompatibleSchemaVersion] ASC);
GO

-- Creating primary key on [UserId] in table 'aspnet_Users'
ALTER TABLE [dbo].[aspnet_Users]
ADD CONSTRAINT [PK_aspnet_Users]
    PRIMARY KEY CLUSTERED ([UserId] ASC);
GO

-- Creating primary key on [EventId] in table 'aspnet_WebEvent_Events'
ALTER TABLE [dbo].[aspnet_WebEvent_Events]
ADD CONSTRAINT [PK_aspnet_WebEvent_Events]
    PRIMARY KEY CLUSTERED ([EventId] ASC);
GO

-- Creating primary key on [aspnet_Roles_RoleId], [aspnet_Users_UserId] in table 'aspnet_UsersInRoles'
ALTER TABLE [dbo].[aspnet_UsersInRoles]
ADD CONSTRAINT [PK_aspnet_UsersInRoles]
    PRIMARY KEY NONCLUSTERED ([aspnet_Roles_RoleId], [aspnet_Users_UserId] ASC);
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

-- Creating foreign key on [ApplicationId] in table 'aspnet_Membership'
ALTER TABLE [dbo].[aspnet_Membership]
ADD CONSTRAINT [FK__aspnet_Me__Appli__44FF419A]
    FOREIGN KEY ([ApplicationId])
    REFERENCES [dbo].[aspnet_Applications]
        ([ApplicationId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK__aspnet_Me__Appli__44FF419A'
CREATE INDEX [IX_FK__aspnet_Me__Appli__44FF419A]
ON [dbo].[aspnet_Membership]
    ([ApplicationId]);
GO

-- Creating foreign key on [ApplicationId] in table 'aspnet_Paths'
ALTER TABLE [dbo].[aspnet_Paths]
ADD CONSTRAINT [FK__aspnet_Pa__Appli__7E37BEF6]
    FOREIGN KEY ([ApplicationId])
    REFERENCES [dbo].[aspnet_Applications]
        ([ApplicationId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK__aspnet_Pa__Appli__7E37BEF6'
CREATE INDEX [IX_FK__aspnet_Pa__Appli__7E37BEF6]
ON [dbo].[aspnet_Paths]
    ([ApplicationId]);
GO

-- Creating foreign key on [ApplicationId] in table 'aspnet_Roles'
ALTER TABLE [dbo].[aspnet_Roles]
ADD CONSTRAINT [FK__aspnet_Ro__Appli__6754599E]
    FOREIGN KEY ([ApplicationId])
    REFERENCES [dbo].[aspnet_Applications]
        ([ApplicationId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK__aspnet_Ro__Appli__6754599E'
CREATE INDEX [IX_FK__aspnet_Ro__Appli__6754599E]
ON [dbo].[aspnet_Roles]
    ([ApplicationId]);
GO

-- Creating foreign key on [ApplicationId] in table 'aspnet_Users'
ALTER TABLE [dbo].[aspnet_Users]
ADD CONSTRAINT [FK__aspnet_Us__Appli__30F848ED]
    FOREIGN KEY ([ApplicationId])
    REFERENCES [dbo].[aspnet_Applications]
        ([ApplicationId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK__aspnet_Us__Appli__30F848ED'
CREATE INDEX [IX_FK__aspnet_Us__Appli__30F848ED]
ON [dbo].[aspnet_Users]
    ([ApplicationId]);
GO

-- Creating foreign key on [UserId] in table 'aspnet_Membership'
ALTER TABLE [dbo].[aspnet_Membership]
ADD CONSTRAINT [FK__aspnet_Me__UserI__45F365D3]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[aspnet_Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [PathId] in table 'aspnet_PersonalizationAllUsers'
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers]
ADD CONSTRAINT [FK__aspnet_Pe__PathI__05D8E0BE]
    FOREIGN KEY ([PathId])
    REFERENCES [dbo].[aspnet_Paths]
        ([PathId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [PathId] in table 'aspnet_PersonalizationPerUser'
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]
ADD CONSTRAINT [FK__aspnet_Pe__PathI__0B91BA14]
    FOREIGN KEY ([PathId])
    REFERENCES [dbo].[aspnet_Paths]
        ([PathId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK__aspnet_Pe__PathI__0B91BA14'
CREATE INDEX [IX_FK__aspnet_Pe__PathI__0B91BA14]
ON [dbo].[aspnet_PersonalizationPerUser]
    ([PathId]);
GO

-- Creating foreign key on [UserId] in table 'aspnet_PersonalizationPerUser'
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]
ADD CONSTRAINT [FK__aspnet_Pe__UserI__0C85DE4D]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[aspnet_Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK__aspnet_Pe__UserI__0C85DE4D'
CREATE INDEX [IX_FK__aspnet_Pe__UserI__0C85DE4D]
ON [dbo].[aspnet_PersonalizationPerUser]
    ([UserId]);
GO

-- Creating foreign key on [UserId] in table 'aspnet_Profile'
ALTER TABLE [dbo].[aspnet_Profile]
ADD CONSTRAINT [FK__aspnet_Pr__UserI__5BE2A6F2]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[aspnet_Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [aspnet_Roles_RoleId] in table 'aspnet_UsersInRoles'
ALTER TABLE [dbo].[aspnet_UsersInRoles]
ADD CONSTRAINT [FK_aspnet_UsersInRoles_aspnet_Roles]
    FOREIGN KEY ([aspnet_Roles_RoleId])
    REFERENCES [dbo].[aspnet_Roles]
        ([RoleId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [aspnet_Users_UserId] in table 'aspnet_UsersInRoles'
ALTER TABLE [dbo].[aspnet_UsersInRoles]
ADD CONSTRAINT [FK_aspnet_UsersInRoles_aspnet_Users]
    FOREIGN KEY ([aspnet_Users_UserId])
    REFERENCES [dbo].[aspnet_Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_aspnet_UsersInRoles_aspnet_Users'
CREATE INDEX [IX_FK_aspnet_UsersInRoles_aspnet_Users]
ON [dbo].[aspnet_UsersInRoles]
    ([aspnet_Users_UserId]);
GO

-- Creating foreign key on [aspnet_UserId] in table 'UserAccounts'
ALTER TABLE [dbo].[UserAccounts]
ADD CONSTRAINT [FK_aspnet_UsersUserAccount]
    FOREIGN KEY ([aspnet_UserId])
    REFERENCES [dbo].[aspnet_Users]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_aspnet_UsersUserAccount'
CREATE INDEX [IX_FK_aspnet_UsersUserAccount]
ON [dbo].[UserAccounts]
    ([aspnet_UserId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------