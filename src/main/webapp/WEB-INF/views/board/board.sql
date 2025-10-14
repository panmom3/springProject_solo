show tables;

-- 커뮤니티 게시글
CREATE TABLE community_board (
    idx         	int AUTO_INCREMENT PRIMARY KEY,  /* 게시판 고유번호 */
    mid      			varchar(20) not null,            /* 게시판 올린사람 아이디 */
    nickName 			varchar(20) not null,		 							/* 게시판 올린사람 닉네임 */
    title         VARCHAR(150) NOT NULL,        /* 게시글 제목 */
    content       TEXT NOT NULL,                /* 게시판글 내용 */
    openSw 				char(2) default 'OK',      /* 게시글 공개여부(OK:공개, NO:비공개) */
    readNum 			int default 0,            /* 글 조회수 */
		wDate 				datetime default now(),     /* 글 올린 날짜 */
		good 					int default 0,								/* 좋아요 클릭수 */
		complaint 		char(2) default 'NO',   /* 신고글(정상글:NO, 신고당한글:OK) */
    FOREIGN KEY (mid) REFERENCES member(mid)
);
desc community_board;

select * from community_board;

insert into community_board values (default, 'admin','관리맨','게시판 서비스를 시작합니다','즐거운 게시판 생활되세요',default,default,default,default,default);