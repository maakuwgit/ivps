Imports System.Data

Partial Class Category
    Inherits System.Web.UI.Page

    Dim cId As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load


        Dim dt As DataTable = RC4.Pull("Select * from RCProductLine order by Id")

        For Each dr As DataRow In dt.Rows
            If Request("Line") Is Nothing Then
                Response.Redirect("/Products.aspx?Line=" & dr("Id"))
            End If
            If Request("Line") = dr("Id") Then
                LineTitle.InnerHtml = dr("Name")
                LineContainerClass.Text = "<div class=""products-line" & dr("Id") & """>"
                LineDescription.InnerHtml = dr("Description").ToString()
            End If
        Next

    End Sub


    Protected Sub Page2_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        Dim dt As DataTable = RC4.Pull("Select * from RCProductLine")
        For Each dr As DataRow In dt.Rows
            If Request("Line") Is Nothing Then
                Response.Redirect("/BackupCategory.aspx?Line=" & dr("Id"))
            Else
                If Request("Line") = dr("Id") Then
                    productLines.InnerHtml &= "<li class=""active""><a data-toggle=""tab"" href=""#tab" & dr("Id") & """ aria-expanded=""true"">" & dr("Name") & "</a></li>"
                    productLineContent.InnerHtml &= GetContent(dr("Name") & " Content")
                    productLineImages.InnerHtml &= GetContent(dr("Name") & " Images")

                    Dim dtCat As DataTable = RC4.Pull("Select * from RCProductCat WHERE LineId=" & CInt(dr("Id")) & " AND Exists (Select Distinct ImgURL from RCProduct where RCProductCat.Id = RCProduct.CatId and ImgURL like '%') order by seq asc") 'Order by Descending only because they are being appended to the beginning
                    Cats.InnerHtml &= "<div id=""tab" & dr("Id") & """ class=""tab-pane active"">"
                    Cats.InnerHtml &= "<div class=""product-grid-holder"">"

                    For Each drC As DataRow In dtCat.Rows
                        Cats.InnerHtml &= "    <div class=""col-md-12  no-margin product-item-holder backupcategories"">"
                        Cats.InnerHtml &= "        <div class=""product-item"">"
                        Cats.InnerHtml &= "            <div class=""body"">"
                        Cats.InnerHtml &= "               <div class=""add-cart-button pull-right"">"
                        Cats.InnerHtml &= "                    <a class=""btn btn-primary"" href=""/Category.aspx?Id=" & drC("Id") & """>Quote</a>"
                        Cats.InnerHtml &= "                </div>"
                        Cats.InnerHtml &= "                <div class=""label-discount green"">" & dr("Name") & "</div>"
                        Cats.InnerHtml &= "                <h3 class=""title"">"
                        Cats.InnerHtml &= "                    <a href=""/Category.aspx?Id=" & drC("Id") & """>" & drC("Name") & "</a>"
                        Cats.InnerHtml &= "                </h3>"

                        Cats.InnerHtml &= "            </div>"
                        Cats.InnerHtml &= "            <div class=""prices"">"
                        Cats.InnerHtml &= "                <div class=""price-prev"">Would you like to speak with a Plan IV team member about " & drC("Name") & "? Please call 1 248-689-4910</div>"
                        Cats.InnerHtml &= "                <a class=""price-current pull-right"" href=""/contact.aspx"" >Speak With an Expert</a>"
                        Cats.InnerHtml &= "            </div>"
                        Cats.InnerHtml &= "            <div class=""hover-area"">"

                        Cats.InnerHtml &= "            </div>"
                        Cats.InnerHtml &= "        </div>"
                        Cats.InnerHtml &= "    </div>"
                    Next
                    Dim dtCat2 As DataTable = RC4.Pull("Select * from RCProductCat WHERE LineId=" & CInt(dr("Id")) & " AND Not Exists (Select Distinct ImgURL from RCProduct where RCProductCat.Id = RCProduct.CatId and ImgURL like '%') order by seq asc") 'Order by Descending only because they are being appended to the beginning
                    For Each drC2 As DataRow In dtCat2.Rows
                        Cats.InnerHtml &= "    <div class=""col-md-12  no-margin product-item-holder backupcategories"">"
                        Cats.InnerHtml &= "        <div class=""product-item"">"
                        Cats.InnerHtml &= "            <div class=""body"">"
                        Cats.InnerHtml &= "               <div class=""add-cart-button pull-right"">"
                        Cats.InnerHtml &= "                    <a class=""btn btn-primary"" href=""/Category.aspx?Id=" & drC2("Id") & """>More Information</a>"
                        Cats.InnerHtml &= "                </div>"
                        Cats.InnerHtml &= "                <div class=""label-discount green"">" & dr("Name") & "</div>"
                        Cats.InnerHtml &= "                <h3 class=""title"">"
                        Cats.InnerHtml &= "                    <a href=""/Category.aspx?Id=" & drC2("Id") & """>" & drC2("Name") & "</a>"
                        Cats.InnerHtml &= "                </h3>"

                        Cats.InnerHtml &= "            </div>"
                        Cats.InnerHtml &= "            <div class=""prices"">"
                        Cats.InnerHtml &= "                <div class=""price-prev"">Would you like to speak with a Plan IV team member about " & drC2("Name") & "? Please call 1 248-689-4910</div>"
                        Cats.InnerHtml &= "                <a class=""price-current pull-right"" href=""/contact.aspx"" >Speak With an Expert</a>"
                        Cats.InnerHtml &= "            </div>"
                        Cats.InnerHtml &= "            <div class=""hover-area"">"

                        Cats.InnerHtml &= "            </div>"
                        Cats.InnerHtml &= "        </div>"
                        Cats.InnerHtml &= "    </div>"
                    Next
                    Cats.InnerHtml &= "</div>"
                    Cats.InnerHtml &= "</div>"
                Else
                    'productLines.InnerHtml &= "<li class=""""><a data-toggle=""tab"" href=""#tab" & dr("Id") & """ aria-expanded=""true"">" & dr("Name") & "</a></li>"
                    'Dim dtCatNext As DataTable = RC4.Pull("Select Distinct Id, Label, Name, Content from RCProductCat where LineId=" & CInt(dr("Id")) & " order by Name asc")
                    'Cats.InnerHtml &= "<div id=""tab" & dr("Id") & """ class=""tab-pane"">"
                    'Cats.InnerHtml &= "<div class=""product-grid-holder"">"
                    'For Each drD As DataRow In dtCatNext.Rows
                    '    Cats.InnerHtml &= "    <div class=""col-md-12  no-margin product-item-holder backupcategories"">"
                    '    Cats.InnerHtml &= "        <div class=""product-item"">"
                    '    Cats.InnerHtml &= "            <div class=""body"">"
                    '    Cats.InnerHtml &= "               <div class=""add-cart-button pull-right"">"
                    '    Cats.InnerHtml &= "                    <a class=""btn btn-primary"" href=""/Category.aspx?Id=" & drD("Id") & """>View Available Plans</a>"
                    '    Cats.InnerHtml &= "                </div>"
                    '    Cats.InnerHtml &= "                <div class=""label-discount green"">" & dr("Name") & "</div>"
                    '    Cats.InnerHtml &= "                <h3 class=""title"">"
                    '    Cats.InnerHtml &= "                    <a href=""/Category.aspx?Id=" & drD("Id") & """>" & drD("Name") & "</a>"
                    '    Cats.InnerHtml &= "                </h3>"
                    '    Cats.InnerHtml &= "            </div>"
                    '    Cats.InnerHtml &= "            <div class=""prices"">"
                    '    Cats.InnerHtml &= "                <div class=""price-prev"">Would you like to speak with a Plan IV team member about " & drD("Name") & "? Please call 1 248-689-4910</div>"
                    '    Cats.InnerHtml &= "                <a class=""price-current pull-right"" href=""/contact.aspx"" >Speak With an Expert</a>"
                    '    Cats.InnerHtml &= "            </div>"
                    '    Cats.InnerHtml &= "            <div class=""hover-area"">"
                    '    Cats.InnerHtml &= "            </div>"
                    '    Cats.InnerHtml &= "        </div>"
                    '    Cats.InnerHtml &= "    </div>"
                    'Next
                    'Cats.InnerHtml &= "</div>"
                    'Cats.InnerHtml &= "</div>"
                End If
            End If
        Next
    End Sub

    Protected Sub Page3_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim dtName As DataTable = RC4.Pull("Select Name, (Select top 1 Name from RCGallery2Cat where RCGallery2Cat.Id=RCGallery2.CatId) as CatName from RCGallery2 where Id=" & CInt(Request("Id")))
        If dtName.Rows.Count > 0 Then
            If Not IsDBNull(dtName.Rows(0).Item("CatName")) Then
                lblName.Text = dtName.Rows(0).Item("CatName") & " - "
            End If
            If Not IsDBNull(dtName.Rows(0).Item("Name")) Then
                lblName.Text &= dtName.Rows(0).Item("Name")
            End If
        End If
        Dim dt As DataTable = RC4.Pull("Select Id, Name, Description from RCGallery2Image where Seq >= -(select cast(coalesce(flagShowThumb, 0) as integer) from RCGallery2 where Id=RCGallery2Image.GalleryId) and GalleryId=" & CInt(Request("Id")) & " Order by Seq Asc")
        For Each dr As DataRow In dt.Rows
            gallery.InnerHtml &= "<div class=""portfolio-item apps col-xs-12 col-sm-4 col-md-3"">"
            gallery.InnerHtml &= "    <div class=""recent-work-wrap"">"
            gallery.InnerHtml &= "        <img class=""img-responsive"" title=""" & dr.Item("Description") & """ alt=""" & dr.Item("Name") & """ src=""/GetThumb.ashx?h=480&Id=" & dr.Item("Id") & """>"
            gallery.InnerHtml &= "        <div class=""overlay"">"
            gallery.InnerHtml &= "            <div class=""recent-work-inner"">"
            gallery.InnerHtml &= "                <h3><a>" & dr.Item("Name") & "</a></h3>"
            gallery.InnerHtml &= "                <p>" & dr.Item("Description") & "</p>"
            gallery.InnerHtml &= "                <a class=""preview"" rel=""gallery[" & lblName.Text & "]"" href=""/GetThumb.ashx?h=480&Id=" & dr.Item("Id") & """ title=""" & dr.Item("Description") & """><i class=""fa fa-eye""></i> Expand</a>"
            gallery.InnerHtml &= "            </div> "
            gallery.InnerHtml &= "        </div>"
            gallery.InnerHtml &= "    </div>"
            gallery.InnerHtml &= "</div>"

            'gallery.InnerHtml &= "<a style=""background-image:url('/GetThumb.ashx?h=240&Id=" & dr.Item("Id") & "');"" rel=""gallery[" & lblName.Text & "]"" href=""/GetThumb.ashx?h=480&Id=" & dr.Item("Id") & """ title=""" & dr.Item("Description") & """>"
            'gallery.InnerHtml &= "<img style=""display:none;"" alt=""" & dr.Item("Name") & """ src=""/GetThumb.ashx?h=480&Id=" & dr.Item("Id") & """ />"
            'If Not dr.Item("Name").ToString().Trim() = "" Then

            'gallery.InnerHtml &= "<span>" & dr.Item("Name") & "</span>"

            'End If
            'gallery.InnerHtml &= "</a>"
        Next
    End Sub
End Class
