Imports System.Data
Imports System.Data.SqlClient

Partial Class GalleryList
    Inherits System.Web.UI.Page

    Protected Sub GalleryLines_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
    
        Dim dtCat As DataTable = RC4.Pull("Select * from RCGallery2Cat order by Seq Asc")
        For Each drCat As DataRow In dtCat.Rows
            galleryLines.InnerHtml &= "<li><a class=""btn btn-default"" href=""" & WebSite.Link("Gallery Category").GetUrl().Replace("*", drCat.Item("Id")) & """ data-filter="".gallery" & drCat.Item("id") & """>" & drCat.Item("Name") & "</a></li>"
        Next

    End Sub
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
    
    
    	Dim variables as string = HttpUtility.UrlDecode(Request.QueryString.toString())
		Dim parts() As String = variables.Split("/")
		Dim categoryId As String = ""
		If parts.Count() > 2 Then
			categoryId = parts(2)
			'Response.Write(categoryId)
		End If
		
		Dim dtCat As DataTable
		If categoryId.ToString().length() > 0 Then
			dtCat = RC4.Pull("Select * from RCGallery2Cat Where id = " & categoryId & " order by Seq Asc")
		Else
        	dtCat = RC4.Pull("Select * from RCGallery2Cat order by Seq Asc")
        End If
        
        For Each drCat As DataRow In dtCat.Rows

            'galleriesHeading.InnerHtml &= "<h1 class=""title"">" & drCat.Item("Name") & "</h1>"
            Dim dt As DataTable = RC4.Pull("Select Id, Name, (Select top 1 Id from RCGallery2Image t2 where t2.GalleryId=t1.Id order by seq asc) as ImageId, (Select top 1 Alt from RCGallery2Image t3 where t3.GalleryId=t1.Id order by seq asc) as ImageAlt, (Select Count(*) from RCGallery2Image t2 where t2.GalleryId=t1.Id) as Count from RCGallery2 t1 where t1.id in (select distinct galleryid from RCGallery2Image) and CatId=" & drCat.Item("Id") & " order by Seq asc")
            For Each dr As DataRow In dt.Rows
                Dim alt As String = ""
                If Not IsDBNull(dr("ImageAlt")) Then
                    alt = dr("ImageAlt")
                End If
                galleries.InnerHtml &= "<div class=""col-lg-6 d-flex align-items-center flex-column"">"
                galleries.InnerHtml &= "        <a href=""" & WebSite.Link("Gallery Images").GetUrl().Replace("*", dr("Id")) & """><img class=""img-fluid mb-3"" src=""/GetThumb.ashx?h=200&id=" & dr.Item("ImageId") & """ alt=""""></a>"
                galleries.InnerHtml &= "            <div class=""mt-auto mb-3 align-self-center"">"
                galleries.InnerHtml &= "                <h4><a href=""" & WebSite.Link("Gallery Images").GetUrl().Replace("*", dr("Id")) & """>" & dr("Name") & " <span class=""badge""></a></h4>"
                galleries.InnerHtml &= "    </div>"
                galleries.InnerHtml &= "</div>"

            Next
        Next
    End Sub
End Class
