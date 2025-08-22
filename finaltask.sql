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



--11.Employees cədvəlində sırası 20 və 40 arasında əməkdaşalrın adını, soyadını və sıra nömrəsini yazın. 
select  first_name,last_name,rankk 
from (select first_name,last_name, rank() over(order by department_id desc) as rankk
from employees) t


where rankk between  20 and 40


--12 Employees cədvəlində ən çox maaş alan 5 ci əməkdaşı tapın. 
--Maaşdan asılı olmayaraq hər sıraya 1 nömrə versin. 


select first_name,last_name,salary ,
row_number() over(order by salary desc) as rn
from employees where  rownum<=5

--13Employees cədvəlində ən çox maaş alan 5 ci əməkdaşı tapın.
--Eyni maaşda olanlara eyni sıra nömrəsi verilsin. 
select first_name,last_name,salary,
dense_rank() over(order by salary desc) as rn 
from employees
where rownum<=5


--14Employees cədvəlində employee_id – i cüt olan və adında sondan ikinci hərfi a olan və manager_id –i 
--145, 146 və ya  147 olan əməkdaşları gətirin. Sıralama maaşa görə çoxdan aza doğru olsun. 
select first_name,employee_id  from employees where manager_id in(145,146,147)  and mod(employee_id,2)=0
and first_name like '%a_'


--15 Employees cədvəlində adında 3
--cü hərfi a olan və soyadında sondan 3 cü hərfi y olan əməkdaşları gətirin. 

select * from employees where first_name like  '__a%' 
and last_name like '%y__'


--16 Employees cədvəlində alt sorğu vasitəsilə əməkdaşların ad və soyadın birləşməsinin 
--uzunluqları cəmini, ortalamsını, ən az olanı və ən çox olanı tapın. 


select sum(lenght),
avg(lenght),
min(lenght),
max(lenght)
from (
select length(first_name || ' ' || last_name) as lenght from employees
)



--17Employees cədvəlində əməkdaşalrın adını, soyadını, təcrübələrini gün ilə,
--təcrübələrini ay ilə və təcrübələrini il ilə gətirin. 

select first_name,last_name,months_between(sysdate,hire_date) as month,months_between(sysdate,hire_date)/12 as year from employees

--18.Employees cədvəlində əməkdaşalrın adını, soyadını, maaşını, komissiyasını və 
--komissiyanın maaşa əlavəsini gətirin. Yeni maaşı 15000 dən çox olanları göstərin. 
select first_name,last_name ,newsal from(


select first_name,last_name,salary,commission_pct,salary+commission_pct as  newsal from employees ) t
where newsal>15000

--19 Employees cədvəlində təcrübəsi 10 ildən 
--çox olan əməkdaşlara maşının 1.5 qatı miqdarında bonus hesablayın. 
select salary*1.5 as salaryy from (
select salary, months_between(sysdate,hire_date)/12 as il  from employees ) t
where il>10

--20 Maaşı 10000 dən çox olan və şəhəri Seattle, Oxford və ya London olan əməkdaşların 
--ad və soyadını bir sütunda, maaşını, department_adını, şəhərini və küçə adresini gətirin. 
select first_name,last_name,salary,d.department_name,c.city from employees e
join departments d on e.department_id=d.department_id
join locations  c on c.location_id=d.location_id
where salary>10000 and c.city in ('Seattle','Oxford','London')

