Attribute VB_Name = "ģ��2"

Sub mycalc()
Attribute mycalc.VB_Description = "���� L.Wang ¼�ƣ�ʱ��: 2017-7-11"
Attribute mycalc.VB_ProcData.VB_Invoke_Func = " \n14"
'
' delete2triggle Macro
' ʱ��: 2017-7-11
'

'
If (Sheet1.ToggleButton1.Value) Then
    Dim NewTime
    NewTime = Now + TimeValue("00:00:10")                       '��һ���ֹ�ִ�У�����30s��ʱִ�� ˢ�£�����ok by
    Sheet1.[a5] = "Getting data..."
    geturl
    DoEvents
    Sheet1.[a5] = ""
    Application.OnTime NewTime, "mycalc"
End If
End Sub
