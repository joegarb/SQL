-- Several different ways to select 1 million rows, useful for quickly populating a table for testing

;with cte(num) as (select 1 union all select num + 1 from cte where num < 1000)
select row_number() over(order by c1.num) from cte c1 cross join cte c2 option(maxrecursion 1000)

;with cte(num) as (select 1 union all select 1 union all select 1 union all select 1)
select top 1000000 row_number() over(order by c1.num) 
from cte c1, cte c2, cte c3, cte c4, cte c5, cte c6, cte c7, cte c8, cte c9, cte c10

select top 1000000 row_number() over(order by o1.object_id) from sys.objects o1, sys.objects o2, sys.objects o3, sys.objects o4

select top 1000000 identity(int,1,1) num into #number from sys.objects o1, sys.objects o2, sys.objects o3, sys.objects o4
select num from #number order by num
drop table #number;

declare @number table (num int)
declare @num int = 1
while @num <= 1000000
begin
	insert into @number select @num
	set @num = @num + 1
end
select num from @number order by num