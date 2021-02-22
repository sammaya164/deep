---
categories: "activation-function"
title: "活性化関数1"

---

以下は個人的なメモでして、説明用の文章ではないので、意味不明でも気にしないで下さい。


## 活性化関数

活性化関数は、入力の総和をもとに、どのように発火するかを決定する。


以下のようなものがある。
- 恒等関数
- ステップ関数
- シグモイド関数
- ReLU関数

## 恒等関数

恒等関数はそのものを返す。

```vb
Function identity_function(x)
    identity_function = x
End Function
```

引数をそのまま返すだけ。あまり意味ない。

クラスを作ってみる。

```vb
Class C_Num
    Private m_mode

    Public Property Let mode(val)
        m_mode = LCase(val) '文字列を小文字に置き換えて格納する
    End Property

    Public Function activation(x)
        Select Case m_mode
        Case "", "identity"
            activation = x
        End Select
    End Function
End Class
```

次のように使う。まだ、あまり意味ない。

```vb
Dim nb
Set nb = New C_Num
nb.mode = "identity"
MsgBox nb.Activation(1) '1を表示
```

恒等関数はあとで扱うことにする。次はステップ関数。

## ステップ関数

ステップ関数は1か0を返す。発火するかしないかの2状態を表す。

```vb
Function step_function(x)
    If x > 0 Then
        step_function = 1 
    Else
        step_function = 0
    End If
End Function
```

引数が値だけでなく、配列である場合にも対応させる。

```vb
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
```

値や配列を表示させる関数を作る。

```vb
Function ToString(x)
    Dim buf()
    Dim i
    
    If IsArray(x) Then
        ReDim buf(UBound(x))
        For i = 0 To UBound(x)
            buf(i) = ToString(x(i)) 
        Next
        ToString = "[" & Join(buf, ",") & "]"
    Else
        ToString = x
    End If
End Function



Function Print(x)
    Msgbox ToString(x)
End Function
```

使用例。

```vb
Print step_function(Array(1,0,0.5)) '>[1,0,1]
```
