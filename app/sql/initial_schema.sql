# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.22)
# Database: koran
# Generation Time: 2016-12-06 16:36:59 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table acl_classes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `acl_classes`;

CREATE TABLE `acl_classes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_type` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_69DD750638A36066` (`class_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table acl_entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `acl_entries`;

CREATE TABLE `acl_entries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(10) unsigned NOT NULL,
  `object_identity_id` int(10) unsigned DEFAULT NULL,
  `security_identity_id` int(10) unsigned NOT NULL,
  `field_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ace_order` smallint(5) unsigned NOT NULL,
  `mask` int(11) NOT NULL,
  `granting` tinyint(1) NOT NULL,
  `granting_strategy` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `audit_success` tinyint(1) NOT NULL,
  `audit_failure` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_46C8B806EA000B103D9AB4A64DEF17BCE4289BF4` (`class_id`,`object_identity_id`,`field_name`,`ace_order`),
  KEY `IDX_46C8B806EA000B103D9AB4A6DF9183C9` (`class_id`,`object_identity_id`,`security_identity_id`),
  KEY `IDX_46C8B806EA000B10` (`class_id`),
  KEY `IDX_46C8B8063D9AB4A6` (`object_identity_id`),
  KEY `IDX_46C8B806DF9183C9` (`security_identity_id`),
  CONSTRAINT `FK_46C8B8063D9AB4A6` FOREIGN KEY (`object_identity_id`) REFERENCES `acl_object_identities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_46C8B806DF9183C9` FOREIGN KEY (`security_identity_id`) REFERENCES `acl_security_identities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_46C8B806EA000B10` FOREIGN KEY (`class_id`) REFERENCES `acl_classes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table acl_object_identities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `acl_object_identities`;

CREATE TABLE `acl_object_identities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_object_identity_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned NOT NULL,
  `object_identifier` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `entries_inheriting` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_9407E5494B12AD6EA000B10` (`object_identifier`,`class_id`),
  KEY `IDX_9407E54977FA751A` (`parent_object_identity_id`),
  CONSTRAINT `FK_9407E54977FA751A` FOREIGN KEY (`parent_object_identity_id`) REFERENCES `acl_object_identities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table acl_object_identity_ancestors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `acl_object_identity_ancestors`;

CREATE TABLE `acl_object_identity_ancestors` (
  `object_identity_id` int(10) unsigned NOT NULL,
  `ancestor_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`object_identity_id`,`ancestor_id`),
  KEY `IDX_825DE2993D9AB4A6` (`object_identity_id`),
  KEY `IDX_825DE299C671CEA1` (`ancestor_id`),
  CONSTRAINT `FK_825DE2993D9AB4A6` FOREIGN KEY (`object_identity_id`) REFERENCES `acl_object_identities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_825DE299C671CEA1` FOREIGN KEY (`ancestor_id`) REFERENCES `acl_object_identities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table acl_security_identities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `acl_security_identities`;

CREATE TABLE `acl_security_identities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `username` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8835EE78772E836AF85E0677` (`identifier`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table adhkar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `adhkar`;

CREATE TABLE `adhkar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ordering` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `reciter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`,`reciter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `adhkar` WRITE;
/*!40000 ALTER TABLE `adhkar` DISABLE KEYS */;

INSERT INTO `adhkar` (`id`, `name`, `ordering`, `reciter`)
VALUES
	(1,'أذكار الصباح','005','فارس عباد'),
	(2,'اذكار الصباح','003','العفاسي'),
	(3,'اذكار المساء','004','العفاسي'),
	(4,'اذكار اليوم والليلة','002','القطامي'),
	(5,'الإستيقاظ من النوم','001','العفاسي'),
	(6,'اذكار المساء','006','فارس عباد'),
	(7,'أذكار الصباح','007','محمد جبريل'),
	(8,'أذكار المساء','008','محمد جبريل'),
	(9,'أذكار الصباح','009',NULL),
	(10,'أذكار المساء','010',NULL),
	(11,'أذكار النوم','011','العفاسي'),
	(15,'دعاء القنوت 1','015','سعود الشريم'),
	(16,'دعاء القنوت 2','016','سعود الشريم'),
	(24,'دعاء ختم القرآن الكريم','024','أحمد العجمي'),
	(28,'دعاء ختم القرآن الكريم 2','028','علي الحذيفي'),
	(30,'الدعاء المعلم','030','مشاري راشد العفاسي'),
	(31,'الرقية الشرعية','031','مشاري راشد العفاسي'),
	(32,'أذكار طرفي النهار','032','فارس عباد'),
	(34,'دعاء لإخواننا في غزة','034','صفوت حجازي'),
	(36,'دعاء لأهل غزة','036','مشارى راشد العفاسى'),
	(38,'دعاء الذهاب إلى المسجد','038','العفاسى'),
	(44,'أدعية الاستفتاح في الصلاة','044','هاني محمد'),
	(46,'دعاء القنوت من صلاة القيام','045','عبد الرحمن العوسي'),
	(47,'دعاء خاشع لإخواننا في سورية','046','إدريس أبكر'),
	(48,'دعاء بر الوالدين','047','إدريس أبكر');

/*!40000 ALTER TABLE `adhkar` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table chapter
# ------------------------------------------------------------

DROP TABLE IF EXISTS `chapter`;

CREATE TABLE `chapter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ordering` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `chapter` WRITE;
/*!40000 ALTER TABLE `chapter` DISABLE KEYS */;

INSERT INTO `chapter` (`id`, `name`, `ordering`)
VALUES
	(1,'سورة الفاتحة','001'),
	(2,'سورة البقرة','002'),
	(3,'سورة آل عمران','003'),
	(4,'سورة النساء','004'),
	(5,'سورة المائدة','005'),
	(6,'سورة الأنعام','006'),
	(7,'سورة الأعراف','007'),
	(8,'سورة الأنفال','008'),
	(9,'سورة التوبة','009'),
	(10,'سورة يونس','010'),
	(11,'سورة هود','011'),
	(12,'سورة يوسف','012'),
	(13,'سورة الرعد','013'),
	(14,'سورة إبراهيم','014'),
	(15,'سورة الحجر','015'),
	(16,'سورة النحل','016'),
	(17,'سورة الإسراء','017'),
	(18,'سورة الكهف','018'),
	(19,'سورة مريم','019'),
	(20,'سورة طه','020'),
	(21,'سورة الأنبياء','021'),
	(22,'سورة الحج','022'),
	(23,'سورة المؤمنون','023'),
	(24,'سورة النّور','024'),
	(25,'سورة الفرقان','025'),
	(26,'سورة الشعراء','026'),
	(27,'سورة النّمل','027'),
	(28,'سورة القصص','028'),
	(29,'سورة العنكبوت','029'),
	(30,'سورة الرّوم','030'),
	(31,'سورة لقمان','031'),
	(32,'سورة السجدة','032'),
	(33,'سورة الأحزاب','033'),
	(34,'سورة سبأ','034'),
	(35,'سورة فاطر','035'),
	(36,'سورة يس','036'),
	(37,'سورة الصافات','037'),
	(38,'سورة ص','038'),
	(39,'سورة الزمر','039'),
	(40,'سورة غافر','040'),
	(41,'سورة فصّلت','041'),
	(42,'سورة الشورى','042'),
	(43,'سورة الزخرف','043'),
	(44,'سورة الدّخان','044'),
	(45,'سورة الجاثية','045'),
	(46,'سورة الأحقاف','046'),
	(47,'سورة محمد','047'),
	(48,'سورة الفتح','048'),
	(49,'سورة الحجرات','049'),
	(50,'سورة ق','050'),
	(51,'سورة الذاريات','051'),
	(52,'سورة الطور','052'),
	(53,'سورة النجم','053'),
	(54,'سورة القمر','054'),
	(55,'سورة الرحمن','055'),
	(56,'سورة الواقعة','056'),
	(57,'سورة الحديد','057'),
	(58,'سورة المجادلة','058'),
	(59,'سورة الحشر','059'),
	(60,'سورة الممتحنة','060'),
	(61,'سورة الصف','061'),
	(62,'سورة الجمعة','062'),
	(63,'سورة المنافقون','063'),
	(64,'سورة التغابن','064'),
	(65,'سورة الطلاق','065'),
	(66,'سورة التحريم','066'),
	(67,'سورة الملك','067'),
	(68,'سورة القلم','068'),
	(69,'سورة الحاقة','069'),
	(70,'سورة المعارج','070'),
	(71,'سورة نوح','071'),
	(72,'سورة الجن','072'),
	(73,'سورة المزّمّل','073'),
	(74,'سورة المدّثر','074'),
	(75,'سورة القيامة','075'),
	(76,'سورة الإنسان','076'),
	(77,'سورة المرسلات','077'),
	(78,'سورة النبأ','078'),
	(79,'سورة النازعات','079'),
	(80,'سورة عبس','080'),
	(81,'سورة التكوير','081'),
	(82,'سورة الإنفطار','082'),
	(83,'سورة المطفّفين','083'),
	(84,'سورة الإنشقاق','084'),
	(85,'سورة البروج','085'),
	(86,'سورة الطارق','086'),
	(87,'سورة الأعلى','087'),
	(88,'سورة الغاشية','088'),
	(89,'سورة الفجر','089'),
	(90,'سورة البلد','090'),
	(91,'سورة الشمس','091'),
	(92,'سورة الليل','092'),
	(93,'سورة الضحى','093'),
	(94,'سورة الشرح','094'),
	(95,'سورة التين','095'),
	(96,'سورة العلق','096'),
	(97,'سورة القدر','097'),
	(98,'سورة البينة','098'),
	(99,'سورة الزلزلة','099'),
	(100,'سورة العاديات','100'),
	(101,'سورة القارعة','101'),
	(102,'سورة التكاثر','102'),
	(103,'سورة العصر','103'),
	(104,'سورة الهمزة','104'),
	(105,'سورة الفيل','105'),
	(106,'سورة قريش','106'),
	(107,'سورة الماعون','107'),
	(108,'سورة الكوثر','108'),
	(109,'سورة الكافرون','109'),
	(110,'سورة النصر','110'),
	(111,'سورة المسد','111'),
	(112,'سورة الإخلاص','112'),
	(113,'سورة الفلق','113'),
	(114,'سورة النّاس','114');

/*!40000 ALTER TABLE `chapter` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table contact
# ------------------------------------------------------------

DROP TABLE IF EXISTS `contact`;

CREATE TABLE `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;

INSERT INTO `contact` (`id`, `name`, `email`, `subject`, `body`)
VALUES
	(6,'ابا زرع','xsami.gharbi@gmail.com','لقاء تواصل وتعارف','السلام عليكم ورحمة الله وبركاته\r\n\r\nيقول سبحانه \"وَالْمُؤْمِنُونَ وَالْمُؤْمِنَاتُ بَعْضُهُمْ أَوْلِيَاءُ بَعْض\" وتجسيدا لمبدا الولاء في الاسلام والاخوة والتعاون على البر والتقوى يمد لكم اخوانكم بجمعية النبأ للإعلام ايديهم ويدعونكم لاجراء لقاء تواصل وتعارف  بين مختلف الأطراف المساهمة والناشطة في مجال الإعلام الاسلامي.\r\n\r\nوفي انتظار إجابتكم تقبلوا تحياتنا, نسأل الله التوفيق والثبات والإخلاص.'),
	(7,'طارق','nasraouitarek1@yahoo.fr','طلب وضع مطويات فيالموقع','لبسم الله والصلاة والسلام على رسول الله ارجو الساهمة في تحسين الموقع والسلام'),
	(9,'mouslima','khayren@yahoo.com','نصيحة','الحمد لله وبعد انصحكم باضافة ما يلي   فيديوات للقراء الصغار لتحفيز اطفالنا          وفيديوهات لمسنين حفظوا القران لشحذ الهمم     وقنوات اجمل برامج عنيت بالقران   واخبارال تحفيظ  بالبلاد            وهذا لاثراء الموقع وتعميم الفائدة                 وفقكم الله      والسلام عليكم'),
	(10,'ammar','ammar.triki@gmail.com','الرواية','السلام عليكم\r\nأرجو أن يتم توضيح الروياة المعتمدة في تلاوة الشيوخ المذكورين\r\nأرجو الحرص على توفير أكثر ما يمكن من أصوات المشايخ بالنسبة لرواية قالون'),
	(11,'مليكة هرماسي','melika.hermassi@planet.tn','تحميل التلاوات القرانية','باسم الله الرحمان الرحيم\r\nكيف يمكن تحميل التلاوات القرانية MP3\r\n\r\nمع الشكر'),
	(12,'hima hero','himahero2014@gmail.com','قران كريم مرتل','شكرااااااااااااااااااااااااا جزيلا'),
	(13,'حسن','hasomhasom@hotmail.fr','طلب تصحيح رابط سورة الناس للقارئ','السلام عليكم ورحمة الله وبركاته\r\n\r\nبارك الله فيكم على هذا الموقع\r\n\r\nأريد أن أخبركم أن سورة رقم 114 سورة الناس  للقارئ الشيخ محمد أيوب الركباوي لاتعمل\r\n\r\nممكن تصحيحوا الله بارك فيكم!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'),
	(14,'حيدر المحسناوي','zz_ff@89gmail.com','المصحف الكامل ﻻبو العينين','ممكن احصل على االختمه الكامله للقارئ ابو العينين شعيشع'),
	(15,'د.عبد الكريم السامرائي','karim@hitech-iraq.net','اضافة','السلام عليكم ورحمة الله وبركاته \r\nبارك الله لكم على هذا الجهد واتمنى ان يتم اضافة القران المرتل للشيخ محمد رشاد شريف امام المسجد الأقصى .. ولدي نسخة أصلية منه أتشرف بان ارسلها لكم مرتبه حسب السور .. \r\nمستعد لإرسالها إليكم بواسطة شركة دي آج ال ..\r\nوجزاكم الله خير الجزاء'),
	(16,'KHALIL','KHALILCAPO@LIVE.FR','A3MLA ISRYA 3NDA ITHKOURA HLAL OU 7','//////////////////'),
	(17,'Ichaka','Www.ichakayarkoi@123.hotmail.com','كيفية التجويد','هل هناك الطريق الأسهل للوصول اليه أفيدوني جزاكم الله'),
	(18,'fathe reil','www.fathe@hotmail.com','adkar koran','koran krem'),
	(19,'souliman','souli.cat-79@hotmail.com','kif ata3alam an akhcha3a fi asalat.','jazakom alaho kola khir'),
	(20,'حسام النابلي','aburueifi3@gmail.com','رابط  - سورة النّاس لمحمد أيوب الركباوي -  لا يشتغل','محمد أيوب الركباوي - سورة النّاس\r\nwww.koran-kareem.com/chapter-play/mohamed-ayoub-rakbaoui/محمد-أيوب-الركباوي/سورة-النّاس/114'),
	(21,'nadia','scs.nedia@topnet.tn','أطلب النصيحة والارشاد','انني أعاني من تقصيري في الصلات فكلما عزمت على المواضبة لاكن دائما انشغل بأشياء أخرى وأسهوا و أنسى صلاتي أريد ان أتبع الصراط المستقيم و أتوب'),
	(22,'محمد صالح الجبر','mmjjrr778877@gmail.com','طلب تشجيع موهبتي في تلاوة القران','الله منحني صوت حسن في تلاوة القران الكريم واتمنى ان يسمع صوتي جميع المسلمين حتى انال الاجر من الله. ..فهل هناك من يعينني على ذلك. ..'),
	(23,'سليمان ابراهيم','skitikole@hotmail.com','طلب تعليم القراءن والتجويد عن طريقة  انترنت','السلا م   عليكم ورحمة الله وبركاته\r\n\r\n\r\nبعد التحية   \r\n\r\nانا  عئز  بتدريس القراءن واحكامه   عن طريقة  انترنت\r\n\r\nلانه  كنت في برطانيا\r\n\r\nكيف اجدكم ؟ \r\n\r\nوكيف  تساعدونني؟\r\n\r\nاخوكم العزيز\r\nسليمان تبراهيم\r\n\r\nالسلام عليكم ورحمة الله وبركاته'),
	(24,'محمود ابراهيم','wasum2112@yahoo.com','الاحاديث والاذكار','السلام عليكم ورحمة الله وبركاتة\r\nجزاكم الله عاى هذا العمل خيرا ولكن ارجو ان يكون هناك المزيد من كتب الاحاديث وشرح كلمات لبعض معانى الاحاديث و الاذكار'),
	(25,'عبدالمحسن','dddeexxrr@gmail.com','بسم الله','ابغا رقم جوال هذا البرنامج عشان انا ماعندي شبكة داىما'),
	(26,'Manal','Smii.slah@ymail.com','نسمع تلاوات نادرة','نسمع تلاوات'),
	(27,'krimo merahi','krimomerahi456@gmail.com','koraan','koraan'),
	(28,'عبدالرزاق','rzougamansouri123@hotmail.com','سورة البقرة','رسالة صوتية'),
	(29,'بلال الخنوسي','ballou1987@hotmail.fr','وجود خطء','السلام عليكم اخوتي اريد ان انبهكم انه هناك خطأ في اول سورة الزمر للقارء الشيخ ابو بكر الشاطري فالرجاء التثبت و السلام عليكم وبارك الله فيكم'),
	(30,'sadok','sadoknet@yahoo.fr','test','asdas asd asd asd'),
	(31,'ذكرى','dhekra.guebsi@yahoo.fr','حفظ القرآن','السلام عليكم شيخ محمد أسألك بلله أن تساعدني كيف احفظ ابني يبلغ من العمر. 7 سنوات لأنني لم أجد له محفظ متقن وان وجد فذلك مرة واحدة في الأسبوع وهذا ليس كافيا وهذا رقم أباه 24971006  ارجو الاتصال به أن كان ذالك لا يأخذ من وقتكم وأسأل الله جل جلاله أن ينفع الناس  بك في كل ما كان وجزاك الله خيرا'),
	(32,'islmail','essaid.ism@gmail.com','koran','koran hifd'),
	(33,'mohamedou','mohamedousaid9@gmail.com','elkoran','ou Selim ou 3aleykom'),
	(34,'mohamedou','mohamedousaid9@gmail.com','elkoran','ou Selim ou 3aleykom'),
	(35,'khadidja','khadidja.hatta@yahoo.co.uk','هل الحب حرام','اريد ان اعرف الحب شخص ليس في اسلام حرام'),
	(36,'ABDE ALILAH','WAHID-TABACH@OUTLLOK.COM','RASL','KJFJCGGGGGGGGGGGGGGGDQDSQSWEZSW'),
	(37,'sadok','sadoknet@yahoo.fr','asdasd asd as','asdasd asd asd asd'),
	(38,'Kik','m-s@hotmil.com','تطوير','اتمنا ان يكون باستطاعتي اختيار الايه من الى'),
	(39,'MZA','hamza_talibi@outlook.com','al koran al kareem','ma ma3na alif.lam.mim'),
	(40,'amine','amine@live.com','de3aa','de3aa bi faraj'),
	(41,'محمد','misk.elkhitam@yahoo.com','قراءة جدد','السلام عليكم . الحمدلله والصلاة والسلان على نبيه ومصطاه اما بعد :\r\nيسعدنا أن نطرح عليكم قراء جدا ربما معروفين ومشهورين فى مكان دون ءاخر .. ونأمل أن نأخذ جميعا الاجر والثواب فى نشر كلام ربنا جل وعلا . \r\nالطرح الاول وهو القارئ : عبدالملك بن عبد الله المصرى . وهو قارئ مصرى أزهرى , مولود فى 27 من شعبان عام 1407 هـ .  وهو يتميز بصوت ناعم وخاشع وأداء جديد متميز ورائع مع حسن الترتيل ومراعاة احكام التجويد وقد حصل على الاجازة فى القراءات العشر الصغرى والكبرى بالسند المتصل إلى رسول الله , وله العديد من التسجيلات بعدة روايات وقراءات متنوعة كحمزة والكسائى ويعقوب ونافع وابى جعفر الى اخر القراء العشرة رحمهم الله ..\r\nرابط سماع من اليوتيوب \r\nhttps://www.youtube.com/watch?v=HEE4KdQYLcE\r\n\r\nرابط لجميع ملفات للشيخ من على الشبكة الاسلامية\r\nhttp://audio.islamweb.net/audio/index.php?page=allsoura&qid=1761\r\nواخيرا مع قارئ جديد ان شاء الله بعد التواصل . ونرجوا الرد على نفس الميل . وبارك الله فيكم'),
	(42,'عبدالسلام محمد البالي','mbdalslam81@gmail.com','تمني','السلام عليكم ورحمة الله وبركاتة...اريد ان اكون مثل القارئ الشيخ عبدالرحمن العوسي جزاه الله خيرا واريد ان اصبح قارئا عظيما من كبار القراء... من منقولاتي(احب شي في حياتي كلها انتغني بالقران وتحبب القران الى الاسلام والى القلوب وتحسن صوت واتمنى من الله يجعل القران حجة لي لا علي )ولا اريد إضاعة هذه المنقولة.... واريد انا وجميع القراء ان نجمتع في اذاعاتكم الكريمة والحبيبه والعزيزة بإذن الله تعالى.. اذا انتم تريدون تواصل معي تفضلوا....\r\nانااخوكم:عبدالسلام محمد البالي:جوال:٠٥٠٩٤٦٣٢٨٥:ولاده:في السعودية عام ١٩٩٩:من :السعودية:من جدة:.....اشكركم جميعا\r\nولن انسى منكم دعاء ........شكرا لكم........'),
	(56,'الإسم','sadoknet@yahoo.fr','البريد الإلكتروني','الرسالة الرسالة'),
	(60,'sadok','sadoknet@yahoo.fr','test','asda sd asd'),
	(61,'sadok','sadoknet@yahoo.fr','test','asd asd asd'),
	(62,'sadok','sadoknet@yahoo.fr','test','asd asd as'),
	(63,'sadok','sadoknet@yahoo.fr','test','asd asd'),
	(64,'sadok','sadoknet@yahoo.fr','test','asd asd'),
	(65,'sadok','sadoknet@yahoo.fr','test','asd asd asd'),
	(66,'sadok','sadoknet@yahoo.fr','test','asd asd as'),
	(67,'sadok','sadoknet@yahoo.fr','test','asd asd asd'),
	(68,'sadok','sadoknet@yahoo.fr','test','asd asd asd'),
	(69,'sadok','sadoknet@yahoo.fr','testas','asd asd as'),
	(70,'sadok','sadoknet@yahoo.fr','تواصل معنا','تواصل معنا\r\nتواصل معنا\r\nتواصل معنا\r\nتواصل معنا'),
	(71,'sadok','sadoknet@yahoo.fr','test','asdasd'),
	(72,'sadok','sadoknet@yahoo.fr','test','asdasd'),
	(73,'sadok','sadoknet@yahoo.fr','test','asdas das d'),
	(74,'sadok','sadoknet@yahoo.fr','test','asdasd'),
	(75,'sadok','sadoknet@yahoo.fr','test','asd'),
	(76,'sadok','sadoknet@yahoo.fr','test','asdasd'),
	(77,'sadok','sadoknet@yahoo.fr','test','asdasd'),
	(78,'sadok','sadoknet@yahoo.fr','asdasd asd as','asd ad'),
	(79,'sadok','sadoknet@yahoo.fr','test','asasd'),
	(80,'sadok','sadoknet@yahoo.fr','test','asd'),
	(81,'sadok','sadoknet@yahoo.fr','test','asda s'),
	(82,'sadok','sadoknet@yahoo.fr','asdasd asd as','asd'),
	(83,'sadok','sadoknet@yahoo.fr','test','asdasd'),
	(84,'sadok','sadoknet@yahoo.fr','test','asd'),
	(85,'sadok','sadoknet@yahoo.fr','test','asdas'),
	(86,'sadok','sadoknet@yahoo.fr','test','asdasd'),
	(87,'Medsalah','medsalahjammel@hotmail.com','Korankoran','Ourdou estami3 il a korqn'),
	(88,'Medsalah','medsalahjammel@hotmail.com','Korankoran','Ourdou estami3 il a korqn'),
	(89,'محمد بن عمر','wardi786@hotmail.com','أريد دخول الإسلام','السلام عليكم ورحمة الله تعالى وبركاته مطلوب رجال الدين في هذا المجال ان يعلم لي بعض الحقوق في دينونا الإسلام كم الحديت القرآن الكريم  وعلومه و عندي بعض  السوءال من فضلكم احد ان يشرح لي و جزاكم الله خيرا 0034631732654'),
	(90,'N/A','mcvals21.quran@gmail.com','شروط نشر التلاوات في الموقع','السلام عليكم\r\n\r\nالله يعطيكم العافية و عسى الله يتقبل منكم\r\n\r\nلدي مشروع اعمل عليه و هو حفظ كتاب الله و تسجيله و نشره عسى ان يكون شفيعا لي بعد الرحيل\r\n\r\nو احببت ان انشر هذه التلاوات في موقعكم فما شروط ذلك ؟\r\n\r\nتلاواتي موجودة في الرابط التالي\r\n\r\nhttps://soundcloud.com/the_noble_quran\r\n\r\nو شكرا'),
	(91,'أحمد','The.storms@hotmail.com','نشر تلاوات','السلام عليكم ورحمة الله وبركاته\r\nطيب الله أوقاتكم بكل خير\r\n\r\nهل من الممكن نشر تلاوات للقارئ خالد الحوسني حيث أنه يتميز بسوط هادئ وشجي عبر موقعكم\r\nمع العلم أنه توجد هناك مجموعة من التلاوات له على اليوتيوب\r\nوجزاكم الله خيرا'),
	(92,'أحمد','The.storms@hotmail.com','نشر تلاوات','السلام عليكم ورحمة الله وبركاته\r\nطيب الله أوقاتكم بكل خير\r\n\r\nهل من الممكن نشر تلاوات للقارئ خالد الحوسني حيث أنه يتميز بسوط هادئ وشجي عبر موقعكم\r\nمع العلم أنه توجد هناك مجموعة من التلاوات له على اليوتيوب\r\nوجزاكم الله خيرا'),
	(93,'عبدالمجيد علي محمد','abd0914725259@gmail.com','القران الكريم','تلاوة حفظكم الله والمسابقات'),
	(94,'sadok','sadoknet@yahoo.fr','الموضوع','الرسالة الرسالة الرسالة'),
	(95,'Amina safi','Mouradsafi@free.fr','Koran karim','Télécharge koran karim'),
	(96,'عمر سعيد','saido363@yahoo.com','الفيس بول','هل التبول وانا واقف حرام'),
	(97,'Lotfi','Lotfi arfaoui21@out look.fr','قرأن','قرأن'),
	(98,'عاطف محمد علي','sudapost2000@gmail.com','طلب خاص','سعادة  السيد   المدير العام     الموقر \r\nالسلام عليكم ورحمة الله وبركاته\r\nأرجو من سعادتك أن ترسل لي عدد خمسة  مصاحف فقط ، أسال الله العلي القدير أن يجعلها في ميزان حسناتكم  \r\nأرجو إرسال المصاحف الي عنواني البريدي التالي :ــــ\r\nعاطف محمد علي \r\nسودابوست\r\nص. ب 11191\r\nالخرطوم\r\nالرمز البريدي 11111\r\nالسودان \r\nرقم الهاتف \r\n00249903890960\r\n\r\nوجزاكم الله خيرا'),
	(99,'asKawhdj92r','case@your-free-mail.bid','2na80mas','http://buy-levitra.accountant/ - levitra http://citalopramhbr20mg.top/ - citalopram hbr tabs 20mg http://metformin.trade/ - metformin 850'),
	(100,'smira','smira-37@outlook.fr','smira-37@outlook.fr','smira-37@outlook.fr'),
	(101,'asKawhqefdg','wbreakspear@mail-server.bid','icgdahsa','<a href=http://benecar.top/>generic for benicar 20 mg</a> <a href=http://buyserpina.loan/>serpina</a> <a href=http://buy-singulair.ru/>buy singulair</a>'),
	(102,'ITPLUS','INFO@IT-PLUS.CO','السلام عليكم','السلام عليكم ورحمة الله وبركاته\r\n\r\n شركة IT PLUS  هى شركة رائدة في تصميم وتطوير مواقع الانترنت وتطبيقات الهواتف الذكية على جميع المنصات\r\n بمنطقة الشرق الأوسط. فنحن حريصون على إنتاج تطبيقات ذات جودة عالية ومميزه بالتصميم والخدمة . \r\nفنحن نعمل من أجل بناء علاقة طويلة المدى مع عملائنا من مبدأ النجاح المشترك\r\n\r\nونقدم لكم عرض تصميم وبرمجة تطبيق جوال احترافى باحدث التقنيات المستخدمة فى برمجة تطبيقات الجوال\r\n\r\nيمكننا برمجة تطبيقات جوال تعمل على الاندرويد والايفون والويندوز فون \r\n\r\n\r\nونقدم لكم هذا العرض لتصميم وبرمجة تطبيق يحتوى على الامكانيات الاتيه : \r\n\r\n- عرض محتوى الصحيفة كاملا على التطبيق بطريقه جذابه وسريعه\r\n- امكانية عمل مشاركة على الشبكات الاجتماعيه للاخبار \r\n- امكانية عمل تعليق على الاخبار من خلال التطبيق\r\n- امكانية تسجيل عضويه على التطبيق لتحديد مصادر معينه من الصحيفه  لمتابعتها\r\n- امكانية متابعة اصدقاء على التطبيق ومتابعة جديدهم \r\n‫-‬ امكانية عمل مشاركة للاخبار لتظهر للاصدقاء المتابعين \r\n‫- امكانية البحث عن الاخبار فى كل المصادر او مصادر العضو فقط ‬\r\n- امكانية البحث عن الاعضاء ‬\r\n-‬ امكانية عمل مشاركة للتطبيق على الشبكات الاجتماعيه \r\n\r\nمثال لتطبيق يحتوى على نفس الامكانيات المذكوره \r\n\r\nعلى ابل ستور\r\n\r\nhttps://itunes.apple.com/us/app/shyft-almwatn-alalktrwnyt/id1097857542?mt=8\r\n\r\n\r\n\r\n على جوجل ستور\r\nhttps://play.google.com/store/apps/details?id=co.itplus.almowaten\r\n\r\n\r\n\r\nفإذا كانت لديكم الرغبة فى التعامل معنا يمكنكم التواصل معنا من خلال \r\n\r\nEMAIL : info@it-plus.co\r\n\r\nSKYPE : ashraf7amdy\r\n\r\nTEL && WHATSAPP : 00201012400340'),
	(103,'chadchoud','chadchoudzinoubi@gmail.com','إشهار صفحة للجمعية القرانية بسيدي بوزيد','أرجو من سيادتكم أن تقوم بوضع إشهار صفحة للجمعية القرانية بسيدي بوزيد\r\nفي هذا الموقع و بارك الله فيكم'),
	(104,'aziz annaba','ohibboalhorria@yahoo.fr','تلاوات','السلام عليكم ورحمة الله تعالى وبركاته'),
	(105,'slimani tawfik','2016.@gmail.com','korain  karim','hifdh Lorain Karim merci'),
	(106,'slimani tawfik','2016.@gmail.com','korain  karim','hifdh Lorain Karim merci'),
	(107,'Wahid','charguiwahid@yahoo.fr','Kooren','Wahidchargui'),
	(108,'nabil','nabiltrabelsi236@yahoo.fr','koran','sorat alkahaf idris abkar'),
	(109,'د. إبراهيم بن فهد الودعان','ebrahim.f.w@gmail.com','التنبيه على خطأ','السلام عليكم ورحمة الله وبركاته . وفقكم الله وبارك في جهودكم .أحببت التنبيه على خطأ في تلاوة سورة  الشعراء للشيخ محمد اللحيدان وقف الشيخ عند آية رقم 104 ثم دخل في آية رقم 29 من سورة ألقصص ثم استمر في سورة القصص .آمل تصحيح هذا الخطأ.\r\nشكر الله لكم وأسعدكم في الدارين .'),
	(110,'Sadok Ferjani','sadoknet@gmail.com','الموضوع','الرسالة  الرسالة الرسالة');

/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table country
# ------------------------------------------------------------

DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;

INSERT INTO `country` (`id`, `name`)
VALUES
	(2,'السعودية'),
	(3,'السودان'),
	(5,'الكويت'),
	(6,'اليمن'),
	(1,'تونس'),
	(4,'مصر');

/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hadith
# ------------------------------------------------------------

DROP TABLE IF EXISTS `hadith`;

CREATE TABLE `hadith` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ordering` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A4FB70A12469DE2` (`category_id`),
  KEY `name` (`name`),
  CONSTRAINT `FK_A4FB70A12469DE2` FOREIGN KEY (`category_id`) REFERENCES `hadith_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hadith` WRITE;
/*!40000 ALTER TABLE `hadith` DISABLE KEYS */;

INSERT INTO `hadith` (`id`, `category_id`, `name`, `ordering`)
VALUES
	(1,1,'الأعمال بالنيات','h1'),
	(2,1,'مراتب الدين','h2'),
	(3,1,'أركان الإسلام','h3'),
	(4,1,'مراحل الخلق','h4'),
	(5,1,'النهي عن الإبتداع في الدين','h5'),
	(6,1,'البعد عن مواطن الشبهات','h6'),
	(7,1,'النصيحة عماد الدين','h7'),
	(8,1,'حرمة دم المسلم وماله','h8'),
	(9,1,'النهي عن كثرة السؤال والتشدد','h9'),
	(10,1,'سبب إجابة الدعاء','h10'),
	(11,1,'اترك ما شككت فيه','h11'),
	(12,1,'الاشتغال بم يفيد','h12'),
	(13,1,'من كمال الإيمان','h13'),
	(14,1,'متى يهدر دم المسلم؟','h14'),
	(15,1,'إكرام الضيف','h15'),
	(16,1,'النهي عن الغضب','h16'),
	(17,1,'الرفق بالحيوان','h17'),
	(18,1,'الخلق الحسن','h18'),
	(19,1,'الإيمان بالقضاء والقدر','h19'),
	(20,1,'الحياء من الإيمان','h20'),
	(21,1,'الاستقامه بالإسلام','h21'),
	(22,1,'الطريق إلى الجنة','h22'),
	(23,1,'جوامع الخير','h23'),
	(24,1,'من فضل الله على الناس','h24'),
	(25,1,'فضل الذكر','h25'),
	(26,1,'كثرة طرق الخير','h26'),
	(27,1,'تعريف البر والإثم','h27'),
	(28,1,'السمع والطاعة','h28'),
	(29,1,'أبواب الخير','h29'),
	(30,1,'الوقوف عند حدود الشرع','h30'),
	(31,1,'الزهد في الدنيا','h31'),
	(32,1,'لا ضرر ولا ضرار','h32'),
	(33,1,'البيّنة على المُدَّعي','h33'),
	(34,1,'تغيير المنكر فريضة','h34'),
	(35,1,'المسلم أخو المسلم','h35'),
	(36,1,'قضاء حوائج المسلمين','h36'),
	(37,1,'الترغيب لفعل الحسنات','h37'),
	(38,1,'جزاء معادات الأولياء','h38'),
	(39,1,'التجاوز عن الخط والنسيان','h39'),
	(40,1,'كن في الدنيا كأنك غريب','h40'),
	(41,1,'اتباع النبي عليه السلام','h41'),
	(42,1,'سعة مغفرة الله','h42'),
	(43,2,'كتاب بدء الوحي','001'),
	(44,2,'كتاب الإيمان','002'),
	(45,2,'كتاب العلم','003'),
	(46,2,'كتاب الوضوء','004'),
	(47,2,'كتاب الغسل','005'),
	(48,2,'كتاب الحيض','006'),
	(49,2,'كتاب التيمم','007'),
	(50,2,'كتاب الصلاة','008'),
	(51,2,'باب مواقيت الصلاة وفضلها','009'),
	(52,2,'باب بدء الأذان','010'),
	(53,2,'باب صلاة الخوف','011'),
	(54,2,'باب في العيدين والتجمل فيه','012'),
	(55,2,'كتاب الجمعة','013'),
	(56,2,'باب ما جاء في الوتر','014'),
	(57,2,'باب ما جاء في الاستسقاء','015'),
	(58,2,'باب الصلاة في كسوف الشمس','016'),
	(59,2,'باب ما جاء في التقصير وكم يقيم حتى يقصر','018'),
	(60,2,'باب التهجد بالليل','019'),
	(61,2,'باب ما جاء في سجود القرآن وسنته','017'),
	(62,2,'باب فضل الصلاة في مسجد مكة والمدينة','020'),
	(63,2,'باب استعانة اليد في الصلاة إذا كان من أمر الصلاة','021'),
	(64,2,'باب ما جاء في السهو إذا قام من ركعتي الفريضة','022'),
	(65,2,'باب في الجنائز ومن كان آخر كلامه لا إله إلا الله','023'),
	(66,2,'كتاب الزكاة','024'),
	(67,2,'كتاب الحج','025'),
	(68,2,'باب العمرة','026'),
	(69,2,'باب المحصر وجزاء الصيد','027'),
	(70,2,'كتاب فضائل المدينة','028'),
	(71,2,'كتاب الصوم','029'),
	(72,2,'كتاب البيوع','030'),
	(73,2,'كتاب السلم','031'),
	(74,2,'كتاب الشفعة','032'),
	(75,2,'كتاب الإجارة','033'),
	(76,2,'كتاب الحوالات','034'),
	(77,2,'كتاب الكفالة','035'),
	(78,2,'كتاب الوكالة','036'),
	(79,2,'كتاب الحرث والمزارعة','037'),
	(80,2,'كتاب الشرب والمساقاة','038'),
	(81,2,'كتاب في الاستقراض وأداء الديون والحجر والتفليس','039'),
	(82,2,'كتاب الإشخاص والخصومات','040'),
	(83,2,'كتاب في اللقطة','041'),
	(84,2,'كتاب في المظالم','042'),
	(85,2,'كتاب الشركة','043'),
	(86,2,'كتاب الرهن','044'),
	(87,2,'كتاب العتق','045'),
	(88,2,'كتاب المكاتَب','046'),
	(89,2,'كتاب الهبة وفضلها','047'),
	(90,2,'كتاب الشهادات','048'),
	(91,2,'كتاب الصلح','049'),
	(92,2,'كتاب الشروط','050'),
	(93,2,'كتاب الوصايا','051'),
	(94,2,'كتاب الجهاد والسِّيَر','052'),
	(95,2,'كتاب فرض الخمس','053'),
	(96,2,'كتاب الجزية','054'),
	(97,2,'كتاب بدء الخلق','055'),
	(98,2,'كتاب أحاديث الأنبياء صلوات الله عليهم','056'),
	(99,2,'كتاب المناقب','057'),
	(100,2,'كتاب فضائل أصحاب النبي','058'),
	(101,2,'كتاب مناقب الأنصار','059'),
	(102,2,'كتاب المغازي','060'),
	(103,2,'كتاب التفسير','061'),
	(104,2,'كتاب فضائل القرآن','062'),
	(105,2,'كتاب النكاح','063'),
	(106,2,'كتاب الطلاق','064'),
	(107,2,'كتاب النفقات','065'),
	(108,2,'كتاب الأطعمة','066'),
	(109,2,'كتاب العقيقة','067'),
	(110,2,'كتاب الذبائح والصيد','068'),
	(111,2,'كتاب الأضاحي','068'),
	(112,2,'كتاب الأشربة','070'),
	(113,2,'كتاب المرضى','071'),
	(114,2,'كتاب الطب','072'),
	(115,2,'كتاب اللباس','073'),
	(116,2,'كتاب الأدب','074'),
	(117,2,'كتاب الاستئذان','075'),
	(118,2,'كتاب الدعوات','076'),
	(119,2,'كتاب الرقاق','077'),
	(120,2,'كتاب القدر','078'),
	(121,2,'كتاب الأيمان والنذور','079'),
	(122,2,'كتاب كفارات الأيمان','080'),
	(123,2,'كتاب الفرائض','081'),
	(124,2,'كتاب الحدود','082'),
	(125,2,'كتاب المحاربين من أهل الكفر والردة','083'),
	(126,2,'كتاب الديات','084'),
	(127,2,'كتاب استتابة المرتدين والمعاندين وقتالهم','085'),
	(128,2,'كتاب الإكراه','086'),
	(129,2,'كتاب الحيل','087'),
	(130,2,'كتاب التعبير','088'),
	(131,2,'كتاب الفتن','089'),
	(132,2,'كتاب الأحكام','090'),
	(133,2,'كتاب التمني','091'),
	(134,2,'كتاب أخبار الآحاد','092'),
	(135,2,'كتاب الاعتصام بالكتاب والسنة','093'),
	(136,2,'كتاب التوحيد','094');

/*!40000 ALTER TABLE `hadith` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table hadith_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `hadith_category`;

CREATE TABLE `hadith_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `name_2` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `hadith_category` WRITE;
/*!40000 ALTER TABLE `hadith_category` DISABLE KEYS */;

INSERT INTO `hadith_category` (`id`, `name`, `description`)
VALUES
	(1,'الأربعون النووية','الأربعون النووية هو كتاب يضم اثنان وأربعين حديث نبوي جمعه أبو زكريا يحيى بن شرف النووي والمعروف بالنووي.\r\n يقدم هذا الكتاب بعض أهم أقوال وأفعال النبي وهذا مجرد نموذج من حكمته يأتي إلينا عبر القرون ليهدينا إلى نواحي كثيرة مما يجب أن تكون عليه حياة المسلم.و ينبغي على كل راغب في الآخرة أن يعرف هذه الأحاديث لما اشتملت عليه من جميع الطاعات والمهمات. عندما سئل الإمام النووي عن سبب جمعه للأربعين النووية قال: من العلماء من جمع الأربعين في أصول الدين، وبعضهم في الفروع وبعضهم في الجهاد، وبعضهم في الزهد وبعضهم في الخطب، وكلها مقاصد صالحة، رضي الله عن قاصديها.و قد رايت جمع أربعين أهم من هذا كله، وهي اربعون حديثاً مشتملةً على جميع ذلك، وكل حديث منها قاعدة عظيمة من قواعد الدين، وقد وصفه العلماء بأنه مدار الإسلام عليه، أو يصف الإسلام أو ثلثه أو نحو ذلك.\r\nثم ألتزم في هذه الأربعين أن تكون صحيحة، ومعظمها في صحيحي بخاري ومسلم.'),
	(2,'كتاب صحيح الامام البخاري','قراءة صحيح الإمام البخاري كاملا للإمام أبي عبد الله محمد بن إسماعيل بن إبراهيم بن المغيرة البخاري الجعفي رحمه الله.');

/*!40000 ALTER TABLE `hadith_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `page`;

CREATE TABLE `page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_140AB620989D9B62` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table playlist
# ------------------------------------------------------------

DROP TABLE IF EXISTS `playlist`;

CREATE TABLE `playlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D782112D8D93D649` (`user`),
  CONSTRAINT `FK_D782112D8D93D649` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table playlist_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `playlist_item`;

CREATE TABLE `playlist_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `playlist_id` int(11) DEFAULT NULL,
  `reciter_id` int(11) DEFAULT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `adhkar_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tilawa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BF02127C6BBD148` (`playlist_id`),
  KEY `IDX_BF02127CDEDF9489` (`reciter_id`),
  KEY `IDX_BF02127C579F4768` (`chapter_id`),
  KEY `IDX_BF02127CDFBEF8DB` (`adhkar_id`),
  KEY `IDX_BF02127C5A347712` (`tilawa_id`),
  CONSTRAINT `FK_BF02127C579F4768` FOREIGN KEY (`chapter_id`) REFERENCES `chapter` (`id`),
  CONSTRAINT `FK_BF02127C5A347712` FOREIGN KEY (`tilawa_id`) REFERENCES `tilawa` (`id`),
  CONSTRAINT `FK_BF02127C6BBD148` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_BF02127CDEDF9489` FOREIGN KEY (`reciter_id`) REFERENCES `quran_reciter` (`id`),
  CONSTRAINT `FK_BF02127CDFBEF8DB` FOREIGN KEY (`adhkar_id`) REFERENCES `adhkar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table quran_reciter
# ------------------------------------------------------------

DROP TABLE IF EXISTS `quran_reciter`;

CREATE TABLE `quran_reciter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `arabic_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `history` longtext COLLATE utf8_unicode_ci,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1A388FC6989D9B62` (`slug`),
  KEY `IDX_1A388FC6F92F3E70` (`country_id`),
  KEY `name` (`name`,`arabic_name`,`slug`),
  CONSTRAINT `FK_1A388FC6F92F3E70` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `quran_reciter` WRITE;
/*!40000 ALTER TABLE `quran_reciter` DISABLE KEYS */;

INSERT INTO `quran_reciter` (`id`, `name`, `arabic_name`, `history`, `slug`, `active`, `country_id`)
VALUES
	(1,'Ahmed Ajmi',' أحمد بن علي العجمي','أحمد على العجمي قارئ قرآن سعودي ولد سنة (24 فبراير 1968) في مدينة الخبر.\r\n هو قارئ للقران الكريم براوية حفص عن عاصم . وهو من أشهر القراء في العالم الإسلامي ويتميز بحسن الصوت وجمال التلاوة.','ahmed-ajmi',1,2),
	(2,'Abdulbasit','عبد الباسط عبد الصمد','الشيخ عبد الباسط بن محمد بن عبد الصمد بن سليم (1927 - 30 نوفمبر 1988)، أحد أشهر قراء القرآن الكريم في العالم الإسلامي . و يتمتع الشيخ عبدالباسط بشعبية كبيرة بأنحاء العالم لجمال صوته ولأسلوبه الفريد . , وقد لُقب بالحنجرة الذهبية','abdulbasit',1,4),
	(3,'Al Afasi','مشاري العفاسي','مشاري بن راشد بن غريب بن محمد بن راشد العفاسي المطيري إمام وخطيب مسجد الشيخ جابر العلي بمنطقة الشهداء في الكويت والمسجد الكبير في العشر الأواخر، صاحب قناة العفاسي الفضائية وشريكه فيصل العيسى. وقارئ القرآن الكريم ومنشد ديني كويتي. يتمتع بصوت عذب وقوة في التحكم بطبقات الصوت وروعة الأداء. له العديد من الإصدارات التي انتشرت في الوطن العربي والإسلامي والعالم.','al-afasi',1,5),
	(4,'Al Ghamdi','سعد الغامدي','إمام وقارئ . من مواليد سنة 1387 هـ الموافق 1967م في مدينة الدمام عاصمة المنطقة الشرقية في المملكة العربية السعودية.\r\nتخرج الشيخ من جامعة الإمام محمد بن سعود الإسلامية بالإحساء (كلية الشريعة تخصص أصول الدين) عام 1410 هـ. ومنذ دخول الشيخ للجامعة كان حريصاً على مراجعة القرآن وإتقانه. ففي عام 1410 هـ أتم حفظ القرآن كاملاً. وقد برز الشيخ في ذلك الوقت كصاحب صوت جميل تلاوة القرآن الكريم.','al-ghamdi',1,2),
	(5,'Al Hussary','محمود خليل الحصري','محمود خليل الحصري أحد أشهر قُرّاء القرآن الكريم في العالم الإسلامي , وهو أحد أبرز القراء المصريين القدماء , وله العديد من المصاحف المسجلة بروايات مختلفة . وُلد في غرة ذي الحجة سنة 1335 هـ الموافق 17 سبتمبر من عام 1917 في قرية شبرا النملة التابعة لطنطا بمحافظة الغربية بمصر. كان والده قبل ولادته قد انتقل من محافظة الفيوم إلى هذه القرية التي ولد فيها. قارئ قرآن مصري أجاد قراءة القرآن الكريم بالقراءات العشر.','al-hussary',1,4),
	(6,'Ali Al huthaifi','علي الحذيفي','أحمد علي الحذيفي من قارئي القرآن الكريم ومن أئمة المساجد في المملكة العربية السعودية، اسمه أحمد ابن امام وخطيب المسجد النبوي الشريف علي بن عبد الرحمن الحذيفي، يعمل أحمد إماما بمسجد قباء بالمدينة المنورة ومحاضرا بقسم التفسير وعلوم القرآن بالجامعة الإسلامية بالمدينة المنورة','ali-al-huthaifi',1,2),
	(7,'Al Lohaidan','محمد اللحيدان','محمد اللحيدان قاضي وقاريء من قارئي القرآن الكريم ومن أئمة المساجد في المملكة العربية السعودية، اسمه محمد بن إبراهيم بن عبد الله بن إبراهيم بن محمد اللحيدان، يعمل إماما لجامع الناصر في حي الروضة خلف أسواق خريص بلازا في مدينة الرياض، بالإضافة لعمله قاضيا في ديوان المظالم في المدينة النبوية.','al-lohaidan',1,2),
	(8,'Al Minshawi','محمد صديق المنشاوي','محمد صديق المنشاوي ((1920, 1969)) أحد أشهر قراء القرآن الكريم , وأحد أكثر القراء شعبية , تميّز باسلوب فريد في القراءة وبإجادة المقامات . ولد الشيخ محمد بقرية المنشاة التابعة لـمحافظة سوهاج في جمهورية مصر العربية، وأتم حفظ القرآن الكريم وهو في الثامنة من عمره؛ حيث نشأ في أسرة قرآنية عريقة، فأبوه الشيخ صديق المنشاوي هو الذي علمه فن قراءة القرآن الكريم وقد وضع أبوه الشيخ الجليل صديق المنشاوي هذه المدرسة العتيقة الجميلة والمنفردة بذاتها، وبإمكاننا أن نطلق عليها (المدرسه المنشاوية)؛ حيث اشتهر الشيخ محمد بقراءته بمقام النهاوند الذي أبهر بها المصريين، وصار علمًا من أعلام خدام القرآن. وقد استمد الشيخ محمد من تلك المدرسة الكثير الذي كان سببًا في نجاحه بعد صوته الخاشع، ولُقِّب الشيخ محمد صديق المنشاوي بـ\"الصوت الباكي\".','al-minshawi',1,4),
	(9,'Al Qahtani','خالد القحطاني',NULL,'al-qahtani',1,2),
	(10,'Al Shuraim','سعود الشريم','يعتبر الشيخ سعود الشريم من القراء المتقنين لقراءة القرآن الكريم وهو يقرأ القرآن برواية حفص عن عاصم وقد حفظ القرآن في مرحلة شبابه وكان يشتغل معظم وقته في الحفظ والمراجعة حيث يقال ان الشيخ حفظ سوره النساء عتد إشارات المرور من أجمل تلاوته في اليوتوب تلاوه حزينه لسعود الشريم رائعه جد','al-shuraim',1,2),
	(11,'Al Sudays','عبدالرحمن السديس','حفظ القرآن الكريم في سن الثانية عشرة، حيث يرجع الفضل في ذلك لوالديه، فقد ألحقه والده في جماعة تحفيظ القرآن الكريم بالرياض، بإشراف الشيخ عبد الرحمن بن عبد الله آل فريان، ومتابعة الشيخ المقرىء محمد عبد الماجد ذاكر، حتى حفظ القرآن الكريم على يد عدد من المدرسين في الجماعة، كان آخرهم الشيخ محمد علي حسا','al-sudays',1,2),
	(12,'Mohamed Ayub','محمد أيوب','يعد الشيخ محمد أيوب من القراء المشهورين في المملكة والعالم الإسلامي، وله تسجيلات قرآنية في الإذاعة والتلفزيون، وقد سجل له مجمع الملك فهد لطباعة المصحف الشريف القرآن كاملاً، حيث يتم بثه من إذاعة القرآن الكريم، وسجلت له أيضاً قراءات صلاة التراويح والقيام في المسجد النبوي الشريف، وهي تنشر كذلك تباعاً في الإذاعة. و قد حصل على عدد من الإجازات في القراءات ومنها: إجازة برواية حفص من شيخ قراء المدينة حسن بن إبراهيم الشاعر، ومن الشيخ أحمد عبد العزيز الزيات، والشيخ خليل بن عبد الرحمن القارئ.','mohamed-ayub',1,2),
	(13,'Fares Abed','فارس عباد','يقول الشيخ: حفظت المصحف منذ صغري عندما كنت أدرس في مدارس التحفيظ في عدة مساجد عندما يأتينا الشيخ ونسمع له ويأتي لنا شيخ آخر ليكمل معنا التسميع , حتى افتتح مركز آخر في الجمهورية اليمنية في جامع بلال بن رباح وفي عدة مساجد من قبل الجمعية الخيرية لتحفيظ القرآن الكريم , افتتحت حلقات نموذجية ودرست في أحد هذه الحلقات التي كان أول من دَرّس فيها الشيخ فضل عبد الله مراد , وبدأنا بالحفظ الجاد وختمنا المصحف , وبعدها صليت بالناس اماما في صلاة التراويح عام 1994 في جامع بلال بن رباح , وكانت هذه بدايتي لمدة 7 سنوات , وسجلت المصحف كاملا في اليمن وأخذت حقوقه تسجيلات القادسية بالدمام الذي لهم الفضل الكبير في نشر قرائتي.','fares-abed',1,6),
	(14,'Hani Rifai','هاني الرفاعي','هاني الرفاعي مولود في عام 1394 هـ.\r\nنشأ الرفاعي في أسرة مباركة يهتم أفرادها بحفظ كتاب الله تعالى ابتداء من أبيه -رحمه الله-، ووالدته -حفظها الله- وإخوته الكبار والذين كانوا بمثابة القدوة له في حفظ القرآن الكريم وأعمال مسيرة حفظه.\r\nوقال الرفاعي في حديثه لـ»المدينة» عن نشأته: «بدأت بالالتحاق بإحدى حلقات تحفيظ القرآن في المسجد الذي بجوار بيتي وأنا في سن السادسة من العمر وكانت أول حلقة ألتحق بها آنذاك يشرف على التدريس فيها فضيلة الشيخ محمد يوسف إمام جامع الأمير متعب بجدة ثم أكملت المسيرة لحفظ كتاب الله من بعد ذلك بسبب انتقال مسكننا إلى مسجد العماري بجدة إلى أن حفظت كتاب الله كاملاً على يد الشيخ محمد عبد الرحيم عشيشي من جمهورية مصر العربية وذلك في عام 1411 هـ.».','hani-rifai',1,2),
	(15,'Ali Jaber','علي جابر','ولد علي جابر في مدينة جدة عام 1373 هـ في شهر ذي الحجة, انتقل إلى المدينة المنورة مع والديه عند بلوغه الخامسة من العمر.\r\nأحب تلاوته ملايين المسلمين وقلده الكثير من الأئمة بسبب أسلوب تلاوته المميزة.','ali-jaber',1,2),
	(16,'Maher Al Muaiqly','ماهر المعيقلي','حفظ القرآن الكريم ودرس كلية المعلمين في المدينة المنورة وتخرج منها معلماً لمادة الرياضيات وانتقل للعمل بمكة المكرمة معلماَ ثم أصبح مرشداَ طلابياَ في مدرسة \"الأمير عبد المجيد\" بمكة المكرمة. حاصل على درجة الماجستير بتاريخ 1425 هـ في فقه الإمام أحمد بن حنبل في كلية الشريعة بجامعة أم القرى ويقوم الآن بالتحضير للدكتوراه في التفسير. هو الآن محاضراَ بجامعة أم القرى في كلية الشريعة والدراسات الإسلامية قسم القضاء.','maher-al-muaiqly',1,2),
	(17,'Mahmoud Al Refaae','محمود الرفاعي','محمود الرفاعي من قارئي القرآن الكريم في دولة الكويت، اسمه محمود سيد علي الرفاعي، حاصل على المركز الأول في مسابقة الكويت الكبرى العاشرة لحفظ القرآن الكريم وتجويده.','mahmoud-al-refaae',1,5),
	(18,'Mustafa Ismail','مصطفى إسماعيل','عتبر الشيخ / مصطفى اسماعيل بحق معجزة التلاوة فى مصر والعالم اجمع فهو صاحب اسلوب متميز وبديع وصاحب مدرسه فريدة من نوعها فى التلاوة فى مجال تلاوة القران الكريم وكان يركب النغمات والمقامات فی تلاوته بشكل يفاجئ المستمع ويثير اعجابه، وكان ينتقل بسلاسة من نغمة الى اخرى، وكان يعرف قدراته الصوتية بشكل جيد، ويستخدمها فی الوقت المناسب وبشكل مناسب فقد استطاع بصوته الذهبى ان يمزج بين علم القراءت واحكام التلاوة وعلم التفسير وعلم المقامات مزجا لم يسبق له مثيل.','mustafa-ismail',1,4),
	(19,'Abu Bakr Al Shatri','شيخ أبو بكر الشاطري','شيخ بن أبي بكر الشاطري هو قارئ للقرآن الكريم يمني الجنسية وهو مولود في مدينة جدة في المملكة العربية السعودية، وهو من مواليد 1970.\r\nتحصل الشاطري على إجازة لتلاوة القرآن الكريم برواية حفص عن عاصم على يد أيمن رشدي سويد. للقارئ اصدارات عديدة وله أيضا ختمتان للقرآن الكريم احداهما في عام 1409 هجرية والأخرى لعام 1428 هجرية.','abu-bakr-al-shatri',1,2),
	(20,'Yasser Al Dosari','ياسر الدوسري','ياسر بن راشد الودعاني الدوسري، يعد من قراء القرآن الكريم في المملكة العربية السعودية وإمام في مدينة الرياض حيث يصلي خلفه جمع غفير من المصلين وتمتلئ بهم الساحات المحيطة بجامع الدخيل، وصنف ضمن أكثر الشخصيات تأثيراً بالمجتمع بحسب مجلة جمعية إنسان.','yasser-al-dosari',1,2),
	(21,'Zain Mohamed Ahmed','الزين محمد أحمد','وهو قارئ من أصل سوداني\r\nالاسم: الزين محمد أحمد الزين\r\nتاريخ الميلاد : يوليو 1982م\r\nالموطن الأصلي : قرية البنية بمحلية أمروابة- ولاية شمال كردفان- السودان\r\nبدأ الشيخ الزين رحلــته مع القرآن الكريم بعد أن درس أربـع سنـوات بالمدرسة الابتدائية وكان آنذاك عمره عشــر سنوات. و تم اعتماد تلاوته لبثها عبر إذاعة القرآن الكريم بالسودان. وقد حصل على إجازة من شيخ قراء الأزهر الشريف في سبتمبر 2009','zain-mohamed-ahmed',1,3),
	(23,'Ali Al Barrak','علي البراق','الشيخ علي البراق مقرئ ومؤذن ومنشد من مدينة القيروان في تونس هو قارئ تونس والمغرب العربي الكبير الأول وهو المقرئ والمؤذن بجامع صاحب الطابع بالحلفاوين. كما ان الشيخ علي البراق حظي بشرف تدشين البث الإذاعي التونسي الرسمي سنة 1938 فيما بدأت تلاوات الشيخ البراق برواية قالون عن نافع في الإذاعة التونسية بعد ذلك. ومازالت تسجيلات الإذاعة الوطنية لصوت الشيخ علي البراق تؤثث به فقرات الإذاعة الوطنية سيما في المناسبات الدينية ومن ضمنها شهر رمضان.','ali-al-barrak',1,1),
	(24,'Mohamed Ayoub Rakbaoui','محمد أيوب الركباوي','ولد في 14 ديسمبر 1988 بأريانة - تونس وتعلم ترتيل القرآن في مدرسة عمر بن الخطاب للشيخ حسن الورغي وحفظ القرآن في ليبيا وهو حاليا مدرس قرآن في مدرسة عبد الله بن مسعود بالنصر.\r\nولقد شارك في مسابقات وطنية ودولية متعددة، ولقب بـ «سفير تونس» في مسابقات حفظ القرآن الكريم، فقد شارك في مسابقة تونس الدولية وتحصل على المرتبة الثانية، وشارك في مسابقة مصر وتحصل على المرتبة العاشرة كما شارك في مسابقة الجزائر ومسابقة دبي، وله ختمة قرآنية مسجلة بإذاعة الزيتونة للقرآن الكريم.','mohamed-ayoub-rakbaoui',1,1),
	(25,'Othman Al Andary','عثمان الأنداري','المقرئ الشيخ عثمان بن الطيب الأنداري من مواليد 27/09/1945 بتونس، هوأستاذ مختص في التجويد القراءات و مراجعة المصاحف القرانية، مدير مدرسة ترتيل القران الكريم بتونس سابقا، الإمام الخطيب حاليا بجامع الملك عبد العزيز ال سعود بالمنار ء تونس، عضو في لجنة الوطنية لمراجعة المصاحف القرانية التابعة للمجلس الاسلامي الاعلى بالوزارة الاولى. وهو المكلـّف برسكلة المتسابقين الدّوليين بالمعهد الأعلى للشّريعة.','othman-al-andary',1,1),
	(26,'Abd allah Matroud','عبد الله المطرود','القارئ عبد الله بن محمد المطرود. إمام وخطيب جامع الأمير بندر بن عبد العزيز آل سعود تلاوته هادئه وخاشعه وهبه الله صوتا عذبا حفظه الله تعالى. والمدرس بمتوسطة وثانوية تحفيظ القرآن الكريم بعليشة-الرياض. له قصه لهدايته رواها عن نفسه.\r\nعبد الله المطرود يحكي قصة تحوله إلى قارئ ويقول:- كنت في بداية حياتي أيام الدراسة الإعدادية والثانوية مغنيا، حيث كنت أغني على المسارح، وكنت رياضيا حيث حصلت على المركز الأول في لعبة الجمباز في المرحلة الابتدائية على منطقة الرياض، وكنت حارسا في كرة القدم، وألعب التنس وكرة الطائرة، كما كنت ممثلا، وحصلت على المركز الأول على مستوى المملكة في منطقة جدة، وفي بداية المرحلة الثانوية كان هناك أستاذجليل اسمه: فلاح بن مبارك العطري يدرس في ثانوية الرياض، وكان هو من الأسباب التي جعلتني أسلك طريق الهداية، والدعوة إلى الله، وسمع صوتي في قراءة القرآن الكريم فشجعني عليها وقال: إنها أفضل من الغناء.. فأخذت أحافظ على قراءة القرآن الكريم، والأناشيد الإسلامية، واستمر في هذا الطريق الجميل.. ومن تشجيع هذاالأستاذ لي أن قدمني للإمامة في أحد المساجد، وبعدها فتح الله علي، وسرت على الطريق الصحيح ولله الحمد.','abd-allah-matroud',1,2),
	(27,'Abd Alrahman Aoussi','عبد الرحمن العوسي','معلم وإمام لمسجد الإخلاص بمدينة الخبر بحي الكورنيش, مجاز برواية حفص عن عاصم.\r\nيقول الشيخ عن نفسه \" أحب شي في حياتي قرآﺀة القرآن الكريم والتغني به, وأتمنى من الله أن يجعله حجة لي لا علي \".','abd-alrahman-aoussi',1,2),
	(28,'Sahl Yassin','سهل ياسين','سهل بن زين ياسين من قارئي القرآن الكريم ومن أئمة المساجد في المملكة العربية السعودية، يعمل إماما وخطيبا لجامع الأمير سلطان بن عبد العزيز في مدينة جدة، وهو مجاز برواية حفص على يد المقرئ أيمن سويد.','sahl-yassin',0,2);

/*!40000 ALTER TABLE `quran_reciter` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table TextAdhkar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TextAdhkar`;

CREATE TABLE `TextAdhkar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `text` longtext COLLATE utf8_unicode_ci NOT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F2584D2D12469DE2` (`category_id`),
  KEY `source` (`source`),
  CONSTRAINT `FK_F2584D2D12469DE2` FOREIGN KEY (`category_id`) REFERENCES `TextAdhkarCategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `TextAdhkar` WRITE;
/*!40000 ALTER TABLE `TextAdhkar` DISABLE KEYS */;

INSERT INTO `TextAdhkar` (`id`, `category_id`, `text`, `source`)
VALUES
	(1,1,'أَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذا اليوم وَخَـيرَ ما بَعْـدَه ، وَأَعـوذُ بِكَ مِنْ شَـرِّ هـذا اليوم وَشَرِّ ما بَعْـدَه، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُبِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.','مسلم 4/2088'),
	(2,1,'اللّهُـمَّ بِكَ أَصْـبَحْنا وَبِكَ أَمْسَـينا ، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ النُّـشُور.','الترمذي 5/466'),
	(3,1,'اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ .','البخاري 7/150'),
	(4,1,'اللّهُـمَّ إِنِّـي أَصْبَـحْتُ أَُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلائِكَتِك ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك .(أربع مرات)','أبو داود 4/317'),
	(5,1,'اللّهُـمَّ ما أَصْبَـَحَ بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر.','أبو داود 4/318'),
	(6,1,'اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ . (ثلاثاً) \r\nاللّهُـمَّ إِنّـي أَعـوذُبِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُبِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلاّ أَنْـتَ . (ثلاثاً)','أبو داود 4/324'),
	(7,1,'حَسْبِـيَ اللّهُ لا إلهَ إلاّ هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم. ( سبع مَرّات حينَ يصْبِح وَيمسي)','أبو داود موقوفاً 4/321'),
	(8,1,'أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق. (ثلاثاً إِذا أمسى)','أحمد 2/290، وصحيح الترمذي 3/187'),
	(9,1,'اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي.','صحيح ابن ماجه 2/332'),
	(10,1,'اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِـرْكِه ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم.','صحيح الترمذي 3/142'),
	(11,1,'بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم. (ثلاثاً)','أبو داود 4/323'),
	(12,1,'رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً. (ثلاثاً)','أبو داود 4/318'),
	(13,1,'سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه. (ثلاثاً)','مسلم 4/2090'),
	(14,1,'سُبْحـانَ اللهِ وَبِحَمْـدِهِ. (مائة مرة)','مسلم 4/2071'),
	(15,1,'يا حَـيُّ يا قَيّـومُ بِـرَحْمَـتِكِ أَسْتَـغـيث ، أَصْلِـحْ لي شَـأْنـي كُلَّـه ، وَلا تَكِلـني إِلى نَفْـسي طَـرْفَةَ عَـين.','صحيح الترغيب والترهيب 1/273'),
	(16,1,'لا إلهَ إلاّ اللّهُ وحْـدَهُ لا شَـريكَ لهُ، لهُ المُـلْكُ ولهُ الحَمْـد، وهُوَ على كُلّ شَيءٍ قَدير. (مائة مرة)','البخاري 4/95 ومسلم 4/2071'),
	(17,1,'أَصْبَـحْـنا وَأَصْبَـحْ المُـلكُ للهِ رَبِّ العـالَمـين ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ خَـيْرَ هـذا الـيَوْم ، فَـتْحَهُ ، وَنَصْـرَهُ ، وَنـورَهُ وَبَـرَكَتَـهُ ، وَهُـداهُ ، وَأَعـوذُ بِـكَ مِـنْ شَـرِّ ما فـيهِ وَشَـرِّ ما بَعْـدَه.','أبو داود 4/322'),
	(18,16,'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ','البقرة/201'),
	(19,16,'رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ','البقرة/250'),
	(20,16,'رَبَّنَا لاَ تُؤَاخِذْنَا إِن نَّسِينَا أَوْ أَخْطَأْنَا رَبَّنَا وَلاَ تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا رَبَّنَا وَلاَ تُحَمِّلْنَا مَا لاَ طَاقَةَ لَنَا بِهِ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا أَنتَ مَوْلاَنَا فَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ','البقرة/286'),
	(21,16,'رَبَّنَا لاَ تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِن لَّدُنكَ رَحْمَةً إِنَّكَ أَنتَ الْوَهَّابُ','آل عمران/8'),
	(22,16,'رَبَّنَا إِنَّنَا آمَنَّا فَاغْفِرْ لَنَا ذُنُوبَنَا وَقِنَا عَذَابَ النَّارِ','آل عمران/16'),
	(23,16,'رَبِّ هَبْ لِي مِن لَّدُنْكَ ذُرِّيَّةً طَيِّبَةً إِنَّكَ سَمِيعُ الدُّعَاء','آل عمران/38'),
	(24,16,'رَبَّنَا آمَنَّا بِمَا أَنزَلْتَ وَاتَّبَعْنَا الرَّسُولَ فَاكْتُبْنَا مَعَ الشَّاهِدِينَ','آل عمران/53'),
	(25,16,'ربَّنَا اغْفِرْ لَنَا ذُنُوبَنَا وَإِسْرَافَنَا فِي أَمْرِنَا وَثَبِّتْ أَقْدَامَنَا وانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَِ','آل عمران/147'),
	(26,16,'رَبَّنَا مَا خَلَقْتَ هَذا بَاطِلاً سُبْحَانَكَ فَقِنَا عَذَابَ النَّارِ رَبَّنَا إِنَّكَ مَن تُدْخِلِ النَّارَ فَقَدْ أَخْزَيْتَهُ وَمَا لِلظَّالِمِينَ مِنْ أَنصَارٍ رَّبَّنَا إِنَّنَا سَمِعْنَا مُنَادِيًا يُنَادِي لِلإِيمَانِ أَنْ آمِنُواْ بِرَبِّكُمْ فَآمَنَّا رَبَّنَا فَاغْفِرْ لَنَا ذُنُوبَنَا وَكَفِّرْ عَنَّا سَيِّئَاتِنَا وَتَوَفَّنَا مَعَ الأبْرَارِ رَبَّنَا وَآتِنَا مَا وَعَدتَّنَا عَلَى رُسُلِكَ وَلاَ تُخْزِنَا يَوْمَ الْقِيَامَةِ إِنَّكَ لاَ تُخْلِفُ الْمِيعَاد ِ','آل عمران/191-194'),
	(27,15,'الحَمْـدُ لِلّهِ الّذي أَحْـيانا بَعْـدَ ما أَماتَـنا وَإليه النُّـشور.','البخاري مع الفتح 11/ 113 ومسلم 4/ 2083'),
	(28,15,'الحمدُ للهِ الذي عافاني في جَسَدي وَرَدّ عَليّ روحي وَأَذِنَ لي بِذِكْرِه.','الترمذي 5/ 473'),
	(29,15,'لا إلهَ إلاّ اللّهُ وَحْـدَهُ لا شَـريكَ له، لهُ المُلـكُ ولهُ الحَمـد، وهوَ على كلّ شيءٍ قدير، سُـبْحانَ اللهِ، والحمْـدُ لله ، ولا إلهَ إلاّ اللهُ واللهُ أكبَر، وَلا حَولَ وَلا قوّة إلاّ باللّهِ العليّ العظيم. \r\nرَبِّ اغْفرْ لي.','البخاري مع الفتح 3/ 144'),
	(30,14,'الحمدُ للهِ الّذي كَساني هذا (الثّوب) وَرَزَقَنيه مِنْ غَـيـْرِ حَولٍ مِنّي وَلا قـوّة.','إرواء الغليل 7/47'),
	(31,13,'(بِسْمِ الله) اللّهُـمَّ إِنِّـي أَعـوذُ بِـكَ مِـنَ الْخُـبْثِ وَالْخَبائِث.','البخاري 1/45 ومسلم 1/283'),
	(32,12,'غُفْـرانَك.','أخرجه أصحاب السنن إلا النسائي، زاد المعاد 2/387'),
	(33,10,'أَشْهَدُ أَنْ لا إِلَـهَ إِلاّ اللهُ وَحْدَهُ لا شَريـكَ لَـهُ وَأَشْهَدُ أَنَّ مُحَمّـداً عَبْـدُهُ وَرَسـولُـه.','مسلم 1/209'),
	(34,10,'اللّهُـمَّ اجْعَلنـي مِنَ التَّـوّابينَ وَاجْعَـلْني مِنَ المتَطَهّـرين.','الترمذي 1/78'),
	(35,10,'سُبْحـانَكَ اللّهُـمَّ وَبِحَمدِك أَشْهَـدُ أَنْ لا إِلهَ إِلاّ أَنْتَ أَسْتَغْفِرُكَ وَأَتوبُ إِلَـيْك.','النسائي في عمل اليوم والليلة ص 173'),
	(36,11,'بِسْمِ الله.','إرواء الغليل 1/122'),
	(37,9,'بِسْمِ اللهِ ، تَوَكَّلْـتُ عَلى اللهِ وَلا حَوْلَ وَلا قُـوَّةَ إِلاّ بِالله.','أبو داود 4/325 والترمذي 5/490'),
	(38,9,'اللّهُـمَّ إِنِّـي أَعـوذُ بِكَ أَنْ أَضِـلَّ أَوْ أُضَـل ، أَوْ أَزِلَّ أَوْ أُزَل ، أَوْ أَظْلِـمَ أَوْ أَُظْلَـم ، أَوْ أَجْهَلَ أَوْ يُـجْهَلَ عَلَـيّ.','صحيح الترمذي 3/152'),
	(39,8,'بِسْـمِ اللهِ وَلَجْنـا، وَبِسْـمِ اللهِ خَـرَجْنـا، وَعَلـى رَبِّنـا تَوَكّلْـنا.','أبو داود 4/325'),
	(40,7,'اللّهُـمَّ اجْعَـلْ في قَلْبـي نورا ، وَفي لِسـاني نورا، وَاجْعَـلْ في سَمْعي نورا، وَاجْعَـلْ في بَصَري نورا، وَاجْعَـلْ مِنْ خَلْفي نورا، وَمِنْ أَمامـي نورا، وَاجْعَـلْ مِنْ فَوْقـي نورا ، وَمِن تَحْتـي نورا .اللّهُـمَّ أَعْطِنـي نورا.','البخاري11/116 ومسلم 1/526،529،530'),
	(41,6,'أَعوذُ باللهِ العَظيـم وَبِوَجْهِـهِ الكَرِيـم وَسُلْطـانِه القَديـم مِنَ الشّيْـطانِ الرَّجـيم،[ بِسْـمِ الله، وَالصَّلاةُ] [وَالسَّلامُ عَلى رَسولِ الله]، اللّهُـمَّ افْتَـحْ لي أَبْوابَ رَحْمَتـِك.','أبو داود وانظر صحيح الجامع برقم 4591'),
	(42,5,'بِسمِ الله وَالصّلاةُ وَالسّلامُ عَلى رَسولِ الله، اللّهُـمَّ إِنّـي أَسْأَلُكَ مِـنْ فَضْـلِك، اللّهُـمَّ اعصِمْنـي مِنَ الشَّيْـطانِ الرَّجـيم.','مسلم 1/494'),
	(43,3,'بِاسْمِكَ رَبِّـي وَضَعْـتُ جَنْـبي ، وَبِكَ أَرْفَعُـه، فَإِن أَمْسَـكْتَ نَفْسـي فارْحَـمْها ، وَإِنْ أَرْسَلْتَـها فاحْفَظْـها بِمـا تَحْفَـظُ بِه عِبـادَكَ الصّـالِحـين.','رواه البخاري/6320 ومسلم/2714'),
	(44,3,'اللّهُـمَّ إِنَّـكَ خَلَـقْتَ نَفْسـي وَأَنْـتَ تَوَفّـاهـا لَكَ ممَـاتـها وَمَحْـياها ، إِنْ أَحْيَيْـتَها فاحْفَظْـها ، وَإِنْ أَمَتَّـها فَاغْفِـرْ لَـها . اللّهُـمَّ إِنَّـي أَسْـأَلُـكَ العـافِـيَة.','مسلم 4/2083'),
	(45,3,'اللّهُـمَّ قِنـي عَذابَـكَ يَـوْمَ تَبْـعَثُ عِبـادَك. (ثلاثاً)','أبو داود 4/311'),
	(46,3,'اسْـمِكَ اللّهُـمَّ أَمـوتُ وَأَحْـيا.','البخاري مع الفتح 11/113 ومسلم 4/2083'),
	(47,3,'الـحَمْدُ للهِ الَّذي أَطْـعَمَنا وَسَقـانا، وَكَفـانا، وَآوانا، فَكَـمْ مِمَّـنْ لا كـافِيَ لَـهُ وَلا مُـؤْوي.','مسلم 4/2085'),
	(49,3,'اللّهُـمَّ عالِـمَ الغَـيبِ وَالشّـهادةِ فاطِـرَ السّماواتِ وَالأرْضِ   رَبَّ كُـلِّ شَـيءٍ وَمَليـكَه، أَشْهـدُ أَنْ لا إِلـهَ إِلاّ أَنْت، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي، وَمِن شَـرِّ الشَّيْـطانِ وَشِـرْكِه، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم.','أبو داود 4/317'),
	(50,3,'اللّهُـمَّ أَسْـلَمْتُ نَفْـسي إِلَـيْكَ، وَفَوَّضْـتُ أَمْـري إِلَـيْكَ، وَوَجَّـهْتُ وَجْـهي إِلَـيْكَ، وَأَلْـجَـاْتُ ظَهـري إِلَـيْكَ، رَغْبَـةً وَرَهْـبَةً إِلَـيْكَ، لا مَلْجَـأَ وَلا مَنْـجـا مِنْـكَ إِلاّ إِلَـيْكَ، آمَنْـتُ بِكِتـابِكَ الّـذي أَنْزَلْـتَ وَبِنَبِـيِّـكَ الّـذي أَرْسَلْـت.','البخاري مع الفتح 11/113 ومسلم 4/2081'),
	(51,2,'أَمْسَيْـنا وَأَمْسـى المـلكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذهِ اللَّـيْلَةِ وَخَـيرَ ما بَعْـدَهـا ، وَأَعـوذُ بِكَ مِنْ شَـرِّ هـذهِ اللَّـيْلةِ وَشَرِّ ما بَعْـدَهـا ، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُبِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.','مسلم 4/2088'),
	(52,2,'اللّهُـمَّ بِكَ أَمْسَـينا، وَبِكَ أَصْـبَحْنا، وَبِكَ نَحْـيا، وَبِكَ نَمـوتُ وَإِلَـيْكَ المَصـير.','الترمذي 5/466'),
	(53,2,'اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ.','البخاري 7/150'),
	(54,2,'اللّهُـمَّ إِنِّـي أَمسيتُ أَُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلائِكَتِك ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك .(أربع مرات)','أبو داود 4/317'),
	(55,2,'اللّهُـمَّ ما أَمسى بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر.','أبو داود 4/318'),
	(56,2,'اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ . \r\nاللّهُـمَّ إِنّـي أَعـوذُبِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُبِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلاّ أَنْـتَ. (ثلاثاً)','أبو داود 4/324'),
	(57,4,'أَسْـتَغْفِرُ الله . (ثَلاثاً)\r\nاللّهُـمَّ أَنْـتَ السَّلامُ ، وَمِـنْكَ السَّلام ، تَبارَكْتَ يا ذا الجَـلالِ وَالإِكْـرام.','مسلم 1/414'),
	(58,4,'لا إلهَ إلاّ اللّهُ وحدَهُ لا شريكَ لهُ، لهُ المُـلْكُ ولهُ الحَمْد، وهوَ على كلّ شَيءٍ قَدير، اللّهُـمَّ لا مانِعَ لِما أَعْطَـيْت، وَلا مُعْطِـيَ لِما مَنَـعْت، وَلا يَنْفَـعُ ذا الجَـدِّ مِنْـكَ الجَـد.','البخاري 1/255 ومسلم 414'),
	(59,4,'لا إلهَ إلاّ اللّه, وحدَهُ لا شريكَ لهُ، لهُ الملكُ ولهُ الحَمد، وهوَ على كلّ شيءٍ قدير، لا حَـوْلَ وَلا قـوَّةَ إِلاّ بِاللهِ، لا إلهَ إلاّ اللّـه، وَلا نَعْـبُـدُ إِلاّ إيّـاه, لَهُ النِّعْـمَةُ وَلَهُ الفَضْل وَلَهُ الثَّـناءُ الحَـسَن، لا إلهَ إلاّ اللّهُ مخْلِصـينَ لَـهُ الدِّينَ وَلَوْ كَـرِهَ الكـافِرون.','مسلم 1/415'),
	(60,4,'سُـبْحانَ اللهِ، والحَمْـدُ لله ، واللهُ أكْـبَر . (ثلاثاً وثلاثين)\r\nلا إلهَ إلاّ اللّهُ وَحْـدَهُ لا شريكَ لهُ، لهُ الملكُ ولهُ الحَمْد، وهُوَ على كُلّ شَيءٍ قَـدير.','مسلم 1/418'),
	(61,4,'( قُـلْ هُـوَ اللهُ أَحَـدٌ …..) [ الإِخْـلاصْ ]\r\n( قُـلْ أَعـوذُ بِرَبِّ الفَلَـقِ…..) [ الفَلَـقْ ]\r\n( قُـلْ أَعـوذُ بِرَبِّ النّـاسِ…..)[ الـنّاس ] (ثلاث مرات بعد صلاتي الفجر والمغرب. ومرة بعد الصلوات الأخرى)','أبو داود 2/86 والنسائي 3/68'),
	(62,4,'( اللّهُ لا إلهَ إلاّ هُـوَ الـحَيُّ القَيّـومُ لا تَأْخُـذُهُ سِنَـةٌ وَلا نَـوْمٌ …..) [آية الكرسي - البقرة:255]','النسائي في عمل اليوم والليلة برقم 100'),
	(63,4,'لا إلهَ إلاّ اللّهُ وحْـدَهُ لا شريكَ لهُ، لهُ المُلكُ ولهُ الحَمْد، يُحيـي وَيُمـيتُ وهُوَ على كُلّ شيءٍ قدير . (عَشْر مَرّات بَعْدَ المَغْرِب وَالصّـبْح)','الترمذي 5/515'),
	(64,4,'اللّهُـمَّ إِنِّـي أَسْأَلُـكَ عِلْمـاً نافِعـاً وَرِزْقـاً طَيِّـباً ، وَعَمَـلاً مُتَقَـبَّلاً . (بَعْد السّلامِ من صَلاةِ الفَجْر)','صحيح ابن ماجه 1/152');

/*!40000 ALTER TABLE `TextAdhkar` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table TextAdhkarCategory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TextAdhkarCategory`;

CREATE TABLE `TextAdhkarCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `TextAdhkarCategory` WRITE;
/*!40000 ALTER TABLE `TextAdhkarCategory` DISABLE KEYS */;

INSERT INTO `TextAdhkarCategory` (`id`, `name`)
VALUES
	(16,'أدعية من القرآن الكريم'),
	(15,'أذكار الإستيقاظ من النوم'),
	(5,'أذكار الخروج من المسجد'),
	(9,'أذكار الخروج من المنزل'),
	(8,'أذكار الدخول إلى المنزل'),
	(6,'أذكار الدخول للمسجد'),
	(7,'أذكار الذهاب إلى المسجد'),
	(1,'أذكار الصباح'),
	(2,'أذكار المساء'),
	(3,'أذكار النوم'),
	(4,'الذكر بعد الصلاة'),
	(10,'الذكر بعد الفراغ من الوضوء'),
	(11,'الذكر عند الوضوء'),
	(12,'دعاء الخروج من الخلاء'),
	(13,'دعاء دخول الخلاء'),
	(14,'دعاء لبس الثوب');

/*!40000 ALTER TABLE `TextAdhkarCategory` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tilawa
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tilawa`;

CREATE TABLE `tilawa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ordering` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `tilawa` WRITE;
/*!40000 ALTER TABLE `tilawa` DISABLE KEYS */;

INSERT INTO `tilawa` (`id`, `name`, `ordering`)
VALUES
	(41,'سورة الكهف إدريس ابكر','101'),
	(42,'سورة البقرة إدريس ابكر','102'),
	(43,'سورة الكهف راشد العفاسي','103'),
	(44,'تلاوة رائعة من صلاة الفجر إدريس أبكر','104'),
	(45,'نونية ابن القيم في وصف الجنة إدريس أبكر','105'),
	(46,'تلاوة خاشعة لسورة الشمس محمد المنشاوي','106'),
	(47,'تلاوة خاشعة من سورة يونس خالد الجهيم','107'),
	(48,'تلاوة خاشعة من سورة الحديد العفاسي','108'),
	(49,'سورة الزخرف محمد الخريف','109'),
	(50,'تلاوة رائعة لسورة البروج أحمد سعود','110'),
	(51,'تلاوة خاشعة من سورة الإسراء ناصر القطامي','111'),
	(52,'وصف الحور العين نونية ابن القيم إدريس أبكر','112'),
	(53,'تلاوة عطرة لسورة الملك ادريس أبكر','113'),
	(54,'تلاوة مجودة لسورة الرحمن محمد المنشاوي','114'),
	(55,'تلاوة بالحدر لسورة الكهف العفاسي','115'),
	(56,'تلاوة عطرة لسورة الكهف عبد الباسط عبد الصمد','116'),
	(57,'سورة الكهف أنس العمادي','117'),
	(58,'تلاوة رائعة من سورة ال عمران فيصل الرشود','118'),
	(61,'تلاوة عطرة من سورة العنكبوت محمد خليل الرحمن','119'),
	(62,'الفاتحة و النجم هيثم أبو دجانة','120'),
	(63,'آواخر سورة البقرة هيثم أبو دجانة','121'),
	(64,'تلاوة عذبة لأواخر البقرة ادريس أبـكـر','122'),
	(65,'سورة الحاقة ادريس ابكر','123'),
	(66,'سورة المؤمنون تلاوة ندية إدريس أبكر','124'),
	(67,'سورة يوسف خالد الحوسني','125'),
	(68,'سورة البقرة الشيخ حمادي بن علي الماجري','126'),
	(69,'سورة الفاتحة الشيخ حمادي بن علي الماجري','127');

/*!40000 ALTER TABLE `tilawa` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `locked` tinyint(1) NOT NULL,
  `expired` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `credentials_expired` tinyint(1) NOT NULL,
  `credentials_expire_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1483A5E992FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_1483A5E9A0D96FBF` (`email_canonical`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `username_canonical`, `email`, `email_canonical`, `enabled`, `salt`, `password`, `last_login`, `locked`, `expired`, `expires_at`, `confirmation_token`, `password_requested_at`, `roles`, `credentials_expired`, `credentials_expire_at`)
VALUES
	(627,'admin','admin','sadoknet@gmail.com','sadoknet@gmail.com',1,'33mrgzt9z7s4kcgoc8o4oc080gg00s4','EetOgC4AjEJ4Gm9VnRNJyyUnMfUB96yQbDTcUfitja+xQv9CkVhk96mqBwkMtfqJCJx3ScxIaqhfnMQYG90WBw==',NULL,0,0,NULL,NULL,NULL,'a:1:{i:0;s:16:\"ROLE_SUPER_ADMIN\";}',0,NULL);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
