-- which grade level had the largest drop in attendance between yesterday and today?
select grade, yesterday_attn - today_attn as drop_attn
from 
(select grade_level as grade, sum(case when date = curdate() and attendance = 'present' then 1 else 0) as today_attn,
sum(case when date = adddate(curdate(), interval - 1 DAY) and attendence = 'present' then 1 else 0 ) as yesterday_attn
from attendence_table attn 
join stdent std 
on attn.student_id = std.student_id
group by grade_level) sub_tbl
order by drop_attn desc
limit 1

-- write a query to get combined name (first name and last name) of employees
select concat(first_name, '', last_name) from employees

-- what percentage of students attend school on their birthday
select count(distinct attn.student_id) * 100 /(select count(distinct student_id) from studen_table) as pct 
from attendence_table attn 
inner join student_table  std 
on attn.student_id = std.student_id 
where attn.attendence_date = std.birth_date 

-- what percentage of active accounts are fraud from ad_account table?
select count(distinct account_id)/(select count(distinct account_id) from ad_account where account_status = 'active') as pct 
from ad_account 
where account_status = 'fraud' 

-- click through rate
select app_id, 
ifnull(sum(case when type = 'click' then 1 else 0 end)/sum(case when type = 'impression' then 1 else 0 end), 0) as ctr
from log_table
group by app_id

-- create buckets, and number of distinct users in each bucket
select floor(timespend/500)*500 as bucket, count(distinct user_id) as user_count
from log_table 
group by 1 

-- most recent login date for each user within the most recent 30 days
select user_id, phone_nbr, max(login_date)
from user_table user 
inner join user_log_table log 
on user.user_id = log.user_id 
and log.action = 'loggin'
and log.login_date >= date_sub(curdate(), interval 30 day)
group by user_id 


select sum(a.partial_interaction)
from
(
SELECT t2.Sender, t2.Receiver, count(t2.ContactTime) as partial_interaction
FROM ContactList t2
group by t2.Sender, t2.Receiver
) a
inner join
(
SELECT t2.Sender, t2.Receiver, count(t2.ContactTime) as partial_interaction
FROM ContactList t2
group by t2.Sender, t2.Receiver
) b
on a.Sender = b.Receiver

select t1.user1, t2.user2, t2.interaction_type
from friend t1
inner join interaction t2 
on ((t1.user1 = t2.sender and t1.user2 = t2.receiver) or (t1.user1 = t2.receiver and t1.user2 = t2.sender))

-- left semi join 
select distinct name, skill, age
from table_1 tbl1
where not exists (select distinct name, skill, age from table_2) tbl2 
where tbl1.name = tbl2.name and tbl1.skill = tbl2.skill and tbl1.age = tbl2.age
