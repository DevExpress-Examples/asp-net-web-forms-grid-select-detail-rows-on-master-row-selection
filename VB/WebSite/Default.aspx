<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="Grid_MasterDetail_SelectDetailRows_Default" %>

<%@ Register Assembly="DevExpress.Web.v15.1, Version=15.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>How to select detail rows on master row selection</title>
</head>
<body>
    <form id="form1" runat="server">
		<script type="text/javascript">
			function onMasterGridSelectionChanged(s, e) {
			    master.PerformCallback("select|" + e.visibleIndex + "|" + (e.isSelected ? "T" : ""));
			}
		</script>
		
        <dx:ASPxGridView ID="master" runat="server" AutoGenerateColumns="False" DataSourceID="masterData" KeyFieldName="CategoryID"
			ClientInstanceName="master" OnCustomCallback="master_CustomCallback">
			<SettingsDetail ShowDetailRow="True" />
            <ClientSideEvents SelectionChanged="onMasterGridSelectionChanged" />
			<Columns>
                <dx:GridViewCommandColumn ShowSelectCheckbox="true" VisibleIndex="0" />
				<dx:GridViewDataTextColumn FieldName="CategoryID" ReadOnly="True" VisibleIndex="1" />
				<dx:GridViewDataTextColumn FieldName="CategoryName" VisibleIndex="2" />
			</Columns>
			<Templates>
				<DetailRow>
					<dx:ASPxGridView ID="detail" runat="server" AutoGenerateColumns="False"
						DataSourceID="detailData" KeyFieldName="ProductID" OnBeforePerformDataSelect="detail_BeforePerformDataSelect">
						<Columns>
							<dx:GridViewCommandColumn ShowSelectCheckbox="true" VisibleIndex="0" />
							<dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" VisibleIndex="1" />
							<dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="2" />
							<dx:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="3" />
						</Columns>
					</dx:ASPxGridView>
				</DetailRow>
			</Templates>
		</dx:ASPxGridView>
		
		<asp:AccessDataSource ID="masterData" runat="server" DataFile="~/App_Data/nwind.mdb"
			SelectCommand="SELECT [CategoryID], [CategoryName] FROM [Categories]"></asp:AccessDataSource>			
		<asp:AccessDataSource ID="detailData" runat="server" DataFile="~/App_Data/nwind.mdb"
			SelectCommand="SELECT [ProductID], [ProductName], [UnitPrice] FROM [Products] WHERE CategoryID = ?">
			<SelectParameters>				
				<asp:Parameter Name="CategoryID" />				
			</SelectParameters>
		</asp:AccessDataSource>	
    </form>
</body>
</html>