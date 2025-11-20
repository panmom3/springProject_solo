show tables;

-- 3. 숙소
CREATE TABLE stay (
    stay_idx       INT AUTO_INCREMENT PRIMARY KEY,			/* 숙소의 고유번호 */
    region          VARCHAR(100) NOT NULL,              /* 지역명 */
    part					 VARCHAR(100) NOT NULL, 							/* 구분(호텔,펜션,리조트) */
    title          VARCHAR(100) NOT NULL, 							/* 숙소이름 */
    address        VARCHAR(200),    										/* 숙소주소 */
    phone        	 VARCHAR(20),    											/* 숙소전화 */
    homepage 			 VARCHAR(255),												/* 숙소홈페이지 */
    price          INT NOT NULL,       									/* 숙박요금 */
    description    TEXT,   															/* 숙소설명 */
    stay_thumbnail VARCHAR(100) NOT NULL,  		  				/* 숙소 썸네일 이미지(ckeditor에 올린 첫번째 사진으로 처리) */
    stay_tags			 VARCHAR(100)   											/* 숙소키워드 */
);

select * from stay;
-- 4. 예약
CREATE TABLE reservation (
    reservation_idx INT AUTO_INCREMENT PRIMARY KEY,     /* 예약의 고유번호 */
    mid            VARCHAR(20) NOT NULL,								/* 예약한 회원의 ID */
    stay_idx       INT NOT NULL,												/* 예약한 숙소의 ID */
    check_in       DATE NOT NULL,												/* 체크인(숙박시작)날짜 */
    check_out      DATE NOT NULL,												/* 체크아웃(숙박종료)날짜 */
    total_price    INT NOT NULL,												/* 총 숙박요금(숙박일수 X 1박요금) */
    status         ENUM('예약신청','취소','예약완료') DEFAULT '예약신청' COMMENT '예약상태',  /* 예약상태 */
    created_at     DATETIME DEFAULT NOW(),              /* 예약 날짜 */
    FOREIGN KEY (mid) REFERENCES member(mid),
    FOREIGN KEY (stay_idx) REFERENCES stay(stay_idx)
);

select * from stay;

INSERT INTO stay VALUES (
    DEFAULT,
    '충남',
    '리조트',
    '발리리조트',
    '충남 보령시 해안로 450',
    '041-935-4500',
    'http://baleresort.com',
    232180,
    '전객실오션뷰 감성 보령리조트',
    'normal.jpg',
    '#대천'
);