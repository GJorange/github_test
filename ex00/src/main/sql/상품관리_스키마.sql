-- ��ǰ������Ű��
--1.��ü����
    --��ǰ����,��ǰ�̹���,��ǰ,ī�װ� ���̺������ ����
    DROP Table goods_price CASCADE CONSTRAINTS;
    DROP Table goods_image CASCADE CONSTRAINTS;
    DROP Table goods CASCADE CONSTRAINTS;
    DROP Table category CASCADE CONSTRAINTS;
    DROP Table wish CASCADE CONSTRAINTS;
    DROP Table cart CASCADE CONSTRAINTS;
    
    DROP SEQUENCE goods_price_seq;
    DROP SEQUENCE goods_image_seq;
    DROP SEQUENCE goods_seq;
    DROP SEQUENCE wish_seq;
    DROP SEQUENCE cart_seq;
     
    
--2.��ü����(���̺� �� ������)
    --2-1.Category Table
    CREATE TABLE category (
        cate_code1 NUMBER(3),
        cate_name VARCHAR2(30) not null,
        CONSTRAINT category_pk PRIMARY KEY (cate_code1)
    );
    
    --2-2.Goods Table
    CREATE TABLE goods(
        goods_no NUMBER PRIMARY KEY,
        goods_name VARCHAR2(300) not null,
        company VARCHAR2(60),
        goods_code VARCHAR2(10) NOT NULL UNIQUE,
        image_name VARCHAR2(300) not null,
        content VARCHAR2(2000),
        cate_code1 NUMBER(3) not null,
        CONSTRAINT goods_fk FOREIGN KEY (cate_code1) REFERENCES category(cate_code1)
    );
    
    --2-3.goods_image Table
    CREATE TABLE goods_image(
        goods_img_no NUMBER PRIMARY KEY,
        goods_img_name VARCHAR2(300) not null,
        goods_no NUMBER REFERENCES goods(goods_no) on DELETE CASCADE NOT NULL
    );
    
    --2-4.Price Table
    CREATE TABLE goods_price(
        goods_price_no NUMBER PRIMARY KEY,
        price NUMBER(9) not null,
        sale_price NUMBER(9) not null,
        discount_rate NUMBER(3) default 0,
        delivary_charge VARCHAR2(60) default 0,
        goods_no NUMBER REFERENCES goods(goods_no) on DELETE CASCADE NOT NULL
    );
    
    --2-5.wish Table    
    CREATE TABLE wish (
        wish_no NUMBER PRIMARY KEY,
        total NUMBER(9),
        id VARCHAR2(255),
        goods_no NUMBER REFERENCES goods(goods_no) on DELETE CASCADE NOT NULL
    );
    
     --2-5.cart Table    
    CREATE TABLE cart (
        cart_no NUMBER PRIMARY KEY,               -- ��ٱ��� �׸� ��ȣ
        total NUMBER(9),                       -- ��ǰ ����
        total_price NUMBER(9),                    -- �� ����
        quantity NUMBER(9), --�����������ҿ� �ʿ��� �ʵ�
        goods_no NUMBER REFERENCES goods(goods_no) ON DELETE CASCADE NOT NULL,  -- ��ǰ ��ȣ
        id VARCHAR(50) NOT NULL                   -- ����� ID
    );
    
    --sequence ����
    create SEQUENCE goods_seq;
    create SEQUENCE goods_image_seq;
    create SEQUENCE goods_price_seq;
    create SEQUENCE wish_seq;
    create SEQUENCE cart_seq;
    
--3.���õ������߰�
    --3-1.category data / NVL(A,B) : A�� null�̸� B�� ����ȴ�. ��з��Է�
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'����');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'��ǰ');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'ħ��');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'���̺�');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'����');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'Ŀư');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'����');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'����');
    commit;
    select * from category;


    --insert data
    --goods table
    insert into goods(goods_no, goods_name, company, goods_code, image_name, content, cate_code1) values (goods_seq.nextval, 
    '�ƽ�ũ�� Askvol','IKEA','C001','/upload/goods/bed02.png','���ɾƿ��� �ڽ��ְ� ����� ������ ��Ÿ���� ħ���Դϴ�.','3');
    commit;
    select * from goods;
    --goods_image table
    insert into goods_image(goods_img_no, goods_img_name, goods_no) values(goods_image_seq.nextval, '/upload/goods/bed02.png',1);
     
    
    commit;
    select * from goods_image;
    --goods_price table
    insert into goods_price(goods_price_no, price, sale_price, discount_rate, delivary_charge, goods_no)
    values (goods_price_seq.nextval, '300000', '270000', '10', '��۹���(��ġ��뺰��)',1);
    
   
   
   
    commit;
    select * from goods_price;
    

