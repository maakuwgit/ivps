Imports System.Data
Imports System.Data.SqlClient

Partial Class Current
    Inherits System.Web.UI.Page

    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dt As DataTable = RC4.Pull("Select * from RCNews where PubDate <= '" & Today.Date.ToShortDateString & "' order by PubDate desc")
        Dim sb As New StringBuilder
        For Each dr As DataRow In dt.Rows
            Dim pubDate As Date = dr("PubDate")
            Dim Title As String = dr("Title")
            Dim Description As String = dr("Description")
            sb.Append(" <div class=""blog-item"">")
            sb.Append("         <div class=""row"">")
            sb.Append("             <div class=""col-xs-12 col-sm-2 text-center"">")
            sb.Append("                 <div class=""entry-meta"">")
            sb.Append("                     <span id=""publish_date""><span class=""day"">" & pubDate.ToString("dd") & "</span><span class=""month"">" & pubDate.ToString("MMM") & "</span></span>")
            sb.Append("                     <span><div class=""addthis_sharing_toolbox""><i class=""pull-left fa fa-heart""></i></div></span>")
            sb.Append("                 </div>")
            sb.Append("             </div>")
            sb.Append("             <div class=""col-xs-12 col-sm-10 blog-content"">")
            sb.Append("                 <a href=""/news.aspx?Id=" & dr("Id") & """><img class=""img-responsive img-blog"" src=""/NewsImg.ashx?Id=" & dr("Id") & """ width=""100%"" alt="""" /></a>")
            sb.Append("                 <h2><a href=""/news.aspx?Id=" & dr("Id") & """>" & Title & "</a></h2>")
            sb.Append("                 <h3>" & Description & "</h3>")
            sb.Append("                 <a class=""btn btn-primary readmore"" href=""/news.aspx?Id=" & dr("Id") & """>Read More <i class=""fa fa-angle-right""></i></a>")
            sb.Append("             </div>")
            sb.Append("         </div>")
            sb.Append(" </div>")

        Next
        news.InnerHtml = sb.ToString
    End Sub

    Protected Sub Recent_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dt As DataTable = RC4.Pull("Select top 3 * from RCNews where PubDate <= '" & Today.Date.ToShortDateString & "' order by PubDate desc")
        Dim sb As New StringBuilder
        For Each dr As DataRow In dt.Rows
            Dim pubDate As Date = dr("PubDate")
            Dim Title As String = dr("Title")
            sb.Append("                 <li><span class=""recent_date"">" & pubDate.ToString("MMM") & " " & pubDate.ToString("dd") & "</span><br/><a href=""/news.aspx?Id=" & dr("Id") & """><i class=""fa fa-angle-right""></i> " & Title & " </a></li>")
        Next
        RecentNews.InnerHtml = sb.ToString
    End Sub

    Protected Sub gallery_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

        Dim dtCat As DataTable = RC4.Pull("Select * from RCGallery2Cat order by Seq Asc")
        For Each drCat As DataRow In dtCat.Rows

            'galleriesHeading.InnerHtml &= "<h1 class=""title"">" & drCat.Item("Name") & "</h1>"
            Dim dt As DataTable = RC4.Pull("Select Id, Name, (Select top 1 Id from RCGallery2Image t2 where t2.GalleryId=t1.Id order by seq asc) as ImageId, (Select top 1 Alt from RCGallery2Image t3 where t3.GalleryId=t1.Id order by seq asc) as ImageAlt, (Select Count(*) from RCGallery2Image t2 where t2.GalleryId=t1.Id) as Count from RCGallery2 t1 where t1.id in (select distinct galleryid from RCGallery2Image) and CatId=" & drCat.Item("Id") & " order by Seq asc")
            For Each dr As DataRow In dt.Rows
                Dim alt As String = ""
                If Not IsDBNull(dr("ImageAlt")) Then
                    alt = dr("ImageAlt")
                End If
                topGalleryImages.Text &= "<li><a href=""/Gallery.aspx?Id=" & dr.Item("Id") & """><img src=""/GetThumb.ashx?h=107&id=" & dr.Item("ImageId") & """ alt=""" & Alt & """></a></li>"
            Next
        Next
    End Sub
End Class
