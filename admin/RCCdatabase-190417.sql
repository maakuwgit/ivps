-- Database export via SQLPro (https://www.sqlprostudio.com/allapps.html)]
-- Exported by mike.m at 17-04-2019 07:18.
-- WARNING: This file may contain descructive statements such as DROPs.
-- Please ensure that you are running the script at the proper location.

USE [NewProductsModule]

-- BEGIN TABLE dbo.mnuInclude
CREATE TABLE dbo.mnuInclude (
	id int NOT NULL IDENTITY(1,1),
	items varchar(max) NULL
);
GO

-- Table dbo.mnuInclude contains no data. No inserts have been generated.
-- Inserting 0 rows into dbo.mnuInclude


-- END TABLE dbo.mnuInclude

-- BEGIN TABLE dbo.mnuItem
CREATE TABLE dbo.mnuItem (
	id int NOT NULL IDENTITY(1,1),
	description varchar(max) NULL,
	name varchar(max) NULL,
	item_category_id int NULL,
	img varbinary(max) NULL
);
GO

-- Table dbo.mnuItem contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.mnuItem


-- END TABLE dbo.mnuItem

-- BEGIN TABLE dbo.mnuItemCategory
CREATE TABLE dbo.mnuItemCategory (
	id int NOT NULL IDENTITY(1,1),
	name varchar(max) NULL
);
GO

-- Table dbo.mnuItemCategory contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.mnuItemCategory


-- END TABLE dbo.mnuItemCategory

-- BEGIN TABLE dbo.mnuItemSize
CREATE TABLE dbo.mnuItemSize (
	id int NOT NULL IDENTITY(1,1),
	name varchar(500) NULL
);
GO

-- Table dbo.mnuItemSize contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.mnuItemSize


-- END TABLE dbo.mnuItemSize

-- BEGIN TABLE dbo.mnuMenu
CREATE TABLE dbo.mnuMenu (
	id int NOT NULL IDENTITY(1,1),
	name varchar(500) NULL,
	description varchar(max) NULL,
	order_online_url varchar(500) NULL,
	published int NULL DEFAULT ((1))
);
GO

-- Table dbo.mnuMenu contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.mnuMenu


-- END TABLE dbo.mnuMenu

-- BEGIN TABLE dbo.mnuMenuSection
CREATE TABLE dbo.mnuMenuSection (
	id int NOT NULL IDENTITY(1,1),
	menu_id int NOT NULL,
	section_id int NOT NULL,
	description varchar(max) NULL,
	order_online_url varchar(500) NULL,
	published int NULL DEFAULT ((1))
);
GO

-- Table dbo.mnuMenuSection contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.mnuMenuSection


-- END TABLE dbo.mnuMenuSection

-- BEGIN TABLE dbo.mnuMenuSectionItem
CREATE TABLE dbo.mnuMenuSectionItem (
	id int NOT NULL IDENTITY(1,1),
	menu_section_id int NOT NULL,
	section_item_number varchar(25) NULL,
	item_id int NOT NULL,
	size_id int NULL,
	include_id int NULL,
	price decimal(19,4) NULL DEFAULT ((0.00)),
	description varchar(max) NULL,
	published int NULL DEFAULT ((1)),
	order_online_url varchar(500) NULL
);
GO

-- Table dbo.mnuMenuSectionItem contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.mnuMenuSectionItem


-- END TABLE dbo.mnuMenuSectionItem

-- BEGIN TABLE dbo.mnuMenuSectionItemSizePrice
CREATE TABLE dbo.mnuMenuSectionItemSizePrice (
	id int NOT NULL IDENTITY(1,1),
	section_item_id int NOT NULL,
	size_id int NULL,
	price decimal(19,4) NULL DEFAULT ((0.00)),
	order_online_url varchar(500) NULL
);
GO

-- Table dbo.mnuMenuSectionItemSizePrice contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.mnuMenuSectionItemSizePrice


-- END TABLE dbo.mnuMenuSectionItemSizePrice

-- BEGIN TABLE dbo.mnuSection
CREATE TABLE dbo.mnuSection (
	id int NOT NULL IDENTITY(1,1),
	code varchar(25) NULL,
	name varchar(500) NULL,
	description varchar(max) NULL
);
GO

-- Table dbo.mnuSection contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.mnuSection


-- END TABLE dbo.mnuSection

-- BEGIN TABLE dbo.RCBio
CREATE TABLE dbo.RCBio (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(100) NULL,
	Title varchar(100) NULL,
	Description varchar(1024) NULL,
	Seq int NULL,
	FSLoc varchar(1024) NULL,
	Email varchar(100) NULL,
	Phone varchar(20) NULL,
	Phone2 varchar(20) NULL,
	Category varchar(100) NULL
);
GO

ALTER TABLE dbo.RCBio ADD CONSTRAINT PK_RCBio PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCBio

-- BEGIN TABLE dbo.RCCalendar
CREATE TABLE dbo.RCCalendar (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(50) NULL,
	Description varchar(1024) NULL,
	OwnerId int NULL,
	minAccess int NULL
);
GO

ALTER TABLE dbo.RCCalendar ADD CONSTRAINT PK_RCCalendar PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCCalendar

-- BEGIN TABLE dbo.RCCalendarEvent
CREATE TABLE dbo.RCCalendarEvent (
	Id int NOT NULL IDENTITY(1,1),
	EventID int NULL,
	CalendarID int NULL
);
GO

ALTER TABLE dbo.RCCalendarEvent ADD CONSTRAINT PK_RCCalendarEvent PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCCalendarEvent

-- BEGIN TABLE dbo.RCCalendarUser
CREATE TABLE dbo.RCCalendarUser (
	Id int NOT NULL IDENTITY(1,1),
	UserId int NULL,
	CalendarId int NULL
);
GO

ALTER TABLE dbo.RCCalendarUser ADD CONSTRAINT PK_RCCalendarUser PRIMARY KEY (Id);
GO

-- Table dbo.RCCalendarUser contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.RCCalendarUser


-- END TABLE dbo.RCCalendarUser

-- BEGIN TABLE dbo.RCContent
CREATE TABLE dbo.RCContent (
	Id int NOT NULL IDENTITY(1,1),
	Title varchar(255) NULL,
	Name varchar(255) NULL,
	Value varchar(max) NULL,
	DateEntered datetime NULL DEFAULT (getdate()),
	DateModified datetime NULL DEFAULT (getdate()),
	LastModifiedBy int NULL,
	PageId int NULL
);
GO

ALTER TABLE dbo.RCContent ADD CONSTRAINT PK_RCContent PRIMARY KEY (Id);
GO

-- Inserting 14 rows into dbo.RCContent
-- Insert batch #1
SET IDENTITY_INSERT dbo.RCContent ON
INSERT INTO dbo.RCContent (Id, Name, Value, DateEntered, DateModified, LastModifiedBy, PageId) VALUES
(1, 'Thank You', 'Thank You', 'We appreciate your request and we be contacting you shortly', '2019-03-12 15:52:46', '2019-03-12 15:52:46', NULL, NULL),
(2, 'Reviews Thank You', 'Reviews Thank You', 'We appreciate your feedback.', '2019-03-12 15:52:46', '2019-03-12 15:52:46', NULL, NULL),
(3, 'Home', 'Home', 'We appreciate your feedback.', '2019-03-12 15:52:46', '2019-03-12 15:52:46', NULL, 1),
(4, 'Privacy Policy', 'Privacy Policy', '<p>This privacy notice discloses the privacy practices for {Site Url}. This privacy notice applies solely to information collected by this website. It will notify you of the following:</p><ol><li>What personally identifiable information is collected from you through the website, how it is used and with whom it may be shared.</li><li>What choices are available to you regarding the use of your data.</li><li>How you can correct any inaccuracies in the information.</li></ol><h3>Information Collection, Use, and Sharing</h3><p>{Company Name} is the sole owner of the information collected on this site. We only have access to/collect information that you voluntarily give us via email or other direct contact from you. We will not sell or rent this information to anyone.</p><p>We will use your information to respond to you, regarding the reason you contacted us. We will not share your information with any third party outside of our organization, other than as necessary to fulfill your request, e.g. to ship an order.</p><p>Unless you ask us not to, we may contact you via email in the future to tell you about specials, new products or services, or changes to this privacy policy.</p><h3>Your Access to and Control Over Information</h3><p>You may opt out of any future contacts from us at any time. You can do the following at any time by contacting us via the email address or phone number given on our website:</p><ul><li>See what data we have about you, if any.</li><li>Change/correct any data we have about you.</li><li>Have us delete any data we have about you.</li><li>Express any concern you have about our use of your data.</li></ul>', '2019-03-12 15:52:46', '2019-03-20 09:12:04', NULL, 2),
(5, 'Terms & Conditions', 'Terms & Conditions', '<p>Please note that this website is provided "as is" and should be accessed and used by you at your own risk. Although reasonable efforts are used to ensure that the website will be current and will contain no errors or inaccuracies, no representations, warranties, guarantees or conditions (whether express or implied) are given as to the operation of this website or that this website and the information, content or materials included in this website will be error free or completely accurate or current at all times, or at any time.</p><p>All content, including without limitation, all text, design, graphics, drawings, photographs, code and software, and all organization and presentation of such content, which forms a part of this website, are subject to intellectual property rights, including copyright and trade-marks held by or licensed to {Company Name}. All such rights are expressly reserved.</p><p>You are permitted to copy electronically and print hard copies of pages from this website for your own non-commercial and lawful use, provided that such copies clearly display the copyright and any other proprietary notices of {Company Name}. No other copying of this website, in whole or in part, is permitted without the express written authorization of {Company Name}.</p><p>"{Company Name}", &nbsp;and certain other names, words, logos, slogans and images used on this website are the property of and are subject to trade-mark rights held by {Company Name}. Certain other trade-marks, trade names, words, logos, slogans and images listed on this website are the property of their respective owners. Use of any such property, except as expressly authorized, shall constitute a violation of the rights of the owner of the property. This website may contain links to other websites. All such other websites are independent from this website and from {Company Name}. {Company Name} has no control over and expressly disclaims any liability for such websites or their contents. The provision of any link does not constitute an endorsement of such linked website by {Company Name}.</p><p>{Company Name} and its directors, employees, agents, representatives, successors and assigns shall not be liable for any damages whatsoever arising out or related to access to or use of this website or any other website linked to this website, whether or not such damages might be foreseeable and even if {Company Name} is informed of their possibility, including without limitations liability for direct, indirect, special, punitive, incidental or consequential damages (including lost profits, lost savings, business interruption or loss of data).</p><p>The Terms and Conditions related to the use of this Website, together with the Website Privacy Policy, constitute the entire agreement between {Company Name} and you pertaining to the subject matter hereof, and supersede any and all written and oral agreements previously existing between us with respect to such subject matter.</p>', '2019-03-12 15:52:46', '2019-03-20 09:11:57', NULL, 3);
SET IDENTITY_INSERT dbo.RCContent OFF
-- END TABLE dbo.RCContent

-- BEGIN TABLE dbo.RCDoc
CREATE TABLE dbo.RCDoc (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(100) NULL,
	FileName varchar(1024) NULL,
	Description varchar(1024) NULL,
	CatId int NULL,
	Seq int NULL,
	FileData varbinary(max) NULL
);
GO

ALTER TABLE dbo.RCDoc ADD CONSTRAINT PK_RCDoc PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCDoc

-- BEGIN TABLE dbo.RCDocCat
CREATE TABLE dbo.RCDocCat (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(100) NULL,
	Seq int NULL,
	bPublic bit NULL,
	ParentId int NULL
);
GO

ALTER TABLE dbo.RCDocCat ADD CONSTRAINT PK_RCDocCat PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCDocCat

-- BEGIN TABLE dbo.RCDocSecurity
CREATE TABLE dbo.RCDocSecurity (
	Id int NOT NULL IDENTITY(1,1),
	CatId int NULL,
	UserId int NULL
);
GO

ALTER TABLE dbo.RCDocSecurity ADD CONSTRAINT PK_RCDocSecurity PRIMARY KEY (Id);
GO

-- Table dbo.RCDocSecurity contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.RCDocSecurity


-- END TABLE dbo.RCDocSecurity

-- BEGIN TABLE dbo.RCEvent
CREATE TABLE dbo.RCEvent (
	Id int NOT NULL IDENTITY(1,1),
	Title varchar(100) NULL,
	StartDt datetime NULL,
	EndDt datetime NULL,
	Owner int NULL,
	[Desc] varchar(2048) NULL,
	Location varchar(100) NULL,
	Paypal varchar(2048) NULL
);
GO

ALTER TABLE dbo.RCEvent ADD CONSTRAINT PK_RCEvent PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCEvent

-- BEGIN TABLE dbo.RCFaq
CREATE TABLE dbo.RCFaq (
	Id int NOT NULL IDENTITY(1,1),
	Question nvarchar(max) NULL,
	Answer nvarchar(max) NULL,
	seq int NULL,
	CatId int NULL DEFAULT ((0)),
	Slug varchar(500) NULL
);
GO

-- Table dbo.RCFaq contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.RCFaq


-- END TABLE dbo.RCFaq

-- BEGIN TABLE dbo.RCFaqCat
CREATE TABLE dbo.RCFaqCat (
	Id int NOT NULL IDENTITY(1,1),
	Name nvarchar(50) NULL,
	Seq int NULL
);
GO

-- Table dbo.RCFaqCat contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.RCFaqCat


-- END TABLE dbo.RCFaqCat

-- BEGIN TABLE dbo.RCGallery
CREATE TABLE dbo.RCGallery (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(50) NULL,
	Description varchar(1024) NULL,
	isFeatured bit NULL DEFAULT ((0)),
	flagShowThumb bit NULL DEFAULT ((0)),
	oldCatId int NULL,
	CatId int NULL,
	Seq int NULL,
	Slug varchar(500) NULL
);
GO

ALTER TABLE dbo.RCGallery ADD CONSTRAINT PK_RCGallery2 PRIMARY KEY (Id);
GO


-- END TABLE dbo.RCGallery

-- BEGIN TABLE dbo.RCGalleryCat
CREATE TABLE dbo.RCGalleryCat (
	Id int NOT NULL IDENTITY(1,1),
	Name nvarchar(50) NULL,
	Seq int NULL
);
GO

ALTER TABLE dbo.RCGalleryCat ADD CONSTRAINT PK_RCGallery2Cat PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCGalleryCat

-- BEGIN TABLE dbo.RCGalleryImage
CREATE TABLE dbo.RCGalleryImage (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(128) NULL,
	Description varchar(1024) NULL,
	Alt varchar(128) NULL,
	Data image NULL,
	ContentType varchar(10) NULL,
	DateModified datetime NULL,
	GalleryId int NULL,
	DateDeleted datetime NULL,
	isDeleted varchar(1) NULL DEFAULT ('N'),
	Seq int NULL
);
GO

ALTER TABLE dbo.RCGalleryImage ADD CONSTRAINT PK_RCGallery2Image PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCGalleryImage

-- BEGIN TABLE dbo.RCGeneric
CREATE TABLE dbo.RCGeneric (
	Id int NOT NULL IDENTITY(1,1),
	Title nvarchar(256) NULL,
	Description nvarchar(1024) NULL,
	Contents varchar(max) NULL,
	Seq int NULL,
	Img image NULL,
	Guid uniqueidentifier NULL DEFAULT (newid()),
	CatId int NULL,
	AttachmentName nchar(255) NULL,
	Attachment varbinary(max) NULL,
	Link varchar(max) NULL,
	Slug varchar(500) NULL
);
GO

ALTER TABLE dbo.RCGeneric ADD CONSTRAINT PK_RCGeneric PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCGeneric

-- BEGIN TABLE dbo.RCGenericCat
CREATE TABLE dbo.RCGenericCat (
	Id int NOT NULL IDENTITY(1,1),
	Name nvarchar(50) NULL,
	Seq int NULL
);
GO

ALTER TABLE dbo.RCGenericCat ADD CONSTRAINT PK_RCGenericCat PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCGenericCat

-- BEGIN TABLE dbo.RCLink
CREATE TABLE dbo.RCLink (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(100) NULL,
	Description varchar(2048) NULL,
	Link varchar(max) NULL,
	[Image] varbinary(max) NULL,
	CatId int NULL DEFAULT ((1)),
	Slug varchar(500) NULL
);
GO

ALTER TABLE dbo.RCLink ADD CONSTRAINT PK_RCLinks PRIMARY KEY (Id);
GO

-- Table dbo.RCLink contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.RCLink


-- END TABLE dbo.RCLink

-- BEGIN TABLE dbo.RCLinkCat
CREATE TABLE dbo.RCLinkCat (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(50) NULL,
	[Image] varbinary(max) NULL,
	Seq int NULL DEFAULT ((1))
);
GO

-- END TABLE dbo.RCLinkCat

-- BEGIN TABLE dbo.RCNews
CREATE TABLE dbo.RCNews (
	Id int NOT NULL IDENTITY(1,1),
	Title nvarchar(256) NULL,
	Description nvarchar(1024) NULL,
	Contents varchar(max) NULL,
	PubDate datetime NULL,
	Img image NULL,
	Guid uniqueidentifier NULL DEFAULT (newid()),
	CatId int NULL DEFAULT ((1)),
	Slug nvarchar(255) NULL,
	Seq int NULL,
	Cornerstone int NULL DEFAULT ((0)),
	Featured int NULL DEFAULT ((0))
);
GO

ALTER TABLE dbo.RCNews ADD CONSTRAINT PK_RCNews PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCNews

-- BEGIN TABLE dbo.RCNewsCat
CREATE TABLE dbo.RCNewsCat (
	Id int NOT NULL IDENTITY(1,1),
	Name nvarchar(50) NULL,
	Seq int NULL,
	Slug varchar(500) NULL DEFAULT (NULL)
);
GO

ALTER TABLE dbo.RCNewsCat ADD CONSTRAINT PK_RCNewsCat PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCNewsCat

-- BEGIN TABLE dbo.RCProduct
CREATE TABLE dbo.RCProduct (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(100) NULL,
	Description varchar(max) NULL,
	Attachment varbinary(max) NULL,
	Img image NULL,
	AttachmentName nvarchar(255) NULL,
	CatId int NULL,
	Seq int NULL,
	Data image NULL,
	ImgURL varchar(1024) NULL,
	fId varchar(100) NULL,
	Published int NULL DEFAULT (0),
	Featured int NULL DEFAULT (0),
	DataType varchar(255) NULL,
	Price decimal(19,2) NULL DEFAULT (0)
);
GO

ALTER TABLE dbo.RCProduct ADD CONSTRAINT PK_RCProduct PRIMARY KEY (Id);
GO

-- BEGIN TABLE dbo.WMAMarkers
CREATE TABLE dbo.WMAMarkers (
	id int NOT NULL IDENTITY(1,1),
	name varchar(60) NOT NULL,
	address varchar(80) NOT NULL,
	lat decimal(10,6) NOT NULL,
	lng decimal(10,6) NOT NULL,
	city varchar(80) NOT NULL,
	state varchar(2) NOT NULL,
	zip int NOT NULL,
	phone bigint NULL DEFAULT ('NULL')
);
GO

ALTER TABLE dbo.WMAMarkers ADD CONSTRAINT PK_WMAMarkers PRIMARY KEY (id);
GO
-- BEGIN TABLE dbo.WMAMarkers

-- END TABLE dbo.RCProduct

-- BEGIN TABLE dbo.RCProductCat
CREATE TABLE dbo.RCProductCat (
	Id int NOT NULL IDENTITY(1,1),
	ParentId int NULL,
	Description varchar(1024) NULL,
	Seq int NULL,
	Name nvarchar(50) NULL
);
GO

ALTER TABLE dbo.RCProductCat ADD CONSTRAINT PK_RCProductCat PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCProductCat

-- BEGIN TABLE dbo.RCPromo
CREATE TABLE dbo.RCPromo (
	Id int NOT NULL IDENTITY(1,1),
	StartDt datetime NULL,
	EndDt datetime NULL,
	Name varchar(500) NULL,
	[Desc] varchar(max) NULL,
	Featured int NULL
);
GO

ALTER TABLE dbo.RCPromo ADD CONSTRAINT PK_RCPromo PRIMARY KEY (Id);
GO

-- END TABLE dbo.RCPromo

-- BEGIN TABLE dbo.RCSeo
CREATE TABLE dbo.RCSeo (
	Id int NOT NULL IDENTITY(1,1),
	Seq int NULL,
	Page varchar(1024) NULL,
	Title varchar(1024) NULL,
	[Desc] varchar(1024) NULL,
	Keywords varchar(1024) NULL,
	flagSitemap varchar(1) NULL,
	StructuredData varchar(max) NULL
);
GO

-- END TABLE dbo.RCSeo

-- BEGIN TABLE dbo.RCString
CREATE TABLE dbo.RCString (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(50) NULL,
	Value varchar(1024) NULL,
	CatId int NOT NULL
);
GO

ALTER TABLE dbo.RCString ADD CONSTRAINT PK_RCString PRIMARY KEY (Id);
GO

-- Inserting 38 rows into dbo.RCString
-- Insert batch #1
SET IDENTITY_INSERT dbo.RCString ON
INSERT INTO dbo.RCString (Id, Name, Value, CatId) VALUES
(1, 'Address', '', 3),
(2, 'City-State-Zip', '', 3),
(3, 'Host', 'mail.real-fast.com', 4),
(4, 'SMTPAccount', 'test@real-fast.com', 4),
(5, 'SMTPPassword', 'real76005fast', 4),
(6, 'SMTP_Auth_Enabled', 'True', 4),
(7, 'Phone', '248-601-0606', 3),
(8, 'Staff Bios', 'False', 1),
(9, 'Content', 'True', 1),
(10, 'Docs', 'False', 1),
(11, 'Eblast', 'False', 1),
(12, 'Events', 'False', 1),
(13, 'Gallery', 'False', 1),
(14, 'Users', 'True', 1),
(15, 'Videos', 'False', 1),
(16, 'Testimonials', 'False', 1),
(17, 'SEO', 'True', 1),
(18, 'News', 'True', 1),
(19, 'Promo', 'False', 1),
(20, 'Large', '1024', 5),
(21, 'Medium', '755', 5),
(22, 'Small', '400', 5),
(23, 'Thumb', '160', 5),
(24, 'Products', 'False', 1),
(25, 'MaxTestimonialLength', '128', 6),
(26, 'GenContact', 'mike.m@rccwebmedia.com', 2),
(27, 'QuickContact', 'mike.m@rccwebmedia.com', 2),
(28, 'Copyright', '&copy; {Today.Year} {Company Name}', 3),
(29, 'Slider Folder Path', '/images/slider/', 6),
(30, 'Company Name', '', 3),
(31, 'Site Url', '', 3),
(32, 'Fax', '', 3),
(33, 'Slider', 'True', 1),
(34, 'Survey', 'False', 1),
(35, 'Links', 'False', 1),
(36, 'City', '', 3),
(37, 'geocode_api_key', 'AIzaSyBct8s5oh2-0SeamTZ1fIROLbiSrmJnA38', 6),
(38, 'map_api_key', 'AIzaSyCqYwczA6YKqiPxphJylgdthyp3uhnNPCw', 6);
SET IDENTITY_INSERT dbo.RCString OFF

-- END TABLE dbo.RCString

-- BEGIN TABLE dbo.RCStringCat
CREATE TABLE dbo.RCStringCat (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(50) NULL
);
GO

ALTER TABLE dbo.RCStringCat ADD CONSTRAINT PK_RCStringCat PRIMARY KEY (Id);
GO

-- Inserting 6 rows into dbo.RCStringCat
-- Insert batch #1
SET IDENTITY_INSERT dbo.RCStringCat ON
INSERT INTO dbo.RCStringCat (Id, Name) VALUES
(1, 'Config Flags'),
(2, 'Email Recipients'),
(3, 'Site Info'),
(4, 'SMTP Auth'),
(5, 'Image Settings'),
(6, 'Misc Settings');
SET IDENTITY_INSERT dbo.RCStringCat OFF

-- END TABLE dbo.RCStringCat

-- BEGIN TABLE dbo.RCTestimonials
CREATE TABLE dbo.RCTestimonials (
	id int NOT NULL IDENTITY(1,1),
	dateCreated datetime NULL,
	firstName nvarchar(50) NULL,
	lastName nvarchar(50) NULL,
	email nvarchar(50) NULL,
	company nvarchar(50) NULL,
	position nvarchar(50) NULL,
	city nvarchar(50) NULL,
	state nvarchar(50) NULL,
	country nvarchar(50) NULL,
	quote nvarchar(max) NULL,
	isApproved bit NULL,
	ip nvarchar(24) NULL,
	RatingValue int NULL
);
GO

-- END TABLE dbo.RCTestimonials

-- BEGIN TABLE dbo.RCVideo
CREATE TABLE dbo.RCVideo (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(64) NULL,
	Description varchar(1024) NULL,
	Code varchar(1024) NULL,
	Seq int NULL,
	CatId int NULL,
	isFeatured bit NULL DEFAULT ((0)),
	Slug varchar(500) NULL
);
GO

ALTER TABLE dbo.RCVideo ADD CONSTRAINT PK_RCVideo PRIMARY KEY (Id);
GO

-- Table dbo.RCVideo contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.RCVideo


-- END TABLE dbo.RCVideo

-- BEGIN TABLE dbo.RCVideoCat
CREATE TABLE dbo.RCVideoCat (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(100) NULL,
	Seq int NULL,
	Description varchar(5000) NULL
);
GO

ALTER TABLE dbo.RCVideoCat ADD CONSTRAINT PK_RCVideoCat PRIMARY KEY (Id);
GO

-- Table dbo.RCVideoCat contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.RCVideoCat


-- END TABLE dbo.RCVideoCat

-- BEGIN TABLE dbo.Users
CREATE TABLE dbo.Users (
	Id int NOT NULL IDENTITY(1,1),
	access int NOT NULL,
	lastAccessed datetime NULL,
	dateCreated datetime NULL,
	firstName nvarchar(50) NULL,
	lastName nvarchar(50) NULL,
	address1 nvarchar(50) NULL,
	address2 nvarchar(50) NULL,
	city nvarchar(50) NULL,
	state nvarchar(50) NULL,
	zip nvarchar(50) NULL,
	country nvarchar(50) NULL,
	phone nvarchar(50) NULL,
	fax nvarchar(50) NULL,
	mobile nvarchar(50) NULL,
	email nvarchar(50) NULL,
	password nvarchar(50) NULL,
	ip nvarchar(50) NULL,
	notes ntext NULL,
	isMailingList bit NULL DEFAULT ((1)),
	UserGroup varchar(50) NULL
);
GO

ALTER TABLE dbo.Users ADD CONSTRAINT PK__Users__3D5E1FD2 PRIMARY KEY (Id);
GO

-- Inserting 1 row into dbo.Users
-- Insert batch #1
SET IDENTITY_INSERT dbo.Users ON
INSERT INTO dbo.Users (Id, access, lastAccessed, dateCreated, firstName, lastName, address1, address2, city, state, zip, country, phone, fax, mobile, email, password, ip, notes, isMailingList, UserGroup) VALUES
(1, 11, '2013-01-01 00:00:00', '2013-01-01 00:00:00', 'RCC', '', '', '', '', '', '', '', '', '', '', 'rcc@romeocomp.com', 'wma$#@!2', '', '', 0, '');
SET IDENTITY_INSERT dbo.Users OFF
-- END TABLE dbo.Users

-- BEGIN TABLE dbo.WMAImages
CREATE TABLE dbo.WMAImages (
	id int NOT NULL IDENTITY(1,1),
	name varchar(255) NULL,
	filename varchar(255) NULL,
	src varchar(500) NULL,
	properties varchar(max) NULL
);
GO

-- Inserting 5 rows into dbo.WMAImages
-- Insert batch #1
SET IDENTITY_INSERT dbo.WMAImages ON
INSERT INTO dbo.WMAImages (id, name, filename, src, properties) VALUES
(1, 'Logo', 'logo.jpg', '/images/logo.jpg', '{"alt":"","title":"","target":"","rel":"","class":"","style":""}')
SET IDENTITY_INSERT dbo.WMAImages OFF

-- END TABLE dbo.WMAImages

-- BEGIN TABLE dbo.WMALabel
CREATE TABLE dbo.WMALabel (
	Id int NOT NULL IDENTITY(1,1),
	Label varchar(500) NULL,
	Location varchar(500) NULL
);
GO

ALTER TABLE dbo.WMALabel ADD CONSTRAINT PK_WMALabel PRIMARY KEY (Id);
GO

-- Table dbo.WMALabel contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.WMALabel


-- END TABLE dbo.WMALabel

-- BEGIN TABLE dbo.WMALinks
CREATE TABLE dbo.WMALinks (
	id int NOT NULL IDENTITY(1,1),
	url nvarchar(max) NULL,
	name varchar(50) NULL,
	[action] varchar(50) NULL,
	label varchar(255) NULL,
	properties varchar(max) NULL,
	active int NULL DEFAULT ((1)),
	location nvarchar(max) NULL,
	parentid int NULL DEFAULT ((0)),
	completeurl nvarchar(max) NULL
);
GO

-- Inserting 4 rows into dbo.WMALinks
-- Insert batch #1
SET IDENTITY_INSERT dbo.WMALinks ON
INSERT INTO dbo.WMALinks (id, url, location, name, [action], label, properties, active, parentid, completeurl) VALUES
(1, '', 'Default.aspx', 'Home', 'Rewrite', 'Home', '{"alt":"","title":"","target":"","rel":"","class":"","style":"","onclick":""}', NULL, NULL, NULL),
(2, 'privacy-policy', 'Privacy.aspx', 'Privacy Policy', 'Rewrite', 'Privacy Policy', '{"alt":"","title":"","target":"","rel":"","class":"","style":"","onclick":""}', NULL, NULL, NULL),
(3, 'terms-and-conditions', 'Terms.aspx', 'Terms & Conditions', 'Rewrite', 'Terms & Conditions', '{"alt":"","title":"","target":"","rel":"","class":"","style":"","onclick":""}', NULL, NULL, NULL),
(4, 'thank-you', 'ThankYou.aspx', 'Thank You Page', 'Rewrite', 'Thank You Page', '{"alt":"","title":"","target":"","rel":"","class":"","style":"","onclick":""}', NULL, NULL, NULL);
SET IDENTITY_INSERT dbo.WMALinks OFF

-- END TABLE dbo.WMALinks

-- BEGIN TABLE dbo.WMAMenuLinks
CREATE TABLE dbo.WMAMenuLinks (
	id int NOT NULL IDENTITY(1,1),
	menuid int NOT NULL,
	linkid int NOT NULL,
	[order] int NULL DEFAULT ((1))
);
GO
-- END TABLE dbo.WMAMenuLinks

-- BEGIN TABLE dbo.WMAMenus
CREATE TABLE dbo.WMAMenus (
	id int NOT NULL IDENTITY(1,1),
	Name varchar(255) NULL,
	Label varchar(255) NULL DEFAULT (NULL)
);
GO
SET IDENTITY_INSERT dbo.WMAMenus ON
INSERT INTO dbo.WMAMenus (id, Name, Label) VALUES (1, 'main', 'Main Menu');
INSERT INTO dbo.WMAMenus (id, Name, Label) VALUES (2, 'footer', 'Footer Menu');
INSERT INTO dbo.WMAMenus (id, Name, Label) VALUES (3, 'submain', 'Secondary Main Menu');
SET IDENTITY_INSERT dbo.WMAMenus OFF
-- END TABLE dbo.WMAMenus

-- BEGIN TABLE dbo.WMASiteErrorLog
CREATE TABLE dbo.WMASiteErrorLog (
	Id int NOT NULL IDENTITY(1,1),
	raw_url varchar(max) NULL,
	redirect_url varchar(max) NULL,
	response_status_code int NULL,
	http_x_original_url varchar(max) NULL,
	query_string varchar(max) NULL,
	remote_addr varchar(50) NULL,
	remote_host varchar(50) NULL,
	request_method varchar(50) NULL,
	http_referer varchar(max) NULL,
	http_user_agent varchar(max) NULL,
	path_info varchar(max) NULL,
	url varchar(max) NULL,
	script_name varchar(max) NULL,
	requests int NULL DEFAULT ((0)),
	LastUpdate datetime NULL DEFAULT (getdate()),
	[Timestamp] datetime NULL DEFAULT (getdate())
);
GO

-- END TABLE dbo.WMASiteErrorLog

-- BEGIN TABLE dbo.WMASlider
CREATE TABLE dbo.WMASlider (
	Id int NOT NULL IDENTITY(1,1),
	Name varchar(256) NULL,
	Title varchar(256) NULL,
	Description varchar(max) NULL,
	ImgSrc varchar(500) NULL,
	Published int NULL DEFAULT ((0)),
	Seq int NULL DEFAULT ((1)),
	Identifier varchar(256) NULL
);
GO

ALTER TABLE dbo.WMASlider ADD CONSTRAINT PK_WMASlider PRIMARY KEY (Id);
GO

-- Table dbo.WMASlider contains no data. No inserts have been genrated.
-- Inserting 0 rows into dbo.WMASlider


-- END TABLE dbo.WMASlider

IF OBJECT_ID('dbo.vRCDocCat', 'V') IS NOT NULL
	DROP VIEW dbo.vRCDocCat;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vRCDocCat]
AS
SELECT        TOP (100) PERCENT Id, COALESCE
                             ((SELECT        Name + ' :: ' AS Expr1
                                 FROM            dbo.RCDocCat AS t2
                                 WHERE        (Id = t1.ParentId)) + Name, Name) AS Name
FROM            dbo.RCDocCat AS t1
ORDER BY Name
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE  id = object_id(N'dbo.GetUrlRedirect') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
	DROP PROCEDURE dbo.GetUrlRedirect
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetUrlRedirect] 
@input nvarchar(256)
AS
SELECT ur.location
FROM dbo.WMALinks ur 
WHERE ur.url = @input Or ur.url + '/' = @input And ur.action = 'Redirect'
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE  id = object_id(N'dbo.GetUrlRewrite') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
	DROP PROCEDURE dbo.GetUrlRewrite
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** PROCEDURE for rewrite rule in the Web.config file ******/
CREATE PROCEDURE [dbo].[GetUrlRewrite] 
@input nvarchar(max)
AS

SELECT TOP 1 location
FROM dbo.WMALinks
WHERE PATINDEX(REPLACE(ISNULL(NULLIF(CompleteUrl,''), Url), '*', '%'), @input) > 0
AND action ='Rewrite'
ORDER BY LEN(CompleteUrl)-LEN(replace(CompleteUrl,'*','')) DESC
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE  id = object_id(N'dbo.Redirect301') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
	DROP PROCEDURE dbo.Redirect301
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** PROCEDURE for rewrite rule in the Web.config file ******/
CREATE PROCEDURE [dbo].[Redirect301] 
@input nvarchar(max)
AS

SELECT TOP 1 LTRIM(RTRIM(redirect_url)) As ru
FROM dbo.WMASiteErrorLog
WHERE (raw_url = @input OR CONCAT(raw_url,'/') = @input) 
AND response_status_code = 301 AND LEN(LTRIM(RTRIM(redirect_url))) > 0
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE  id = object_id(N'dbo.Redirect302') AND OBJECTPROPERTY(id, N'IsProcedure') = 1 )
	DROP PROCEDURE dbo.Redirect302
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** PROCEDURE for rewrite rule in the Web.config file ******/
CREATE PROCEDURE [dbo].[Redirect302] 
@input nvarchar(max)
AS

SELECT TOP 1 LTRIM(RTRIM(redirect_url)) As ru
FROM dbo.WMASiteErrorLog
WHERE (raw_url = @input OR CONCAT(raw_url,'/') = @input) 
AND response_status_code = 302 AND LEN(LTRIM(RTRIM(redirect_url))) > 0
GO

