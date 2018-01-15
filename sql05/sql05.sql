--문제 1번
--  가장 늦게 입사한 직원의 이름과 연봉, 부서이름 은? 
select em.first_name || ' '|| em.last_name as "이름",
       em.salary as "연봉",
       d.department_name as "부서이름",
       em.hire_date
from employees em, departments d
where em.department_id = d.department_id
and hire_date = (select max(hire_date)
                   from employees);  



--문제 2번
--  (평균연봉이 가장 높은 )  부서 직원들의 직원번호, 이름, 성, 업무, 연봉을 조회
select employee_id as "사번",
        first_name as "이름",
        last_name as "성",
        salary as "급여",
        jb.job_title
from employees em, jobs jb
where department_id = (select department_id
                        from (select avg(salary) avgs, department_id
                              from employees
                              group by department_id) a,
                             (select max(avg(salary)) mavgs
                              from employees
                              group by department_id) b
                        where a.avgs = b.mavgs)
 and em.job_id = jb.job_id;

--select avg(salary), department_id
--from employees
--group by department_id;
--
--select max(avg(salary))
--from employees
--group by department_id;
--
--select department_id
--from (select avg(salary) avgs, department_id
--      from employees
--      group by department_id) a,
--     (select max(avg(salary)) mavgs
--      from employees
--      group by department_id) b
--where a.avgs = b.mavgs;

 

--문제 3번
--  평균 급여가 가장 높은 부서는?
select department_name
from departments
where department_id = (select department_id
                        from (select avg(salary) avgs, department_id
                              from employees
                              group by department_id) a ,
                             (select max(avg(salary)) mavgs
                              from employees
                              group by department_id) b     
                              where a.avgs = b.mavgs);

----부서별 평균급여 구하기
--select avg(salary), department_id
--from employees
--group by department_id;
--
----제일 높은 평균급여 구하기
--select max(avg(salary))
--from employees
--group by department_id;
--
----평균 급여가 제일 높은 부서를 구하기
--select department_id
--from (select avg(salary) avgs, department_id
--      from employees
--      group by department_id) a ,
--      (select max(avg(salary)) mavgs
--       from employees
--       group by department_id) b     
--where a.avgs = b.mavgs;

                              
                              
--문제 4번
--  평균 급여가 가장 높은 지역은?
select region_name
from locations l,
     countries c,
     regions r,
    (select location_id, avg(salary) avgs
     from employees e, departments d
     where e.department_id= d.department_id
     group by location_id) a ,
     (select max(avg(salary)) maxs
      from employees e, departments d
      where e.department_id= d.department_id
      group by location_id) b
where a.avgs=b.maxs
  and a.location_id =l.location_id
  and l.country_id =c.country_id
  and c.region_id=r.region_id;

----도시별평균연봉
--select location_id, avg(salary)
--from employees e, departments d
--where e.department_id= d.department_id
--group by location_id;

  

--문제 5번
-- 평균 급여가 가장 높은 업무는?
select job_title
from (select avg(salary) avgs, job_title
      from employees e, jobs j
      where e.job_id = j.job_id
      group by job_title) a,
      (select max(avg(salary)) maxs
       from employees e, jobs j
       where e.job_id = j.job_id
       group by job_title) b
where a.avgs = b.maxs ;

----업무별 평균급여
--select avg(salary), job_title
--from employees e, jobs j
--where e.job_id = j.job_id
--group by job_title;
----업무별 max평균급여
--select max(avg(salary))
--from employees e, jobs j
--where e.job_id = j.job_id
--group by job_title;
