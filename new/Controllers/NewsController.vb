Imports System.Data

Public Class NewsController
	Inherits ModuleController
	
	' LAYOUT PROPERTIES
	Public SHOW_DESCRIPTION = "ShowDescription"
	Public SHOW_TITLE_ONLY = "ShowTitleOnly"
	Public NUMBER_OF_COLUMNS_PER_ROW = "NumberOfColumnsPerRow"
	Public DESCRIPTION_WORD_LIMIT = "DescriptionWordLimit"
	
	' DATA PROPERTIES
	Public SELECT_TOP_NUMBER = "SelectTopNumber"
	Public CATEGORY_ID = "CategoryId"
	Public NEWS_ID = "NewsId"
	
	Public Sub New() 
		Me.Value(SHOW_DESCRIPTION, False)
		Me.TitleOnly = False
		Me.Value(NUMBER_OF_COLUMNS_PER_ROW, 3)
		Me.Value(DESCRIPTION_WORD_LIMIT, False)
		Me.Value(SELECT_TOP_NUMBER, 10)
		Me.Value(CATEGORY_ID, False)
		Me.Value(NEWS_ID, False)
	End Sub
	
	Public Function Top() As DataTable
		If Me.SelectTopNumber = false Then
			return Me.All()
		Else
			If Not Me.CategoryId Then
				return RC4.Pull("Select Top " & Me.SelectTopNumber & " * from RCNews where PubDate <= '" & Today.Date.ToShortDateString & "' order by PubDate desc")
			Else
				return RC4.Pull("Select Top " & Me.SelectTopNumber & " * from RCNews where PubDate <= '" & Today.Date.ToShortDateString & "' AND CatId = " & Me.CategoryId & " order by PubDate desc")
			End If
		End If
    End Function
    

    
    Public Function All() As DataTable
    	If Not Me.CategoryId Then
			return RC4.Pull("Select * from RCNews where PubDate <= '" & Today.Date.ToShortDateString & "' order by PubDate desc")
		Else
			return RC4.Pull("Select * from RCNews where PubDate <= '" & Today.Date.ToShortDateString & "' AND CatId = " & Me.CategoryId & " order by PubDate desc")
		End If
    End Function
    
    Public Function Story()
		If Not Me.NewsId Then
			return New DataTable()
		Else
			return RC4.Pull("Select * from RCNews where PubDate <= '" & Today.Date.ToShortDateString & "' AND Id = " & Me.NewsId)
		End If
    End Function
    
    Public Function Categories() As DataTable
		return RC4.Pull("Select * from RCNewsCat order by seq, id")
    End Function
    
    Public Function Category() As DataTable
    	If  Me.CategoryId.ToString() Is Nothing Then
    		return New DataTable()
    	Else
			return RC4.Pull("Select * from RCNewsCat WHERE Id = " & Me.CategoryId & " order by seq, id")
		End If
    End Function
 
	'
	' PROPERTIES
	'
    Public Property ShowDescription As Boolean
        Get
            Return Me.Value(SHOW_DESCRIPTION)
        End Get
        Set(ByVal value As Boolean)
            Me.Value(SHOW_DESCRIPTION, value)
        End Set
    End Property

    Public Property TitleOnly As Boolean
        Get
            Return Me.Value(SHOW_TITLE_ONLY)
        End Get
        Set(ByVal value As Boolean)
            Me.Value(SHOW_TITLE_ONLY, value)
        End Set
    End Property
    
    Public Property NumberOfColumnsPerRow As Integer
        Get
            Return Me.Value(NUMBER_OF_COLUMNS_PER_ROW)
        End Get
        Set(ByVal value As Integer)
            Me.Value(NUMBER_OF_COLUMNS_PER_ROW, value)
        End Set
    End Property
    
    Public Property DescriptionWordLimit As Integer
        Get
            Return Me.Value(DESCRIPTION_WORD_LIMIT)
        End Get
        Set(ByVal value As Integer)
            Me.Value(DESCRIPTION_WORD_LIMIT, value)
        End Set
    End Property
    
    Public Property SelectTopNumber As Integer
        Get
            Return Me.Value(SELECT_TOP_NUMBER)
        End Get
        Set(ByVal value As Integer)
            Me.Value(SELECT_TOP_NUMBER, value)
        End Set
    End Property
    
    Public Property CategoryId As Integer
        Get
            Return Me.Value(CATEGORY_ID)
        End Get
        Set(ByVal value As Integer)
            Me.Value(CATEGORY_ID, value)
        End Set
    End Property
    
    Public Property NewsId As Integer
        Get
            Return Me.Value(NEWS_ID)
        End Get
        Set(ByVal value As Integer)
            Me.Value(NEWS_ID, value)
        End Set
    End Property
    
End Class 