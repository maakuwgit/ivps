Imports System.Data
Imports System.Data.SqlClient

Partial Class Admin_testimonials
    Inherits System.Web.UI.Page

    Protected Sub page_load(ByVal s As Object, ByVal e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            Dim dt As DataTable = RC4.Pull("Select Id, firstName + ' ' + lastName as Author, Quote, isApproved, CAST(RatingValue As VarChar) + ' of 5' as Rating from RcTestimonials")
            gvTest.DataSource = dt
            gvTest.DataBind()
        End If
    End Sub

    Protected Sub btnAdd_Click(ByVal s As Button, ByVal e As EventArgs) Handles btnAdd.Click
        Response.Redirect("Add.aspx")
    End Sub

    Protected Sub btnEdit_Click(ByVal s As Button, ByVal e As EventArgs)
        Response.Redirect("Edit.aspx?Id=" & s.CommandArgument)
    End Sub

    Protected Sub ckApproved_CheckedChanged(ByVal s As CheckBox, ByVal e As EventArgs)
        Dim id As Integer = s.Attributes("TestimonialId")
        RC4.SQLExec("Update RcTestimonials set isApproved = " & IIf(s.Checked, "1", "0") & " where Id=" & id)
    End Sub

    Protected Sub btnDelete_Click(ByVal s As Button, ByVal e As EventArgs)
        Dim id As Integer = s.CommandArgument
        RC4.SQLExec("Delete from RcTestimonials where Id=" & id)
        Response.Redirect("/Admin/Testimonials/")
    End Sub
End Class
