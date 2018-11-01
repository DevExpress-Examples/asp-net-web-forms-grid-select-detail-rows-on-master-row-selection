Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web

Partial Public Class Grid_MasterDetail_SelectDetailRows_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not IsPostBack Then
            master.DataBind()
            master.DetailRows.ExpandRow(0)
        End If
    End Sub

    Protected Sub detail_BeforePerformDataSelect(ByVal sender As Object, ByVal e As EventArgs)
        detailData.SelectParameters("CategoryID").DefaultValue = (TryCast(sender, ASPxGridView)).GetMasterRowKeyValue().ToString()
    End Sub
    Protected Sub master_CustomCallback(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)
        Dim data() As String = e.Parameters.Split("|"c)
        If data.Length = 3 AndAlso data(0) = "select" Then
            ProcessDetailSelection(Integer.Parse(data(1)), data(2) = "T")
        End If
    End Sub

    Private Sub ProcessDetailSelection(ByVal index As Integer, ByVal state As Boolean)
        Dim detail As ASPxGridView = TryCast(master.FindDetailRowTemplateControl(index, "detail"), ASPxGridView)
        If detail IsNot Nothing Then
            If state Then
                detail.Selection.SelectAll()
            Else
                detail.Selection.UnselectAll()
            End If
        End If
    End Sub
End Class
