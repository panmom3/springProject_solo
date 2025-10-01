-- 회원 테이블
CREATE TABLE MEMBER (
    idx   BIGINT AUTO_INCREMENT,/* 회원 고유 ID */ 
    mid    VARCHAR(50) UNIQUE NOT NULL  '로그인 ID',
    pwd    VARCHAR(255) NOT NULL  '비밀번호(암호화 저장)',
    name   VARCHAR(100)  '회원 이름',
    email  VARCHAR(100) UNIQUE  '이메일' not null,
    tel 		varchar(15)  '전화번호',
    address varchar(100),
    content text,
		photo varchar(100) default 'noimage.jpg',
    level int default 1,  /* 권한 구분 회원등급(0:관리자, 1:회원, 2:비회원, 3:탈퇴신청회원) */
    visitCnt int default 0,       /* 총 방문횟수 */
    todayCnt int default 0,       /* 오늘 방문한 횟수 */
    startDate    TIMESTAMP DEFAULT CURRENT_TIMESTAMP  '가입일',
    status      ENUM('ACTIVE','BLOCKED') DEFAULT 'ACTIVE'  '회원 상태 (활동/차단)'
    lastDate datetime default now(),   /* 마지막 접속일/탈퇴일 */
    primary key (idx),
		unique(mid)
);

-- 지역 테이블
CREATE TABLE REGION (
    region_id   INT AUTO_INCREMENT PRIMARY KEY  '지역 고유 ID',
    region_name VARCHAR(50) NOT NULL  '지역 이름 (예: 서울, 부산, 제주)',
    description TEXT  '지역 설명'
);

-- 여행지 테이블
CREATE TABLE TRAVEL_DEST (
    travel_id   BIGINT AUTO_INCREMENT PRIMARY KEY  '여행지 고유 ID',
    region_id   INT NOT NULL  '지역 ID (FK)',
    title       VARCHAR(200) NOT NULL  '여행지 이름/제목',
    description TEXT  '여행지 설명',
    address     VARCHAR(255)  '주소',
    image_url   VARCHAR(255)  '대표 이미지 경로',
    reg_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP  '등록일',
    FOREIGN KEY(region_id) REFERENCES REGION(region_id)
);

-- 이벤트 테이블 (공지/축제 소식 용도, 예약 기능 없음)
CREATE TABLE EVENT (
    event_id    BIGINT AUTO_INCREMENT PRIMARY KEY  '이벤트 고유 ID',
    title       VARCHAR(200) NOT NULL  '이벤트 제목',
    content     TEXT  '이벤트 상세 설명',
    image_url   VARCHAR(255)  '이벤트 이미지 경로',
    start_date  DATE  '이벤트 시작일',
    end_date    DATE  '이벤트 종료일',
    location    VARCHAR(200)  '이벤트 장소',
    reg_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP  '등록일',
    created_by  BIGINT  '작성자 (관리자 ID, FK)',
    FOREIGN KEY(created_by) REFERENCES MEMBER(idx)
);

-- 자유게시판 테이블
CREATE TABLE BOARD_POST (
    post_id     BIGINT AUTO_INCREMENT PRIMARY KEY  '게시글 고유 ID',
    idx   BIGINT NOT NULL  '작성자 회원 ID (FK)',
    title       VARCHAR(200)  '게시글 제목',
    content     TEXT  '게시글 내용',
    reg_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP  '작성일',
    hit         INT DEFAULT 0  '조회수',
    FOREIGN KEY(idx) REFERENCES MEMBER(idx)
);

-- 댓글 테이블
CREATE TABLE BOARD_ (
    _id  BIGINT AUTO_INCREMENT PRIMARY KEY  '댓글 고유 ID',
    post_id     BIGINT NOT NULL  '게시글 ID (FK)',
    idx   BIGINT NOT NULL  '작성자 회원 ID (FK)',
    content     TEXT  '댓글 내용',
    reg_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP  '작성일',
    FOREIGN KEY(post_id) REFERENCES BOARD_POST(post_id),
    FOREIGN KEY(idx) REFERENCES MEMBER(idx)
);

-- 여행지 예약 테이블
CREATE TABLE RESERVATION (
    reservation_id BIGINT AUTO_INCREMENT PRIMARY KEY  '예약 고유 ID',
    idx      BIGINT NOT NULL  '예약자 회원 ID (FK)',
    travel_id      BIGINT NOT NULL  '예약 여행지 ID (FK)',
    reserve_date   DATE NOT NULL  '예약 날짜',
    persons        INT DEFAULT 1  '예약 인원 수',
    status         ENUM('PENDING','CONFIRMED','CANCELLED') DEFAULT 'PENDING'  '예약 상태',
    reg_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP  '예약 신청일',
    FOREIGN KEY(idx) REFERENCES MEMBER(idx),
    FOREIGN KEY(travel_id) REFERENCES TRAVEL_DEST(travel_id)
);

-- 리뷰 테이블 (여행지 후기/평점)
CREATE TABLE REVIEW (
    review_id      BIGINT AUTO_INCREMENT PRIMARY KEY  '리뷰 고유 ID',
    reservation_id BIGINT NOT NULL  '예약 ID (FK, 리뷰는 예약자만 작성 가능)',
    idx      BIGINT NOT NULL  '작성자 회원 ID (FK)',
    travel_id      BIGINT NOT NULL  '리뷰 대상 여행지 ID (FK)',
    rating         INT CHECK (rating BETWEEN 1 AND 5)  '평점 (1~5)',
    content        TEXT  '리뷰 내용',
    reg_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP  '작성일',
    FOREIGN KEY(reservation_id) REFERENCES RESERVATION(reservation_id),
    FOREIGN KEY(idx) REFERENCES MEMBER(idx),
    FOREIGN KEY(travel_id) REFERENCES TRAVEL_DEST(travel_id)
);
