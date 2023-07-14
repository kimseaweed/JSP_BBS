create table userT(
userID varchar2(20),
userPassword varchar2(20),
userName varchar2(20),
userGenger varchar(20),
userEmail varchar(50),
primary key(userID)
);

insert into usert values('gildong','123456','홍길동','남자','gildong@naver.com');


create table bbs(
bbsID int,
bbsTitle varchar2(50),
userID varchar2(20),
bbsDate DATE,
bbsContent varchar2(2048),
bbsAvailable int,
Primary key(bbsID)
);