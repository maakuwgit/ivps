Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_testimonials_add
    Inherits System.Web.UI.Page
    Sub page_load()

    End Sub
    Sub btnSubmit_Click(ByVal s As Object, ByVal e As EventArgs)
    	Dim rating = Request("rating")
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim strSQL As String = "INSERT INTO RCTestimonials (dateCreated, firstname, lastname, company, position, city, state, country, quote, isApproved, ip, RatingValue) VALUES (@dateCreated, @firstname, @lastname, @company, @position, @city, @state, @country, @quote, @isApproved, @ip, @RatingValue)"
        Dim cmd As New SqlCommand(strSQL, con)
        cmd.Parameters.AddWithValue("dateCreated", Now)
        cmd.Parameters.AddWithValue("firstname", txtfirstname.Text)
        cmd.Parameters.AddWithValue("lastname", txtlastname.Text)
        cmd.Parameters.AddWithValue("company", txtcompany.Text)
        cmd.Parameters.AddWithValue("position", txtposition.Text)
        cmd.Parameters.AddWithValue("city", txtcity.Text)
        cmd.Parameters.AddWithValue("state", txtstate.Text)
        cmd.Parameters.AddWithValue("country", txtcountry.Text)
        cmd.Parameters.AddWithValue("quote", txtqout.Text)
        cmd.Parameters.AddWithValue("isApproved", "False")
        cmd.Parameters.AddWithValue("ip", HttpContext.Current.Request.UserHostAddress)
        cmd.Parameters.AddWithValue("RatingValue", rating)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect("/admin/testimonials/")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("/Admin/Testimonials/")
    End Sub
End Class
