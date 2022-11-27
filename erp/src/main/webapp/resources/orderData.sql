insert into M_COUNTRY values ('KOR', '한국', 82);

insert into M_BUYER values ('EMART', 'KOR', '이마트', '이해민',
	'서울특별시 강남구 테헤란로 123', '02-1234-5678', 'haemin@emart.com','N', null);
	
insert into M_EMPLOYEE values ('PSI0000', '박수인', '1234','영업', '대리', 'Y', 'N', null);

insert into ORDER_HEAD values (1, 'EMART', sysdate, 'PSI0000', '승인해줘', '승인대기', null, 'N');