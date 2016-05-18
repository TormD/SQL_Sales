


--Есть таблица хранящая покупки (линии чека): Sales: salesid, productid, datetime, customerid. 
--Мы хотим понять, через какие продукты клиенты «попадают» к нам в магазин. 
--Напишите запрос, который выводит продукт и количество случаев, когда он был первой покупкой клиента. 

--решение задачи:
SELECT M.productid, COUNT (M.productid) AS QntFistOrder FROM 

(SELECT productid  FROM sales AS S,

(SELECT  min ( [datetime]) AS FistOrder, customerid  FROM sales
GROUP BY customerid) F

WHERE S.[datetime] = FistOrder AND S.customerid = F.customerid) M

GROUP BY M.productid

--ход решения:
--Узнаем когда кождый клиент сделал первую покупку:
select  min ( [datetime]) as FistOrder, customerid  from sales
group by customerid

-- сделаем выборку, отражающую какие продукты купил каждый клиент
select salesid, productid, [datetime], F.customerid, F.FistOrder  from sales as S,
(select  min ( [datetime]) as FistOrder, customerid  from sales
group by customerid) F
where S.[datetime] = FistOrder AND S.customerid = F.customerid

--сгрупируем по продукту, и посчитаем сколько раз каждый продукт был первым
select M.productid, Count (M.salesid) as QntFistOrder from 
(select salesid, productid, [datetime], F.customerid, F.FistOrder  from sales as S,
(select  min ( [datetime]) as FistOrder, customerid  from sales
group by customerid) F
where S.[datetime] = FistOrder AND S.customerid = F.customerid) M
group by M.productid

--удалим неучавствующие поля
SELECT M.productid, COUNT (M.productid) AS QntFistOrder FROM 

(SELECT productid  FROM sales AS S,

(SELECT  min ( [datetime]) AS FistOrder, customerid  FROM sales
GROUP BY customerid) F

WHERE S.[datetime] = FistOrder AND S.customerid = F.customerid) M

GROUP BY M.productid

--если клиент сделал две покупки одновременно и это было в первый раз, то защитаются оба товара