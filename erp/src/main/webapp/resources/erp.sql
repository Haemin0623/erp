drop table m_country cascade constraints;
drop table m_buyer cascade constraints;
drop table m_product cascade constraints;
drop table m_pricing cascade constraints;
drop table m_employee cascade constraints;
drop table order_head cascade constraints;
drop table order_item cascade constraints;

create table m_country(
    country_cd  varchar2(3) not null PRIMARY KEY,
    cname        varchar2(50) not null,
    calling_cd  number(3) not null
);

create table m_buyer(
    buyer_cd    varchar2(40) not null PRIMARY KEY,
    country_cd  varchar2(3) not null,
    bname        varchar2(100) not null,
    manager     varchar2(100) not null,
    address     varchar2(300) not null,
    tel         varchar2(20) not null,
    email       varchar2(50) not null,
    adddate		date not null,
    del         varchar2(1) DEFAULT 'N' not null,
    statusdate	date,
    
    constraint check_del check(del in ('N', 'Y')),
    constraint fk_buyer_country_cd foreign key (country_cd) references m_country(country_cd)
);

create table m_product(
    product_cd  varchar2(40) not null PRIMARY KEY,
    pname        varchar2(100) not null,
    volume      varchar2(10) not null,
    unit        varchar2(10) not null,
    category    varchar2(40) not null,
    adddate     date       default sysdate not null,
    del         varchar2(1) not null,
    statusdate		date,
    
     constraint check_del2 check(del in ('N', 'Y'))
);

create table m_pricing(
    buyer_cd    varchar2(40) not null,
    product_cd  varchar2(40) not null,
    startdate   date not null,
    enddate   	date not null,    
    price       number(10) not null,
    currency    varchar2(10) not null,
    discountrate number(10) not null,
    adddate		date not null,
    del         varchar2(1) DEFAULT 'N' not null,
    statusdate	date,
    
    constraint check_del3 check(del in ('N', 'Y')),
    constraint pk_pricing PRIMARY KEY(buyer_cd, product_cd, startdate ,enddate),
    constraint fk_pricing_buyer_cd foreign key (buyer_cd) references m_buyer(buyer_cd),
    constraint fk_pricing_product_cd foreign key (product_cd) references m_product(product_cd)
    );
    
create table m_employee(
    employee_cd varchar2(40) not null PRIMARY KEY,
    ename        varchar2(100) not null,
    password    varchar2(30) not null,
    department  varchar2(30) not null,
    job         varchar2(30) not null,
    authority   varchar2(1) default 'N' not null,
    adddate		date not null,
    del         varchar2(1) DEFAULT 'N' not null,
    statusdate	date,
    
     constraint check_del4 check(del in ('N', 'Y')),
     constraint check_authority check(authority in ('N', 'Y'))
);

create table order_head(
    order_no    varchar2(40) not null PRIMARY key,
    buyer_cd    varchar2(40) not null,
    orderdate   date DEFAULT sysdate not null,
    employee_cd varchar2(40) not null,
    reason      varchar2(300),
    status      varchar2(30) DEFAULT '승인대기'   not null,
    statusdate	date,
    signemp_cd	varchar2(40),
    del         varchar2(1) DEFAULT 'N' not null,
    
    constraint check_del5 check(del in ('N', 'Y')),
    
    constraint fk_order_head_buyer_cd foreign key (buyer_cd) references m_buyer(buyer_cd),
    constraint fk_order_head_employee_cd foreign key (employee_cd) references m_employee(employee_cd)
);

create table order_item(
    order_no    varchar2(40) not null,
    product_cd  varchar2(40) not null,
    requestqty  number(10) not null,
    requestdate date not null,
    price       number(10) not null,
    amount      number(20) not null,
    remark      varchar2(300),
    
    CONSTRAINT pk_order_item PRIMARY KEY(order_no, product_cd),
    constraint fk_order_item_order_no foreign key (order_no) references order_head(order_no),
    constraint fk_order_item_product_cd foreign key (product_cd) references m_product(product_cd)
);


select * from ORDER_ITEM;
select * from ORDER_HEAD;
select * from BUYER;
select * from M_BUYER;