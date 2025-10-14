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
    travel_id      BIGINT AUTO_INCREMENT PRIMARY KEY,
    title          VARCHAR(100) NOT NULL,
    region         VARCHAR(50) NOT NULL,
    theme          VARCHAR(50),
    description    TEXT,
    address        VARCHAR(200),
    image_url      VARCHAR(200),
    create_date    DATETIME DEFAULT NOW(),
    update_date    DATETIME DEFAULT NOW() ON UPDATE NOW()
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
