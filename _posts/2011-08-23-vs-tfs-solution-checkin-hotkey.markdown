---
layout: post
title:  "VS TFS Solution CheckIn Hotkey"
date:   2011-08-23 11:44:00
categories: blog
tags:
- visual studio
- tfs
- macros
---

## Intoduction
This is a nice implementation of a keyboard shortcut to checkin your Solution that makes use of the Macro engine of visual studo.  
This implementation will prompt the exact same modal window that shows when we choose "Check In..." from the solution context menu.  

This is particulary useful not only on big solution where you have to scroll a lot to see the solution node but also when the solution context menu gets so big that finding the "Check In..." option is not that easy.<br />

## Creating the Macro
There isn't any out-of-the-box way of doing this, so we have to write a macro.  
On Visual Studio go to: *Tools > Macros > Macro Explorer*

On the right side a new pane appeared showing the Macros you have.  
By default you have two child nodes under Macros: MyMacros and Sample.  
Lets use MyMacros.

1. Right-click it and choose "New Module".
2. Name it TFS and ckick Add.
3. Open the created module and replace the entire file content with the code bellow
4. I don't take the credit of the code bellow, it was taken from [here](http://stackoverflow.com/questions/3994906/hotkey-for-tfs-checkin)
{% highlight csharp %}
Imports System
Imports EnvDTE
Imports EnvDTE80
Imports EnvDTE90
Imports EnvDTE90a
Imports EnvDTE100
Imports System.Diagnostics

Public Module TFS

    Sub CheckInSolution()
        DTE.Windows.Item(Constants.vsWindowKindSolutionExplorer).Activate()

        Dim fi As System.IO.FileInfo = New System.IO.FileInfo(DTE.Solution.FullName)
        Dim name As String = fi.Name.Substring(0, fi.Name.Length - fi.Extension.Length)

        DTE.ActiveWindow.Object.GetItem(name).Select(vsUISelectionType.vsUISelectionTypeSelect)
        DTE.ExecuteCommand("ClassViewContextMenus.ClassViewProject.TfsContextCheckIn")
    End Sub

End Module
{% endhighlight %}
Save the Macro and close it.

## Creating the Keyboard Shortcut

1. Go to Tools &gt; Options &gt; Environment &gt; Keyboard
2. On the listbox searck for Macros.MyMacros.TFS.ChackInSolution and select it
3. On the Shortcut keys textbox I used: Ctrl+Shift+K, Ctrl+Shift+I
  * This combination is accomplished by pressing *K* **and then** *I* while holding (without releasing) the *Control and Shift* keys
  * The above combination was available on my environment, don't use a combination that is already in use on your environment.
  * **EDIT:** I previously had a Ctrl+C, Ctrl-I combination but using Ctrl+C will mess the default clipboard Copy shortcut. If you find that your shortcut messed up anything you must reset the key assignments ckicking the Reset button.
4. Click OK, and you're done.

Now, when you use Ctrl+C, Ctrl+I anywhere on Visual Studio the checkin modal form will appear just like it would if you choose "Check In..." from the Solution context menu.