Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing.Drawing2D
Imports System.Drawing
Imports System.IO


Public Module ControllerFactory
	Public  News = New NewsController()   
	Public  Bios = New BiosController()    
	Public  Faq = New FAQController()    
	Public  Contact = New ContactController()    
	Public  Links = New LinksController()    
	'Public  Products = New ProductsController()    
	Public  Reviews = New ReviewsController()    
	Public  Staff = New StaffController()    
	Public  Videos = New VideosController()    
	Public  ImageSlider = New ImageSliderController()    
End Module

