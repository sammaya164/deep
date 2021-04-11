Option Explicit

Dim input1
Dim input2

'MNIST�f�[�^�x�[�X�t�@�C����C:\test�ɕۑ����Ă���ꍇ
input1 = "C:\test\train-images.idx3-ubyte"
input2 = "C:\test\train-labels.idx1-ubyte"

Dim images
Dim labels

'�o�C�i���`���Ńt�@�C�����J��
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

Randomize '�����W�F�l���[�^��������

'�L�����Z���{�^�����������܂ŌJ��Ԃ�
Do
    myVal = Int((Rnd * 60000) + 1) '1�`60000�̗���
    images.Position = 16 + 784 * (myVal - 1)
    labels.Position = 8 + (myval - 1)

    '1�摜�̊e�s�N�Z���f�[�^��1�����̔z��Ɋi�[����
    For i = 0 To 783
        image(i) = AscB(images.Read(1))
    Next

    '�����̐��l
    label = AscB(labels.Read(1))

    '�摜���_�C�A���O�{�b�N�X��ɋ^���I�ɕ\������
    buf = ""
    For i = 0 To 783
        If image(i) > 128 Then
            buf = buf & "��"
        Else
            buf = buf & "��"
        End If

        If (i + 1) Mod 28 = 0 Then
            buf = buf & vbCr
        End If
    Next

    If Msgbox(buf & vbCr & "����: " & label, vbOKCancel, "No." & myVal) = vbCancel Then
        Exit Do
    End If
    
Loop

images.Close
labels.Close
