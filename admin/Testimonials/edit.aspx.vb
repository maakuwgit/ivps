Imports System.Data
Imports System.Data.SqlClient

Partial Class Admin_testimonials_edit
    Inherits System.Web.UI.Page

    Sub page_load(ByVal s As Object, ByVal e As EventArgs)
        If Not Me.IsPostBack Then
            Dim id As Integer = Request("Id")
            Dim dt As DataTable = RC4.Pull("Select * from rcTestimonials where Id=" & id)
            If dt.Rows.Count > 0 Then
                With dt.Rows(0)
                    If Not IsDBNull(.Item("firstName")) Then txtFirstName.Text = .Item("firstName")
                    If Not IsDBNull(.Item("lastName")) Then txtLastName.Text = .Item("lastName")
                    If Not IsDBNull(.Item("company")) Then txtCompany.Text = .Item("company")
                    If Not IsDBNull(.Item("position")) Then txtPosition.Text = .Item("position")
                    If Not IsDBNull(.Item("city")) Then txtCity.Text = .Item("city")
                    If Not IsDBNull(.Item("state")) Then txtState.Text = .Item("state")
                    If Not IsDBNull(.Item("country")) Then txtCountry.Text = .Item("country")
                    If Not IsDBNull(.Item("quote")) Then txtQuote.Value = .Item("quote")
                    
                    
   
					Dim sb As New StringBuilder				
                    If Not  dt.Rows(0).IsNull("RatingValue") Then
                    	
							sb.Append("<fieldset class=""starability-basic ml-3"">")
							sb.Append("<legend>Rating</legend>")
							sb.Append("<input type=""radio"" id=""no-rate"" class=""input-no-rate"" name=""rating"" value=""0"" checked aria-label=""No rating."" />")
							
							Dim rating As Integer = Convert.toInt32(.Item("RatingValue").ToString())
						For value As Integer = 1 To 5
							if value <= rating Then
								sb.Append("<input type=""radio"" id=""rate" & value & """ name=""rating"" value=""" & value & """  checked/>")
								sb.Append("<label for=""rate"& value &""">"& value &" stars</label>")
							Else
								sb.Append("<input type=""radio"" id=""rate" & value & """ name=""rating"" value=""" & value & """  />")
								sb.Append("<label for=""rate"& value &""">"& value &" stars</label>")
							End If
							
						Next
						sb.Append("<span class=""starability-focus-ring""></span>")
						sb.Append("</fieldset>")
					
					
				Else
					sb.Append("<fieldset class=""starability-basic ml-3"">")
							sb.Append("<legend>Rating</legend>")
							sb.Append("<input type=""radio"" id=""no-rate"" class=""input-no-rate"" name=""rating"" value=""0"" checked aria-label=""No rating."" />")
					For value As Integer = 1 To 5
						sb.Append("<input type=""radio"" id=""rate" & value & """ name=""rating"" value=""" & value & """  />")
						sb.Append("<label for=""rate"& value &""">"& value &" stars</label>")
					Next
				sb.Append("<span class=""starability-focus-ring""></span>")
						sb.Append("</fieldset>")		
				End If
				ratingcontainer.text = sb.ToString
                End With
            End If
        End If
    End Sub

    Sub btnSubmit_Click(ByVal s As Object, ByVal e As EventArgs)
    	Dim rating = Request("rating")
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
        Dim cmd As New SqlCommand("UPDATE RCTestimonials SET firstName=@firstName, lastName=@lastName, company=@company, position=@position, city=@city, state=@state, country=@country, quote=@quote, RatingValue=@RatingValue WHERE Id=@Id", con)
        cmd.Parameters.AddWithValue("firstName", txtFirstName.Text)
        cmd.Parameters.AddWithValue("lastName", txtLastName.Text)
        cmd.Parameters.AddWithValue("company", txtCompany.Text)
        cmd.Parameters.AddWithValue("position", txtPosition.Text)
        cmd.Parameters.AddWithValue("city", txtCity.Text)
        cmd.Parameters.AddWithValue("state", txtState.Text)
        cmd.Parameters.AddWithValue("country", txtCountry.Text)
        cmd.Parameters.AddWithValue("quote", txtQuote.Value)
        cmd.Parameters.AddWithValue("Id", Request("Id"))
        cmd.Parameters.AddWithValue("RatingValue", rating)

        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect("~/admin/testimonials")
    End Sub
    Sub btnCancel_Click(ByVal s As Object, ByVal e As EventArgs)
        Response.Redirect("~/admin/testimonials")
    End Sub
End Class
