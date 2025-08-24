--1.Employee Steven's Salary is 24000 EUR nümun?sind? oldu?u kimi bütün s?tirl?ri yazd?r?n. 
select 'Employee ' || first_name || '''s Salary is '  || salary || ' EUR' from employees

--2Employees c?dv?lind? ?m?kda??n ad? v? maa??n ç?kin.
--Sütun aliaslar? is? ‘?m?kda? ad?’ v? ‘?m?kda??n maa??’ kimi olsun. 
select first_name "?m?kda? ad?" ,salary "?m?kda??n maa??" from employees
--3Employees c?dv?lind? maa?? 5000 v? 25000 aral???nda olan 
--?m?kda?lar? maa?a gör? çoxdan aza do?ru s?ralay?b ilk 25 datan? g?tirin. 

select * from employees where salary between 5000 and 25000
order by salary desc
fetch first 25 rows only
--4Employees c?dv?lind? ?m?kda?lar?n adlar?n?n ilk h?rfi  a v? e aral???nda olan h?rfl?rl? ba?layanlar? g?tirin. Commission_pct is? null olmas?n. 

select * from employees where regexp_like(first_name,'^[A-Ea-e]')  and commission_pct is not null

--5 Employees c?dv?lind? department_id-i 
--50, 80 v? ya 90 olan v? soyad? a h?rfi il? ba?layan v? ya a h?rfi il? bit?n ?m?kda?lar? g?tirin. 

select * from employees where department_id in(50,80,90)and (first_name like '%a' or first_name like 'a%') 


--6Employees c?dv?lind? maa?lar? 20000 d?n a?a?? olan ?m?kda?alr? maa?a gör?
--çoxdan aza do?ru s?ralay?b ilk 5 s?trind?n ba?qa dig?rl?rini g?tirin. 
select * from employees where salary<20000 order by salary desc fetch first 5 rows only



--7Employees c?dv?lind? maa?? 7000 d?n çox olan v? department_id- i 50, 60 v? ya 80 olan ?m?kda?lar? g?tirin.
--?N istifad? olunmas?n. 

select * from employees where salary>7000 and (department_id=50 or department_id=60 or department_id=80)



--8Employees c?dv?lind? ?m?kda?lar?n ad?n?, soyad?n?, commission_pct, phone_number v? department_name g?tirin.
--Phone_number-d? ‘.’ –i ‘–‘ l? ?v?z edin. Commission_pct-d? null olanlar ilk g?lsin. 

select first_name,last_name,commission_pct,replace(phone_number,'.','-') from employees order by  commission_pct
nulls first 

--9Employees c?dv?lind? ?m?kda?alr?n ad?n?, soyad?n?, maa??n? v? maa??n çoxdan aza do?ru s?ra nömr?sini g?tirin. 
--Eyni maa?da olanlara eyni s?ra nöme?si yaz?ls?n. 

select first_name,last_name,salary,
dense_rank() over(order by salary desc) as rankk

from employees order by salary desc



--10Employees c?dv?lind? maa?? 10000 d?n çox olan v? ??h?ri 
--Oxford olan ?m?kda?lar?n ad?n?, maa??n?, department_id-i, department_name-i v? ??h?r ad?n? g?tirin. 
select e.first_name,e.salary,e.department_id,d.department_name ,l.city from employees e
join  departments d  on e.department_id=d.department_id 
join locations l on l.location_id=d.location_id where e.salary>10000



--11.Employees c?dv?lind? s?ras? 20 v? 40 aras?nda ?m?kda?alr?n ad?n?, soyad?n? v? s?ra nömr?sini yaz?n. 
select  first_name,last_name,rankk 
from (select first_name,last_name, rank() over(order by department_id desc) as rankk
from employees) t


where rankk between  20 and 40


--12 Employees c?dv?lind? ?n çox maa? alan 5 ci ?m?kda?? tap?n. 
--Maa?dan as?l? olmayaraq h?r s?raya 1 nömr? versin. 


select first_name,last_name,salary ,
row_number() over(order by salary desc) as rn
from employees where  rownum<=5

--13Employees c?dv?lind? ?n çox maa? alan 5 ci ?m?kda?? tap?n.
--Eyni maa?da olanlara eyni s?ra nömr?si verilsin. 
select first_name,last_name,salary,
dense_rank() over(order by salary desc) as rn 
from employees
where rownum<=5


--14Employees c?dv?lind? employee_id – i cüt olan v? ad?nda sondan ikinci h?rfi a olan v? manager_id –i 
--145, 146 v? ya  147 olan ?m?kda?lar? g?tirin. S?ralama maa?a gör? çoxdan aza do?ru olsun. 
select first_name,employee_id  from employees where manager_id in(145,146,147)  and mod(employee_id,2)=0
and first_name like '%a_'


--15 Employees c?dv?lind? ad?nda 3
--cü h?rfi a olan v? soyad?nda sondan 3 cü h?rfi y olan ?m?kda?lar? g?tirin. 

select * from employees where first_name like  '__a%' 
and last_name like '%y__'


--16 Employees c?dv?lind? alt sor?u vasit?sil? ?m?kda?lar?n ad v? soyad?n birl??m?sinin 
--uzunluqlar? c?mini, ortalams?n?, ?n az olan? v? ?n çox olan? tap?n. 


select sum(lenght),
avg(lenght),
min(lenght),
max(lenght)
from (
select length(first_name || ' ' || last_name) as lenght from employees
)



--17Employees c?dv?lind? ?m?kda?alr?n ad?n?, soyad?n?, t?crüb?l?rini gün il?,
--t?crüb?l?rini ay il? v? t?crüb?l?rini il il? g?tirin. 

select first_name,last_name,months_between(sysdate,hire_date) as month,months_between(sysdate,hire_date)/12 as year from employees

--18.Employees c?dv?lind? ?m?kda?alr?n ad?n?, soyad?n?, maa??n?, komissiyas?n? v? 
--komissiyan?n maa?a ?lav?sini g?tirin. Yeni maa?? 15000 d?n çox olanlar? göst?rin. 
select first_name,last_name ,newsal from(


select first_name,last_name,salary,commission_pct,salary+commission_pct as  newsal from employees ) t
where newsal>15000

--19 Employees c?dv?lind? t?crüb?si 10 ild?n 
--çox olan ?m?kda?lara ma??n?n 1.5 qat? miqdar?nda bonus hesablay?n. 
select salary*1.5 as salaryy from (
select salary, months_between(sysdate,hire_date)/12 as il  from employees ) t
where il>10

--20 Maa?? 10000 d?n çox olan v? ??h?ri Seattle, Oxford v? ya London olan ?m?kda?lar?n 
--ad v? soyad?n? bir sütunda, maa??n?, department_ad?n?, ??h?rini v? küç? adresini g?tirin. 
select first_name,last_name,salary,d.department_name,c.city from employees e
join departments d on e.department_id=d.department_id
join locations  c on c.location_id=d.location_id
where salary>10000 and c.city in ('Seattle','Oxford','London')


--21Employees cədvəlində əməkdaşalrın işə giriş tarixinə 
--10 il 3 ay və 10 gün əlavə edin (Sql developer üçün 20 il 3 ay 10 gün). Günümüzdən (sysdate) daha sonrasına gedənlər varsa, onları tapın. 



--23Employees cədvəlində əməkdaşalar işə girən zaman həmin ay sonuna neçə gün qaldığını tapın. Ay sonuna 10 gündən daha çox qalanları gətirin. 
select last_day(hire_date)-hire_date from employees
where last_day(hire_date)-hire_date>10

select * from (
select last_day(hire_date)-hire_date as datee  from employees) t
where datee>10
--24Employees cədvəlində phone_number sütununda 3 cüdən başlayaraq 3 rəqəmi 515 olanları tapın. 

select * from employees where substr(phone_number,0,3)='515'
select * from employees where regexp_like(phone_number,'^515') 


--25Employees cədvəlində phone_number sütununda 3 cüdən başlayaraq 3 rəqəmi 515 olanlara 515 yazın. 590 olanlara 590, 650 olanlara isə 650 yazın. Digərlərinə isə Others yazın. 



select phone number case when 
 regexp_like(phone_number,'^515') 
SELECT phone_number,
       CASE 
         WHEN REGEXP_LIKE(phone_number, '^..515') THEN '515'
         WHEN REGEXP_LIKE(phone_number, '^..590') THEN '590'
         WHEN REGEXP_LIKE(phone_number, '^..650') THEN '650'
         ELSE 'Others'
       END AS phone_status
FROM employees;


--Employees cədvəlində qış aylarında işə başlayan əməkdaşlara maaşına 300 azn, 
--yazda işə başlayanlara 350 azn, yayda işə başlayanlara 400 azn və payızda işə başlayanlara isə 450 azn artım edin. 
--

select hire_date,salary,salary+
case when to_char(hire_date,'mm') in(12,1,2) then 300,
 when to_char(hire_date,'mm') in(1,2,3) then 300,
 when to_char(hire_date,'mm') in(4,5,6) then 300,
else salary+40
end as netice
from employees


SELECT hire_date,
       salary,
       salary +
       CASE 
           WHEN TO_CHAR(hire_date,'MM') IN ('12','01','02') THEN 300  -- Qış
           WHEN TO_CHAR(hire_date,'MM') IN ('03','04','05') THEN 350  -- Yaz
           WHEN TO_CHAR(hire_date,'MM') IN ('06','07','08') THEN 400  -- Yay
           WHEN TO_CHAR(hire_date,'MM') IN ('09','10','11') THEN 450  -- Payız
           ELSE 40
       END AS netice
FROM employees;

--28Employees cədvəlində Commission_pct və manager_id sütunlarında hansı null deyilsə onun datası yazılsın. 
select * from employees where commission_pct is not null and manager_id is not null



--29Hər ölkədə neçə nəfər işlədiyini tapın. Işçiləri sayı 2 dən çox olanlar gəlsin. Sıralama saya görə çoxdan aza doğru olsun. 


select c.country_name ,count(*)employee_count
 from employees e
join departments d on e.department_id=d.department_id
join locations l on l.location_id=d.location_id
join countries c on c.country_id=l.country_id
group by c.country_name 
having count(*)>2
ORDER BY employee_count DESC;

--where count(2)


--Employees cədvəlində əməkdaşların menecerini tapın. İşçi adı və müdir adı olaraq 2 sütun olsun. 


select e.first_name as adi ,m.first_name as mudur  from employees e
left join employees m
on e.employee_id=m.manager_id




--31Union vasitəsilə Canada və Germany-də işləyənlərin adını, soyadını,maaşını və ölkə adını tapın. 
select salary,last_name from employees
union 
select country_name,country_id from countries where country_name in('Canada','Germany')




SELECT e.first_name,
       e.last_name,
       e.salary,
       c.country_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l   ON d.location_id   = l.location_id
JOIN countries c   ON l.country_id    = c.country_id
WHERE c.country_name = 'Canada'

UNION

SELECT e.first_name,
       e.last_name,
       e.salary,
       c.country_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l   ON d.location_id   = l.location_id
JOIN countries c   ON l.country_id    = c.country_id
WHERE c.country_name = 'Germany';

SELECT d.department_name,
       e.first_name,
       e.last_name,
       e.salary,
       rankk
FROM (
    SELECT e.*,
           d.department_name,
           DENSE_RANK() OVER (PARTITION BY d.department_name 
                              ORDER BY e.salary DESC) AS rankk
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
) t
WHERE rankk = 5;

