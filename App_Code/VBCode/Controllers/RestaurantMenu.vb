Imports System.Data

Public Class RestaurantMenuController
	Inherits ModuleController
	
	Dim sqlBuilder
	
	Public Sub New()
	End Sub

	Public Function Menus() As DataTable
		sqlBuilder = new MSSQLBuilder("mnuMenu")
		sqlBuilder.Where("published = 1")
		return sqlBuilder.SelectAll()
    	End Function
    
    	Public Function MenuSections(menuid) As DataTable
    		Dim 	sqlBuilder = new MSSQLBuilder("mnuMenuSection")
		sqlBuilder.Where("published = 1 AND menu_id = " & menuid)
		return sqlBuilder.SelectAll()
    	End Function
    	
    	Public Function MenuSection(id) As DataTable
    		Dim 	sqlBuilder = new MSSQLBuilder("mnuMenuSection")
		sqlBuilder.Where("published = 1 AND id = " & id)
		return sqlBuilder.SelectAll()
    	End Function
    	
    	Public Function Section(id) As DataTable
    		Dim 	sqlBuilder = new MSSQLBuilder("mnuSection")
		return sqlBuilder.SelectAllForId(id)
    	End Function
    	
    	Public Function MenuSectionItems(menusectionid) As DataTable
		sqlBuilder = new MSSQLBuilder("mnuMenuSectionItem")
		sqlBuilder.Where("published = 1 AND menu_section_id = " & menusectionid)
		sqlBuilder.OrderBy("section_item_number asc")
		return sqlBuilder.SelectAll()
    	End Function
    	
    	' SINGLE ROW
    	Public Function MenuSectionItem(id) As DataTable
		sqlBuilder = new MSSQLBuilder("mnuMenuSectionItem")
		sqlBuilder.Where("published = 1 AND id = " & id)
		return sqlBuilder.SelectAll()
    	End Function
    	
    	' SINGLE ROW
    	Public Function ItemSizeName(id) As DataTable
    		sqlBuilder = new MSSQLBuilder("mnuItemSize")
		return sqlBuilder.SelectAllForId(id)
    	End Function
    	
    	' SINGLE ROW
    	Public Function ItemIncludeItems(id)
    		If id > 0 Then
    		sqlBuilder = new MSSQLBuilder("mnuInclude")
		Dim dt = sqlBuilder.SelectAllForId(id)
		return dt.rows(0)("items")
		Else
			return ""
		End If
    	End Function
    	
    	' SINGLE ROW
    	Public Function MenuSectionItemDescription(menusectionitemid)
		sqlBuilder = new MSSQLBuilder("mnuMenuSectionItem")
		sqlBuilder.Where("published = 1 AND menu_section_id = " & menusectionitemid)
		Dim dt = sqlBuilder.SelectAll()
		return dt.rows(0)("Description")
    	End Function
    	
    	' SINGLE ROW
    	Public Function Item(id)
    		sqlBuilder = new MSSQLBuilder("mnuItem")
		sqlBuilder.Where("id = " & id)
		return sqlBuilder.SelectAll()
    	End Function
    	
    	Public Function ItemName(id)
    		Dim dt = Item(id)
    		return dt.rows(0)("name")
    	End Function
    	
    	Public Function ItemImageSrc(id, Optional w = 100)
    		Dim dt = Item(id)
    		If dt.rows(0)("img").ToString.Length > 0 Then
    			return "/admin/restaurant/img.ashx?id=" & id & "&w=" & w
    		Else
    			' Could return a default missing image
    			return "/admin/restaurant/img.ashx?id=" & id & "&w=" & w
    		End IF
    	End Function
    	
    	Public Function ItemHasImage(id)
    		Dim dt = Item(id)
    		return dt.rows(0)("img").ToString.Length > 0 
    	End Function
    	
    	Public Function ItemDescription(id)
    		If id > 0 Then
    			Dim dt = Item(id)
    			return dt.rows(0)("description")
    		Else
    			return ""
    		End If
    	End Function
    	
    	Public Function MenuSectionCode(menuSectionId)
    		Dim dt = MenuSection(menuSectionId)
    		Dim sdt = Section(dt.rows(0)("section_id"))
    		return sdt.rows(0)("code")
    	End Function
    	
    	Public Function ItemOrderOnlineUrl(itemid)
    		If itemid > 0 Then
			Dim sqlBuilder = new MSSQLBuilder("mnuMenuSectionItem")
			sqlBuilder.Where("published = 1 AND item_id = " & itemid)
			Dim menuSectionItem = sqlBuilder.SelectAll()
			If menuSectionItem.rows(0)("order_online_url").ToString.Length > 0 Then
				return menuSectionItem.rows(0)("order_online_url")
			Else
				sqlBuilder = new MSSQLBuilder("mnuMenuSection")
				sqlBuilder.Where("published = 1 AND id = " & menuSectionItem.rows(0)("menu_section_id"))
				Dim menuSection = sqlBuilder.SelectAll()
				If menuSection.rows(0)("order_online_url").ToString.Length > 0 Then
					return menuSection.rows(0)("order_online_url")
				Else
					sqlBuilder = new MSSQLBuilder("mnuMenu")
					sqlBuilder.Where(" id = " & menuSection.rows(0)("menu_id"))
					Dim menu = sqlBuilder.SelectAll()
					If menu.rows(0)("order_online_url").ToString.Length > 0 Then
						return menu.rows(0)("order_online_url")
					Else	
						return ""
					End If
				End If
			End If
		End If
		return ""
    	End Function

End Class 