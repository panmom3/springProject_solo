show tables;

--회원 테이블
create table member (
	idx int not null auto_increment, /* 회원 고유 ID */ 
	mid varchar(30) not null,				 /* 로그인 ID */ 
	pwd varchar(100) not null,       /* 비밀번호(암호화저장) */  
	nickName varchar(20) not null,   /* 별명 */ 
	name varchar(20) not null,       /* 이름 */ 	
	email varchar(60) not null,				/* 이메일 */
	birthday datetime default now(), /* 생일 */ 
	tel varchar(15),									/* 전화번호 */ 
	address varchar(100),             /* 주소 */ 
	hopeTour varchar(20);							/* (설문)여행 가고싶은지역*/
	content text,											/* 자기소개 */ 
	photo varchar(100) default 'noimage.jpg', /* 프로필사진 */ 
	status	varchar(10) default 'ACTIVE', /* 회원 상태(활동/탈퇴?차단)- ('ACTIVE','BLOCKED')-탈퇴후1달간 같은아이디로 재가입 불가*/
	level int default 3,          /* 회원등급(0:관리자, 1:우수회원, 2:정회원, 3:준회원), 99:비회원, 999:탈퇴신청회원 */
	visitCnt int default 0,       /* 총 방문횟수 */
	startDate datetime default now(),  /* 최초 가입일() */
	lastDate datetime default now(),   /* 마지막 접속일/탈퇴일 */
	primary key (idx),
	unique(mid)
);
desc member;
drop table member;

select * from member;
--컬럼추가
alter table member add hopeTour varchar(20);
--컬럼삭제
alter table member drop column aaa;