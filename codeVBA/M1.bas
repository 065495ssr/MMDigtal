Attribute VB_Name = "ģ��1"
Function FormatDate(ByRef strDate As String)
iYear = Mid(strDate, 1, 4)
iMonth = Mid(strDate, 5, 2)
iDay = Mid(strDate, 7, 2)

FormatDate = iYear + "-" + iMonth + "-" + iDay
End Function

'http://eryk.javaeye.com/blog/638277
'0����������·������Ʊ���֣�
'1����27.55�壬���տ��̼ۣ�
'2����27.25�壬�������̼ۣ�
'3����26.91�壬��ǰ�۸�
'4����27.55�壬������߼ۣ�
'5����26.20�壬������ͼۣ�
'6����26.91�壬����ۣ�������һ�����ۣ�
'7����26.92�壬�����ۣ�������һ�����ۣ�
'8����22114263�壬�ɽ��Ĺ�Ʊ�������ڹ�Ʊ������һ�ٹ�Ϊ������λ��������ʹ��ʱ��ͨ���Ѹ�ֵ����һ�٣�
'9����589824680�壬�ɽ�����λΪ��Ԫ����Ϊ��һĿ��Ȼ��ͨ���ԡ���Ԫ��Ϊ�ɽ����ĵ�λ������ͨ���Ѹ�ֵ����һ��
'10����4695�壬����һ������4695�ɣ���47�֣�
'11����26.91�壬����һ�����ۣ�
'12����57590�壬�������
'13����26.90�壬�������
'14����14700�壬��������
'15����26.89�壬��������
'16����14300�壬�����ġ�
'17����26.88�壬�����ġ�
'18����15100�壬�����塱
'19����26.87�壬�����塱
'20����3100�壬����һ���걨3100�ɣ���31�֣�
'21����26.92�壬����һ������
'(22, 23), (24, 25), (26,27), (28, 29)�ֱ�Ϊ���������������ĵ������
'30����2008-01-11�壬���ڣ�
'31����15:05:32�壬ʱ�䣻
Function getFundData(ByRef StockCode As String)
Url = "http://hq.sinajs.cn/list=" + StockCode
strData = GetHttp(Url)
strData = Replace(strData, Chr(13), "")
strData = Replace(strData, Chr(10), "")

Set objREGEXP = CreateObject("VBSCRIPT.REGEXP")
With objREGEXP
.Global = True
.Pattern = "var hq_str_.*=\"""
strData = .Replace(strData, "")
.Pattern = "\"";"
strData = .Replace(strData, "")

End With
Set objREGEXP = Nothing

getFundData = Split(strData, ",")

End Function

Function getStockPrice2(ByRef StockCode As String)
Application.Volatile
getStockPrice = 0
End Function
Function getStockPrice(ByRef StockCode As String)
Application.Volatile                            '����Ϊ��ʧ�Ժ���(ÿ����Ҫ���¼���)
Url = "https://hq.sinajs.cn/list=" + StockCode
strData = GetHttp(Url)
strData = Replace(strData, Chr(13), "") '�滻���з�
strData = Replace(strData, Chr(10), "") '�滻�س���

Set objREGEXP = CreateObject("VBSCRIPT.REGEXP")  'note������һ��������ʽ��ȥ��http���ص�ǰ��һ�����߰����ͷ
With objREGEXP
.Global = True
.Pattern = "var hq_str_.*=\"""
strData = .Replace(strData, "")
.Pattern = "\"";"
strData = .Replace(strData, "")

End With
Set objREGEXP = Nothing

StockData = Split(strData, ",")                    '��strDataͨ��Split�����ֿ�,split��������һ�������������ݵ�����
getStockPrice = Val(StockData(3))                   '��strData(3)�ı�Ϊ��ֵ�������

End Function

Function getLastDayStockPrice(ByRef StockCode As String)
Application.Volatile                            '����Ϊ��ʧ�Ժ���(ÿ����Ҫ���¼���)
Url = "https://hq.sinajs.cn/list=" + StockCode
strData = GetHttp(Url)
strData = Replace(strData, Chr(13), "") '�滻���з�
strData = Replace(strData, Chr(10), "") '�滻�س���

Set objREGEXP = CreateObject("VBSCRIPT.REGEXP")  'note������һ��������ʽ��ȥ��http���ص�ǰ��һ�����߰����ͷ
With objREGEXP
.Global = True
.Pattern = "var hq_str_.*=\"""
strData = .Replace(strData, "")
.Pattern = "\"";"
strData = .Replace(strData, "")

End With
Set objREGEXP = Nothing

StockData = Split(strData, ",")                    '��strDataͨ��Split�����ֿ�,split��������һ�������������ݵ�����
getLastDayStockPrice = Val(StockData(2))                   '��strData(2)�ı�Ϊ��ֵ�������

End Function
Function getHKStockPrice(ByRef StockCode As String)
Application.Volatile                            '����Ϊ��ʧ�Ժ���(ÿ����Ҫ���¼���)

'HK Stock Sina Http
'http://hq.sinajs.cn/list=hk00001
''var hq_str_hk00001="CHEUNG KONG,����,90.300,91.050,91.050,90.000,90.750,-0.300,-0.329,90.650,90.750,627798876,6932826,2.954,2.810,118.800,87.600,2016/06/22,16:01";
'temp[0]------CHEUNG KONG------����
'temp [1] - -----���� - -----��Ʊ����
'temp [2] - -----90.3 - -----���տ��̼�
'temp [3] - -----91.05 - -----�������̼�
'temp [4] - -----91.05 - -----��߼�
'temp [5] - -----90# - -----��ͼ�
'temp [6] - -----90.75 - -----��ǰ��(�ּ�)
'temp [7] - ------0.3 - -----�ǵ�
'temp [8] - ------0.329 - -----�Ƿ�
'temp [9] - -----90.65 - -----��һ
'temp [10] - -----90.75 - -----��һ
'temp [11] - -----627798876 - -----�ɽ���
'temp [12] - -----6932826 - -----�ɽ���
'temp [13] - -----2.954 - -----��ӯ��
'temp[14]------2.810------��Ϣ�ʣ�2.810%��
'temp[15]------118.800------52�����
'temp[16]------87.600------52�����
'temp [17] - -----2016 / 6 / 22 - -----����
'temp[18]------16:01------ʱ��


Url = "https://hq.sinajs.cn/list=" + StockCode
strData = GetHttp(Url)
strData = Replace(strData, Chr(13), "") '�滻���з�
strData = Replace(strData, Chr(10), "") '�滻�س���

Set objREGEXP = CreateObject("VBSCRIPT.REGEXP")  'note������һ��������ʽ��ȥ��http���ص�ǰ��һ�����߰����ͷ
With objREGEXP
.Global = True
.Pattern = "var hq_str_.*=\"""
strData = .Replace(strData, "")
.Pattern = "\"";"
strData = .Replace(strData, "")

End With
Set objREGEXP = Nothing

StockData = Split(strData, ",")                    '��strDataͨ��Split�����ֿ�,split��������һ�������������ݵ�����
getHKStockPrice = Val(StockData(6))                   '��strData(6)�ı�Ϊ��ֵ�������

End Function
Function getLastDayHKStockPrice(ByRef StockCode As String)
Application.Volatile                            '����Ϊ��ʧ�Ժ���(ÿ����Ҫ���¼���)

'HK Stock Sina Http
'http://hq.sinajs.cn/list=hk00001
''var hq_str_hk00001="CHEUNG KONG,����,90.300,91.050,91.050,90.000,90.750,-0.300,-0.329,90.650,90.750,627798876,6932826,2.954,2.810,118.800,87.600,2016/06/22,16:01";
'temp[0]------CHEUNG KONG------����
'temp [1] - -----���� - -----��Ʊ����
'temp [2] - -----90.3 - -----���տ��̼�
'temp [3] - -----91.05 - -----�������̼�
'temp [4] - -----91.05 - -----��߼�
'temp [5] - -----90# - -----��ͼ�
'temp [6] - -----90.75 - -----��ǰ��(�ּ�)
'temp [7] - ------0.3 - -----�ǵ�
'temp [8] - ------0.329 - -----�Ƿ�
'temp [9] - -----90.65 - -----��һ
'temp [10] - -----90.75 - -----��һ
'temp [11] - -----627798876 - -----�ɽ���
'temp [12] - -----6932826 - -----�ɽ���
'temp [13] - -----2.954 - -----��ӯ��
'temp[14]------2.810------��Ϣ�ʣ�2.810%��
'temp[15]------118.800------52�����
'temp[16]------87.600------52�����
'temp [17] - -----2016 / 6 / 22 - -----����
'temp[18]------16:01------ʱ��


Url = "https://hq.sinajs.cn/list=" + StockCode
strData = GetHttp(Url)
strData = Replace(strData, Chr(13), "") '�滻���з�
strData = Replace(strData, Chr(10), "") '�滻�س���

Set objREGEXP = CreateObject("VBSCRIPT.REGEXP")  'note������һ��������ʽ��ȥ��http���ص�ǰ��һ�����߰����ͷ
With objREGEXP
.Global = True
.Pattern = "var hq_str_.*=\"""
strData = .Replace(strData, "")
.Pattern = "\"";"
strData = .Replace(strData, "")

End With
Set objREGEXP = Nothing

StockData = Split(strData, ",")                    '��strDataͨ��Split�����ֿ�,split��������һ�������������ݵ�����
getLastDayHKStockPrice = Val(StockData(3))                   '��strData(3)�ı�Ϊ��ֵ�������

End Function
Function getStockDate()
Application.Volatile
Url = "https://hq.sinajs.cn/list=sz399001"
strData = GetHttp(Url)
strData = Replace(strData, Chr(13), "")
strData = Replace(strData, Chr(10), "")

Set objREGEXP = CreateObject("VBSCRIPT.REGEXP")
With objREGEXP
.Global = True
.Pattern = "var hq_str_.*=\"""
strData = .Replace(strData, "")
.Pattern = "\"";"
strData = .Replace(strData, "")

End With
Set objREGEXP = Nothing

StockData = Split(strData, ",")
getStockDate = StockData(30) + " " + StockData(31)

End Function


Function getStockData(ByRef StockCode As String)
Url = "http://hq.sinajs.cn/list=" + StockCode
strData = GetHttp(Url)
strData = Replace(strData, Chr(13), "")
strData = Replace(strData, Chr(10), "")

Set objREGEXP = CreateObject("VBSCRIPT.REGEXP")
With objREGEXP
.Global = True
.Pattern = "var hq_str_.*=\"""
strData = .Replace(strData, "")
.Pattern = "\"";"
strData = .Replace(strData, "")

End With
Set objREGEXP = Nothing

getStockData = Split(strData, ",")

End Function

Function GetHttp(Url)
Dim objXML
On Error Resume Next
Set objXML = CreateObject("Microsoft.XMLHTTP")
With objXML
.Open "Get", Url, False, "", ""
.Send
GetHttp = .ResponseBody
End With
GetHttp = BytesToBstr(GetHttp, "GB2312")
Set objXML = Nothing
On Error GoTo 0
End Function

Function BytesToBstr(strBody, CodeBase)
Dim objStream
Set objStream = CreateObject("Adodb.Stream")

With objStream
.Type = 1
.Mode = 3
.Open
.Write strBody
.Position = 0
.Type = 2
.Charset = CodeBase
BytesToBstr = .ReadText
End With
objStream.Close
Set objStream = Nothing
End Function


