Imports System.Data
Imports System.Data.SqlClient

Partial Class Gallery
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
    
    	Dim variables as string = HttpUtility.UrlDecode(Request.QueryString.toString())
		Dim parts() As String = variables.Split("/")
		Dim galleryId As String
		If parts.Count() > 1 Then
			galleryId = parts(1)
			'Response.Write(galleryId)
		End If
		
        Dim dtName As DataTable = RC4.Pull("Select Name, (Select top 1 Name from RCGallery2Cat where RCGallery2Cat.Id=RCGallery2.CatId) as CatName from RCGallery2 where Id=" & CInt(galleryId))
        If dtName.Rows.Count > 0 Then
            If Not IsDBNull(dtName.Rows(0).Item("CatName")) Then
                lblName.Text = dtName.Rows(0).Item("CatName") & " - "
            End If
            If Not IsDBNull(dtName.Rows(0).Item("Name")) Then
                lblName.Text &= dtName.Rows(0).Item("Name")
            End If
        End If
        Dim dt As DataTable = RC4.Pull("Select Id, Name, Description from RCGallery2Image where Seq >= -(select cast(coalesce(flagShowThumb, 0) as integer) from RCGallery2 where Id=RCGallery2Image.GalleryId) and GalleryId=" & CInt(galleryId) & " Order by Seq Asc")
        For Each dr As DataRow In dt.Rows
            gallery.InnerHtml &= "    <div class=""col-md-2"">"
            gallery.InnerHtml &= "        <a class="""" data-fancybox=""group"" data-type=""image"" data-caption=""" & dr.Item("Description") & """ href=""/GetThumb.ashx?h=800&Id=" & dr.Item("Id") & """ title=""" & dr.Item("Description") & """><img class=""img-fluid"" title=""" & dr.Item("Description") & """ alt=""" & dr.Item("Name") & """ src=""/GetThumb.ashx?h=480&Id=" & dr.Item("Id") & """></a>"
            gallery.InnerHtml &= "        <div>"
            gallery.InnerHtml &= "            <div class=""mb-5"">"
            gallery.InnerHtml &= "                <p>" & dr.Item("Description") & "</p>"
            gallery.InnerHtml &= "            </div> "
            gallery.InnerHtml &= "        </div>"
            gallery.InnerHtml &= "    </div>"
        Next
    End Sub
End Class
