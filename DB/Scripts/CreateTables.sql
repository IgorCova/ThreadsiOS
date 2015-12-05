create schema if not exists dbo;

create table if not exists dbo.Position (
   ID          int constraint pkPositionID primary key
  ,Name        varchar(128) not null
);

create table if not exists dbo.Community (
   ID          int constraint pkCommunityID primary key
  ,Code        varchar(128) null
  ,Name        varchar(128) 
  ,Description varchar(4000) null
  ,IsPrivate   boolean
);

create table if not exists dbo.Column (
   ID          int constraint pkColumnID primary key
  ,CommunityID int
  ,Name        varchar(128) not null
  ,IsPrivate   boolean
);

create table if not exists dbo.Person (
   ID          int constraint pkPersonID primary key
  ,UserName    varchar(128) 
  ,Name        varchar(256) null
  ,Surname     varchar(256) null  
  ,Phone       varchar(32)  
  ,Description varchar(4000) null
  ,IsIncognito boolean
  ,IncognitoName varchar(128) null
);

create table if not exists dbo.Person (
   ID          int constraint pkPersonID primary key
  ,UserName    varchar(128) 
  ,Name        varchar(256) null
  ,Surname     varchar(256) null  
  ,Phone       varchar(32)  
  ,Description varchar(4000) null
  ,IsIncognito boolean
  ,IncognitoName varchar(128) null
);

create table if not exists dbo.ComPerson (
   IDPerson    int
  ,IDCommunity int
  ,IDPosition  int
  ,constraint pkComPerson primary key (IDPerson, IDCommunity, IDPosition)
  ,constraint fkComPersonToPerson foreign key (IDPerson) references dbo.Person(ID)
  ,constraint fkComPersonToCommunity foreign key  (IDCommunity) references dbo.Community(ID)
  ,constraint fkComPersonToPosition foreign key (IDPosition) references dbo.Position(ID)
);

create table if not exists dbo.Post (
   ID          int constraint pkPostID primary key
  ,IDCommunity int
  ,IDPerson    int
  ,Content     varchar(8000)
  ,IDColumn    int
  ,constraint fkPostToPerson foreign key (IDPerson) references dbo.Person(ID)
  ,constraint fkPostToCommunity foreign key  (IDCommunity) references dbo.Community(ID)
  ,constraint fkPostToColumn foreign key (IDColumn) references dbo.Column(ID) 
);
