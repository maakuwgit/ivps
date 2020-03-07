Imports System.Data

Partial Class Category
    Inherits System.Web.UI.Page

    Dim cId As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not Request("Id") Is Nothing Then
            cId = Request("Id")
            Dim dt As DataTable = RC4.Pull("SELECT Label, Name from  RCProductCat where Id=" & cId & " order by Label asc")
            For Each drC As DataRow In dt.Rows

                'Products.InnerHtml &= "<h3>" & drC("Name") & "</h3>"
                'Products.InnerHtml &= "<p>" & drC("Content") & "</p>"
                'Dim dtm As DataTable = RC4.Pull("SELECT * from RCProduct where CatId=" & cId & " order by Name asc")
                'For Each dr As DataRow In dtm.Rows
                '    Products.InnerHtml &= "<div class=""col-md-4"">"
                '    Products.InnerHtml &= "<div class=""media post"">"
                '    Products.InnerHtml &= "    <div class=""pull-left post-image"">"
                '    Products.InnerHtml &= "        <a href=""/Product.aspx?Id=" & dr("Id") & """>"
                '    Products.InnerHtml &= "            <img class=""contentimg"" src=""/Product.ashx?Id=" & dr("Id") & """>"
                '    Products.InnerHtml &= "        </a>"
                '    Products.InnerHtml &= "    </div>"
                '    Products.InnerHtml &= "    <div class=""media-body"">"

                '    Products.InnerHtml &= "        <h4>" & dr("Name") & "</h4>"
                '    Products.InnerHtml &= "        <p>" & dr("Description") & " </p>"
                '    Products.InnerHtml &= "        <p>" & dr("Matching") & "</p>"
                '    Products.InnerHtml &= "        <a class=""button"" href=""/Product.aspx?Id=" & dr("Id") & """>VIEW DETAILS</a>"
                '    Products.InnerHtml &= "    </div>"
                '    Products.InnerHtml &= "</div>"
                '    Products.InnerHtml &= "</div>"
                'Next

            Next
            Categories()
        End If

    End Sub

    Protected Sub Page2_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim dt3 As DataTable = RC4.Pull("Select * from RCProductCat")
        For Each dr3 As DataRow In dt3.Rows
            If Request("Id") Is Nothing Then
                Response.Redirect("/Category.aspx?Id=" & dr3("Id"))
            Else
                If Request("Id") = dr3("Id") Then
                    If Not IsDBNull(dr3("Id")) Then

                        CatContent.InnerHtml = "<h2 class=""section-title-main"">" & dr3("Name") & "</h2>"
                        CatContent.InnerHtml &= "<p>" & dr3("Name") & "</p>"
                        CatContent.InnerHtml &= "<p>" & dr3("Label") & "</p>"
                    End If
                End If
            End If
        Next
        Dim dt As DataTable = RC4.Pull("Select * from RCProductCat Where Exists (Select CatId from RCProduct where RCProductCat.Id = RCProduct.CatId)")
        For Each dr As DataRow In dt.Rows
            'If Request("Id") Is Nothing Then
            'Response.Redirect("/Category.aspx?Id=" & dr("Id"))
            'Else
            If Request("Id") = dr("Id") Then
                If Not IsDBNull(dr("Id")) Then
                    Dim dtm As DataTable = RC4.Pull("SELECT * from RCProduct where CatId=" & CInt(dr("Id")) & " order by Seq asc")

                    productCat.InnerHtml &= "<li class=""active""><a data-toggle=""tab"" href=""#tab" & dr("Id") & """ aria-expanded=""true"">" & dr("Name") & "</a></li>"
                    Products.InnerHtml &= "<div id=""tab" & dr("Id") & """ class=""tab-pane active"">"
                    Products.InnerHtml &= "<div class=""product-grid-holder"">"

                    For Each drC As DataRow In dtm.Rows
                        If Not IsDBNull(drC("CatId")) Then
                            Products.InnerHtml &= "    <div class=""col-sm-4 col-md-3 no-margin product-item-holder hover"">"
                            Products.InnerHtml &= "        <div class=""product-item"">"
                            Products.InnerHtml &= "            <div class=""ribbon red""><span>New</span></div>"
                            Products.InnerHtml &= "            <div class=""image"">"
							If NOT IsDBNull (drC("Img")) Then 
                            Products.InnerHtml &= "                 <img class=""img-responsive"" src=""/Product.ashx?Id=" & drC("Id") & """>"
							End If
                            Products.InnerHtml &= "            </div>"
                            Products.InnerHtml &= "            <div class=""body"">"
                            Products.InnerHtml &= "                <div class=""label-discount green"">" & dr("Name") & "</div>"
                            Products.InnerHtml &= "                <div class=""title"">"
                            Products.InnerHtml &= "                    <a href=""/Product.aspx?Id=" & drC("Id") & """>" & drC("Name") & "</a>"
                            Products.InnerHtml &= "                </div>"
                            Products.InnerHtml &= "                <div class=""brand"">" & drC("Description") & "</div>"
                            Products.InnerHtml &= "            </div>"
                            Products.InnerHtml &= "            <div class=""prices"">"
                            Products.InnerHtml &= "                <div class=""price-prev"">Available</div>"
                            Products.InnerHtml &= "            </div>"
                            Products.InnerHtml &= ""
                            Products.InnerHtml &= "            <div class=""hover-area"">"
                            Products.InnerHtml &= "               <div class=""add-cart-button"">"
                            If Not IsDBNull(drC("ImgURL")) and (drC("ImgURL")) IsNot ""  Then
                                Products.InnerHtml &= "                    <a class=""btn btn-primary"" target=""_blank"" href=""" & drC("ImgURL") & """>Quote</a>"
                            Else
                                Products.InnerHtml &= "                    <a class=""btn btn-primary"" href=""/Product.aspx?Id=" & drC("Id") & """>More Information</a>"
                            End If
                            Products.InnerHtml &= "                </div>"
                            Products.InnerHtml &= "            </div>"
                            Products.InnerHtml &= "        </div>"
                            Products.InnerHtml &= "    </div>"
                        End If
                    Next
                    Products.InnerHtml &= "</div>"
                    Products.InnerHtml &= "<div class=""loadmore-holder text-center"">"
                    Products.InnerHtml &= "    <a href=""/contact.aspx"" class=""btn-loadmore""><i class=""fa fa-plus""></i> To View More Products Contact us</a>"
                    Products.InnerHtml &= "</div>"
                    Products.InnerHtml &= "</div>"


                    ' End If
                End If
            End If

        Next
    End Sub

    Private Sub Categories()
        Dim dtL As DataTable = RC4.Pull("Select * from RCProductLine order by Id")
        For Each drL As DataRow In dtL.Rows
            'sideNavProductCats.InnerHtml = "<li class=""dropdown menu-item""><a class=""productCats-toggle"" href=""/Products.aspx?Line=" & drL("Id") & """> " & drL("Name") & " </a></li>" & sideNavProductCats.InnerHtml
        Next
        Dim dt As DataTable = RC4.Pull("Select * from RCProductCat order by Id") 'Order by Descending only because they are being appended to the beginning
        For Each dr As DataRow In dt.Rows
            If Request("Id") Is Nothing Then
                Response.Redirect("/Category.aspx?Id=" & dr("Id"))
            End If
            If Request("Id") = dr("Id") Then
                'sideNavProductCats.InnerHtml = "<li class=""dropdown menu-item""><a class=""productCats-toggle"" href=""/Category.aspx?Id=" & dr("Id") & """> " & dr("Name") & " </a></li>" & sideNavProductCats.InnerHtml

            End If
        Next
    End Sub

End Class
