Option Explicit

Dim input1
Dim input2

'MNISTデータベースファイルをC:\testに保存している場合
input1 = "C:\test\train-images.idx3-ubyte"
input2 = "C:\test\train-labels.idx1-ubyte"

Dim images
Dim labels

'バイナリ形式でファイルを開く
Set images = CreateObject("ADODB.Stream")
Set labels = CreateObject("ADODB.Stream")
images.Type = 1 'BINARY
labels.Type = 1 'BINARY
images.Open
labels.Open
images.LoadFromFile(input1)
labels.LoadFromFile(input2)

Dim myVal
Dim label
Dim image(783)
Dim i
Dim buf

Randomize '乱数ジェネレータを初期化

'キャンセルボタンが押されるまで繰り返す
Do
    myVal = Int((Rnd * 60000) + 1) '1～60000の乱数
    images.Position = 16 + 784 * (myVal - 1)
    labels.Position = 8 + (myval - 1)

    '1画像の各ピクセルデータを1次元の配列に格納する
    For i = 0 To 783
        image(i) = AscB(images.Read(1))
    Next

    '正解の数値
    label = AscB(labels.Read(1))

    '画像をダイアログボックス上に疑似的に表示する
    buf = ""
    For i = 0 To 783
        If image(i) > 128 Then
            buf = buf & "■"
        Else
            buf = buf & "□"
        End If

        If (i + 1) Mod 28 = 0 Then
            buf = buf & vbCr
        End If
    Next

    If Msgbox(buf & vbCr & "正解: " & label, vbOKCancel, "No." & myVal) = vbCancel Then
        Exit Do
    End If
    
Loop

images.Close
labels.Close
