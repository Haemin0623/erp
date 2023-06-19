![image](https://github.com/Haemin0623/erp/assets/112607474/d0325102-c55e-4f75-9c11-83c1f0da44b9)# ERP
쉐어드원 erp 개발 프로젝트
2022/11/14 ~ 2022/12/15


## 개요
기업 '쉐어드원'과 연계하여 진행된 ERP제작 프로젝트입니다.
ERP란 프로그램의 기본적인 형태와 간단한 데이터 관리를 할 수 있도록 구현 하는것이 목표인 프로젝트입니다.
  
## 개발환경
- IDE : Eclipse (STS4)
* 언어 : JAVA, javaScript
+ 서버 : Apache Tomcat v9.0
- DB : Oracle RDBMS (MyBatis)
  
## ERD
![image](https://github.com/Haemin0623/erp/assets/112607474/52c196eb-afad-47f2-8591-f5a4c03be844)
직원정보, 구매자, 단가, 상품을 관리하는 테이블과, 해당 데이터를 종합하는 주문정보를 저장할 수 있는 테이블로 구성되어있습니다.
  
## 주요 화면 구성
##### 상품관리
![image](https://github.com/Haemin0623/erp/assets/112607474/4e616c84-f85d-49b6-91af-93ce49018d15)
판매상품을 등록하고 상단 검색창에서 검색조건에 맞는 특정 상품을 검색할 수 있습니다.
![image](https://github.com/Haemin0623/erp/assets/112607474/4632d357-63ee-4673-916a-d2b5a1d0f4e1)
상품종류에 따른 상품 코드를 자동으로 채번하고 상품을 등록 할 수도 있습니다.
![image](https://github.com/Haemin0623/erp/assets/112607474/a4fc6df2-fb0b-49b6-91f5-336355039422)
삭제한 상품들은 DB에서 삭제되지 않고 삭제처리되어 삭제항목만 따로 확인 할 수 있습니다.
기본적인 CRUD는 모든 메뉴가 동일합니다.

##### 고객관리
![image](https://github.com/Haemin0623/erp/assets/112607474/4a8e12f3-3cb1-48af-8158-8e6c55253fc0)
기본적인 CRUD는 모든 메뉴가 동일합니다.

##### 판매가관리
![image](https://github.com/Haemin0623/erp/assets/112607474/c76be024-6ea0-4569-9378-6dd9ddc04cf3)
등록한 상품의 판매가는 날짜별로 따로 관리됩니다.

##### 주문관리
![image](https://github.com/Haemin0623/erp/assets/112607474/c43e811e-da2c-4e77-974e-be20ea797b11)
등록한 고객과, 상품에 따른 판매가를 납품요청일에 맞게 자동 설정하며 하나의 주문에 여러개의 상품을 담아 한번에 관리할 수 있습니다
![image](https://github.com/Haemin0623/erp/assets/112607474/7a220567-4246-41f6-9291-9ca0639cf07e)
등록된 주문은 확인하여, 승인 또는 반려 할 수 있으며 주문상태에 따라 다른 색깔로 표현됩니다.

##### 주문관리
![image](https://github.com/Haemin0623/erp/assets/112607474/9a8bb6e3-691e-4476-8c7d-e38be2f17f8b)
등록된 주문들을 총합하여 해당 주문들의 통계를 확인할 수 있습니다.

##### 엑셀추출
![image](https://github.com/Haemin0623/erp/assets/112607474/af120f8d-3774-4e22-a96f-8ec900882772)
그리드에 표현된 리스트는 엑셀로 추출할 수 있습니다.
