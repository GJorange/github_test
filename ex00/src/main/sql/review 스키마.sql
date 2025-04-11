-- 일반게시판 댓글허용
-- 댓글도 하나의 테이블로 관리
-- view.do 댓글 스키마 작성
-- 댓글번호(PK), 글번호(어디에 달린 댓글인지?, FK, board.no)
-- 물품 고유번호, 제목, 내용, 작성자(id), 작성일, 좋아요 개수, 댓글 상태

-- 1. 객체제거
drop table review cascade constraints purge;
drop sequence review_seq;

-- 2. 객체 생성
CREATE TABLE review (
    rno NUMBER PRIMARY KEY,                            -- 댓글 번호 (기본키)
    no NUMBER REFERENCES goods(goods_no) NOT NULL,   -- 상품 번호 (외래키)
    title VARCHAR2(300) NOT NULL,                       -- 제목
    content VARCHAR2(2000) NOT NULL,                    -- 댓글 내용
    id VARCHAR2(30) REFERENCES member(id) NOT NULL,    -- 작성자 ID (외래키)
    writeDate DATE DEFAULT sysdate,                    -- 작성일
    likeCount NUMBER DEFAULT 0,                       -- 댓글 좋아요 개수
    status VARCHAR2(10) DEFAULT 'ACTIVE'               -- 댓글 상태 (ACTIVE, DELETED 등)
);

create sequence review_seq;

-- 댓글 샘플데이터
-- 댓글에는 글넘버가 들어갑니다.
select max(no) from review;

insert into review(rno, no, title, content, id, writeDate, likeCount, status)
    values (review_seq.nextval, 2, '사진이랑 똑같아요!', '만족합니다.', 'test1', sysdate, '9', '삭제');

commit;

select * from review;