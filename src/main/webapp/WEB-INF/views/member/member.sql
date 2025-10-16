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
	point		  int default 100,				/* 회원 누적포인트(가입포인트 100점,1회방문시 10포인트증가, 1일 최대방문 5회까지허용, 물건구매시 100원당 1포인트 증가처리) */
	level int default 1,          /* 회원등급(0:관리자, 1:회원), 99:비회원, 999:탈퇴신청회원 */
	visitCnt int default 0,       /* 총 방문횟수 */
	todayCnt  int default 0,					/* 오늘 방문한 횟수 */
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
alter table member add todayCnt int default 0;
alter table member add point int default 100;
--컬럼삭제
alter table member drop column aaa;

insert into member (mid,pwd,nickName,name,email) value ('admin', '1234', '관리맨', '관리자', 'panmom5@naver.com');

select mid, pwd from member;