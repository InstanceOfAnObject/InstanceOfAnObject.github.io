---
layout: post
title:  "Simple Automatic SQL Server Backups"
date:   2011-01-06 21:36:00
categories: blog
tags:
- database
- sql server
---

<div class="separator" style="clear: both; text-align: center;">
 <a href="/assets/blog/2011-01-06-simple-automatic-sql-server-backups/database-backup.png" imageanchor="1" style="clear: left; float: left; margin-bottom: 1em; margin-right: 1em;">
  <img border="0" src="/assets/blog/2011-01-06-simple-automatic-sql-server-backups/database-backup.png" />
 </a>
</div>

This one is nice and easy.<br />
If you ever want to backup all your databases on an instance use the following script bellow.<br />
I picked the original script from <a href="http://www.mssqltips.com/tip.asp?tip=1070">here</a>&nbsp;and changed it to suite my needs.<br />
<br />
I use it on a SQL Job and save the backup files to a folder under my DropBox... pure magic!

<div style="clear: both;"></div>

<h3>Implementation</h3>
 <ul><li>The Job runs every day</li>
 <li>Full backup every month and Diffs every day</li>
 <li>The file name is the database name + year + month</li>
 <li>Excludes all the system databases</li>
 </ul>

<h3>The Script</h3>

{% highlight sql %}
DECLARE @name VARCHAR(50) -- database name 
DECLARE @path VARCHAR(256) -- path for backup files 
DECLARE @fileName VARCHAR(256) -- filename for backup 

DECLARE @fileDate VARCHAR(20) -- used for file name 
DECLARE @fileYear VARCHAR(20) -- used for file name 
DECLARE @fileMonth VARCHAR(20) -- used for file name 

SET @path = 'DESTINATION PATH' 

SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112)
SELECT @fileYear = CAST(YEAR(GETDATE()) AS VARCHAR)
SELECT @fileMonth = RIGHT('00' + CAST(MONTH(GETDATE()) AS VARCHAR), 2)


DECLARE db_cursor CURSOR FOR 
SELECT name 
FROM master.dbo.sysdatabases 
WHERE name NOT IN ('master','model','msdb','tempdb') 

OPEN db_cursor 
FETCH NEXT FROM db_cursor INTO @name 

WHILE @@FETCH_STATUS = 0 
BEGIN 
SET @fileName = @path + @name + '_' + @fileYear + @fileMonth + '.BAK' 
BACKUP DATABASE @name TO DISK = @fileName WITH DIFFERENTIAL

FETCH NEXT FROM db_cursor INTO @name 
END

CLOSE db_cursor;
DEALLOCATE db_cursor;
{% endhighlight %}