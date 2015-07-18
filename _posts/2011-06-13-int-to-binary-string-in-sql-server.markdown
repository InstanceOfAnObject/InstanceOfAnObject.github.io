---
layout: post
title:  "INT to BINARY string in SQL Server"
date:   2011-06-13 13:56:00
categories: blog
tags:
- t-sql
- sql server
---

SQL Server doesn't have a native way of converting INTs to BINARY.

### Executing
{% highlight sql %}SELECT CAST(25 AS BINARY){% endhighlight %}
infact returns *19* which is the Hexadecimal equivalent, not the binary.

Bellow you can see the differences between the 3 numeric representations:  
*Integer*: 25  
*Binary*: 11001  
*Hexadecimal*: 19  

So I had 2 requirements:

1. Have the BIN representation of 25 as a string: '11001'
2. Be able to set a fixed minimum result size
  * fixedSize=2 : '11001'
  * fixedSize=5 : '11001'
  * fixedSize=10 : '0000011001'

### Best Solution
After posting this article I triggered the genious inside my big friend [Tiago Guedes](http://www.facebook.com/tiagofilipeguedes) that came up with a much cleaner solution:
{% highlight sql %}
ALTER FUNCTION INT2BIN
(
 @value INT,
 @fixedSize INT = 10
)
RETURNS VARCHAR(1000)
AS
BEGIN
 DECLARE @result VARCHAR(MAX) = '';

 WHILE @value >= 1
 BEGIN
 SELECT @result = CAST(@value % 2 AS VARCHAR) + @result, @value = @value / 2
 END;

 IF(@fixedSize > LEN(@result))
 BEGIN
 SELECT @result = REPLICATE('0', @fixedSize - LEN(@result)) + @result
 END;

 RETURN @result;
END
GO
{% endhighlight %}

### My Initial solution
For historical purposes I leave here my original two ways of doing the same thing.

{% highlight sql %}
CREATE FUNCTION INT2BIN
(
 @value INT,
 @fixedSize INT = 10
)
RETURNS VARCHAR(1000)
AS
BEGIN
 DECLARE @result VARCHAR(1000) = '';

 WHILE (@value != 0)
 BEGIN
  IF(@value%2 = 0) 
   SET @Result = '0' + @Result;
  ELSE
   SET @Result = '1' + @Result;
   
  SET @value = @value / 2;
 END;

 IF(@FixedSize > 0 AND LEN(@Result) < @FixedSize)
  SET @result = RIGHT('00000000000000000000' + @Result, @FixedSize);

 RETURN @Result;
END
GO
{% endhighlight %}
**Caution:**  
The above code only supports @FixedSize values equal or bellow 20.
If you need support for higher values just add more zeros to the 'RIGHT' statement.
Another option is to make this padding dynamic introducing another loop.

{% highlight sql %}
CREATE FUNCTION INT2BIN
(
 @value INT,
 @fixedSize INT = 10
)
RETURNS VARCHAR(1000)
AS
BEGIN
 DECLARE @result VARCHAR(1000) = '';

 WHILE (@value != 0)
 BEGIN
  IF(@value%2 = 0) 
   SET @Result = '0' + @Result;
  ELSE
   SET @Result = '1' + @Result;
   
  SET @value = @value / 2;
 END;

 IF(@fixedSize IS NOT NULL AND @fixedSize > 0 AND LEN(@Result) < @fixedSize)
 BEGIN
  DECLARE @len INT = @fixedSize;
  DECLARE @padding VARCHAR(1000) = '';
 
  WHILE @len > 0
  BEGIN
   SET @padding = @padding + '0';
   SET @len = @len-1;
  END; 
  SET @result = RIGHT(@padding + @result, @fixedSize);
 END;
 
 RETURN @result;
END
GO
{% endhighlight %}