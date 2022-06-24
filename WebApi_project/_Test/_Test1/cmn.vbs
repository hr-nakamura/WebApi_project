Sub JsDoevents()
   DoEvents
End Sub

Function formatNum(num,n)
   if num <> "" then
      formatNum = formatnumber(num,n)
      end if
End Function

Function formatNumZ(num,n)
   if num <> "" then
      if num <> 0 then
         formatNumZ = formatnumber(num,n)
      else
         formatNumZ = "Å@"
         end if
      end if
End Function

Function putNum(num)
   if num = 0 then
      putNum = null
   else
      putNum = num
      end if
End Function

Function JsFormatDateTime(Date,NamedFormat)
   JsFormatDateTime = FormatDateTime(Date,NamedFormat)
End Function

Function JsIsNull(expression)
   JsIsNull = IsNull(expression)
End Function

Function JsIsNumeric(expression)
   JsIsNumeric = IsNumeric(expression)
End Function

Function JsIsDate(expression)
   JsIsDate = IsDate(expression)
End Function

Function JsFormatDateTime(date1,format)
   JsFormatDateTime = FormatDateTime(date1,format)
End Function

Function JsDatePart(interval,date1)
   JsDatePart = DatePart(interval,date1)
End Function

Function JsDateSerial(year, month, day)
   JsDateSerial = DateSerial(year, month, day)
End Function

Function JsDateDiff(interval,date1,date2)
   JsDateDiff = DateDiff(interval,date1,date2)
End Function

Function JsDateAdd(interval,number,date1)
   JsDateAdd = DateAdd(interval,number,date1)
End Function

Function JsYear(date1)
   JsYear = Year(date1)
End Function

Function JsMonth(date1)
   JsMonth = Month(date1)
End Function

Function JsDay(date1)
   JsDay = Day(date1)
End Function

Function JsWeekday(date1)
   JsWeekday = Weekday(date1)
End Function

Function JsTrim(str)
   JsTrim = Trim(str)
End Function

Function JsLTrim(str)
   JsLTrim = LTrim(str)
End Function

Function JsRTrim(str)
   JsRTrim = RTrim(str)
End Function
