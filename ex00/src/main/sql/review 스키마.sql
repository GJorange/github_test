-- �ϹݰԽ��� ������
-- ��۵� �ϳ��� ���̺�� ����
-- view.do ��� ��Ű�� �ۼ�
-- ��۹�ȣ(PK), �۹�ȣ(��� �޸� �������?, FK, board.no)
-- ��ǰ ������ȣ, ����, ����, �ۼ���(id), �ۼ���, ���ƿ� ����, ��� ����

-- 1. ��ü����
drop table review cascade constraints purge;
drop sequence review_seq;

-- 2. ��ü ����
CREATE TABLE review (
    rno NUMBER PRIMARY KEY,                            -- ��� ��ȣ (�⺻Ű)
    no NUMBER REFERENCES goods(goods_no) NOT NULL,   -- ��ǰ ��ȣ (�ܷ�Ű)
    title VARCHAR2(300) NOT NULL,                       -- ����
    content VARCHAR2(2000) NOT NULL,                    -- ��� ����
    id VARCHAR2(30) REFERENCES member(id) NOT NULL,    -- �ۼ��� ID (�ܷ�Ű)
    writeDate DATE DEFAULT sysdate,                    -- �ۼ���
    likeCount NUMBER DEFAULT 0,                       -- ��� ���ƿ� ����
    status VARCHAR2(10) DEFAULT 'ACTIVE'               -- ��� ���� (ACTIVE, DELETED ��)
);

create sequence review_seq;

-- ��� ���õ�����
-- ��ۿ��� �۳ѹ��� ���ϴ�.
select max(no) from review;

insert into review(rno, no, title, content, id, writeDate, likeCount, status)
    values (review_seq.nextval, 2, '�����̶� �Ȱ��ƿ�!', '�����մϴ�.', 'test1', sysdate, '9', '����');

commit;

select * from review;