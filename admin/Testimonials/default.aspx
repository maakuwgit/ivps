<%@ Page MasterPageFile="~/admin/Admin.master" CodeFile="default.aspx.vb" Inherits="Admin_testimonials" EnableEventValidation="false" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
</asp:Content>
<asp:Content ContentPlaceHolderID="main" runat="server">
<h1>Reviews</h1>
<asp:button ID="btnAdd" ToolTip="Add a New Review" runat="server" Text="Add" class="btn btn-primary btn-sm my-3"/>
    <asp:GridView runat="server" ID="gvTest" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" EmptyDataText="There are no Testimonials to display.">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" />
            <asp:BoundField DataField="Rating" HeaderText="Rating" />
            <asp:BoundField DataField="Author" HeaderText="Author" />
            <asp:BoundField DataField="Quote" HeaderText="Quote" />
            <asp:TemplateField HeaderText="Published">
                <ItemTemplate>
                    <asp:CheckBox ID="ckApproved" runat="server" TestimonialId='<%#Eval("Id")%>' AutoPostBack="true" OnCheckedChanged="ckApproved_CheckedChanged" Checked='<%#Eval("IsApproved")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ItemStyle-Width="110" HeaderText="Actions">
                <ItemTemplate>
                    <div class="btn-group">
                		<asp:Button ID="btnEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("Id") %>' OnClick="btnEdit_Click" class="btn btn-outline-primary btn-sm "/>
                		<asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("Id") %>' OnClientClick="return confirm('Are you sure?')" OnClick="btnDelete_Click" class="btn btn-outline-danger btn-sm"/>
                	</div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>