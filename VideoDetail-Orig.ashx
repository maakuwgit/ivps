<%@ WebHandler Language="VB" Class="VideoDetail" %>

Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient

Public Class VideoDetail : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/html"
        'Dim dt As DataTable = RC4.Pull("Select * from RCVideo where CatId=" & CInt(ctx.Request("catId")) & " Order by Id desc")
        Dim dt As DataTable
        If ctx.Request("catId") Is Nothing Then
            dt = RC4.Pull("Select * from VideoItem Order by Id desc")
        ElseIf Not ctx.Request("id") Is Nothing Then
            dt = RC4.Pull("Select * from VideoItem where Id=" & CInt(ctx.Request("id")))
        End If
        
        Dim sb As New StringBuilder
        For x As Integer = 0 To dt.Rows.Count - 1
            With dt.Rows(x)
                sb.AppendLine("<div class=""detailEntry videoEntry col-md-6 col-sm-6 col-xs-12"">")
                sb.AppendLine("<div class=""padboth"">")
                'If x = 0 Then
                '    Dim dtCat As DataTable = RC4.Pull("Select CatName from RCVideoCat where Id=" & CInt(.Item("catId")))
                '    If dtCat.Rows.Count > 0 Then
                '        sb.AppendLine("<h3>" & dtCat.Rows(0).Item("CatName") & "</h3>")
                '    End If
                'End If
                'sb.AppendLine("<br />")
                'sb.AppendLine("<h2>" & .Item("VidName") & "</h2>")
                
                'sb.AppendLine("<label>Category:</label>")
                'sb.AppendLine("<p>" & .Item("CatName") & "</p>")
                
                'If Not IsDBNull(.Item("VidDesc")) AndAlso Not String.IsNullOrEmpty(.Item("VidDesc")) Then
                '  sb.AppendLine("<div class=""vidDesc"">")
                '  sb.AppendLine("<p>" & .Item("VidDesc") & "</p>")
                 '  sb.AppendLine("</div>")
                'End If
                
                If Not IsDBNull(.Item("Code")) Then
                    sb.AppendLine("<label></label>")
                    
                    Dim Vid As String = .Item("Code")
                    Dim NewURL As String = Vid
                    If Vid.Contains("?") And LCase(Vid).Contains("youtube.com") Then
                        Vid = Vid.Replace("watch", "embed")
                        NewURL = Vid.Split("?").First
                        Dim Q As String = Vid.Split("?").Last
                        Dim Params() As String = Q.Split("&")
                        For i As Integer = 0 To Params.Count - 1
                            If Params(i).Contains("=") Then
                                Dim key As String = Params(i).Split("=").First
                                Dim val As String = Params(i).Split("=").Last
                                If LCase(key) = "v" Then
                                    NewURL &= "/" & val
                                End If
                                'NewURL &= str & "/"
                            End If
                        Next
<<<<<<< .mine
                        sb.AppendLine("<div class=""""><iframe width=""100%"" scrolling=""no"" frameborder=""0"" src=""" & NewURL + "?rel=0" & """></iframe></div>")
||||||| .r6183
                        sb.AppendLine("<div class=""""><iframe width=""100%"" scrolling=""no"" height=""400"" frameborder=""0"" src=""" & NewURL & """></iframe></div>")
=======
                        sb.AppendLine("<div class=""""><iframe width=""100%"" scrolling=""no"" frameborder=""0"" src=""" & NewURL & """></iframe></div>")
>>>>>>> .r7259
                    ElseIf LCase(Vid).Contains("vimeo.com") Then
                        Vid = Vid.Replace("vimeo.com/", "player.vimeo.com/video/")
                        sb.AppendLine("<p><iframe width=""100%"" scrolling=""no"" height=""400"" frameborder=""0"" src=""" & Vid & """></iframe></p>")
                    End If
				Else
					sb.AppendLine("<p>This did not work</p>")
                End If
                sb.AppendLine("</div>")
                sb.AppendLine("</div>")
            End With
        Next
        If sb.Length = 0 Then
            ctx.Response.Write("<div class=""detailEntry g6 videoEntry""></div>")
        Else
            ctx.Response.Write(sb)
        End If
        
    End Sub
   
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class