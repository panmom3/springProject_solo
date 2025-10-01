show tables;

create table member (
	idx int not null auto_increment,
	mid varchar(30) not null,
	pwd varchar(100) not null,
	nickName varchar(20) not null,
	name varchar(20) not null,
	birthday datetime default now(),
	tel varchar(15),
	address varchar(100),
	email varchar(60) not null,
	homePage varchar(60),
	--hopeTour varchar(100),
	content text,
	photo varchar(100) default 'noimage.jpg',
	userDel char(2) default 'NO', /* 회원 탈퇴신청여부(NO:현재 활동중, OK:탈퇴신청중)-탈퇴후1달간 같은아이디로 재가입 불가 */
	level int default 3,          /* 회원등급(0:관리자, 1:우수회원, 2:정회원, 3:준회원), 99:비회원, 999:탈퇴신청회원 */
	visitCnt int default 0,       /* 총 방문횟수 */
	todayCnt int default 0,       /* 오늘 방문한 횟수 */
	startDate datetime default now(),  /* 최초 가입일() */
	lastDate datetime default now(),   /* 마지막 접속일/탈퇴일 */
	primary key (idx),
	unique(mid)
);