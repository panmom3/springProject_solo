show tables;

/* 1:1 문의 */
CREATE TABLE inquiry (
	idx INT NOT NULL AUTO_INCREMENT,				/* 고유번호 */
	mid VARCHAR(20) NOT NULL,								/* 아이디(작성자) */ 	
	title VARCHAR(100) NOT NULL,						/* 1:1문의 제목 */
	part VARCHAR(20) NOT NULL,							/* 문의유형(카테고리) */
	wDate DATETIME NOT NULL DEFAULT now(),	/* 문의날짜 */ 
	content TEXT NOT NULL,									/* 문의내역 */
	fName VARCHAR(100),											/* 문의시에 올린 사진이나 문서파일 */
	fSName VARCHAR(200),										/* 문의시에 올린 서버에 저장된 사진이나 문서파일 - 여기선 사진, 압축파일만 올리도록 처리함 */
	reply VARCHAR(10) DEFAULT '답변대기중',		/* 답변여부(답변대기중/답변완료) */
	PRIMARY KEY (idx),											/* 주키 : 고유번호 */
	FOREIGN KEY (mid) REFERENCES member(mid) ON UPDATE CASCADE ON DELETE NO ACTION /* 외래키 : 회원아이디 */
);

SELECT * FROM inquiryReply;

/* 1:1 문의 답변글 */
CREATE TABLE inquiryReply (
	reIdx INT NOT NULL AUTO_INCREMENT,
	inquiryIdx INT NOT NULL,
	reWDate DATETIME NOT NULL DEFAULT now(),
	reContent TEXT NOT NULL,
	PRIMARY KEY(reIdx),
	FOREIGN KEY(inquiryIdx) REFERENCES inquiry(idx)
);
