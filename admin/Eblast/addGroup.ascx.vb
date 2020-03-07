Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_emailCenter_addGroup
    Inherits System.Web.UI.UserControl

    Sub page_init(ByVal s As Object, ByVal e As EventArgs)
        pnl.Style.Add("display", "none")
    End Sub

    Sub page_load(ByVal s As Object, ByVal e As EventArgs)
        btnAdd.Attributes.Add("onMouseOver", "this.src='addOn.png'")
        btnAdd.Attributes.Add("onMouseOut", "this.src='add.png'")
    End Sub
    Sub btnSubmit_click(ByVal s As Object, ByVal e As EventArgs)
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As New SqlCommand("INSERT INTO EblastGroups (title, description) VALUES (@Title, @Description)", con)
        cmd.Parameters.AddWithValue("title", txtTitle.Text)
        cmd.Parameters.AddWithValue("description", txtDescription.Text)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect("groups.aspx", True)
    End Sub
End Class
