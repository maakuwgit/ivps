Imports System.Data

Partial Class admin_emailCenter_templates
    Inherits System.Web.UI.Page
    Sub page_load(ByVal s As Object, ByVal e As EventArgs)
        If Not Me.IsPostBack Then
            plh.Controls.Add(GetTemplateTable)
        End If
    End Sub

    Public Shared Function GetTemplateTable() As Table
        Dim tbl As New Table
        tbl.Width = Unit.Percentage(100)
        tbl.CellPadding = 4

        Dim trH As New TableRow
        trH.BackColor = Drawing.Color.FromArgb(255, 50, 50, 50)
        trH.Width = Unit.Percentage(100)

        Dim tdH1 As New TableCell
        tdH1.Style("color") = "#eeeeee"
        tdH1.Text = "Edit"
        tdH1.HorizontalAlign = HorizontalAlign.Center

        Dim tdH2 As New TableCell
        tdH2.Style("color") = "#eeeeee"
        tdH2.Text = "Title"
        tdH2.HorizontalAlign = HorizontalAlign.Left

        Dim tdH3 As New TableCell
        tdH3.Style("color") = "#eeeeee"
        tdH3.Text = "Description"
        tdH3.HorizontalAlign = HorizontalAlign.Left

        trH.Cells.Add(tdH1)
        trH.Cells.Add(tdH2)
        trH.Cells.Add(tdH3)
        tbl.Rows.Add(trH)

        Dim x As Integer

        Dim dt As DataTable = RC4.Pull("Select * from EblastTemplates")

        For Each r As DataRow In dt.Rows

            Dim tr As New TableRow
            If x Mod 2 = 1 Then
                tr.BackColor = Drawing.Color.FromArgb(255, 245, 245, 245)
            Else
                tr.BackColor = Drawing.Color.FromArgb(255, 225, 225, 225)
            End If

            'Dim btnEdit As New Button
            'With btnEdit
            '    '.CommandName = r.Item("ID")
            '    .Attributes.Add("onMouseOver", "this.src='editOn.png'")
            '    .Attributes.Add("onMouseOut", "this.src='edit.png'")
            '    .ImageUrl = "edit.png"
            '    .ID = "btn_" & r.Item("ID") & "_Edit"
            '    .EnableViewState = True
            '    .Enabled = True
            '    .Visible = True
            '    .OnClientClick = "location.href='template.aspx?Id=" & r.Item("Id") & "'"
            '    'AddHandler .Click, AddressOf btnEdit_Click
            'End With

            Dim tdEdit As New TableCell
            tdEdit.Width = Unit.Percentage(5)
            tdEdit.HorizontalAlign = HorizontalAlign.Center
            tdEdit.Text = "<a href=""template.aspx?Id=" & r.Item("Id") & """><img src=""edit.png"" /></a>"
            'tdEdit.Controls.Add(btnEdit)

            Dim tdT As New TableCell
            tdT.Width = Unit.Percentage(25)
            tdT.Text = "<h3>" & r.Item("Title") & "</h3>"

            Dim tdD As New TableCell
            tdD.Width = Unit.Percentage(70)
            tdD.HorizontalAlign = HorizontalAlign.Left
            tdD.Text = r.Item("Description")

            tr.Cells.Add(tdEdit)
            tr.Cells.Add(tdT)
            tr.Cells.Add(tdD)
            tbl.Rows.Add(tr)

            x += 1
        Next

        Return tbl

        tbl = Nothing

    End Function

End Class
