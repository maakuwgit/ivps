Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing.Drawing2D
Imports System.Drawing

Public Class RCMime
    Public Shared Function GetFromFileName(ByVal fileName As String) As String
        Return GetFromExtension(System.IO.Path.GetExtension(fileName).Remove(0, 1))
    End Function

    Public Shared Function GetFromExtension(ByVal extension As String) As String
        If extension.StartsWith("."c) Then
            extension = extension.Remove(0, 1)
        End If

        If MIMETypesDictionary.ContainsKey(extension) Then
            Return MIMETypesDictionary(extension)
        End If

        'Return "unknown/unknown"
        Return False
    End Function

    Private Shared ReadOnly MIMETypesDictionary As New Dictionary(Of String, String)() From { _
         {"ai", "application/postscript"}, _
         {"aif", "audio/x-aiff"}, _
         {"aifc", "audio/x-aiff"}, _
         {"aiff", "audio/x-aiff"}, _
         {"asc", "text/plain"}, _
         {"atom", "application/atom+xml"}, _
         {"au", "audio/basic"}, _
         {"avi", "video/x-msvideo"}, _
         {"bcpio", "application/x-bcpio"}, _
         {"bin", "application/octet-stream"}, _
         {"bmp", "image/bmp"}, _
         {"cdf", "application/x-netcdf"}, _
         {"cgm", "image/cgm"}, _
         {"class", "application/octet-stream"}, _
         {"cpio", "application/x-cpio"}, _
         {"cpt", "application/mac-compactpro"}, _
         {"csh", "application/x-csh"}, _
         {"css", "text/css"}, _
         {"dcr", "application/x-director"}, _
         {"dif", "video/x-dv"}, _
         {"dir", "application/x-director"}, _
         {"djv", "image/vnd.djvu"}, _
         {"djvu", "image/vnd.djvu"}, _
         {"dll", "application/octet-stream"}, _
         {"dmg", "application/octet-stream"}, _
         {"dms", "application/octet-stream"}, _
         {"doc", "application/msword"}, _
         {"dtd", "application/xml-dtd"}, _
         {"dv", "video/x-dv"}, _
         {"dvi", "application/x-dvi"}, _
         {"dxr", "application/x-director"}, _
         {"eps", "application/postscript"}, _
         {"etx", "text/x-setext"}, _
         {"exe", "application/octet-stream"}, _
         {"ez", "application/andrew-inset"}, _
         {"gif", "image/gif"}, _
         {"gram", "application/srgs"}, _
         {"grxml", "application/srgs+xml"}, _
         {"gtar", "application/x-gtar"}, _
         {"hdf", "application/x-hdf"}, _
         {"hqx", "application/mac-binhex40"}, _
         {"htm", "text/html"}, _
         {"html", "text/html"}, _
         {"ice", "x-conference/x-cooltalk"}, _
         {"ico", "image/x-icon"}, _
         {"ics", "text/calendar"}, _
         {"ief", "image/ief"}, _
         {"ifb", "text/calendar"}, _
         {"iges", "model/iges"}, _
         {"igs", "model/iges"}, _
         {"jnlp", "application/x-java-jnlp-file"}, _
         {"jp2", "image/jp2"}, _
         {"jpe", "image/jpeg"}, _
         {"jpeg", "image/jpeg"}, _
         {"jpg", "image/jpeg"}, _
         {"js", "application/x-javascript"}, _
         {"kar", "audio/midi"}, _
         {"latex", "application/x-latex"}, _
         {"lha", "application/octet-stream"}, _
         {"lzh", "application/octet-stream"}, _
         {"m3u", "audio/x-mpegurl"}, _
         {"m4a", "audio/mp4a-latm"}, _
         {"m4b", "audio/mp4a-latm"}, _
         {"m4p", "audio/mp4a-latm"}, _
         {"m4u", "video/vnd.mpegurl"}, _
         {"m4v", "video/x-m4v"}, _
         {"mac", "image/x-macpaint"}, _
         {"man", "application/x-troff-man"}, _
         {"mathml", "application/mathml+xml"}, _
         {"me", "application/x-troff-me"}, _
         {"mesh", "model/mesh"}, _
         {"mid", "audio/midi"}, _
         {"midi", "audio/midi"}, _
         {"mif", "application/vnd.mif"}, _
         {"mov", "video/quicktime"}, _
         {"movie", "video/x-sgi-movie"}, _
         {"mp2", "audio/mpeg"}, _
         {"mp3", "audio/mpeg"}, _
         {"mp4", "video/mp4"}, _
         {"mpe", "video/mpeg"}, _
         {"mpeg", "video/mpeg"}, _
         {"mpg", "video/mpeg"}, _
         {"mpga", "audio/mpeg"}, _
         {"ms", "application/x-troff-ms"}, _
         {"msh", "model/mesh"}, _
         {"mxu", "video/vnd.mpegurl"}, _
         {"nc", "application/x-netcdf"}, _
         {"oda", "application/oda"}, _
         {"ogg", "application/ogg"}, _
         {"pbm", "image/x-portable-bitmap"}, _
         {"pct", "image/pict"}, _
         {"pdb", "chemical/x-pdb"}, _
         {"pdf", "application/pdf"}, _
         {"pgm", "image/x-portable-graymap"}, _
         {"pgn", "application/x-chess-pgn"}, _
         {"pic", "image/pict"}, _
         {"pict", "image/pict"}, _
         {"png", "image/png"}, _
         {"pnm", "image/x-portable-anymap"}, _
         {"pnt", "image/x-macpaint"}, _
         {"pntg", "image/x-macpaint"}, _
         {"ppm", "image/x-portable-pixmap"}, _
         {"ppt", "application/vnd.ms-powerpoint"}, _
         {"ps", "application/postscript"}, _
         {"qt", "video/quicktime"}, _
         {"qti", "image/x-quicktime"}, _
         {"qtif", "image/x-quicktime"}, _
         {"ra", "audio/x-pn-realaudio"}, _
         {"ram", "audio/x-pn-realaudio"}, _
         {"ras", "image/x-cmu-raster"}, _
         {"rdf", "application/rdf+xml"}, _
         {"rgb", "image/x-rgb"}, _
         {"rm", "application/vnd.rn-realmedia"}, _
         {"roff", "application/x-troff"}, _
         {"rtf", "text/rtf"}, _
         {"rtx", "text/richtext"}, _
         {"sgm", "text/sgml"}, _
         {"sgml", "text/sgml"}, _
         {"sh", "application/x-sh"}, _
         {"shar", "application/x-shar"}, _
         {"silo", "model/mesh"}, _
         {"sit", "application/x-stuffit"}, _
         {"skd", "application/x-koan"}, _
         {"skm", "application/x-koan"}, _
         {"skp", "application/x-koan"}, _
         {"skt", "application/x-koan"}, _
         {"smi", "application/smil"}, _
         {"smil", "application/smil"}, _
         {"snd", "audio/basic"}, _
         {"so", "application/octet-stream"}, _
         {"spl", "application/x-futuresplash"}, _
         {"src", "application/x-wais-source"}, _
         {"sv4cpio", "application/x-sv4cpio"}, _
         {"sv4crc", "application/x-sv4crc"}, _
         {"svg", "image/svg+xml"}, _
         {"swf", "application/x-shockwave-flash"}, _
         {"t", "application/x-troff"}, _
         {"tar", "application/x-tar"}, _
         {"tcl", "application/x-tcl"}, _
         {"tex", "application/x-tex"}, _
         {"texi", "application/x-texinfo"}, _
         {"texinfo", "application/x-texinfo"}, _
         {"tif", "image/tiff"}, _
         {"tiff", "image/tiff"}, _
         {"tr", "application/x-troff"}, _
         {"tsv", "text/tab-separated-values"}, _
         {"txt", "text/plain"}, _
         {"ustar", "application/x-ustar"}, _
         {"vcd", "application/x-cdlink"}, _
         {"vrml", "model/vrml"}, _
         {"vxml", "application/voicexml+xml"}, _
         {"wav", "audio/x-wav"}, _
         {"wbmp", "image/vnd.wap.wbmp"}, _
         {"wbmxl", "application/vnd.wap.wbxml"}, _
         {"wml", "text/vnd.wap.wml"}, _
         {"wmlc", "application/vnd.wap.wmlc"}, _
         {"wmls", "text/vnd.wap.wmlscript"}, _
         {"wmlsc", "application/vnd.wap.wmlscriptc"}, _
         {"wrl", "model/vrml"}, _
         {"xbm", "image/x-xbitmap"}, _
         {"xht", "application/xhtml+xml"}, _
         {"xhtml", "application/xhtml+xml"}, _
         {"xls", "application/vnd.ms-excel"}, _
         {"xml", "application/xml"}, _
         {"xpm", "image/x-xpixmap"}, _
         {"xsl", "application/xml"}, _
         {"xslt", "application/xslt+xml"}, _
         {"xul", "application/vnd.mozilla.xul+xml"}, _
         {"xwd", "image/x-xwindowdump"}, _
         {"xyz", "chemical/x-xyz"}, _
         {"zip", "application/zip"} _
        }
End Class

Public Module RC4
    Private _ConfigStrings As StringResList
    Private _ConfigStringsLastUpdate As Date

    Public Property ConfigStrings As StringResList
        Get
            'If _ConfigStrings is empty, load it and set the time it was last loaded.
            If _ConfigStrings Is Nothing Then
                _ConfigStrings = New StringResList
                _ConfigStringsLastUpdate = Now
            Else
                'if it's not empty, check how long it's been since its last update.
                If DateDiff(DateInterval.Hour, _ConfigStringsLastUpdate, Now) > 1 Then 'if it is over an hour old, reload it.
                    _ConfigStrings = New StringResList
                    _ConfigStringsLastUpdate = Now
                End If
            End If
            Return _ConfigStrings
        End Get

        'When it is manually set (for example when any string is added or edited in the admin:
        '   1) Set the private variable to the value provided
        '   2) Set the time it was last updated!
        Set(value As StringResList)
            _ConfigStrings = value
            _ConfigStringsLastUpdate = Now
        End Set
    End Property
    
    Public Function GetResourceFor(name As String, Optional defaultValue As String = Nothing)
    	Dim dt As DataTable = RC4.Pull("SELECT * FROM RCString WHERE Name = '" & name & "'")
        If dt.Rows.Count > 0 Then
            Return dt.Rows(0)("Value")
        End If
        Return defaultValue
    End Function

    Public Function getCon(Optional ByVal Name As String = "rcon") As SqlConnection
        Return New SqlConnection(ConfigurationManager.ConnectionStrings(Name).ConnectionString)
    End Function

    Public Function GetRandomTestimonial() As DataRow
        Dim dt As DataTable = RC4.Pull("Select * from RCTestimonials where isApproved = 1")
        If dt.Rows.Count > 0 Then
            Dim r As New Random
            Dim idx As Integer = r.Next(0, dt.Rows.Count)
            Return dt.Rows(idx)
        End If
        Return Nothing
    End Function

    Public Function Pull(ByVal Query As String) As DataTable
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim ad As New SqlDataAdapter(Query, con)
        Dim dt As New DataTable
        con.Open()
        ad.Fill(dt)
        con.Close()
        Return dt
    End Function

    Public Sub SQLExec(ByVal Command As String)
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As New SqlCommand(Command, con)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
    End Sub

    Public Function GetContent(ByVal name As String) As String
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim ad As SqlDataAdapter
        Dim nameAsInt As Integer
        If Integer.TryParse(name, nameAsInt) Then
        	ad = New SqlDataAdapter("Select Value from RCContent where [Id]=@Id", con)
        	ad.SelectCommand.Parameters.AddWithValue("Id", nameAsInt)
        Else
			ad = New SqlDataAdapter("Select Value from RCContent where [Name]=@Name", con)
			ad.SelectCommand.Parameters.AddWithValue("Name", name)
        End If
        Dim dt As New DataTable
        con.Open()
        ad.Fill(dt)
        con.Close()
        If dt.Rows.Count > 0 Then
            Return dt.Rows(0).Item("Value")
        End If
        Return ""
    End Function

    Public Function GetGallery(ByVal Id As Integer) As String
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim ad As New SqlDataAdapter("Select * from RCGallery where CatId=@CatId", con)
        ad.SelectCommand.Parameters.AddWithValue("CatId", Id)
        Dim dt As New DataTable
        con.Open()
        ad.Fill(dt)
        con.Close()
        Dim sb As New StringBuilder
        sb.Append("<ul id=""gallery""/>")
        For x As Integer = 0 To dt.Rows.Count - 1
            With dt.Rows.Item(x)
                sb.Append("<li><img src=""" & .Item("FSLoc") & """ /></li>")
            End With
        Next
        sb.Append("</ul>")
        Return sb.ToString
    End Function

    Public Function GetGallery() As String
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim ad As New SqlDataAdapter("Select * from GalleryItem where CatName=(select top 1 CatName from GalleryItem) order by Seq asc", con)
        Dim dt As New DataTable
        con.Open()
        ad.Fill(dt)
        con.Close()
        Dim sb As New StringBuilder
        sb.Append("<ul id=""gallery""/>")
        For x As Integer = 0 To dt.Rows.Count - 1
            With dt.Rows.Item(x)
                sb.Append("<li><span class=""panel-overlay"">" & .Item("ImgName") & "</span><img src=""" & .Item("FSLoc") & """ /></li>")
            End With
        Next
        sb.Append("</ul>")
        Return sb.ToString
    End Function

    Public Sub SiteHealthCheck()
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim sr As New IO.StreamReader(HttpContext.Current.Server.MapPath("/admin/DBCreate.sql"))
        Dim sql As String = sr.ReadToEnd
        sr.Close()
        Dim cmd As New SqlCommand(sql, con)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()

        If Not IO.Directory.Exists(HttpContext.Current.Server.MapPath("/images/")) Then
            My.Computer.FileSystem.CreateDirectory(HttpContext.Current.Server.MapPath("/images/"))
        End If
        If Not IO.Directory.Exists(HttpContext.Current.Server.MapPath("/images/docs/")) Then
            My.Computer.FileSystem.CreateDirectory(HttpContext.Current.Server.MapPath("/images/docs/"))
        End If
        If Not IO.Directory.Exists(HttpContext.Current.Server.MapPath("/images/gallery/")) Then
            My.Computer.FileSystem.CreateDirectory(HttpContext.Current.Server.MapPath("/images/gallery/"))
        End If
        If Not IO.Directory.Exists(HttpContext.Current.Server.MapPath("/images/gallery/")) Then
            My.Computer.FileSystem.CreateDirectory(HttpContext.Current.Server.MapPath("/images/bios/"))
        End If
    End Sub

    Public Function ResizeImage(m As IO.MemoryStream, ImgType As String, Optional ByVal w As Integer = 0, Optional ByVal h As Integer = 0) As IO.MemoryStream
        Dim img As System.Drawing.Image = System.Drawing.Image.FromStream(m)
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

    'Public Function GetGallery(ByVal Category As String) As String 
    '    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
    '    Dim ad As New SqlDataAdapter("Select * from GalleryItem where CatName=@CatName order by Seq asc", con)
    '    ad.SelectCommand.Parameters.AddWithValue("CatName", Category)
    '    Dim dt As New DataTable
    '    con.Open()
    '    ad.Fill(dt)
    '    con.Close()
    '    Dim sb As New StringBuilder
    '    sb.Append("<ul class=""gallery""/>")
    '    For x As Integer = 0 To dt.Rows.Count - 1
    '        With dt.Rows.Item(x)
    '            sb.Append("<li><span class=""panel-overlay"">" & .Item("ImgName") & "</span><img src=""" & .Item("FSLoc") & """ /></li>")
    '        End With
    '    Next
    '    sb.Append("</ul>")
    '    Return sb.ToString
    'End Function

    Public Function GetImageStrip(ByVal Category As String) As String
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim ad As New SqlDataAdapter("Select * from GalleryItem where CatName=@CatName order by Seq asc", con)
        ad.SelectCommand.Parameters.AddWithValue("CatName", Category)
        Dim dt As New DataTable
        con.Open()
        ad.Fill(dt)
        con.Close()
        Dim sb As New StringBuilder
        sb.Append("<ul class=""gallery""/>")
        For x As Integer = 0 To dt.Rows.Count - 1
            With dt.Rows.Item(x)
                Dim ThumbLoc As String = .Item("FSLoc")
                ThumbLoc = ThumbLoc.Replace("/images/gallery/", "/images/gallery/thumb-")
                sb.Append("<li><a class=""lightbox"" href=""" & .Item("FSLoc") & """><img src=""" & ThumbLoc & """ alt=""" & .Item("ImgName") & """ /></a></li>")
            End With
        Next
        sb.Append("</ul>")
        Return sb.ToString
    End Function

    Public Class RCCUser
        Public Id As Integer
        Public access As Integer
        Public firstName As String
        Public lastName As String
        Public email As String
    End Class

    Public Function GetUserLoggedIn(ByVal dt As DataTable) As RCCUser
        If dt Is Nothing Then Return Nothing
        Dim u As New RCCUser
        With dt.Rows(0)
            u.Id = .Item("Id")
            u.access = .Item("access")
            u.firstName = .Item("firstName")
            u.lastName = .Item("lastName")
            u.email = .Item("email")
        End With
        Return u
    End Function


    Public Class StringRes
        Private _Id As Integer
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        Private _CatId As Integer
        Public Property CatId() As Integer
            Get
                Return _CatId
            End Get
            Set(ByVal value As Integer)
                _CatId = value
            End Set
        End Property

        Private _Name As String
        Public Property Name() As String
            Get
                Return _Name
            End Get
            Set(ByVal value As String)
                _Name = value
            End Set
        End Property

        Private _Value As String
        Public Property Value() As String
            Get
                Return _Value
            End Get
            Set(ByVal value As String)
                _Value = value
            End Set
        End Property

        Private _CatName As String
        Public Property CatName() As String
            Get
                Return _CatName
            End Get
            Set(ByVal value As String)
                _CatName = value
            End Set
        End Property

        Public Sub New(ByRef dr As DataRow)
            _Id = dr.Item("Id")
            _Name = dr.Item("Name")
            _Value = dr.Item("Value")
            _CatId = dr.Item("CatId")
            _CatName = dr.Item("CatName")
        End Sub
    End Class

    Public Class StringResList
        Inherits CollectionBase

        Public Sub New()
            Dim dt As DataTable = RC4.Pull("Select t1.*, t2.Name as CatName from RCString t1 join RCStringCat t2 on t1.CatId=t2.Id order by t1.CatId asc, t1.Name asc")
            For Each dr As DataRow In dt.Rows
                Dim sr As New StringRes(dr)
                Me.Add(sr)
            Next
        End Sub

        Public Function GetByName(Name As String) As StringRes
            For Each sr As StringRes In Me
                If LCase(Name) = LCase(sr.Name) Then
                    Return sr
                End If
            Next
            Return Nothing
        End Function
        Public Function GetValByName(Name As String) As String
            For Each sr As StringRes In Me
                If LCase(Name) = LCase(sr.Name) Then
                    Return sr.Value
                End If
            Next
            Return ""
        End Function

        Default Public Property Item(index As Integer) As StringRes
            Get
                Return CType(List(index), StringRes)
            End Get
            Set(value As StringRes)
                List(index) = value
            End Set
        End Property

        Public Sub Remove(Item As StringRes)
            List.Remove(Item)
        End Sub

        Public Sub Insert(index As Integer, value As StringRes)
            List.Insert(index, value)
        End Sub

        Public Function Add(Item As StringRes) As Integer
            Return List.Add(Item)
        End Function

        Public Function IndexOf(Item As StringRes) As Integer
            Return List.IndexOf(Item)
        End Function
    End Class






End Module

Public Class RCC

End Class