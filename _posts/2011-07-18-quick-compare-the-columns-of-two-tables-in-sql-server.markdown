---
layout: post
title:  "Quick compare the columns of two tables in SQL Server"
date:   2011-07-18 15:01:00
categories: blog
tags:
- sql server
---

This is a quick tip on how to compare the columns of two tables in the same database.
{% highlight sql %}
-- Replace Table1Name and Table2Name
-- with the name of the tables you want to compare
DECLARE @tbl1 varchar(200) = 'Table1Name'; 
DECLARE @tbl2 varchar(200) = 'Table2Name';
SELECT * FROM 
(
 select 
 tbl1.COLUMN_NAME AS tbl1Column_Name,
 tbl1.DATA_TYPE AS tbl1Data_Type,
 tbl2.COLUMN_NAME AS tbl2Column_Name,
 tbl2.DATA_TYPE AS tbl2Data_Type
 FROM 
  (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME LIKE @tbl1) AS tbl1
  FULL OUTER JOIN (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME LIKE @tbl2) AS tbl2 ON tbl2.COLUMN_NAME LIKE tbl1.COLUMN_NAME) AS compare
-- uncomment the line bellow to show only the columns that don't match by name
--WHERE tbl1Column_Name IS NULL OR tbl2Column_Name IS NULL
{% endhighlight %}

## Remarks

* This will only work with tables on the same SQL Database
  * This can be extended to support comparisons between databases within the same instance without much trouble
* It doesn't matter which table is Table1 or Table2
* You can add more columns to the result, [INFORMATION_SCHEMA.Columns](http://msdn.microsoft.com/en-us/library/ms188348.aspx) returns a lot more information

