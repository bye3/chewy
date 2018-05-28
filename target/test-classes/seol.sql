--회원정보 수정
update GT_MEMBER set password='1234', address='성남', email='gmail.com'
where id='javaking'

--비밀번호 변경
update GT_MEMBER set password='1111'
where password='1234';

--회원탈퇴
update GT_MEMBER set mgroup_no = '5'
where id = 'jin';

select * from GT_MEMBER
select * from member_grade
--마일리지 거래 내역 리스트
select * from mileage_trade;

select mt_volume, mt_regdate from mileage_trade
where id='D_ruking'
order by mt_regdate desc

--후기리스트
select r.rp_no,r.rp_title,r.rp_regdate from(
select row_number() over (order by rp_no desc) as rnum,rp_no,rp_title,to_char(rp_regdate,'YYYY,MM,DD') as rp_regdate,id
from REVIEW_POST
where id='keroro'
) r, GT_MEMBER m
where r.id=m.id and rnum between 1 and 5 
order by r.rp_no desc

select count(*) from
		review_post
		where id='keroro'


select id from GT_MEMBER
select * from REVIEW_POST

-- 나의 활동 목록 리스트 

-- 나의 후기 상세보기
select r.rp_no, r.rp_title, r.rp_contents, d.dp_title,
to_char(r.rp_regdate,'YYYY,MM,DD') as rp_regdate, m.name
from REVIEW_POST r, GT_MEMBER m, donation_post d
where r.rp_no='22' and r.id=m.id and d.dp_no='22'
	
select rp_title,rp_contents
from REVIEW_POST
where rp_no='1'


select t.td_regdate,d.dp_title
from take_donation t
INNER donation_post d JOIN ON t.dp_no=d.dp_no

select dp_title
from DONATION_POST

SELECT r.rp_no AS rpNo, r.rp_title AS rpTitle, r.rp_contents AS rpContents, 
r.rp_regdate AS rpRegdate, r.rp_rate AS rpRate, p.dp_title
FROM review_post r
INNER JOIN gt_member m ON r.id = m.id
INNER JOIN donation_post p ON p.dp_no = r.dp_no
INNER JOIN take_donation t ON t.td_no = r. td_no
AND m.id='yong' and r.rp_no='21'

SELECT r.rp_no AS rpNo, r.rp_title AS rpTitle, r.rp_contents AS rpContents, 
		r.rp_regdate AS rpRegdate, r.rp_rate AS rpRate, p.dp_title AS dpTitle
		FROM review_post r
		INNER JOIN gt_member m ON r.id = m.id
		INNER JOIN donation_post p ON p.dp_no = r.dp_no
		INNER JOIN take_donation t ON t.td_no = r.td_no
		AND m.id='yong'  and r.rp_no='21'
		
SELECT r.rp_no, r.rp_title, r.rp_contents, 
		r.rp_regdate, r.rp_rate, p.dp_title
		FROM review_post r
		INNER JOIN gt_member m ON r.id = m.id
		INNER JOIN donation_post p ON p.dp_no = r.dp_no
		INNER JOIN take_donation t ON t.td_no = r.td_no
		AND r.rp_no='21'
		
		
--나의 재능기부 참여 목록
select t.td_no,t.td_regdate,t.td_mileage,d.dp_title
from take_donation t
INNER JOIN donation_post d ON t.dp_no = d.dp_no
AND t.id='keroro'

select count(*) 
from take_donation
where id='keroro'

select t.td_no, t.td_regdate, t.td_mileage, d.dp_title from(
select row_number() over (order by td_no desc) as rnum,td_no,to_char(td_regdate,'YYYY,MM,DD') 
as td_regdate,td_mileage,id,dp_no
from take_donation
where id='keroro'
) t, donation_post d
where t.dp_no = d.dp_no and rnum between 1 and 2
order by t.td_no desc
--나의 재능기부 신청 내역

select count(*) 
from application
where id='keroro'

select a.app_no, a.app_title, a.app_regdate, a.app_status from(
select row_number() over (order by app_no desc) as rnum,app_no,to_char(app_regdate,'YYYY.MM.DD') 
as app_regdate,app_status,id,app_title
from application
where id='keroro'
) a, gt_member m
where a.id = m.id and rnum between 1 and 3
order by a.app_no desc

-- 나의 후기 수정
select * from REVIEW_POST where rp_no='4'
update review_post set rp_title='제목수정1', rp_contents='컨텐츠수정1' where rp_no='4'
