<%@ WebHandler Language="VB" Class="VideoDetail" %>

Imports System
Imports System.Web
Imports System.Data
Imports System.Data.SqlClient

Public Class VideoDetail : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal ctx As HttpContext) Implements IHttpHandler.ProcessRequest
        ctx.Response.ContentType = "text/html"
        Dim dtc As DataTable
		Dim dt As DataTable
        dtc = RC4.Pull("Select * from RCVideoCat Order by Id desc")

        
        
        Dim sb As New StringBuilder
        'For x As Integer = 0 To dtc.Rows.Count - 1
		For Each drc As DataRow in dtc.Rows	
			dt = RC4.Pull("Select * from VideoItem Order by Id desc")
            'With dt.Rows(x)
			For Each dr As DataRow in dt.Rows
                'If Not x=0 then sb.AppendLine("<div class=""redline""></div>")
				sb.AppendLine("<div class=""redline""></div>")
                sb.AppendLine("<div class=""detailEntry videoEntry col-lg-3 col-md-4 col-sm-6 col-xs-12"">")
                If Not IsDBNull(dr("Code")) Then
                    'sb.AppendLine("<label>Watch:</label>")
                    
                    Dim Vid As String = dr("Code")
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
                        sb.AppendLine("<iframe id=""vid"" width=""100%"" height=""auto"" scrolling=""no"" frameborder=""0"" src=""" & NewURL + "?rel=0" & """></iframe>")
=======
                        sb.AppendLine("<div class=""""><iframe width=""100%"" scrolling=""no"" frameborder=""0"" src=""" & NewURL & """></iframe></div>")
>>>>>>> .r7087
                    ElseIf LCase(Vid).Contains("vimeo.com") Then
                        Vid = Vid.Replace("vimeo.com/", "player.vimeo.com/video/")
                        sb.AppendLine("<iframe id=""vid"" width=""100%"" height=""auto"" scrolling=""no"" frameborder=""0"" src=""" & Vid + "?title=0&byline=0&portrait=0" & """></iframe>")
                    End If
                End If
                sb.AppendLine("<div class=""video-info"">")
                sb.AppendLine("<h4>" & dr("VidName") & "</h4>")
                'sb.AppendLine("<span class=""category-video"">Category: " & dr("CatName") & "</span>")
                If Not IsDBNull(dr("VidDesc")) AndAlso Not String.IsNullOrEmpty(dr("VidDesc")) Then
                    sb.AppendLine("<div class=""vidDesc"">")
                    'sb.AppendLine("<label>Description:</label>")
                    sb.AppendLine("<p>" & dr("VidDesc") & "</p>")
                    sb.AppendLine("</div>")
                End If
                sb.AppendLine("</div>")
                sb.AppendLine("</div>")
            'End With
			Next
        Next
        If sb.Length = 0 Then
            ctx.Response.Write("<div class=""detailEntry videoEntry col-lg-3 col-md-4 col-sm-6 col-xs-12""></div>")
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