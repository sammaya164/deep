Option Explicit

Dim w1, b1, w2, b2 '�d�݂ƃo�C�A�X�̃p�����[�^
Dim projectName '�v���W�F�N�g��
Dim numLearn '�w�K��

Select Case WScript.Arguments.Count
Case 0 'W�N���b�N�ŋN�������ꍇ
    Call InitParameters()
    Call OutputParameters()

Case 1 '�h���b�O���h���b�v�ŋN�������ꍇ
    Call LoadParameters(WScript.Arguments.Item(0))

    Select Case MsgBox("�w�K����@���͂�" & vbCr & "���_����@��������", vbYesNoCancel, "�w�K���܂���")
    Case vbNo
        Call Suiron()
        Call OutputAccuracy()
    Case vbYes
        Call Gakushu()
        Call OutputParameters()
    Case Else
        WScript.Quit()
    End Select

Case Else '�����t�@�C���̏ꍇ�͏I��
    WScript.Quit()

End Select



'�p�����[�^�̐V�K�쐬
Function InitParameters()
    projectName = Inputbox("�v���W�F�N�g������͂��ĉ�����", "�p�����[�^�̐V�K�쐬", "Test")
    If projectName = "" Then WScript.Quit '�L�����Z���{�^���������ꂽ�ꍇ�͏I��
    projectName = Replace(projectName, "_", "-") '_��-�֕ϊ�����
    numLearn = 0

    Const N1 = 784
    Const N2 = 100
    Const N3 = 10
    Dim i

    w1 = Zeros(N1)
    For i = 0 To UBound(w1)
        w1(i) = Rands(N2, 0.02)
    Next

    b1 = Zeros(N2)

    w2 = Zeros(N2)
    For i = 0 To UBound(w2)
        w2(i) = Rands(N3, 0.02)
    Next

    b2 = Zeros(N3)
End Function



'�e�v�f��0��1�����z���Ԃ�
Function Zeros(size)
    Dim buf()
    Dim i

    ReDim buf(size - 1)
    For i = 0 To UBound(buf)
        buf(i) = 0
    Next

    Zeros = buf
End Function



'�e�v�f�������_���Ȑ��l��1�����z���Ԃ�
Function Rands(size, random_std)
    Dim buf()
    Dim i

    ReDim buf(size - 1)
    Randomize '�����W�F�l���[�^��������
    For i = 0 To UBound(buf)
        buf(i) = random_std * Rnd
    Next

    Rands = buf
End Function



'�p�����[�^���t�@�C���ɏo�͂���
Function OutputParameters()
    Dim file
    Dim i, j
    Dim buf

    Set file = New C_FileOpen
    file.Path = ".\" & projectName & "_" & numLearn & ".txt"
    file.Open("w")

    For i = 0 To UBound(w1)
        For j = 0 To UBound(w1(i))
            file.Write(w1(i)(j))
        Next
    Next

    For i = 0 To UBound(b1)
        file.Write(b1(i))
    Next

    For i = 0 To UBound(w2)
        For j = 0 To UBound(w2(i))
            file.Write(w2(i)(j))
        Next
    Next

    For i = 0 To UBound(b2)
        file.Write(b2(i))
    Next

    MsgBox file.Path & "�ɏo�͂��܂����B"
    file.Close
    Set file = Nothing
End Function



'�t�@�C������p�����[�^��ǂݍ���
Function LoadParameters(filePath)
    '�t�@�C�����̃`�F�b�N�ƃv���W�F�N�g���A�w�K�񐔂̓ǂݍ���
    Dim reg
    Dim matches

    Set reg = CreateObject("VBScript.RegExp") '���K�\���I�u�W�F�N�g
    reg.Pattern = "\\([^\\]+)_(\d+)\.txt$"
    If reg.Test(filePath) Then
        Set matches = reg.Execute(filePath)
        projectName = matches(0).submatches(0) '�v���W�F�N�g��
        numLearn = CLng(matches(0).submatches(1)) '�w�K��
    Else
        Msgbox filePath & "�̓p�����[�^�t�@�C���ł͂Ȃ��悤�ł��B"
        WScript.Quit()
    End If

    '�p�����[�^�̓ǂݍ���
    Const N1 = 784
    Const N2 = 100
    Const N3 = 10

    Dim file
    Dim i, j
    Dim buf

    Set file = New C_FileOpen
    file.Path = filePath
    file.Open("r")

    w1 = Zeros(N1) 'w1
    For i = 0 To UBound(w1)
        w1(i) = Zeros(N2)
        For j = 0 To UBound(w1(i))
            w1(i)(j) = file.Read
        Next
    Next

    b1 = Zeros(N2) 'b1
    For i = 0 To UBound(b1)
         b1(i) = file.Read
    Next

    w2 = Zeros(N2) 'w2
    For i = 0 To UBound(w2)
        w2(i) = Zeros(N3)
        For j = 0 To UBound(w2(i))
            w2(i)(j) = file.Read
        Next
    Next

    b2 = Zeros(N3) 'b2
    For i = 0 To UBound(b2)
        b2(i) = file.Read
    Next

    file.Close
    Set file = Nothing
End Function



Function Suiron()

End Function



Function OutputAccuracy()

End Function



Function Gakushu()

End Function



'**********************************************************
'�N���X�錾
'**********************************************************
Class C_FileOpen
    Private m_fso
    Private m_path
    Private m_file


    Private Sub Class_Initialize
        Set m_fso = CreateObject("Scripting.FileSystemObject")
    End Sub



    Private Sub Class_Terminate
        Set m_fso = Nothing
        If TypeName(m_file) = "TextStream" Then
            m_file.Close
        End If
        Set m_file = Nothing
    End Sub



    Public Property Let Path(val)
        If Left(val, 1) = "." Then
            m_path = m_fso.GetAbsolutePathName(WScript.ScriptFullName & "\..\" & val)
        Else
            m_path = m_fso.GetAbsolutePathName(val)
        End If
    End Property



    Public Property Get Path()
        Path = m_path
    End Property



    Public Property Get HasNext()
        HasNext = Not m_file.AtEndOfStream
    End Property



    Public Function Open(mode)
        Select Case LCase(mode)
        Case "r"
            Set m_file = m_fso.OpenTextFile(m_path, 1, False)
        Case "w"
            Set m_file = m_fso.OpenTextFile(m_path, 2, True)
        Case "a"
            Set m_file = m_fso.OpenTextFile(m_path, 8, True)
        End Select
    End Function



    Public Function Read()
        Read = m_file.ReadLine
    End Function



    Public Function Write(val)
        m_file.WriteLine(val)
    End Function



    Public Function Close()
        m_file.Close()
    End Function

End Class