-- <이벤트 및 프로모션 게시판 스키마> --
-- 제거
drop table event cascade CONSTRAINTS;
drop SEQUENCE event_seq;

-- 생성
create table event(
    eno number primary key, -- 글번호, image_seq로 세팅
    title varchar2(300) not null, -- 제목
    content varchar2(2000) not null, -- 내용
    startDate date default TO_DATE('2000-01-01', 'YYYY-MM-DD'), -- 시작일
    endDate date default TO_DATE('2000-01-01', 'YYYY-MM-DD'), -- 종료일
    writeDate date default TO_DATE('2000-01-01', 'YYYY-MM-DD'), -- 작성일
    imageName varchar2(300) NOT NULL -- 이미지 파일 (위치+파일이름)
);

-- event table no에 사용할 시퀀스 생성
create SEQUENCE event_seq;

-- 샘플데이터
insert into event(eno, title, content, startDate, endDate, writeDate, imageName) 
values(event_seq.nextval, '샘플이미지', '이미지입니다', TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2000-01-01', 'YYYY-MM-DD'), '../../upload/goods/bed01.png');

commit;

select * from event;