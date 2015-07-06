---
layout: post
title:  "SQL Server 2008 Transactions Usage Template"
date:   2011-11-10 15:57:00
categories: blog
tags:
- t-sql
- sql server
---
I must admit I don't use Transactions that much, but the fact is that most of my stored procedures are atomic, i.e. although they may have a lot of code, only one data changing operation (INSERT, UPDATE or DELETE) is done, so there's no need to wrap it on a transaction.  

Because I don't use them much, its not always clear to me what's the "best way" of using a transaction. Sure we all know the basics but:

* Is the transaction always closed?
* Are we handling the error that caused the transaction to rollback?  
* Are we accurately reporting the error to the caller?  

To be able to always answer YES to all these questions without thinking much about it, my friend [Rui Inacio](http://www.linkedin.com/in/ruiinacio) dove into Google and came up with a template that can be used as a start point of all your transaction scripts.
{% highlight sql %}
 BEGIN TRY
  BEGIN TRANSACTION
  
   -- ADD YOUR CODE HERE --
  
  IF @@TRANCOUNT > 0
  BEGIN
   COMMIT TRANSACTION;
  END
 END TRY
 BEGIN CATCH
  DECLARE @ErrorMessage VARCHAR(4000)
  
  SET @ErrorMessage = 'ErrorProcedure: ' + ISNULL(ERROR_PROCEDURE(), '') + ' Line: ' + CAST(ERROR_LINE() AS VARCHAR(10)) + ' Message: ' + ERROR_MESSAGE()
  
  IF @@TRANCOUNT > 0
  BEGIN
   ROLLBACK TRANSACTION;
  END
  
  RAISERROR (@ErrorMessage, 16, 1)  
 END CATCH
{% endhighlight %}
You may change the way you report the error inside the CATCH but for most cases this is what you need.