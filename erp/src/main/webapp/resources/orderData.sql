--국가코드--
select * from M_COUNTRY;
insert into M_COUNTRY values ('KR', '한국', 82);
insert into M_COUNTRY values ('CN', '중국', 86);
insert into M_COUNTRY values ('US', '미국', 1);
insert into M_COUNTRY values ('VN', '베트남', 84);
insert into M_COUNTRY values ('JP', '일본', 81);
insert into M_COUNTRY values ('IN', '인도', 91);
insert into M_COUNTRY values ('DE', '독일', 49);
insert into M_COUNTRY values ('SG', '싱가포르', 65);
insert into M_COUNTRY values ('GB', '영국', 44);
insert into M_COUNTRY values ('CH', '스위스', 41);


--상품
INSERT INTO m_product
VALUES ('SN0001', '새우깡', '290g','개', '스낵', sysdate, 'N', null);
INSERT INTO m_product
VALUES ('SN0002', '누네띠네', '170g', '개', '스낵', sysdate, 'N', null);
INSERT INTO m_product
VALUES ('SN0003', '치토스', '180g', '개', '스낵', sysdate, 'N', null);
INSERT INTO m_product
VALUES ('SN0004', '참크래커', '220g', '개', '스낵', sysdate, 'Y', '2022-11-25');
INSERT INTO m_product
VALUES ('SN0005', '다이제', '370g', '개', '스낵', sysdate, 'N', null);
INSERT INTO m_product
VALUES ('SN0006', '포카칩', '240g', '개', '스낵', sysdate, 'N', null);
INSERT INTO m_product
VALUES ('RA0001', '육개장', '120g', '개', '라면', sysdate, 'N', null);
INSERT INTO m_product
VALUES ('RA0002', '신라면', '130g', '개', '라면', sysdate, 'N', null);
INSERT INTO m_product
VALUES ('DR0001', '파워에이드', '250ml', '병', '음료', sysdate, 'N', null);
INSERT INTO m_product
VALUES ('DR0002', '포카리스웨트', '200ml', '병', '음료', sysdate, 'N', null);


-- update M_BUYER set country_cd = 'KR' where name = '이마트';
--고객코드--
select * from M_BUYER;


insert into M_BUYER values ('CVS001', 'KR', 'BGF리테일', '황시유', '서울특별시 강남구 테헤란로 405', '02-1234-1234', 'hwang@cu.com',sysdate, 'N', null);
insert into M_BUYER values ('CVS002', 'KR', 'GS리테일', '이시보', '서울시 강남구 논현로 508', '02-5678-1234', 'lee25@gs.com',sysdate, 'N', null);
insert into M_BUYER values ('CVS003', 'KR', '롯데', '김로티', '서울특별시 송파구 올림픽로 300', '02-4321-4321', 'lotti@seven.com',sysdate, 'N', null);
insert into M_BUYER values ('CVS004', 'KR', '이마트24', '이나나', '서울특별시 성동구 광나루로 310', '02-5432-1234', 'nanana@emart.com',sysdate, 'N', null);
insert into M_BUYER values ('CVS005', 'KR', '미니스톱', '박미니', '서울특별시 서초구 효령로 11', '02-1321-1432', 'mini@stop.com',sysdate, 'N', null);
insert into M_BUYER values ('MAT001', 'KR', '롯데마트', '이해피', '서울특별시 성동구 뚝섬로 377', '02-6431-2142', 'mini@stop.com',sysdate, 'N', null);
insert into M_BUYER values ('MAT002', 'KR', '이마트', '이해민','서울특별시 강남구 테헤란로 123', '02-1234-5678', 'haemin@naver.com',sysdate,'N', null);
insert into M_BUYER values ('FOD001', 'KR', 'CJ제일제당', '최선희','서울특별시 강남구 테헤란로 123', '02-1234-5678', 'sunny@naver.com',sysdate,'N', null);
insert into M_BUYER values ('FOD002', 'KR', '롯데푸드', '김창률',	'서울특별시 강남구 테헤란로 123', '02-1234-5678', 'chang@naver.com',sysdate,'N', null);
insert into M_BUYER values ('FOD003', 'KR', '오뚜기', '박수인',	'서울특별시 강남구 테헤란로 32', '02-1234-5678', 'sooin818@naver.com',sysdate,'N', null);
insert into M_BUYER values ('FOD004', 'KR', '농심', '박현서',	'서울특별시 강남구 테헤란로 14', '02-1234-5678', 'phs@naver.com',sysdate,'N', null);
insert into M_BUYER values ('FOD005', 'CN', '롯데푸드', 'Wang fei', '서울특별시 강남구 테헤란로 123', '02-1234-5678', 'wangfei@google.com',sysdate, 'N', null);
insert into M_BUYER values ('FOD006', 'CN', '칭따오', 'Zhao wei','서울특별시 강남구 테헤란로 12', '02-1234-5678', 'zhaowei@google.com',sysdate, 'N', null);
insert into M_BUYER values ('FOD007', 'US', '크래프트푸드', 'Ashley Park','서울특별시 강남구 테헤란로 4', '02-1234-5678', 'ashleypark@google.com',sysdate, 'N', null);
insert into M_BUYER values ('FOD008', 'US', '켈로그', 'John Brown','서울특별시 강남구 테헤란로 5', '02-1234-5678', 'johnbrown@google.com',sysdate, 'N', null);
insert into M_BUYER values ('FOD009', 'VN', '비나밀크', 'Nguyen Xuan Phuc','서울특별시 강남구 테헤란로88', '02-1234-5678', 'nguyenxuanphuc@google.com',sysdate, 'N', null);
insert into M_BUYER values ('FOD010', 'JP', '아지노모토', 'Toriyama Akira','서울특별시 강남구 테헤란로 33', '02-1234-5678', 'toriyamaakira@google.com',sysdate, 'N', null);
insert into M_BUYER values ('FOD011', 'IN', '네슬레인디아', 'Kabir Bedi','서울특별시 강남구 테헤란로 44', '02-1234-5678', 'kabirbedi@google.com',sysdate,'N', null);
insert into M_BUYER values ('FOD012', 'DE', '하리보', 'Michael Hofmann','서울특별시 강남구 테헤란로 12', '02-1234-5678', 'michaelhofmann@google.com',sysdate, 'N', null);
insert into M_BUYER values ('FOD013', 'CH', '네슬레', 'Granit Xhaka','서울특별시 강남구 테헤란로 12', '02-1234-5678', 'granitxhaka@google.com',sysdate, 'N', null);
insert into M_BUYER values ('FOD014', 'GB', '영국연합식품', 'James Brown', '서울특별시 강남구 테헤란로 13', '02-1234-5678', 'jamesbrown@google.com',sysdate, 'N', null);
insert into M_BUYER values ('FOD015', 'SG', '월마인터네셔널', 'Baihakki Khaizan', '서울특별시 강남구 테헤란로 133', '02-1234-5678', 'baihakkikhaizan@google.com',sysdate, 'N', null);


--직원
insert into M_EMPLOYEE values ('SAL001', '이해민', '1234', '영업', '사원', 'N', sysdate, 'N', null );
insert into M_EMPLOYEE values ('SAL002', '김창률', '1234', '영업', '대리', 'N', sysdate, 'N', null );
insert into M_EMPLOYEE values ('SAL003', '최선희', '1234', '영업', '과장', 'Y', sysdate, 'N', null );
insert into M_EMPLOYEE values ('SAL004', '박현서', '1234', '영업', '차장', 'Y', sysdate, 'N', null );
insert into M_EMPLOYEE values ('SAL005', '박수인', '1234', '영업', '부장', 'Y', sysdate, 'N', null );
insert into M_EMPLOYEE values ('MNG001', '민해이', '1234', '관리', '사원', 'N', sysdate, 'N', null );
insert into M_EMPLOYEE values ('MNG002', '률창김', '1234', '관리', '대리', 'N', sysdate, 'N', null );
insert into M_EMPLOYEE values ('MNG003', '희선최', '1234', '관리', '과장', 'N', sysdate, 'N', null );
insert into M_EMPLOYEE values ('MNG004', '서현박', '1234', '관리', '차장', 'N', sysdate, 'N', null );
insert into M_EMPLOYEE values ('MNG005', '인수박', '1234', '관리', '부장', 'Y', sysdate, 'N', null );

--주문 해민
insert into ORDER_HEAD values ('220304CVS001001', 'CVS001', '2022-03-04', 'SAL001', null, '승인', '220310', 'SAL004','N');
insert into ORDER_ITEM values ('220304CVS001001', 'SN0001', 1000, '2022-03-26', 300, 1000*300, null);
insert into ORDER_ITEM values ('220304CVS001001', 'SN0004', 1500, '2022-03-26', 350, 1500*350, null);
insert into ORDER_ITEM values ('220304CVS001001', 'SN0006', 500, '2022-04-01', 400, 500*400, '확실히');
insert into ORDER_ITEM values ('220304CVS001001', 'RA0002', 1000, '2022-03-26', 600, 1000*600, '검수 확실히');

insert into ORDER_HEAD values ('220304CVS001002', 'CVS001', '2022-03-04', 'SAL002', null, '반려', '220305', 'SAL005', 'N');
insert into ORDER_ITEM values ('220304CVS001002', 'SN0004', 1000, '2022-04-04', 300, 1000*300, null);
insert into ORDER_ITEM values ('220304CVS001002', 'SN0002', 1500, '2022-04-04', 350, 1500*350, null);
insert into ORDER_ITEM values ('220304CVS001002', 'RA0002', 500, '2022-04-04', 400, 500*400, null);
insert into ORDER_ITEM values ('220304CVS001002', 'DR0001', 1000, '2022-03-20', 600, 1000*600, '검수 확실히');

insert into ORDER_HEAD values ('220623MAT002001', 'MAT002', '2022-06-23', 'SAL001', null, '승인', '220627', 'SAL005', 'N');
insert into ORDER_ITEM values ('220623MAT002001', 'SN0005', 1000, '2022-07-26', 300, 1000*300, null);
insert into ORDER_ITEM values ('220623MAT002001', 'SN0006', 1500, '2022-07-26', 350, 1500*350, null);
insert into ORDER_ITEM values ('220623MAT002001', 'RA0001', 500, '2022-07-26', 400, 500*400, null);
insert into ORDER_ITEM values ('220623MAT002001', 'DR0002', 1000, '2022-07-26', 600, 1000*600, '검수 확실히');

insert into ORDER_HEAD values ('220919FOD006001', 'FOD006', '2022-09-19', 'SAL002', null, '승인요청', '220920', null, 'N');
insert into ORDER_ITEM values ('220919FOD006001', 'SN0001', 1000, '2022-09-24', 300, 1000*300, '품질문제 없이');
insert into ORDER_ITEM values ('220919FOD006001', 'SN0005', 1500, '2022-09-24', 350, 1500*350, null);
insert into ORDER_ITEM values ('220919FOD006001', 'RA0002', 500, '2022-09-24', 400, 500*400, null);
insert into ORDER_ITEM values ('220919FOD006001', 'DR0002', 1000, '2022-09-24', 600, 1000*600, '급하게 요구');

insert into ORDER_HEAD values ('221127FOD014001', 'FOD014', '2022-11-27', 'SAL001', null, '승인대기', '221129', null, 'N');
insert into ORDER_ITEM values ('221127FOD014001', 'SN0003', 1000, '2022-12-26', 300, 1000*300, null);
insert into ORDER_ITEM values ('221127FOD014001', 'SN0004', 1500, '2022-12-26', 350, 1500*350, null);
insert into ORDER_ITEM values ('221127FOD014001', 'SN0005', 500, '2022-12-26', 400, 500*400, null);
insert into ORDER_ITEM values ('221127FOD014001', 'RA0002', 1000, '2022-12-26', 600, 1000*600, '검수 확실히');


--주문 선희

insert into order_head values('200214MAT002001', 'MAT002', '200303', 'SAL001', null, '승인', '200305', 'MNG001', 'N');
insert into order_item values('200214MAT002001', 'SN0001', 100, '200403', 856, 100*856, null);
insert into order_item values('200214MAT002001', 'SN0002', 150, '200403', 756, 150*756, null);
insert into order_item values('200214MAT002001', 'SN0003', 120, '200403', 900, 120*900, null);

insert into order_head values('210314FOD001001', 'FOD001', '211003', 'SAL002', '기간 안에 납품 불가능, 납품일 조율 요망', '반려', '211007', 'MNG002', 'N');
insert into order_item values('210314FOD001001', 'RA0001', 100, '211013', 856, 100*856, null);
insert into order_item values('210314FOD001001', 'RA0002', 150, '211013', 756, 150*756, null);
insert into order_item values('210314FOD001001', 'DR0001', 120, '211013', 900, 120*900, null);
insert into order_item values('210314FOD001001', 'DR0002', 150, '211013', 756, 150*756, null);
insert into order_item values('210314FOD001001', 'SN0006', 120, '211013', 900, 120*900, null);


insert into order_head values('210314FOD001002', 'FOD001', '211007', 'SAL002', null, '승인', '211008', 'MNG002', 'N');
insert into order_item values('210314FOD001002', 'RA0001', 100, '211113', 856, 100*856, null);
insert into order_item values('210314FOD001002', 'RA0002', 150, '211113', 756, 150*756, '물량 준비시 먼저 납품 예정');
insert into order_item values('210314FOD001002', 'DR0001', 120, '211113', 900, 120*900, null);
insert into order_item values('210314FOD001002', 'DR0002', 150, '211113', 756, 150*756, null);
insert into order_item values('210314FOD001002', 'SN0006', 120, '211113', 900, 120*900, null);

insert into order_head values('221124CVS002001', 'CVS002', '221128', 'SAL004', null, '승인요청', '221128', null, 'N');
insert into order_item values('221124CVS002001', 'SN0003', 100, '221228', 856, 100*856, null);
insert into order_item values('221124CVS002001', 'SN0005', 150, '221228', 756, 150*756, null);

insert into order_head values('221124CVS001001', 'CVS001', '221128', 'SAL005', null, '승인대기', '221128', null, 'N');
insert into order_item values('221124CVS001001', 'RA0001', 100, '230102', 856, 100*856, null);
insert into order_item values('221124CVS001001', 'DR0002', 150, '230102', 756, 150*756, null);
insert into order_item values('221124CVS001001', 'SN0003', 120, '230102', 900, 120*900, null);



--판매가 현서
select * from m_pricing;
insert into m_pricing values('CVS001', 'SN0001', '2021-05-17', '2022-12-01', 1200, '원(₩)', 0, sysdate, 'N', NULL);
insert into m_pricing values('CVS002', 'SN0002', '2022-03-12', '2023-02-27', 1500, '원(₩)', 0, sysdate, 'N', NULL);
insert into m_pricing values('CVS003', 'SN0003', '2022-07-28', '2022-12-28', 1700, '원(₩)', 2, sysdate, 'N', NULL);
insert into m_pricing values('CVS004', 'SN0004', '2021-11-04', '2023-05-26', 3500, '원(₩)', 4, sysdate, 'N', NULL);
insert into m_pricing values('CVS005', 'SN0005', '2022-01-08', '2023-07-12', 2400, '원(₩)', 0, sysdate, 'N', NULL);
insert into m_pricing values('MAT001', 'SN0006', '2022-04-22', '2022-10-04', 2000, '원(₩)', 0, sysdate, 'N', NULL);
insert into m_pricing values('MAT002', 'RA0001', '2022-03-14', '2023-04-08', 1400, '원(₩)', 1, sysdate, 'N', NULL);
insert into m_pricing values('FOD001', 'RA0002', '2021-07-30', '2023-10-31', 1300, '원(₩)', 0, sysdate, 'N', NULL);
insert into m_pricing values('FOD002', 'DR0001', '2022-09-02', '2022-11-07', 1000, '원(₩)', 3, sysdate, 'N', NULL);
insert into m_pricing values('FOD003', 'DR0002', '2022-06-16', '2023-05-27', 1100, '원(₩)', 0, sysdate, 'N', NULL);



-- 그래프 영업 사원 별 12월 매출 실적 용
insert into order_head values('221201FOD001001', 'FOD001', '221201', 'SAL001', '기간 안에 납품 가능, 납품일 조율 요망', '승인', '221203', 'MNG002', 'N');
insert into order_item values('221201FOD001001', 'RA0001', 3500, '221201', 856, 3500*856, null);

insert into order_head values('221201CVS002001', 'CVS002', '221201', 'SAL002', '기간 안에 납품 가능, 납품일 조율 요망', '승인', '221203', 'MNG002', 'N');
insert into order_item values('221201CVS002001', 'RA0002', 1500, '221201', 1003, 1500*1003, null);

insert into order_head values('221201MAT001001', 'MAT001', '221201', 'SAL003', '기간 안에 납품 가능, 납품일 조율 요망', '승인', '221203', 'MNG002', 'N');
insert into order_item values('221201MAT001001', 'SN0006', 1300, '221201', 555, 1300*555, null);

insert into order_head values('221201CVS003001', 'CVS003', '221201', 'SAL004', '기간 안에 납품 가능, 납품일 조율 요망', '승인', '221203', 'MNG002', 'N');
insert into order_item values('221201CVS003001', 'SN0005', 2000, '221201', 1278, 2000*1278, null);

insert into order_head values('221201CVS004001', 'CVS004', '221201', 'SAL005', '기간 안에 납품 가능, 납품일 조율 요망', '승인', '221203', 'MNG002', 'N');
insert into order_item values('221201CVS004001', 'SN0003', 1700, '221201', 856, 1700*856, null);

