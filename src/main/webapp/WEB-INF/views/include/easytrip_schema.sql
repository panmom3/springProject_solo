-- EasyTrip Database Schema (MySQL)

CREATE DATABASE IF NOT EXISTS easytrip DEFAULT CHARACTER SET utf8mb4;
USE easytrip;

-- 1. 회원 테이블
CREATE TABLE member (
    member_id      BIGINT AUTO_INCREMENT PRIMARY KEY,
    username       VARCHAR(50) NOT NULL UNIQUE,
    password       VARCHAR(255) NOT NULL,
    name           VARCHAR(50) NOT NULL,
    email          VARCHAR(100) NOT NULL UNIQUE,
    phone          VARCHAR(20),
    role           ENUM('USER','ADMIN') DEFAULT 'USER',
    join_date      DATETIME DEFAULT NOW(),
    status         TINYINT DEFAULT 1
);

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
		goodCount  INT NOT NULL DEFAULT 0,
		readNum    INT NOT NULL DEFAULT 0,
    primary key(idx),
  	foreign key(mid) references member(mid)
);

-- 3. 숙소
CREATE TABLE stay (
    stay_id        BIGINT AUTO_INCREMENT PRIMARY KEY,
    travel_id      BIGINT,
    name           VARCHAR(100) NOT NULL,
    address        VARCHAR(200),
    price          INT,
    description    TEXT,
    image_url      VARCHAR(200),
    rating         DECIMAL(2,1) DEFAULT 0,
    FOREIGN KEY (travel_id) REFERENCES travel(travel_id) ON DELETE SET NULL
);

-- 4. 예약
CREATE TABLE reservation (
    reservation_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    member_id      BIGINT NOT NULL,
    stay_id        BIGINT NOT NULL,
    check_in       DATE NOT NULL,
    check_out      DATE NOT NULL,
    total_price    INT NOT NULL,
    status         ENUM('예약완료','취소','이용완료') DEFAULT '예약완료',
    created_at     DATETIME DEFAULT NOW(),
    FOREIGN KEY (member_id) REFERENCES member(member_id),
    FOREIGN KEY (stay_id) REFERENCES stay(stay_id)
);

-- 5. 커뮤니티 게시글
CREATE TABLE community_post (
    post_id        BIGINT AUTO_INCREMENT PRIMARY KEY,
    member_id      BIGINT NOT NULL,
    category       ENUM('자유게시판','여행팁','후기') DEFAULT '자유게시판',
    title          VARCHAR(150) NOT NULL,
    content        TEXT NOT NULL,
    image_url      VARCHAR(200),
    view_count     INT DEFAULT 0,
    created_at     DATETIME DEFAULT NOW(),
    updated_at     DATETIME DEFAULT NOW() ON UPDATE NOW(),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

-- 6. 커뮤니티 댓글
CREATE TABLE community_comment (
    comment_id     BIGINT AUTO_INCREMENT PRIMARY KEY,
    post_id        BIGINT NOT NULL,
    member_id      BIGINT NOT NULL,
    content        TEXT NOT NULL,
    created_at     DATETIME DEFAULT NOW(),
    FOREIGN KEY (post_id) REFERENCES community_post(post_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

-- 7. 고객센터 (공지사항, FAQ, 문의)
CREATE TABLE notice (
    notice_id      BIGINT AUTO_INCREMENT PRIMARY KEY,
    admin_id       BIGINT NOT NULL,
    title          VARCHAR(150) NOT NULL,
    content        TEXT,
    created_at     DATETIME DEFAULT NOW(),
    FOREIGN KEY (admin_id) REFERENCES member(member_id)
);

CREATE TABLE faq (
    faq_id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    question       VARCHAR(200) NOT NULL,
    answer         TEXT NOT NULL
);

CREATE TABLE inquiry (
    inquiry_id     BIGINT AUTO_INCREMENT PRIMARY KEY,
    member_id      BIGINT NOT NULL,
    title          VARCHAR(150) NOT NULL,
    content        TEXT NOT NULL,
    reply          TEXT,
    created_at     DATETIME DEFAULT NOW(),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

-- 8. 마이페이지 (찜목록, 후기)
CREATE TABLE wishlist (
    wishlist_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
    member_id      BIGINT NOT NULL,
    stay_id        BIGINT NOT NULL,
    created_at     DATETIME DEFAULT NOW(),
    FOREIGN KEY (member_id) REFERENCES member(member_id),
    FOREIGN KEY (stay_id) REFERENCES stay(stay_id)
);

CREATE TABLE review (
    review_id      BIGINT AUTO_INCREMENT PRIMARY KEY,
    reservation_id BIGINT NOT NULL,
    member_id      BIGINT NOT NULL,
    rating         INT CHECK (rating BETWEEN 1 AND 5),
    content        TEXT,
    created_at     DATETIME DEFAULT NOW(),
    FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

-- 9. 관리자 로그
CREATE TABLE admin_log (
    log_id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    admin_id       BIGINT NOT NULL,
    action_type    VARCHAR(100),
    action_detail  TEXT,
    action_time    DATETIME DEFAULT NOW(),
    FOREIGN KEY (admin_id) REFERENCES member(member_id)
);
