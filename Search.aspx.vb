Imports System.Data
Imports System.Data.SqlClient

Partial Class Search
    Inherits System.Web.UI.Page



    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
		Results.InnerHtml = Server.HtmlEncode("")
        Dim catA as string = "pname"

	If dlCols.SelectedValue = 1 then catA = "pname"
	If dlCols.SelectedValue = 2 then catA = "Output"
	If dlCols.SelectedValue = 3 then catA = "Freq"
	If dlCols.SelectedValue = 4 then catA = "Pulse"
	If dlCols.SelectedValue = 5 then catA = "Duty"
	If dlCols.SelectedValue = 6 then catA = "Eff"
	If dlCols.SelectedValue = 7 then catA = "Voltage"
	If dlCols.SelectedValue = 8 then catA = "Matching"
	
	
        
        Dim TermA As String = txtSearch.Text.Replace("'", "''").Replace("--", "") .Replace(";", "")


        'Dim dt As DataTable = RC4.Pull("SELECT Distinct Label, LineId, Id AS CatId2, Name from vProductCat where " & catA & " like '%" & TermA & "%'  order by Label Asc")
		
		

Dim strQuery  AS string = "SELECT Distinct Label, LineId, Id AS CatId2, Name from vProductCat where " & catA & " like '%" & TermA & "%'  order by Label Asc"

Dim cmd As new SqlCommand(strQuery)

Dim dt AS DataTable = GetData(cmd)
Dim Gridview1 AS new gridview
GridView1.DataSource = dt

GridView1.DataBind()

        
        For Each drL As DataRow In dt.Rows
            Results.InnerHtml &= "<table class=""product-table full left simpleTable"">"
            Results.InnerHtml &= "<h3>" & drL("Name") & "</h3>"
            Results.InnerHtml &= "<thead>"
            Results.InnerHtml &= "<tr>"
            'Results.InnerHtml &= "<th class=""col1 displaynone"">Image</th>"
            Results.InnerHtml &= "<th  data-sort=""string"" class=""col13"">Name</th>"
            Results.InnerHtml &= "<th  data-sort=""int"" class=""col4"">Output</th>"
            Results.InnerHtml &= "<th  data-sort=""int"" class=""col7"">Freq</th>"
            Results.InnerHtml &= "<th   data-sort=""int"" class=""col6"">Pulse</th>"
            Results.InnerHtml &= "<th  data-sort=""int"" class=""col8"">Duty</th>"
            Results.InnerHtml &= "<th  data-sort=""int"" class=""col9"">Eff</th>"
            Results.InnerHtml &= "<th  data-sort=""int"" class=""col10"">Voltage</th>"
            Results.InnerHtml &= "<th  data-sort=""string"" class=""col11 hide-tp-only"">Matching</th>"
            Results.InnerHtml &= "<th  data-sort=""string"" class=""col12 hide-tp-only"">Pkg.</th>"
            Results.InnerHtml &= "</tr>"
            Results.InnerHtml &= "</thead>"
            'Dim dtm As DataTable = RC4.Pull("SELECT * from vProductCat where CatId =" & drL("CatId2") & " and " & catA & " like '%" & TermA & "%' order by PName Asc")

            Dim strQuery2 As String = "SELECT * from vProductCat where CatId =" & drL("CatId2") & " and " & catA & " like '%" & TermA & "%' order by PName Asc"

            Dim cmdP As New SqlCommand(strQuery2)

            Dim dtm As DataTable = GetData(cmdP)
            Dim Gridview2 As New gridview
            GridView2.DataSource = dt

            GridView2.DataBind()

            
            For Each dr As DataRow In dtm.Rows

                Results.InnerHtml &= "<tr>"
                'Results.InnerHtml &= "  <td class=""col1"">"
                'Results.InnerHtml &= "    <a target=""_blank"" href=""/Product.ashx?Id=" & dr("Id") & """ alt=""Product Picture"" />View</a>"
                'Results.InnerHtml &= "  </td>"
                Results.InnerHtml &= "  <td data-title=""Name"" class=""col13"">"
                If Not IsDBNull(dr("Attachment")) Then
                    Results.InnerHtml &= "<a href=""/ProductDoc.ashx?Id=" & dr("pId") & """>"
                    Results.InnerHtml &= "    <strong>" & dr("PName") & "</strong>"
                    Results.InnerHtml &= "</a>"
                Else
                    Results.InnerHtml &= "    <strong>" & dr("PName") & "</strong></td>"
                End If

                Results.InnerHtml &= "    <td data-title=""Output"" class=""col4"">" & dr("Output") & " </td>"
                Results.InnerHtml &= "    <td data-title=""Freq"" class=""col7"">" & dr("Freq") & "</td>"
                Results.InnerHtml &= "    <td data-title=""Pulse""class=""col6"">" & dr("Pulse") & "</td>"
                Results.InnerHtml &= "    <td data-title=""Duty"" class=""col8"">" & dr("Duty") & "</td>"
                Results.InnerHtml &= "    <td data-title=""Eff"" class=""col9"">" & dr("Eff") & "</td>"
                Results.InnerHtml &= "    <td data-title=""Voltage"" class=""col10"">" & dr("Voltage") & "</td>"
                Results.InnerHtml &= "    <td data-title=""Matching"" class=""col11 hide-tp-only"">" & dr("Matching") & "</td>"
                Results.InnerHtml &= "    <td data-title=""Pkg."" class=""col12 hide-tp-only"">"
                If Not IsDBNull(dr("BroFile")) Then
                    Results.InnerHtml &= "<a href=""/ProductDoc.ashx?Type=Bro&Id=" & dr("pId") & """>"
                    Results.InnerHtml &= "    <strong>" & dr("PkgName") & "</strong>"
                    Results.InnerHtml &= "</a></td>"
                Else
                    Results.InnerHtml &= "    <strong>" & dr("PkgName") & "</strong></td>"
                End If
                Results.InnerHtml &= "  </tr>"
                'Results.InnerHtml &= "</div>"

            Next

        Next

        Results.InnerHtml &= "</table>"
        Results.InnerHtml &= "<h3>No More Results Match the Search Term</h3>"
        TermA = ""
        catA = ""
    End Sub
    


Public Function GetData(ByVal cmd As SqlCommand) As DataTable

        Dim dt As New DataTable

        Dim strConnString As String = System.Configuration.ConfigurationManager.ConnectionStrings("rcon").ConnectionString

        Dim con As New SqlConnection(strConnString)

        Dim sda As New SqlDataAdapter

        cmd.CommandType = CommandType.Text

        cmd.Connection = con

        Try

            con.Open()

            sda.SelectCommand = cmd

            sda.Fill(dt)

            Return dt

        Catch ex As Exception

            Response.Write(ex.Message)

            Return Nothing

        Finally

            con.Close()

            sda.Dispose()

            con.Dispose()

        End Try

 End Function



End Class

