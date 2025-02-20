#include <Date.au3>

Local $currentDate;
; Kiểm tra xem có argument không
If $CmdLine[0] > 0 Then
	$currentDate = $CmdLine[1]
Else
	; Lấy thời gian hiện tại
	$currentDate = _NowCalc()
EndIf

; Lấy thông tin current path
Local $currentPath = @WorkingDir
; Mở ứng dụng notepad
Run("notepad.exe")
; Chờ màn hình notepad hiển thị
WinWaitActive("[CLASS:Notepad]")
; Lấy handle của control edit area
Local $hEdit = ControlGetHandle("[CLASS:Notepad]", "", "Edit1")
; Focus control edit area
ControlFocus("[CLASS:Notepad]", "", $hEdit)
; Nhập nội dung vào edit area
ControlSend("[CLASS:Notepad]", "", $hEdit, "Hello, this is a test!")
; Nhập ký tự xuống dòng vào edit area
ControlSend("[CLASS:Notepad]", "", $hEdit, @CRLF)
; Nhập thời gian vào edit area
ControlSend("[CLASS:Notepad]", "", $hEdit, $currentDate)
; Mở menu File và chọn Save As
WinMenuSelectItem("[CLASS:Notepad]", "", "&File", "Save &As...")
; Chờ màn hình Save As hiển thị
WinWaitActive("Save As")
; Lấy handle của ô nhập tên file
Local $hFileName = ControlGetHandle("Save As", "", "[CLASS:Edit; INSTANCE:1]")
; Focus vào ô nhập tên file
ControlFocus("Save As", "", $hFileName)
; Xóa nội dung mặc định trong ô nhập tên file
ControlSend("Save As", "", $hFileName, "{DELETE}")
; Nhập tên file
ControlSend("Save As", "", $hFileName, $currentPath & "\data\test.txt")
; Lấy handle button save
Local $hSave = ControlGetHandle("Save As", "", "[CLASS:Button; INSTANCE:2]")
; Focus vào button save
ControlFocus("Save As", "", $hSave);
; Click button save
ControlClick("Save As", "", $hSave);
; Chờ hiển thị màn hình Confirm Save As trong 1 giây
if WinWaitActive("Confirm Save As", "", 1) Then
	; Trường hợp hiển thị màn hình Confirm Save As (do trùng tên file)
	; Lấy handle button Yes
	Local $hYes = ControlGetHandle("Confirm Save As", "", "[CLASS:Button; INSTANCE:1]")
	; Focus vào button yes
	ControlFocus("Confirm Save As", "", $hYes);
	; Click button yes
	ControlClick("Confirm Save As", "", $hYes);
	; Chờ quá trình save file (Chờ màn hình Confirm Save As đóng)
	While WinExists("Confirm Save As")
		Sleep(100)
	WEnd
Else
	; Trường hợp không hiển thị màn hình Confirm Save As (do file mới)
	; Chờ quá trình save file (Chờ màn hình Save As đóng)
	While WinExists("Save As")
		Sleep(100)
	WEnd
EndIf
; Đóng ứng dụng notepad
WinClose("[CLASS:Notepad]")