Imports System.Data
Imports System.Data.SqlClient

'/////////////////////////////////////////////////////////////////////////////////
'
' This  accepts a NameValueCollection or JSON. It filters out all 
' values that can't be associated with a column in the table. Then
' build the correct SQL statement based upon if the a ID value
' is set. If set then update if not then insert. Delete must explicitly
' be called.
'
'/////////////////////////////////////////////////////////////////////////////////
Public Class MSSQLBuilder

	Const _ID = "Id"
	
	Dim _operation
	Dim _table
	Dim _select = "*"
	Dim _joins
	Dim _order
	Dim _limit
	Dim _offset
	Dim _group
	Dim _having
	Dim _update
	Dim _where
	Dim _orderBy
	Dim _data
	
	Public SQL As String
	
	Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings.Item("rcon").ConnectionString)
    Dim cmd As SqlCommand
    	
	Public FormData = New Dictionary(Of String, Object)(StringComparer.OrdinalIgnoreCase)
	Public Table As MSSQLTable
	
	Sub New(TableName As String)
		Table = New MSSQLTable(TableName)
	End Sub
	
	Function Where(Str as String)
		_where = str
	End Function
	
	Function OrderBy(Str as String)
		_orderBy = str
	End Function
	
	Function BuildSelect()
	End Function
	
	Function BuildInsert()
    	
		Dim Cols As New ArrayList()
		Dim Values As New ArrayList()
		
		RemoveDataForKey(_ID)
		
		SQL = ""
		
		For Each Key in FormData.Keys
			' Filter out binary data for now because I can't figure out how to handle that type of data. It could be an image or file.
			If Table.ContainsColumn(Key) And Not Table.IsBinaryColumn(key) Then
				Cols.Add(key)
				Values.Add(FormData(Key))
			End If
		Next
		
		SQL = "INSERT INTO " & Table.Name & " ("
		
		Dim ListLength = Cols.Count
		Dim Counter = 1
		For Each obj In  Cols
			If ListLength > Counter Then
				SQL &= "[" & obj & "],"
			Else
				SQL &= "[" & obj & "]"
			End IF
			Counter += 1
		Next
		
		SQL &= ") VALUES("
		
		ListLength = Values.Count
		Counter = 1
		For Each obj In  Cols
			If ListLength > Counter Then
				SQL &= "@" & obj & ","
			Else
				SQL &= "@" & obj
			End IF
			Counter += 1
		Next
		
		SQL &= ") Select Scope_Identity()"
		
		cmd = New SqlCommand(SQL, con)
		
		Counter = 0
		For Each obj In  Values
			cmd.Parameters.AddWithValue(Cols(Counter), obj)
			Counter += 1
		Next
		
		Return True
		
	End Function
	
	Protected Function BuildUpdate()
		
		Dim Cols As New ArrayList()
		Dim Values As New ArrayList()
		Dim Id = FormData(_ID)
		
		RemoveDataForKey(_ID)
		
		SQL = ""
		
		For Each Key in FormData.Keys
			' Filter out binary data for now because I can't figure out how to handle that type of data. It could be an image or file.
			If Table.ContainsColumn(Key) And Not Table.IsBinaryColumn(key) Then
				Cols.Add(key.ToLower())
				Values.Add(FormData(Key))
			End If
		Next
		
		SQL = "UPDATE " & Table.Name & " SET "
		
		Dim ListLength = Cols.Count
		Dim Counter = 1
		For Each obj In  Cols
			If ListLength > Counter Then
				SQL &= "[" & obj & "]=@" & obj & ","
			Else
				SQL &= "[" & obj & "]=@" & obj
			End IF
			Counter += 1
		Next
		
		SQL &= " WHERE Id = " & Id
		
		cmd = New SqlCommand(SQL, con)
		
		Counter = 0
		For Each obj In  Values
			cmd.Parameters.AddWithValue(Cols(Counter), obj)
			Counter += 1
		Next
		
		Return True
		
	End Function
	
	Protected Function BuildDelete()
		cmd = New SqlCommand("DELETE FROM " & Table.Name & " WHERE ID = @Id", con)
		cmd.Parameters.AddWithValue(_ID, FormData(_ID))
		Return true
	End Function
	
	Function Save()
		If FormData.containsKey(_ID) AndAlso NOT String.IsNullOrEmpty(FormData(_ID)) Then
			Dim Id = FormData(_ID)
			If BuildUpdate() Then
				con.Open()
				cmd.ExecuteScalar
				con.Close()
				Return Id
			End If
		Else
			If BuildInsert() Then
				con.Open()
				Dim result As Integer = cmd.ExecuteScalar
				con.Close()
				Return result
			End If
		End If
	End Function
	
	Function Delete()
		If FormData.containsKey(_ID) Then
			Dim Id = FormData(_ID)
			If BuildDelete() Then
				con.Open()
				Dim result As Integer = cmd.ExecuteScalar
				con.Close()
				Return Id
			End If
		End If
	End Function
	
	Function SelectAll()
		Dim strSQL = "SELECT * FROM " & Table.Name
		If Not _where Is Nothing Then
			strSQL += " WHERE " + _where
		End If
		If Not _orderBy Is Nothing Then
			strSQL += " ORDER BY " + _orderBy
		End If
		return RC4.Pull(strSQL)
	End Function
	
	Shared Function Query(str)
		return RC4.Pull(str)
	End Function
	
	Function SelectAllForId(Id as String)
		If Not Id Is Nothing Then
			return RC4.Pull("SELECT * FROM " & Table.Name & " WHERE Id = " & Id)
		Else
			Return Table.CreateEmptyTable()
		End If
	End Function
	
	Function Reset()
		FormData.Clear()
	End Function
	
	Function SetValueFor(Column As String, Value As Object)
		If FormData.containsKey(column.ToLower()) Then
			FormData(column.ToLower()) = value
		Else
			FormData.Add(column.ToLower(), value)
		End If
	End Function
	
	Function ParseJSON(str As String)
		Dim data = json_decode(str)
		For Each Key as String in data.Keys
    		FormData.Add(Key.ToLower(), data(Key) )
    	Next
	End Function
	
	Function ParseHttpRequest(data As System.Collections.Specialized.NameValueCollection)
    	For Each Key as String in data.AllKeys
    		FormData.Add(Key.ToLower(), data(Key) )
    	Next
	End Function
	
	Function RemoveDataForKey(Key As String)
		If FormData.ContainsKey(Key.ToLower()) Then
			FormData.Remove(Key.ToLower())
		End If
	End Function
	
	Function SaveToString()
		If FormData.containsKey(_ID) AndAlso NOT String.IsNullOrEmpty(FormData(_ID)) Then
			Dim Id = FormData(_ID)
			BuildUpdate()
		Else
			BuildInsert()
		End If
		Return SQL
	End Function
	
End Class

'/////////////////////////////////////////////////////////////////////////////////
'
' This holds all the columns inf for a MSSQL table
'
'/////////////////////////////////////////////////////////////////////////////////
Public Class MSSQLTable 
	
	Public Columns As Dictionary(Of String, Object)
	Public Name As String
	
	Sub New(Name As String)
		ME.Name = Name
		Columns = New  Dictionary(Of String, Object)
		Dim data As DataTable = RC4.Pull("SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" & Name & "'")
		For Each row As DataRow In data.Rows
			Me.Columns.Add(row("COLUMN_NAME").ToLower(),  New MSSQLTableColumn(row))
		Next
	End Sub

	Function ContainsColumn(Name As String)
		return Columns.ContainsKey(name)
	End Function
	
	Function IsBinaryColumn(Key As String)
		If Columns.ContainsKey(Key) Then
			return Columns(Key).IsDataTypeBinary()
		Else
			return false
		End If
	End Function
	
	Function CreateEmptyTable()
		Dim EmptyTable =  New DataTable()
		For Each Key As String In Columns.Keys
			Dim Column = New DataColumn()
			Column.DataType = System.Type.GetType(Columns(Key).SystemDataType())
			Column.ColumnName = Key
			EmptyTable.Columns.Add(Column)
		Next
		Dim EmptyRow = EmptyTable.NewRow()
		EmptyTable.Rows.InsertAt(EmptyRow, 0)
		Return EmptyTable
	End Function

End Class

'/////////////////////////////////////////////////////////////////////////////////
'
' This holds all the info for a MSSQL table column
'
'/////////////////////////////////////////////////////////////////////////////////
Public Class MSSQLTableColumn

	Const _STRING = 1
	Const _INTEGER = 2
	Const _DECIMAL = 3
	Const _DATETIME = 4
	Const _DATE = 5
	Const _TIME = 6
	Const _BINARY = 7
	Const _BITE = 7
	
	Shared TYPE_MAPPING = new Dictionary(Of String, Integer) From _
		{ _
			{ "datetime", _DATETIME }, _
			{ "timestamp", _DATETIME }, _
			{ "date", _DATETIME }, _
			{ "time", _DATETIME }, _
			{ "tinyint", _INTEGER }, _
			{ "smallint", _INTEGER }, _
			{ "mediumint", _INTEGER }, _
			{ "int", _INTEGER }, _
			{ "bigint", _INTEGER }, _
			{ "boolean", _INTEGER }, _
			{ "float", _DECIMAL }, _
			{ "money", _DECIMAL }, _
			{ "double", _DECIMAL }, _
			{ "numeric", _DECIMAL }, _
			{ "decimal", _DECIMAL }, _
			{ "dec", _DECIMAL }, _
			{ "varchar", _STRING }, _
			{ "nvarchar", _STRING }, _
			{ "image", _BINARY }, _
			{ "varbinary", _BINARY }, _
			{ "binary", _BINARY } _
		}
		
		Shared SYSTEM_TYPE_MAPPING = new Dictionary(Of String, String) From _
		{ _
			{ "datetime", "System.DateTime"  }, _
			{ "timestamp", "System.DateTime"  }, _
			{ "date", "System.DateTime"  }, _
			{ "time", "System.DateTime" }, _
			{ "tinyint", "System.Int32" }, _
			{ "smallint", "System.Int32" }, _
			{ "mediumint", "System.Int32" }, _
			{ "int",  "System.Int32" }, _
			{ "bigint",  "System.Int32" }, _
			{ "boolean",  "System.Int32" }, _
			{ "float",  "System.Decimal" }, _
			{ "money",  "System.Decimal" }, _
			{ "double", "System.Decimal"  }, _
			{ "numeric", "System.Int32" }, _
			{ "decimal", "System.Decimal"  }, _
			{ "dec", "System.Decimal"  }, _
			{ "varchar", "System.String" }, _
			{ "image", "System.Byte"  }, _
			{ "varbinary", "System.Byte" }, _
			{ "binary", "System.Byte"  }, _
			{ "bit", "System.Byte"  } _
		}

	Private data As DataRow
	
	Sub New(row As DataRow)
		data = row
	End Sub
	
	Function IsData()
	End Function
	
	Function Format(Value As String) 
		If Value Is Nothing Then
			return Nothing
		Else
			If TYPE_MAPPING.ContainsKey(DataType()) Then
				Select Case TYPE_MAPPING(DataType())
					Case _STRING, _DATETIME, _TIME, _DATE
						return "'" & Value & "'"
					Case Else
						return Value
				End Select
			Else	
				return Value
			End If
		End If
	End Function
	
	Private Function GetProperty(name As String)
		return data(name)
	End Function
	
	Function IsDataTypeBinary()
		return false 'TYPE_MAPPING(DataType()) = _BINARY
	End FUnction
	
	Function TableName()
		return GetProperty("TABLE_NAME")
	End Function
	
	Function Name()
		return GetProperty("COLUMN_NAME")
	End Function
	
	Function DefaultValue()
		return Nothing
	End Function
	
	Function DataType()
		return GetProperty("DATA_TYPE")
	End Function
	
	Function SystemDataType()
		return SYSTEM_TYPE_MAPPING(GetProperty("DATA_TYPE"))
	End Function
	
	Function IsNullable()
		return GetProperty("IS_NULLABLE")
	End Function
	
	Function IsRequired()
		return IsNullable() = "NO"
	End Function
	
	Function CharMaxLength()
		return GetProperty("CHARACTER_MAXIMUM_LENGTH")
	End Function
	
	Function OrdinalPosition()
		return GetProperty("ORDINAL_POSITION")
	End Function
	
End Class
