<%@ WebHandler Language="VB" Class="GetThumb" %>

Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Drawing.Drawing2D

Public Class GetThumb : Implements IHttpHandler
    
    Dim ctx2 As HttpContext
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx2 = ctx
        ctx.Response.Cache.SetExpires(Today.Date.AddMonths(12))
        ctx.Response.Cache.SetMaxAge(New TimeSpan(24, 0, 0)) '24 hours
        ctx.Response.Cache.SetCacheability(HttpCacheability.Public)
        If Not ctx.Request("Id") Is Nothing Then
            Dim Id As Integer
            If IsNumeric(ctx.Request("Id")) Then
                Id = ctx.Request("Id")
                Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("rcon").ConnectionString)
                Dim ad As New SqlDataAdapter("Select Data, ContentType, DateModified from RCGallery2Image where Id=@Id", con)
                Dim dt As New DataTable
                ad.SelectCommand.Parameters.AddWithValue("Id", Id)
                con.Open()
                ad.Fill(dt)
                con.Close()
                If dt.Rows.Count > 0 Then
                    If IsDBNull(dt.Rows(0).Item("DateModified")) Then
                        ctx.Response.AddHeader("Last-Modified", Now.ToLongDateString())
                    Else
                        ctx.Response.AddHeader("Last-Modified", CDate(dt.Rows(0).Item("DateModified")).ToLongDateString)
                    End If
                    ctx.Response.ContentType = dt.Rows(0).Item("ContentType")
                    If Not ctx.Request("w") Is Nothing Then
                        Dim w As Integer = CInt(ctx.Request("w"))
                        Dim ms As New IO.MemoryStream(dt.Rows(0).Item("Data"), False)
                        Dim ms2 As IO.MemoryStream = ResizeImage(ms, dt.Rows(0).Item("ContentType"), w)
                        ctx.Response.BinaryWrite(ms2.ToArray)
                    ElseIf Not ctx.Request("h") Is Nothing Then
                        Dim h As Integer = CInt(ctx.Request("h"))
                        Dim ms As New IO.MemoryStream(dt.Rows(0).Item("Data"), False)
                        Dim ms2 As IO.MemoryStream = ResizeImage(ms, dt.Rows(0).Item("ContentType"), , h)
                        ctx.Response.BinaryWrite(ms2.ToArray)
                    ElseIf Not ctx.Request("s") Is Nothing Then
                        Dim s As String = ctx.Request("s")
                        Dim w As Integer
                        Dim ms As New IO.MemoryStream(dt.Rows(0).Item("Data"), False)
                        Select Case LCase(s)
                            Case "large"
                                w = ConfigStrings.GetValByName("Large")
                            Case "medium"
                                w = ConfigStrings.GetValByName("Medium")
                            Case "small"
                                w = ConfigStrings.GetValByName("Small")
                            Case "thumb"
                                w = ConfigStrings.GetValByName("Thumb")
                            Case Else
                                w = 128
                        End Select
                        Dim ms2 As IO.MemoryStream = ResizeImage(ms, dt.Rows(0).Item("ContentType"), w)
                        ctx.Response.BinaryWrite(ms2.ToArray)
                    Else
                        ctx.Response.BinaryWrite(dt.Rows(0).Item("Data"))
                        ctx.Response.End()
                    End If
                Else
                    ctx.Response.StatusCode = 404
                End If
            Else
                ctx.Response.StatusCode = 404
            End If
        End If
    End Sub
 
    Protected Function ResizeImage(m As IO.MemoryStream, ImgType As String, Optional ByVal w As Integer = 0, Optional ByVal h As Integer = 0) As IO.MemoryStream
        Dim img As System.Drawing.Image = System.Drawing.Image.FromStream(m)
        If w > 0 Then
            Dim recDest As New Rectangle(0, 0, w, w * img.Height / img.Width)
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
    
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return True
        End Get
    End Property
End Class