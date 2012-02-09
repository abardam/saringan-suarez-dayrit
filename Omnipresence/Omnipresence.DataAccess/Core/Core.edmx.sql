
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 02/10/2012 00:54:52
-- Generated from EDMX file: C:\Users\Mr Suarez\Documents\thesis\Omnipresence\Omnipresence.DataAccess\Core\Core.edmx
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
IF OBJECT_ID(N'[dbo].[FK_Comment_Events]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_Comment_Events];
GO
IF OBJECT_ID(N'[dbo].[FK_Event_Location]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_Event_Location];
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
IF OBJECT_ID(N'[dbo].[FK_UserProfileComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_UserProfileComment];
GO
IF OBJECT_ID(N'[dbo].[FK_UserProfileEvent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Events] DROP CONSTRAINT [FK_UserProfileEvent];
GO
IF OBJECT_ID(N'[dbo].[FK_EventMediaItem]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MediaItems] DROP CONSTRAINT [FK_EventMediaItem];
GO
IF OBJECT_ID(N'[dbo].[FK_UserProfileFriendRequest]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[FriendRequests] DROP CONSTRAINT [FK_UserProfileFriendRequest];
GO
IF OBJECT_ID(N'[dbo].[FK_UserProfileFriendRequest1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[FriendRequests] DROP CONSTRAINT [FK_UserProfileFriendRequest1];
GO
IF OBJECT_ID(N'[dbo].[FK_EventEventVotes]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventVotes] DROP CONSTRAINT [FK_EventEventVotes];
GO
IF OBJECT_ID(N'[dbo].[FK_UserProfileEventVotes]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[EventVotes] DROP CONSTRAINT [FK_UserProfileEventVotes];
GO
IF OBJECT_ID(N'[dbo].[FK_MailEvent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Mails] DROP CONSTRAINT [FK_MailEvent];
GO
IF OBJECT_ID(N'[dbo].[FK_UserProfileMail]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Mails] DROP CONSTRAINT [FK_UserProfileMail];
GO
IF OBJECT_ID(N'[dbo].[FK_UserProfileMail1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Mails] DROP CONSTRAINT [FK_UserProfileMail1];
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
IF OBJECT_ID(N'[dbo].[Events]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Events];
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
IF OBJECT_ID(N'[dbo].[Friendships]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Friendships];
GO
IF OBJECT_ID(N'[dbo].[ApiUsers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ApiUsers];
GO
IF OBJECT_ID(N'[dbo].[MediaItems]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MediaItems];
GO
IF OBJECT_ID(N'[dbo].[FriendRequests]', 'U') IS NOT NULL
    DROP TABLE [dbo].[FriendRequests];
GO
IF OBJECT_ID(N'[dbo].[EventVotes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[EventVotes];
GO
IF OBJECT_ID(N'[dbo].[Mails]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Mails];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Categories'
CREATE TABLE [dbo].[Categories] (
    [CategoryId] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(32)  NOT NULL,
    [Description] nvarchar(128)  NULL,
    [IconPath] nvarchar(max)  NULL
);
GO

-- Creating table 'Comments'
CREATE TABLE [dbo].[Comments] (
    [CommentId] int IDENTITY(1,1) NOT NULL,
    [CommentText] nvarchar(1024)  NOT NULL,
    [Timestamp] datetime  NOT NULL,
    [UserProfileId] int  NOT NULL,
    [EventId] int  NOT NULL
);
GO

-- Creating table 'Events'
CREATE TABLE [dbo].[Events] (
    [EventId] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(64)  NOT NULL,
    [Description] nvarchar(1024)  NOT NULL,
    [Rating] int  NOT NULL,
    [Created] datetime  NOT NULL,
    [LastModified] datetime  NOT NULL,
    [StartTime] datetime  NOT NULL,
    [EndTime] datetime  NOT NULL,
    [IsActive] bit  NOT NULL,
    [VisibilityTypeId] int  NULL,
    [LocationId] int  NULL,
    [CategoryId] int  NULL,
    [IsPrivate] bit  NOT NULL,
    [CreatedById] int  NOT NULL
);
GO

-- Creating table 'Locations'
CREATE TABLE [dbo].[Locations] (
    [LocationId] int IDENTITY(1,1) NOT NULL,
    [Latitude] float  NOT NULL,
    [Longitude] float  NOT NULL,
    [Name] nvarchar(64)  NULL,
    [CountryId] int  NULL,
    [Address] nvarchar(64)  NOT NULL
);
GO

-- Creating table 'UserProfiles'
CREATE TABLE [dbo].[UserProfiles] (
    [UserProfileId] int  NOT NULL,
    [FirstName] nvarchar(128)  NOT NULL,
    [LastName] nvarchar(128)  NOT NULL,
    [Birthdate] datetime  NOT NULL,
    [Description] nvarchar(1024)  NOT NULL,
    [Avatar] nvarchar(max)  NULL,
    [Reputation] int  NOT NULL,
    [Timezone] int  NOT NULL,
    [IsFemale] bit  NOT NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [UserId] int IDENTITY(1,1) NOT NULL,
    [Username] nvarchar(32)  NOT NULL,
    [Password] nvarchar(128)  NOT NULL,
    [PasswordSalt] nvarchar(128)  NOT NULL,
    [Email] nvarchar(128)  NOT NULL,
    [AlternateEmail] nvarchar(128)  NOT NULL,
    [CreatedDate] datetime  NOT NULL,
    [LastModifiedDate] datetime  NOT NULL,
    [LastLoginDate] datetime  NOT NULL,
    [IsActivated] bit  NOT NULL,
    [IsLockedOut] bit  NOT NULL,
    [LastLockedOutDate] datetime  NOT NULL,
    [SecurityQuestion] nvarchar(256)  NOT NULL,
    [SecurityAnswer] nvarchar(256)  NULL
);
GO

-- Creating table 'Friendships'
CREATE TABLE [dbo].[Friendships] (
    [AdderId] int  NOT NULL,
    [AddedId] int  NOT NULL
);
GO

-- Creating table 'ApiUsers'
CREATE TABLE [dbo].[ApiUsers] (
    [ApiUserId] int IDENTITY(1,1) NOT NULL,
    [ApiKey] nchar(32)  NOT NULL,
    [LastCallDate] datetime  NOT NULL,
    [ApiCallCount] int  NOT NULL,
    [AppName] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [ApiCallLimit] int  NOT NULL
);
GO

-- Creating table 'MediaItems'
CREATE TABLE [dbo].[MediaItems] (
    [MediaItemId] int IDENTITY(1,1) NOT NULL,
    [FileName] nvarchar(max)  NOT NULL,
    [FilePath] nvarchar(max)  NOT NULL,
    [EventId] int  NOT NULL,
    [UploaderUsername] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'FriendRequests'
CREATE TABLE [dbo].[FriendRequests] (
    [AdderId] int  NOT NULL,
    [AddedId] int  NOT NULL
);
GO

-- Creating table 'EventVotes'
CREATE TABLE [dbo].[EventVotes] (
    [EventId] int  NOT NULL,
    [UserProfileId] int  NOT NULL,
    [IsUpVote] bit  NOT NULL
);
GO

-- Creating table 'Mails'
CREATE TABLE [dbo].[Mails] (
    [MailId] uniqueidentifier  NOT NULL,
    [MailMessage] nvarchar(max)  NOT NULL,
    [Read] bit  NOT NULL,
    [Starred] bit  NOT NULL,
    [DateSent] datetime  NOT NULL,
    [ReferredEvent_EventId] int  NULL,
    [FromUserProfile_UserProfileId] int  NOT NULL,
    [ToUserProfile_UserProfileId] int  NOT NULL
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

-- Creating primary key on [EventId] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [PK_Events]
    PRIMARY KEY CLUSTERED ([EventId] ASC);
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

-- Creating primary key on [AdderId], [AddedId] in table 'Friendships'
ALTER TABLE [dbo].[Friendships]
ADD CONSTRAINT [PK_Friendships]
    PRIMARY KEY NONCLUSTERED ([AdderId], [AddedId] ASC);
GO

-- Creating primary key on [ApiUserId] in table 'ApiUsers'
ALTER TABLE [dbo].[ApiUsers]
ADD CONSTRAINT [PK_ApiUsers]
    PRIMARY KEY CLUSTERED ([ApiUserId] ASC);
GO

-- Creating primary key on [MediaItemId] in table 'MediaItems'
ALTER TABLE [dbo].[MediaItems]
ADD CONSTRAINT [PK_MediaItems]
    PRIMARY KEY CLUSTERED ([MediaItemId] ASC);
GO

-- Creating primary key on [AdderId], [AddedId] in table 'FriendRequests'
ALTER TABLE [dbo].[FriendRequests]
ADD CONSTRAINT [PK_FriendRequests]
    PRIMARY KEY NONCLUSTERED ([AdderId], [AddedId] ASC);
GO

-- Creating primary key on [EventId], [UserProfileId] in table 'EventVotes'
ALTER TABLE [dbo].[EventVotes]
ADD CONSTRAINT [PK_EventVotes]
    PRIMARY KEY CLUSTERED ([EventId], [UserProfileId] ASC);
GO

-- Creating primary key on [MailId] in table 'Mails'
ALTER TABLE [dbo].[Mails]
ADD CONSTRAINT [PK_Mails]
    PRIMARY KEY CLUSTERED ([MailId] ASC);
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

-- Creating foreign key on [CreatedById] in table 'Events'
ALTER TABLE [dbo].[Events]
ADD CONSTRAINT [FK_UserProfileEvent]
    FOREIGN KEY ([CreatedById])
    REFERENCES [dbo].[UserProfiles]
        ([UserProfileId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserProfileEvent'
CREATE INDEX [IX_FK_UserProfileEvent]
ON [dbo].[Events]
    ([CreatedById]);
GO

-- Creating foreign key on [EventId] in table 'MediaItems'
ALTER TABLE [dbo].[MediaItems]
ADD CONSTRAINT [FK_EventMediaItem]
    FOREIGN KEY ([EventId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_EventMediaItem'
CREATE INDEX [IX_FK_EventMediaItem]
ON [dbo].[MediaItems]
    ([EventId]);
GO

-- Creating foreign key on [AdderId] in table 'FriendRequests'
ALTER TABLE [dbo].[FriendRequests]
ADD CONSTRAINT [FK_UserProfileFriendRequest]
    FOREIGN KEY ([AdderId])
    REFERENCES [dbo].[UserProfiles]
        ([UserProfileId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [AddedId] in table 'FriendRequests'
ALTER TABLE [dbo].[FriendRequests]
ADD CONSTRAINT [FK_UserProfileFriendRequest1]
    FOREIGN KEY ([AddedId])
    REFERENCES [dbo].[UserProfiles]
        ([UserProfileId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserProfileFriendRequest1'
CREATE INDEX [IX_FK_UserProfileFriendRequest1]
ON [dbo].[FriendRequests]
    ([AddedId]);
GO

-- Creating foreign key on [EventId] in table 'EventVotes'
ALTER TABLE [dbo].[EventVotes]
ADD CONSTRAINT [FK_EventEventVotes]
    FOREIGN KEY ([EventId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [UserProfileId] in table 'EventVotes'
ALTER TABLE [dbo].[EventVotes]
ADD CONSTRAINT [FK_UserProfileEventVotes]
    FOREIGN KEY ([UserProfileId])
    REFERENCES [dbo].[UserProfiles]
        ([UserProfileId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserProfileEventVotes'
CREATE INDEX [IX_FK_UserProfileEventVotes]
ON [dbo].[EventVotes]
    ([UserProfileId]);
GO

-- Creating foreign key on [ReferredEvent_EventId] in table 'Mails'
ALTER TABLE [dbo].[Mails]
ADD CONSTRAINT [FK_MailEvent]
    FOREIGN KEY ([ReferredEvent_EventId])
    REFERENCES [dbo].[Events]
        ([EventId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_MailEvent'
CREATE INDEX [IX_FK_MailEvent]
ON [dbo].[Mails]
    ([ReferredEvent_EventId]);
GO

-- Creating foreign key on [FromUserProfile_UserProfileId] in table 'Mails'
ALTER TABLE [dbo].[Mails]
ADD CONSTRAINT [FK_UserProfileMail]
    FOREIGN KEY ([FromUserProfile_UserProfileId])
    REFERENCES [dbo].[UserProfiles]
        ([UserProfileId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserProfileMail'
CREATE INDEX [IX_FK_UserProfileMail]
ON [dbo].[Mails]
    ([FromUserProfile_UserProfileId]);
GO

-- Creating foreign key on [ToUserProfile_UserProfileId] in table 'Mails'
ALTER TABLE [dbo].[Mails]
ADD CONSTRAINT [FK_UserProfileMail1]
    FOREIGN KEY ([ToUserProfile_UserProfileId])
    REFERENCES [dbo].[UserProfiles]
        ([UserProfileId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserProfileMail1'
CREATE INDEX [IX_FK_UserProfileMail1]
ON [dbo].[Mails]
    ([ToUserProfile_UserProfileId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------