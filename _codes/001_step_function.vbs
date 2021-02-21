'2021/2/21 配列の引数にも対応したステップ関数を作る

Function step_function(x)
    Dim buf()
    Dim i
    
    If IsArray(x) Then
        ReDim buf(UBound(x))
        For i = 0 To UBound(x)
            buf(i) = step_function(x(i))
        Next
        step_function = buf
    Else
        If x > 0 Then
            step_function = 1 
        Else
            step_function = 0
        End If
    End If
End Function



Function ToString(x)
    Dim buf()
    Dim i
    
    If IsArray(x) Then
        ReDim buf(UBound(x))
        For i = 0 To UBound(x)
            buf(i) = ToString(x(i)) 
        Next
        ToString = "[" & Join(buf, ", ") & "]"
    Else
        ToString = x
    End If
End Function



Function Print(x)
    Msgbox ToString(x)
End Function



Print step_function(Array(1,0,0.5))
