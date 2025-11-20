show tables;

-- 2. 추천여행지
CREATE TABLE travel (
    idx      int not null AUTO_INCREMENT,  /* 고유번호 */
    mid			 VARCHAR(20) NOT NULL,               /* 포토갤러리에 올린이 아이디 */
    part			VARCHAR(10) NOT NULL,							 /* 테마파트(가족/연인/친구/기타) */
    title          VARCHAR(100) NOT NULL,        /* 제목 */
    content    TEXT NOT NULL,                    /* 상세내역-사진 List(CKEDITOR사용) */
    thumbnail  VARCHAR(100) NOT NULL,            /* 썸네일 이미지(ckeditor에 올린 첫번째 사진으로 처리) */
    address        VARCHAR(200),									/* 여행지 주소 */
    pDate      datetime NOT NULL DEFAULT NOW(),  /* 올린 날짜 */
		goodCount  INT NOT NULL DEFAULT 0,           /* 좋아요수 */
		readNum    INT NOT NULL DEFAULT 0,           /* 조회수 */
		tags     VARCHAR(100),
    primary key(idx),
  	foreign key(mid) references member(mid)
);
desc travel;

select * from travel;

insert into travel values (default,'admin','가족','테마별 가고 싶은 여행지를 추천해 드립니다.','추천 여행지','normal.jpg','충북 제천',default,default,default,'#가족');

create table travelReply (
  idx  int not null auto_increment,
  mid   varchar(20) not null,				/* 게시판에 댓글 올린이 아이디 */
  travelIdx int not null,						/* 게시판 고유번호 */
  content  text not null,						/* 게시판 댓글 내용 */
  prDate   datetime default now(),	/* 댓글 입력일자 */
  primary key(idx),
  foreign key(travelIdx) references travel(idx),
  foreign key(mid) references member(mid)
);