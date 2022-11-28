
-- insert into M_COUNTRY values ('KOR', '한국', 82);
-- delete from M_COUNTRY where country_cd='KOR';

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

-- update M_BUYER set country_cd = 'KR' where name = '이마트';


--고객코드--
select * from M_BUYER;
insert into M_BUYER values ('CVS001', 'KR', 'BGF리테일', '황시유', '서울특별시 강남구 테헤란로 405', '02-1234-1234', 'hwang@cu.com', 'N', null);
insert into M_BUYER values ('CVS002', 'KR', 'GS리테일', '이시보', '서울시 강남구 논현로 508', '02-5678-1234', 'lee25@gs.com', 'N', null);
insert into M_BUYER values ('CVS003', 'KR', '롯데', '김로티', '서울특별시 송파구 올림픽로 300', '02-4321-4321', 'lotti@seven.com', 'N', null);
insert into M_BUYER values ('CVS004', 'KR', '이마트24', '이나나', '서울특별시 성동구 광나루로 310', '02-5432-1234', 'nanana@emart.com', 'N', null);
insert into M_BUYER values ('CVS005', 'KR', '미니스톱', '박미니', '서울특별시 서초구 효령로 11', '02-1321-1432', 'mini@stop.com', 'N', null);
insert into M_BUYER values ('MAT001', 'KR', '롯데마트', '이해피', '서울특별시 성동구 뚝섬로 377', '02-6431-2142', 'mini@stop.com', 'N', null);
insert into M_BUYER values ('MAT002', 'KR', '이마트', '이해민','서울특별시 강남구 테헤란로 123', '02-1234-5678', 'haemin@naver.com','N', null);
insert into M_BUYER values ('FOD001', 'KR', 'CJ제일제당', '최선희','서울특별시 강남구 테헤란로 123', '02-1234-5678', 'sunny@naver.com','N', null);
insert into M_BUYER values ('FOD002', 'KR', '롯데푸드', '김창률',	'서울특별시 강남구 테헤란로 123', '02-1234-5678', 'chang@naver.com','N', null);
insert into M_BUYER values ('FOD003', 'KR', '오뚜기', '박수인',	'서울특별시 강남구 테헤란로 32', '02-1234-5678', 'sooin818@naver.com','N', null);
insert into M_BUYER values ('FOD004', 'KR', '농심', '박현서',	'서울특별시 강남구 테헤란로 14', '02-1234-5678', 'phs@naver.com','N', null);
insert into M_BUYER values ('FOD005', 'CN', '롯데푸드', 'Wang fei',	'서울특별시 강남구 테헤란로 123', '02-1234-5678', 'wangfei@google.com','N', null);
insert into M_BUYER values ('FOD006', 'CN', '칭따오', 'Zhao wei','서울특별시 강남구 테헤란로 12', '02-1234-5678', 'zhaowei@google.com','N', null);
insert into M_BUYER values ('FOD007', 'US', '크래프트푸드', 'Ashley Park','서울특별시 강남구 테헤란로 4', '02-1234-5678', 'ashleypark@google.com','N', null);
insert into M_BUYER values ('FOD008', 'US', '켈로그', 'John Brown','서울특별시 강남구 테헤란로 5', '02-1234-5678', 'johnbrown@google.com','N', null);
insert into M_BUYER values ('FOD009', 'VN', '비나밀크', 'Nguyen Xuan Phuc','서울특별시 강남구 테헤란로88', '02-1234-5678', 'nguyenxuanphuc@google.com','N', null);
insert into M_BUYER values ('FOD010', 'JP', '아지노모토', 'Toriyama Akira','서울특별시 강남구 테헤란로 33', '02-1234-5678', 'toriyamaakira@google.com','N', null);
insert into M_BUYER values ('FOD011', 'IN', '네슬레인디아', 'Kabir Bedi','서울특별시 강남구 테헤란로 44', '02-1234-5678', 'kabirbedi@google.com','N', null);
insert into M_BUYER values ('FOD012', 'DE', '하리보', 'Michael Hofmann','서울특별시 강남구 테헤란로 12', '02-1234-5678', 'michaelhofmann@google.com','N', null);
insert into M_BUYER values ('FOD013', 'CH', '네슬레', 'Granit Xhaka','서울특별시 강남구 테헤란로 12', '02-1234-5678', 'granitxhaka@google.com','N', null);
insert into M_BUYER values ('FOD014', 'GB', '영국연합식품', 'James Brown',	'서울특별시 강남구 테헤란로 13', '02-1234-5678', 'jamesbrown@google.com','N', null);
insert into M_BUYER values ('FOD015', 'SG', '월마인터네셔널', 'Baihakki Khaizan',	'서울특별시 강남구 테헤란로 133', '02-1234-5678', 'baihakkikhaizan@google.com','N', null);



select *from ORDER_item;

insert into M_COUNTRY values ('KOR', '한국', 82);

insert into M_EMPLOYEE values ('PSI0000', '박수인', '1234','영업', '대리', 'Y', 'N', null);

insert into ORDER_HEAD values (1, 'EMART', sysdate, 'PSI0000', '승인해줘', '승인대기', null, 'N');



select * from BUYER;
select * from M_COUNTRY;


insert into M_PRODUCT values ('swg0010', '새우깡', '60g', '개', '스낵', sysdate, 'N', null);


insert into M_EMPLOYEE values ('SAL001', '이해민', '1234', '영업', '사원', 'N', 'N', null );
insert into M_EMPLOYEE values ('SAL002', '김창률', '1234', '영업', '대리', 'N', 'N', null );
insert into M_EMPLOYEE values ('SAL003', '최선희', '1234', '영업', '과장', 'Y', 'N', null );
insert into M_EMPLOYEE values ('SAL004', '박현서', '1234', '영업', '차장', 'Y', 'N', null );
insert into M_EMPLOYEE values ('SAL005', '박수인', '1234', '영업', '부장', 'Y', 'N', null );
insert into M_EMPLOYEE values ('MNG001', '민해이', '1234', '관리', '사원', 'N', 'N', null );
insert into M_EMPLOYEE values ('MNG002', '률창김', '1234', '관리', '대리', 'N', 'N', null );
insert into M_EMPLOYEE values ('MNG003', '희선최', '1234', '관리', '과장', 'N', 'N', null );
insert into M_EMPLOYEE values ('MNG004', '서현박', '1234', '관리', '차장', 'N', 'N', null );
insert into M_EMPLOYEE values ('MNG005', '인수박', '1234', '관리', '부장', 'Y', 'N', null );

insert into ORDER_HEAD values ('220304 001', '', '2022-03-04', 'SAL001', null, '승인', null, 'SAL004','N');
insert into ORDER_ITEM values ('', '', 1000, '2022-03-26', 300, 1000*300, null, 'N', null);
insert into ORDER_ITEM values ('', '', 1500, '2022-03-26', 350, 1500*350, null, 'N', null);
insert into ORDER_ITEM values ('', '', 500, '2022-04-01', 400, 500*400, '확실히', 'N', null);
insert into ORDER_ITEM values ('', '', 1000, '2022-03-26', 600, 1000*600, '검수 확실히', 'N', null);

insert into ORDER_HEAD values ('220304 002', '', '2022-03-04', 'SAL002', null, '반려', null, 'SAL005', 'N');
insert into ORDER_ITEM values ('', '', 1000, '2022-04-04', 300, 1000*300, null, 'N', null);
insert into ORDER_ITEM values ('', '', 1500, '2022-04-04', 350, 1500*350, null, 'N', null);
insert into ORDER_ITEM values ('', '', 500, '2022-04-04', 400, 500*400, null, 'N', null);
insert into ORDER_ITEM values ('', '', 1000, '2022-03-20', 600, 1000*600, '검수 확실히', 'N', null);

insert into ORDER_HEAD values ('220623 001', '', '2022-06-23', 'SAL001', null, '승인', null, 'SAL005', 'N');
insert into ORDER_ITEM values ('', '', 1000, '2022-07-26', 300, 1000*300, null, 'N', null);
insert into ORDER_ITEM values ('', '', 1500, '2022-07-26', 350, 1500*350, null, 'N', null);
insert into ORDER_ITEM values ('', '', 500, '2022-07-26', 400, 500*400, null, 'N', null);
insert into ORDER_ITEM values ('', '', 1000, '2022-07-26', 600, 1000*600, '검수 확실히', 'N', null);

insert into ORDER_HEAD values ('220919 001', '', '2022-09-19', 'SAL002', null, '승인요청', null, null, 'N');
insert into ORDER_ITEM values ('', '', 1000, '2022-09-24', 300, 1000*300, '품질문제 없이', 'N', null);
insert into ORDER_ITEM values ('', '', 1500, '2022-09-24', 350, 1500*350, null, 'N', null);
insert into ORDER_ITEM values ('', '', 500, '2022-09-24', 400, 500*400, null, 'N', null);
insert into ORDER_ITEM values ('', '', 1000, '2022-09-24', 600, 1000*600, '급하게 요구', 'N', null);

insert into ORDER_HEAD values ('221127 001', '', '2022-11-27', 'SAL001', null, '승인대기', null, null, 'N');
insert into ORDER_ITEM values ('', '', 1000, '2022-12-26', 300, 1000*300, null, 'N', null);
insert into ORDER_ITEM values ('', '', 1500, '2022-12-26', 350, 1500*350, null, 'N', null);
insert into ORDER_ITEM values ('', '', 500, '2022-12-26', 400, 500*400, null, 'N', null);
insert into ORDER_ITEM values ('', '', 1000, '2022-12-26', 600, 1000*600, '검수 확실히', 'N', null);

