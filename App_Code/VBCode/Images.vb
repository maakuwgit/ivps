Imports System
Imports System.IO
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Drawing.Drawing2D

Public Module Images
    Public Function ResizeImage(m As IO.MemoryStream, ImgType As String, Optional ByVal w As Integer = 0, Optional ByVal h As Integer = 0) As IO.MemoryStream
        Dim img As System.Drawing.Image = System.Drawing.Image.FromStream(m)
        If w > 0 And h > 0 Then
			Dim imgWidth = img.Size.width
			Dim imgHeight = img.Size.height
			Dim orientationIsLandscape = true
			Dim recDest As System.Drawing.Rectangle
			Dim thumb As System.Drawing.Bitmap
			If imgWidth < imgHeight Then
				orientationIsLandscape = false
			End If
			If orientationIsLandscape Then
				If (w * img.Height / img.Width) > h Then
					recDest = New Rectangle(0, 0, h * img.Width / img.Height, h)
            		thumb = New System.Drawing.Bitmap(CInt(h * img.Width / img.Height), h)
            	Else
            		recDest = New System.Drawing.Rectangle(0, 0, w, w * img.Height / img.Width)
            		thumb = New System.Drawing.Bitmap(w, CInt(w * img.Height / img.Width))
            	End If
			Else
				If (h * img.Width / img.Height) > w Then
					recDest = New System.Drawing.Rectangle(0, 0, w, w * img.Height / img.Width)
            		thumb = New System.Drawing.Bitmap(w, CInt(w * img.Height / img.Width))
				Else
					recDest = New Rectangle(0, 0, h * img.Width / img.Height, h)
            		thumb = New System.Drawing.Bitmap(CInt(h * img.Width / img.Height), h)
				End If
            End If
            Dim g As Graphics = Graphics.FromImage(thumb)
            g.SmoothingMode = SmoothingMode.HighQuality
            g.CompositingQuality = CompositingQuality.HighQuality
            g.InterpolationMode = InterpolationMode.High
            g.DrawImage(img, 0, 0, thumb.Width, thumb.Height)
            Dim ms As New IO.MemoryStream
            If ImgType = "image/png" Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Png)
                'ctx2.Response.AddHeader("Content-Disposition", "attachment; filename=""Something.png""")
            ElseIf ImgType = "image/gif" Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Gif)
                'ctx2.Response.AddHeader("Content-Disposition", "attachment; filename=""Something.gif""")
            ElseIf ImgType = "image/jpeg" Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg)
                'ctx2.Response.AddHeader("Content-Disposition", "attachment; filename=""Something.jpg""")
            End If
            Return ms
		End If
        If w > 0 Then
            Dim recDest As New System.Drawing.Rectangle(0, 0, w, w * img.Height / img.Width)
            Dim thumb As New System.Drawing.Bitmap(w, CInt(w * img.Height / img.Width))
            Dim g As Graphics = Graphics.FromImage(thumb)
            g.SmoothingMode = SmoothingMode.HighQuality
            g.CompositingQuality = CompositingQuality.HighQuality
            g.InterpolationMode = InterpolationMode.High
            g.DrawImage(img, 0, 0, thumb.Width, thumb.Height)
            Dim ms As New IO.MemoryStream
            If ImgType = "image/png" Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Png)
                'ctx2.Response.AddHeader("Content-Disposition", "attachment; filename=""Something.png""")
            ElseIf ImgType = "image/gif" Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Gif)
                'ctx2.Response.AddHeader("Content-Disposition", "attachment; filename=""Something.gif""")
            ElseIf ImgType = "image/jpeg" Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg)
                'ctx2.Response.AddHeader("Content-Disposition", "attachment; filename=""Something.jpg""")
            End If
            Return ms
        End If
        If h > 0 Then
            Dim recDest As New Rectangle(0, 0, h * img.Width / img.Height, h)
            Dim thumb As New System.Drawing.Bitmap(CInt(h * img.Width / img.Height), h)
            Dim g As Graphics = Graphics.FromImage(thumb)
            g.SmoothingMode = SmoothingMode.HighQuality
            g.CompositingQuality = CompositingQuality.HighQuality
            g.InterpolationMode = InterpolationMode.High
            g.DrawImage(img, 0, 0, thumb.Width, thumb.Height)
            Dim ms As New IO.MemoryStream
            If ImgType = "image/png" Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Png)
            ElseIf ImgType = "image/gif" Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Gif)
            ElseIf ImgType = "image/jpeg" Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg)
            End If
            Return ms
        End If
        Return m
    End Function
End Module