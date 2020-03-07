Imports System
Imports System.IO
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Drawing.Drawing2D

Public Module ImageUtility

	Public Function ResizeHttpPostedFile(f as HttpPostedFile, Optional ImgFormat As ImageFormat = Nothing, Optional MaxWidth As Integer = 1500, Optional MaxHeight As Integer = 1000) As System.IO.MemoryStream
	
		 If f.ContentLength > 0 Then 
			Dim fi As New IO.FileInfo(f.FileName)   
			Dim b(f.InputStream.Length) As Byte
			f.InputStream.Read(b, 0, f.InputStream.Length)
			
			 ' Restrict the size of the image
			Dim image_file As System.Drawing.Image = System.Drawing.Image.FromStream(f.InputStream)
			Dim image_height As Integer = image_file.Height
			Dim image_width As Integer = image_file.Width
			Dim max_height As Integer = MaxHeight
			Dim max_width As Integer = MaxWidth

			If image_height > max_height Or image_width > max_width Then
				image_height = (image_height * max_width) / image_width
				image_width = max_width

				If image_height > max_height Then
					image_width = (image_width * max_height) / image_height
					image_height = max_height
				End If
			End If

			Dim bitmap_file As New Bitmap(image_file, image_width, image_height)
			Dim stream As New System.IO.MemoryStream
			
			If LCase(fi.Extension) = ".jpg" Or LCase(fi.Extension) = ".jpeg" Then
				ImgFormat = ImageFormat.Jpeg
			End If
			
			If LCase(fi.Extension) = ".png" Then
				ImgFormat = ImageFormat.Png
			End If
			
			If LCase(fi.Extension) = ".gif" Then
				ImgFormat = ImageFormat.Gif
			End If
			
			If ImgFormat Is Nothing Then
				ImgFormat = ImageFormat.Png
				'ImgFormat = ImageFormat.Jpeg
			End If
			
			bitmap_file.Save(stream, ImgFormat)
			stream.Position = 0

			Dim data(stream.Length) As Byte
			stream.Read(data, 0, stream.Length)
			
			return stream
		
		Else
		
			return Nothing
			
		End If
		
	End Function
	
	Public Function SaveStreamToFileSystem(Stream As IO.MemoryStream, FolderPath As String, FileName As String)
        
    	' Should add a resize function here to prevent extra large images
    	If Stream.length > 0 Then
			Dim strFileName as string
			Dim strFilePath as string
			Dim strFolder as string
			
			' Map the path on the server
			strFolder = HttpContext.Current.Server.MapPath(FolderPath)

			'Create the directory if it does not exist.
			If(Not System.IO.Directory.Exists(strFolder)) Then
    			System.IO.Directory.CreateDirectory(strFolder)
			End If
			
			Dim File As New FileStream(strFolder & FileName, FileMode.Create, FileAccess.Write)
        	
        	Stream.WriteTo(File)
        	
        	File.Close()
        	
        	Stream.Close()
			
			' Return the files src
			Return FolderPath & FileName
			
		End If
		
		Return Nothing
	 
	End Function
	
	Public Function SaveHttpPostedFileToFileSystem(f as HttpPostedFile, ImgFolderPath As String, Optional FileName As String = Nothing)
		
    	' Should add a resize function here to prevent extra large images
    	If f.ContentLength > 0 Then
			Dim strFileName as string
			Dim strFilePath as string
			Dim strFolder as string

			'Get the name of the file that is posted.
			strFileName = f.FileName
			strFileName = Path.GetFileName(strFileName)
			
			' Map the path on the server
			strFolder = HttpContext.Current.Server.MapPath(ImgFolderPath)

			'Create the directory if it does not exist.
			If(Not System.IO.Directory.Exists(strFolder)) Then
    			System.IO.Directory.CreateDirectory(strFolder)
			End If
			
			Dim FileNameWithoutExtension as String
			If FileName Is Nothing Then
				FileNameWithoutExtension = Path.GetFileNameWithoutExtension(strFileName)
			Else
				FileNameWithoutExtension = FileName
			End If 
			
			Dim FileExtension = Path.GetExtension(strFileName)

			
			'Define the path with the file name
			strFilePath = strFolder & FileNameWithoutExtension & FileExtension

			'Save the uploaded file to the server.
			f.SaveAs(strFilePath)
			
			' Return the files src
			Return ImgFolderPath & FileNameWithoutExtension & FileExtension
			
		End If
		
		Return Nothing
	
	End Function
	
	Function PostedFileMimeType(f as HttpPostedFile)
		If f.ContentLength > 0 Then
			return RCMime.GetFromFileName(f.FileName)
		End If
		Return False
    End Function
	
    Function ResizeAndUploadPostedFileToFileSystem(f as HttpPostedFile, FolderPath As String, FileName As String, Optional ImgFormat As ImageFormat = Nothing, Optional MaxWidth As Integer = 1500, Optional MaxHeight As Integer = 1000)
    	Dim stream As System.IO.MemoryStream = ImageUtility.ResizeHttpPostedFile(f, ImgFormat, MaxWidth, MaxHeight)
		Dim src = ImageUtility.SaveStreamToFileSystem(stream, FolderPath, FileName)
		return src
    End Function
    
    Function ResizePostedFileToBytes(f as HttpPostedFile, Optional ImgFormat As ImageFormat = Nothing, Optional MaxWidth As Integer = 1500, Optional MaxHeight As Integer = 1000)
    	Dim stream As System.IO.MemoryStream = ImageUtility.ResizeHttpPostedFile(f, ImgFormat, MaxWidth, MaxHeight)
    	return stream.ToArray()
    End Function
    
     Function ImageFormatType(m As IO.MemoryStream)
    		Dim img As System.Drawing.Image = System.Drawing.Image.FromStream(m)
    		if System.Drawing.Imaging.ImageFormat.Png.Equals(img.RawFormat) Then
                return System.Drawing.Imaging.ImageFormat.Png.ToString()
          ElseIf System.Drawing.Imaging.ImageFormat.Gif.Equals(img.RawFormat) Then
                return System.Drawing.Imaging.ImageFormat.Gif.ToString()
          ElseIf System.Drawing.Imaging.ImageFormat.Jpeg.Equals(img.RawFormat) Then
                return System.Drawing.Imaging.ImageFormat.Jpeg.ToString()
          End If
          return Nothing
    End Function
    
    Function ImageMimeType(m As IO.MemoryStream)
    		Dim Mime = new RCMime()
    		Dim imageFormat = ImageUtility.ImageFormatType(m)
          return Mime.GetFromExtension(imageFormat)
    End Function
    
    Public Function ResizeImage(m As IO.MemoryStream, Optional ByVal w As Integer = 0, Optional ByVal h As Integer = 0) As IO.MemoryStream
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
            
            if System.Drawing.Imaging.ImageFormat.Png.Equals(img.RawFormat) Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Png)
          ElseIf System.Drawing.Imaging.ImageFormat.Gif.Equals(img.RawFormat) Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Gif)
          ElseIf System.Drawing.Imaging.ImageFormat.Jpeg.Equals(img.RawFormat) Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg)
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
            
            if System.Drawing.Imaging.ImageFormat.Png.Equals(img.RawFormat) Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Png)
          ElseIf System.Drawing.Imaging.ImageFormat.Gif.Equals(img.RawFormat) Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Gif)
          ElseIf System.Drawing.Imaging.ImageFormat.Jpeg.Equals(img.RawFormat) Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg)
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
            
          if System.Drawing.Imaging.ImageFormat.Png.Equals(img.RawFormat) Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Png)
          ElseIf System.Drawing.Imaging.ImageFormat.Gif.Equals(img.RawFormat) Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Gif)
          ElseIf System.Drawing.Imaging.ImageFormat.Jpeg.Equals(img.RawFormat) Then
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg)
          End If
            
            Return ms
        End If
        Return m
    End Function
    
End Module