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

