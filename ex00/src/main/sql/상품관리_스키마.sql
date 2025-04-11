-- 상품관리스키마
--1.객체삭제
    --상품가격,상품이미지,상품,카테고리 테이블순으로 삭제
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
     
    
--2.객체세팅(테이블 및 시퀀스)
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
        cart_no NUMBER PRIMARY KEY,               -- 장바구니 항목 번호
        total NUMBER(9),                       -- 상품 수량
        total_price NUMBER(9),                    -- 총 가격
        quantity NUMBER(9), --갯수증가감소에 필요한 필드
        goods_no NUMBER REFERENCES goods(goods_no) ON DELETE CASCADE NOT NULL,  -- 상품 번호
        id VARCHAR(50) NOT NULL                   -- 사용자 ID
    );
    
    --sequence 생성
    create SEQUENCE goods_seq;
    create SEQUENCE goods_image_seq;
    create SEQUENCE goods_price_seq;
    create SEQUENCE wish_seq;
    create SEQUENCE cart_seq;
    
--3.샘플데이터추가
    --3-1.category data / NVL(A,B) : A가 null이면 B로 적용된다. 대분류입력
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'의자');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'소품');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'침구');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'테이블');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'수납');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'커튼');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'러그');
    insert into category(cate_code1, cate_name) values((select NVL(max(cate_code1),0)+1 from category),'조명');
    commit;
    select * from category;


    --insert data
    --goods table
    insert into goods(goods_no, goods_name, company, goods_code, image_name, content, cate_code1) values (goods_seq.nextval, 
    '아스크볼 Askvol','IKEA','C001','/upload/goods/bed02.png','이케아에서 자신있게 출시한 스웨덴 스타일의 침대입니다.','3');
    commit;
    select * from goods;
    --goods_image table
    insert into goods_image(goods_img_no, goods_img_name, goods_no) values(goods_image_seq.nextval, '/upload/goods/bed02.png',1);
     
    
    commit;
    select * from goods_image;
    --goods_price table
    insert into goods_price(goods_price_no, price, sale_price, discount_rate, delivary_charge, goods_no)
    values (goods_price_seq.nextval, '300000', '270000', '10', '배송무료(설치비용별도)',1);
    
   
   
   
    commit;
    select * from goods_price;
    

