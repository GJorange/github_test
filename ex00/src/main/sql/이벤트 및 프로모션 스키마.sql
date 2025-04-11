-- <�̺�Ʈ �� ���θ�� �Խ��� ��Ű��> --
-- ����
drop table event cascade CONSTRAINTS;
drop SEQUENCE event_seq;

-- ����
create table event(
    eno number primary key, -- �۹�ȣ, image_seq�� ����
    title varchar2(300) not null, -- ����
    content varchar2(2000) not null, -- ����
    startDate date default TO_DATE('2000-01-01', 'YYYY-MM-DD'), -- ������
    endDate date default TO_DATE('2000-01-01', 'YYYY-MM-DD'), -- ������
    writeDate date default TO_DATE('2000-01-01', 'YYYY-MM-DD'), -- �ۼ���
    imageName varchar2(300) NOT NULL -- �̹��� ���� (��ġ+�����̸�)
);

-- event table no�� ����� ������ ����
create SEQUENCE event_seq;

-- ���õ�����
insert into event(eno, title, content, startDate, endDate, writeDate, imageName) 
values(event_seq.nextval, '�����̹���', '�̹����Դϴ�', TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2000-01-01', 'YYYY-MM-DD'), '../../upload/goods/bed01.png');

commit;

select * from event;