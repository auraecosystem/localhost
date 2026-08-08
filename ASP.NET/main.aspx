<asp:Panel
    ID="pnlGreeting"
    runat="server"
    DefaultButton="btnSubmit"
    CssClass="greeting-form">

    <asp:Label
        ID="lblName"
        runat="server"
        AssociatedControlID="txtName"
        Text="Name" />

    <asp:TextBox
        ID="txtName"
        runat="server"
        CssClass="form-input"
        MaxLength="100"
        placeholder="Enter your name"
        autocomplete="name" />

    <asp:RequiredFieldValidator
        ID="valName"
        runat="server"
        ControlToValidate="txtName"
        ErrorMessage="Please enter your name."
        Display="Dynamic"
        CssClass="validation-error" />

    <asp:Button
        ID="btnSubmit"
        runat="server"
        Text="Greet Me"
        CssClass="form-button"
        OnClick="btnSubmit_Click" />

    <asp:Label
        ID="lblMessage"
        runat="server"
        CssClass="greeting-message"
        EnableViewState="false" />

</asp:Panel>
