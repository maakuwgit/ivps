Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Strings_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        LoadCats()
        If Not Me.IsPostBack Then
            If Not Request("CatId") Is Nothing Then
                btnAddString.CommandArgument = Request("CatId")
                LoadGrid(Request("CatId"))
            Else
                For Each ctl As Control In Categories.Controls
                    If TypeOf (ctl) Is LinkButton Then
                        btnCat_Click(ctl, e)
                        Exit Sub
                    End If
                Next
            End If
        End If
    End Sub

    Protected Sub LoadCats()
        Dim dt As DataTable = RC4.Pull("Select Id, Name from RCStringCat")
        
        For Each dr As DataRow In dt.Rows
        	Dim liToAdd As New HtmlGenericControl("li")
        	liToAdd.Attributes.Add("class", "nav-item")
        	'liToAdd.InnerText = dr.Item("Name")
        
            Dim btnCat As New LinkButton
            btnCat.CssClass = "nav-link"
            btnCat.Text = dr.Item("Name")
            btnCat.CommandArgument = dr.Item("Id")
            AddHandler btnCat.Click, AddressOf btnCat_Click
            
            liToAdd.Controls.Add(btnCat)
            
            'ul.Controls.Add(liToAdd)
            
            'Categories.Controls.Add(btnCat)
            Categories.Controls.Add(liToAdd)
        Next
    End Sub

    Protected Sub btnCat_Click(sender As Object, e As EventArgs)
        For Each ctl As Control In Categories.Controls
            If TypeOf (ctl) Is HtmlGenericControl Then
                CType(ctl.Controls(0), LinkButton).CssClass = "nav-link"
            End If
        Next
        
        CType(sender, LinkButton).CssClass = "nav-link active bg-secondary text-white"
        
        LoadGrid(CInt(CType(sender, LinkButton).CommandArgument))
    End Sub

    Protected Sub LoadGrid(CatId As Integer)
        For Each ctl As Control In Categories.Controls
            If TypeOf (ctl) Is LinkButton Then
                If CInt(CType(ctl, LinkButton).CommandArgument) = CatId Then
                    CType(ctl, LinkButton).CssClass = "nav-link"
                End If
            End If
        Next
        
        btnAddString.Visible = True
        btnAddString.CommandArgument = CatId
        Dim dt As DataTable = RC4.Pull("Select * from RCString where CatId=" & CatId & " Order by Name asc")
        gvStr.DataSource = dt
        gvStr.DataBind()
    End Sub

    Protected Sub btnEdit_Click(sender As Object, e As EventArgs)
        Dim Id As Integer = CType(sender, Button).CommandArgument
        Response.Redirect("/admin/strings/edit.aspx?Id=" & Id)
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As EventArgs)
        Dim Id As Integer = CType(sender, Button).CommandArgument
        RC4.SQLExec("Delete from RCString where Id=" & Id)

        Dim dt As DataTable = RC4.Pull("Select * from RCString where CatId=" & btnAddString.CommandArgument)
        gvStr.DataSource = dt
        gvStr.DataBind()
    End Sub

    Protected Sub btnAddString_Click(sender As Object, e As System.EventArgs) Handles btnAddString.Click
        Response.Redirect("/admin/strings/edit.aspx?CatId=" & btnAddString.CommandArgument)
    End Sub
End Class