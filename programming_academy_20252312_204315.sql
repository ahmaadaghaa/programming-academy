-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: programming_academy
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `programming_academy`
--

/*!40000 DROP DATABASE IF EXISTS `programming_academy`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `programming_academy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `programming_academy`;

--
-- Table structure for table `academy_reviews`
--

DROP TABLE IF EXISTS `academy_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academy_reviews` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `rating` tinyint(1) NOT NULL COMMENT 'Ø§Ù„ØªÙ‚ÙŠÙŠÙ… Ù…Ù† 1 Ø¥Ù„Ù‰ 5',
  `review_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `idx_reviews_recent` (`created_at`),
  KEY `idx_reviews_rating` (`rating`,`created_at`),
  CONSTRAINT `academy_reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academy_reviews`
--

LOCK TABLES `academy_reviews` WRITE;
/*!40000 ALTER TABLE `academy_reviews` DISABLE KEYS */;
INSERT INTO `academy_reviews` (`id`, `user_id`, `rating`, `review_text`, `created_at`) VALUES (1,1,1,'test','2025-10-07 20:38:35'),(2,1,1,'ww','2025-10-07 20:46:28'),(3,1,1,'s','2025-10-07 20:47:07'),(4,1,3,'s','2025-10-07 20:50:41'),(5,1,4,'dddd','2025-10-07 20:55:37'),(6,1,4,'dddd','2025-10-07 20:55:45'),(7,7,4,'hello','2025-10-07 21:39:13'),(8,1,3,'hi','2025-10-16 22:52:46'),(9,1,5,'hi','2025-10-22 22:26:23'),(10,1,3,'ffggffgfg','2025-12-22 21:05:16'),(11,1,5,'test','2025-12-22 21:05:27');
/*!40000 ALTER TABLE `academy_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignments`
--

DROP TABLE IF EXISTS `assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(10) unsigned NOT NULL,
  `question` text NOT NULL,
  `difficulty` int(11) NOT NULL DEFAULT 1,
  `assignment_order` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_course_assignments` (`course_id`,`assignment_order`),
  KEY `idx_assignment_difficulty` (`difficulty`,`course_id`),
  CONSTRAINT `assignments_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignments`
--

LOCK TABLES `assignments` WRITE;
/*!40000 ALTER TABLE `assignments` DISABLE KEYS */;
INSERT INTO `assignments` (`id`, `course_id`, `question`, `difficulty`, `assignment_order`, `created_at`) VALUES (2,9,'Ø§ÙƒØªØ¨ Ø¯Ø§Ù„Ø© ÙÙŠ Ù„ØºØ© C ØªÙ‚Ø¨Ù„ Ø¹Ø¯Ø¯Ø§Ù‹ ØµØ­ÙŠØ­Ø§Ù‹ ÙˆØªØ¹ÙŠØ¯ Ù…Ø¶Ø±ÙˆØ¨ Ù‡Ø°Ø§ Ø§Ù„Ø¹Ø¯Ø¯ (Factorial).',2,2,'2025-12-07 20:43:57'),(3,9,'Ø§ÙƒØªØ¨ Ø¨Ø±Ù†Ø§Ù…Ø¬Ø§Ù‹ ÙÙŠ Ù„ØºØ© C ÙŠÙ‚Ø±Ø£ Ù…ØµÙÙˆÙØ© Ù…Ù† Ø§Ù„Ø£Ø¹Ø¯Ø§Ø¯ Ø§Ù„ØµØ­ÙŠØ­Ø© Ø«Ù… ÙŠØ·Ø¨Ø¹ Ø£ÙƒØ¨Ø± Ø¹Ù†ØµØ± ÙÙŠÙ‡Ø§.',3,3,'2025-12-07 20:43:57'),(4,10,'Ø§ÙƒØªØ¨ ÙƒÙˆØ¯ CSS Ù„ØªØµÙ…ÙŠÙ… Ù‚Ø§Ø¦Ù…Ø© ØªÙ†Ù‚Ù„ Ø£ÙÙ‚ÙŠØ© Ù…Ø¹ ØªØ£Ø«ÙŠØ±Ø§Øª hover.',2,1,'2025-12-07 20:43:57'),(5,10,'Ø£Ù†Ø´Ø¦ ØªØµÙ…ÙŠÙ… Ù…ØªØ¬Ø§ÙˆØ¨ Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… CSS Grid Ù„ØµÙØ­Ø© Ø´Ø®ØµÙŠØ©.',3,2,'2025-12-07 20:43:57'),(6,8,'Ø£Ù†Ø´Ø¦ ØµÙØ­Ø© HTML ØªØ­ØªÙˆÙŠ Ø¹Ù„Ù‰ Ù†Ù…ÙˆØ°Ø¬ ØªØ³Ø¬ÙŠÙ„ Ø¯Ø®ÙˆÙ„ Ù…Ø¹ Ø¬Ù…ÙŠØ¹ Ø§Ù„Ø­Ù‚ÙˆÙ„ Ø§Ù„Ù…Ø·Ù„ÙˆØ¨Ø©.',1,1,'2025-12-07 20:43:57'),(7,8,'Ø£Ù†Ø´Ø¦ ØµÙØ­Ø© HTML Ù„Ù…Ø¹Ø±Ø¶ ØµÙˆØ± Ù…Ø¹ Ø§Ø³ØªØ®Ø¯Ø§Ù… semantic elements.',2,2,'2025-12-07 20:43:57'),(8,6,'Ø£Ù†Ø´Ø¦ Ù…ÙƒÙˆÙ† React Ù„Ø¹Ø±Ø¶ Ù‚Ø§Ø¦Ù…Ø© Ù…Ù‡Ø§Ù… Ù‚Ø§Ø¨Ù„Ø© Ù„Ù„Ø¥Ø¶Ø§ÙØ© ÙˆØ§Ù„Ø­Ø°Ù.',3,1,'2025-12-07 20:43:57'),(9,6,'Ø£Ù†Ø´Ø¦ ØªØ·Ø¨ÙŠÙ‚ React Ø¨Ø³ÙŠØ· Ù„Ø¥Ø¯Ø§Ø±Ø© Ù‚Ø§Ø¦Ù…Ø© ØªØ³ÙˆÙ‚.',4,2,'2025-12-07 20:43:57'),(10,14,'Ø§ÙƒØªØ¨ API Ø¨Ø³ÙŠØ· Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… Node.js Ùˆ Express ÙŠÙ‚ÙˆÙ… Ø¨Ø¥Ø±Ø¬Ø§Ø¹ Ù‚Ø§Ø¦Ù…Ø© Ù…Ù† Ø§Ù„Ù…Ø³ØªØ®Ø¯Ù…ÙŠÙ†.',3,1,'2025-12-07 20:43:57'),(11,14,'Ø£Ù†Ø´Ø¦ Ù†Ø¸Ø§Ù… Ù…ØµØ§Ø¯Ù‚Ø© Ø£Ø³Ø§Ø³ÙŠ Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… JWT ÙÙŠ Node.js.',4,2,'2025-12-07 20:43:57'),(12,9,'Ø§ÙƒØªØ¨ Ø¯Ø§Ù„Ø© ÙÙŠ Ù„ØºØ© C ØªÙ‚Ø¨Ù„ Ø¹Ø¯Ø¯Ø§Ù‹ ØµØ­ÙŠØ­Ø§Ù‹ ÙˆØªØ¹ÙŠØ¯ Ù…Ø¶Ø±ÙˆØ¨ Ù‡Ø°Ø§ Ø§Ù„Ø¹Ø¯Ø¯ (Factorial)',5,1,'2025-12-16 22:10:18');
/*!40000 ALTER TABLE `assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `challenge_attempts`
--

DROP TABLE IF EXISTS `challenge_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `challenge_attempts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `challenge_id` int(11) NOT NULL,
  `code` text NOT NULL,
  `completed` tinyint(1) DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_attempt` (`user_id`,`challenge_id`),
  KEY `challenge_id` (`challenge_id`),
  CONSTRAINT `challenge_attempts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `challenge_attempts_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenge_attempts`
--

LOCK TABLES `challenge_attempts` WRITE;
/*!40000 ALTER TABLE `challenge_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `challenge_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `challenges`
--

DROP TABLE IF EXISTS `challenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `challenges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `category` enum('algorithms','data-structures','web','database') NOT NULL,
  `difficulty` enum('easy','medium','hard') NOT NULL,
  `points` int(11) NOT NULL DEFAULT 0,
  `starter_code` text DEFAULT NULL,
  `code_language` varchar(50) DEFAULT NULL,
  `test_cases` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`test_cases`)),
  `solution_template` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_challenge_filter` (`category`,`difficulty`,`is_active`),
  KEY `idx_challenge_points` (`points`),
  FULLTEXT KEY `idx_challenge_search` (`title`,`description`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenges`
--

LOCK TABLES `challenges` WRITE;
/*!40000 ALTER TABLE `challenges` DISABLE KEYS */;
INSERT INTO `challenges` (`id`, `title`, `description`, `category`, `difficulty`, `points`, `starter_code`, `code_language`, `test_cases`, `solution_template`, `is_active`, `created_at`, `updated_at`) VALUES (2,'Ø´Ø¬Ø±Ø© Ø«Ù†Ø§Ø¦ÙŠØ© Ø¨Ø­Ø«','ØµÙ…Ù… ÙˆØ·Ø¨Ù‚ Ø´Ø¬Ø±Ø© Ø«Ù†Ø§Ø¦ÙŠØ© Ø¨Ø­Ø« Ù…Ø¹ Ø¹Ù…Ù„ÙŠØ§Øª Ø§Ù„Ø¥Ø¯Ø±Ø§Ø¬ ÙˆØ§Ù„Ø­Ø°Ù ÙˆØ§Ù„Ø¨Ø­Ø«. ØªØ£ÙƒØ¯ Ù…Ù† Ø§Ù„Ø­ÙØ§Ø¸ Ø¹Ù„Ù‰ Ø®ØµØ§Ø¦Øµ Ø´Ø¬Ø±Ø© Ø§Ù„Ø¨Ø­Ø« Ø§Ù„Ø«Ù†Ø§Ø¦ÙŠØ©.','data-structures','medium',100,NULL,'python',NULL,NULL,1,'2025-12-17 19:13:05','2025-12-17 19:13:05'),(3,'Ø¢Ù„Ø© Ø­Ø§Ø³Ø¨Ø© ØªÙØ§Ø¹Ù„ÙŠØ©','Ø£Ù†Ø´Ø¦ Ø¢Ù„Ø© Ø­Ø§Ø³Ø¨Ø© ØªÙØ§Ø¹Ù„ÙŠØ© Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… HTML CSS ÙˆJavaScript. ÙŠØ¬Ø¨ Ø£Ù† ØªØ¯Ø¹Ù… Ø§Ù„Ø¹Ù…Ù„ÙŠØ§Øª Ø§Ù„Ø£Ø³Ø§Ø³ÙŠØ© ÙˆØ§Ù„Ø¹Ù…Ù„ÙŠØ§Øª Ø§Ù„Ù…ØªÙ‚Ø¯Ù…Ø©.','web','easy',75,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:13:05','2025-12-17 19:13:05'),(7,'Ù…Ù‚Ù„ÙˆØ¨ Ø§Ù„Ù…ØµÙÙˆÙØ©','Ø§ÙƒØªØ¨ Ø¯Ø§Ù„Ø© ØªÙ‚ÙˆÙ… Ø¨Ù‚Ù„Ø¨ Ø¹Ù†Ø§ØµØ± Ø§Ù„Ù…ØµÙÙˆÙØ© Ø¨Ø¯ÙˆÙ† Ø§Ø³ØªØ®Ø¯Ø§Ù… Ø¯ÙˆØ§Ù„ Ø¬Ø§Ù‡Ø²Ø©. ÙŠØ¬Ø¨ Ø£Ù† ØªØ¹ÙŠØ¯ Ø§Ù„Ù…ØµÙÙˆÙØ© Ø§Ù„Ù…Ù‚Ù„ÙˆØ¨Ø©.','algorithms','easy',40,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(8,'Ø¬Ù…Ø¹ Ø§Ù„Ø£Ø±Ù‚Ø§Ù… ÙÙŠ Ù…ØµÙÙˆÙØ©','Ø§ÙƒØªØ¨ Ø¯Ø§Ù„Ø© ØªØ­Ø³Ø¨ Ù…Ø¬Ù…ÙˆØ¹ Ø¬Ù…ÙŠØ¹ Ø§Ù„Ø£Ø±Ù‚Ø§Ù… ÙÙŠ Ù…ØµÙÙˆÙØ© Ù…Ø¹ÙŠÙ†Ø© ÙˆØªØ¹ÙŠØ¯ Ø§Ù„Ù†ØªÙŠØ¬Ø©.','algorithms','easy',35,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(9,'ØªØ±ØªÙŠØ¨ Ø¨Ø§Ù„ÙÙ‚Ø§Ø¹Ø§Øª','Ø·Ø¨Ù‚ Ø®ÙˆØ§Ø±Ø²Ù…ÙŠØ© ØªØ±ØªÙŠØ¨ Ø§Ù„ÙÙ‚Ø§Ø¹Ø§Øª (Bubble Sort) Ù„ØªØ±ØªÙŠØ¨ Ù…ØµÙÙˆÙØ© Ù…Ù† Ø§Ù„Ø£Ø±Ù‚Ø§Ù… ØªØµØ§Ø¹Ø¯ÙŠØ§Ù‹.','algorithms','medium',70,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(10,'Ø£ÙƒØ¨Ø± Ø¹Ø¯Ø¯ Ù…Ø´ØªØ±Ùƒ','Ø§ÙƒØªØ¨ Ø¯Ø§Ù„Ø© ØªØ­Ø³Ø¨ Ø£ÙƒØ¨Ø± Ø¹Ø¯Ø¯ Ù…Ø´ØªØ±Ùƒ (GCD) Ø¨ÙŠÙ† Ø¹Ø¯Ø¯ÙŠÙ† Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… Ø®ÙˆØ§Ø±Ø²Ù…ÙŠØ© Ø¥Ù‚Ù„ÙŠØ¯Ø³.','algorithms','medium',65,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(11,'Ø£Ø³Ø±Ø¹ Ø·Ø±ÙŠÙ‚','Ø·Ø¨Ù‚ Ø®ÙˆØ§Ø±Ø²Ù…ÙŠØ© Ø¯Ø§ÙŠÙƒØ³ØªØ±Ø§ Ù„Ø¥ÙŠØ¬Ø§Ø¯ Ø£Ù‚ØµØ± Ø·Ø±ÙŠÙ‚ ÙÙŠ Ø±Ø³Ù… Ø¨ÙŠØ§Ù†ÙŠ Ù…Ø¹ Ø£ÙˆØ²Ø§Ù†.','algorithms','hard',150,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(12,'Ù‚Ø§Ø¦Ù…Ø© Ù…Ø±ØªØ¨Ø·Ø© Ø¨Ø³ÙŠØ·Ø©','Ø£Ù†Ø´Ø¦ ÙØ¦Ø© Ù‚Ø§Ø¦Ù…Ø© Ù…Ø±ØªØ¨Ø·Ø© Ø¨Ø³ÙŠØ·Ø© Ù…Ø¹ Ø¹Ù…Ù„ÙŠØ§Øª Ø§Ù„Ø¥Ø¯Ø±Ø§Ø¬ ÙÙŠ Ø§Ù„Ø¨Ø¯Ø§ÙŠØ© ÙˆØ§Ù„Ù†Ù‡Ø§ÙŠØ© ÙˆØ§Ù„Ø­Ø°Ù.','data-structures','easy',60,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(13,'Ù…ÙƒØ¯Ø³ Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… Ù…ØµÙÙˆÙØ©','Ø·Ø¨Ù‚ Ø¨Ù†ÙŠØ© Ù…ÙƒØ¯Ø³ (Stack) Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… Ù…ØµÙÙˆÙØ© Ù…Ø¹ Ø¹Ù…Ù„ÙŠØ§Øª push Ùˆ pop Ùˆ peek.','data-structures','medium',80,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(14,'Ø·Ø§Ø¨ÙˆØ± Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… Ù‚Ø§Ø¦Ù…Ø© Ù…Ø±ØªØ¨Ø·Ø©','Ø·Ø¨Ù‚ Ø¨Ù†ÙŠØ© Ø·Ø§Ø¨ÙˆØ± (Queue) Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… Ù‚Ø§Ø¦Ù…Ø© Ù…Ø±ØªØ¨Ø·Ø© Ù…Ø¹ Ø¹Ù…Ù„ÙŠØ§Øª enqueue Ùˆ dequeue.','data-structures','medium',85,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(15,'Ø´Ø¬Ø±Ø© AVL','Ø·Ø¨Ù‚ Ø´Ø¬Ø±Ø© AVL Ù…Ø¹ Ø¹Ù…Ù„ÙŠØ§Øª Ø§Ù„Ø¥Ø¯Ø±Ø§Ø¬ ÙˆØ§Ù„Ø­Ø°Ù Ù…Ø¹ Ø§Ù„Ø­ÙØ§Ø¸ Ø¹Ù„Ù‰ ØªÙˆØ§Ø²Ù† Ø§Ù„Ø´Ø¬Ø±Ø©.','data-structures','hard',180,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(16,'ØªØ­Ù‚Ù‚ Ù…Ù† ØµØ­Ø© Ø§Ù„Ø¨Ø±ÙŠØ¯ Ø§Ù„Ø¥Ù„ÙƒØªØ±ÙˆÙ†ÙŠ','Ø§ÙƒØªØ¨ Ø¯Ø§Ù„Ø© JavaScript ØªØªØ­Ù‚Ù‚ Ù…Ù† ØµØ­Ø© Ø¹Ù†ÙˆØ§Ù† Ø§Ù„Ø¨Ø±ÙŠØ¯ Ø§Ù„Ø¥Ù„ÙƒØªØ±ÙˆÙ†ÙŠ Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… ØªØ¹Ø¨ÙŠØ±Ø§Øª Ù…Ù†ØªØ¸Ù…Ø©.','web','easy',45,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(17,'ØªØºÙŠÙŠØ± Ø£Ù„ÙˆØ§Ù† Ø§Ù„Ø¹Ù†Ø§ØµØ±','Ø£Ù†Ø´Ø¦ ØµÙØ­Ø© HTML Ø¨Ø£Ø²Ø±Ø§Ø± ØªØªÙŠØ­ ØªØºÙŠÙŠØ± Ø£Ù„ÙˆØ§Ù† Ø¹Ù†Ø§ØµØ± Ø§Ù„ØµÙØ­Ø© Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… JavaScript.','web','easy',50,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(18,'Ù‚Ø§Ø¦Ù…Ø© Ù…Ù‡Ø§Ù… ØªÙØ§Ø¹Ù„ÙŠØ©','Ø£Ù†Ø´Ø¦ ØªØ·Ø¨ÙŠÙ‚ Ù‚Ø§Ø¦Ù…Ø© Ù…Ù‡Ø§Ù… Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… HTMLØŒ CSSØŒ ÙˆJavaScript Ù…Ø¹ Ø¥Ù…ÙƒØ§Ù†ÙŠØ© Ø¥Ø¶Ø§ÙØ© ÙˆØ­Ø°Ù Ø§Ù„Ù…Ù‡Ø§Ù….','web','medium',90,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(19,'Ø³Ø§Ø¹Ø© Ø±Ù‚Ù…ÙŠØ©','Ø£Ù†Ø´Ø¦ Ø³Ø§Ø¹Ø© Ø±Ù‚Ù…ÙŠØ© ØªÙØ¸Ù‡Ø± Ø§Ù„ÙˆÙ‚Øª Ø§Ù„Ø­Ø§Ù„ÙŠ ÙˆØªØªØ­Ø¯Ø« ÙƒÙ„ Ø«Ø§Ù†ÙŠØ© Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… JavaScript.','web','medium',75,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(20,'Ù„Ø¹Ø¨Ø© Ø§Ù„Ø°Ø§ÙƒØ±Ø©','Ø£Ù†Ø´Ø¦ Ù„Ø¹Ø¨Ø© Ø§Ù„Ø°Ø§ÙƒØ±Ø© (Memory Game) Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… JavaScript Ù…Ø¹ Ø¨Ø·Ø§Ù‚Ø§Øª Ù‚Ø§Ø¨Ù„Ø© Ù„Ù„Ù‚Ù„Ø¨ ÙˆÙ†Ø¸Ø§Ù… Ù†Ù‚Ø§Ø·.','web','hard',140,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(21,'Ø§Ø³ØªØ¹Ù„Ø§Ù… Ø¨Ø³ÙŠØ· Ù„Ù„Ø·Ù„Ø§Ø¨','Ø§ÙƒØªØ¨ Ø§Ø³ØªØ¹Ù„Ø§Ù… SQL Ù„Ø§Ø³ØªØ®Ø±Ø§Ø¬ Ø£Ø³Ù…Ø§Ø¡ Ø¬Ù…ÙŠØ¹ Ø§Ù„Ø·Ù„Ø§Ø¨ Ù…Ù† Ø¬Ø¯ÙˆÙ„ Ø§Ù„Ø·Ù„Ø§Ø¨ Ù…Ø±ØªØ¨Ø© Ø£Ø¨Ø¬Ø¯ÙŠØ§Ù‹.','database','easy',30,NULL,'sql',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(22,'Ø§Ù†Ø¶Ù…Ø§Ù… Ø¬Ø¯Ø§ÙˆÙ„ Ø§Ù„Ø·Ù„Ø§Ø¨ ÙˆØ§Ù„ÙƒÙˆØ±Ø³Ø§Øª','Ø§ÙƒØªØ¨ Ø§Ø³ØªØ¹Ù„Ø§Ù… SQL ÙŠØ¬Ù…Ø¹ Ø¨ÙŠÙ† Ø¬Ø¯Ø§ÙˆÙ„ Ø§Ù„Ø·Ù„Ø§Ø¨ ÙˆØ§Ù„ÙƒÙˆØ±Ø³Ø§Øª Ù„Ø¥Ø¸Ù‡Ø§Ø± Ø§Ù„Ø·Ù„Ø§Ø¨ Ø§Ù„Ù…Ø³Ø¬Ù„ÙŠÙ† ÙÙŠ ÙƒÙ„ ÙƒÙˆØ±Ø³.','database','medium',55,NULL,'sql',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(23,'Ø¥Ø­ØµØ§Ø¦ÙŠØ§Øª Ø§Ù„Ù…Ø¨ÙŠØ¹Ø§Øª','Ø§ÙƒØªØ¨ Ø§Ø³ØªØ¹Ù„Ø§Ù… SQL ÙŠØ­Ø³Ø¨ Ø¥Ø¬Ù…Ø§Ù„ÙŠ Ø§Ù„Ù…Ø¨ÙŠØ¹Ø§Øª Ù„ÙƒÙ„ Ù…Ù†ØªØ¬ ÙˆÙŠØ¸Ù‡Ø± Ø£Ø¹Ù„Ù‰ 5 Ù…Ù†ØªØ¬Ø§Øª Ù…Ø¨ÙŠØ¹Ø§Ù‹.','database','medium',70,NULL,'sql',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(24,'ØªÙ‚Ø±ÙŠØ± Ù…Ø¹Ù‚Ø¯ Ù„Ù„Ù…Ø®Ø²ÙˆÙ†','Ø§ÙƒØªØ¨ Ø§Ø³ØªØ¹Ù„Ø§Ù…Ø§Øª SQL Ù…Ø¹Ù‚Ø¯Ø© Ù„Ø¥Ù†Ø´Ø§Ø¡ ØªÙ‚Ø±ÙŠØ± Ø´Ø§Ù…Ù„ Ø¹Ù† Ø­Ø§Ù„Ø© Ø§Ù„Ù…Ø®Ø²ÙˆÙ† Ù…Ø¹ Ø§Ù„ØªÙ†Ø¨Ø¤Ø§Øª ÙˆØ§Ù„Ø¥Ù†Ø°Ø§Ø±Ø§Øª.','database','hard',120,NULL,'sql',NULL,NULL,1,'2025-12-17 19:45:34','2025-12-17 19:45:34'),(25,'Test Challenge','Test description','algorithms','easy',50,NULL,'javascript',NULL,NULL,1,'2025-12-17 19:50:04','2025-12-17 19:50:04'),(26,'Test Challenge API','Test description for API','algorithms','easy',50,NULL,NULL,NULL,NULL,1,'2025-12-17 19:51:16','2025-12-17 19:51:16'),(27,'Test','Test','algorithms','easy',10,NULL,NULL,NULL,NULL,1,'2025-12-17 19:58:48','2025-12-17 19:58:48'),(28,'dffesda','fasfasfsfa','algorithms','easy',50,NULL,'saffsasfasaf','[{\"input\": \"test\", \"expected\": \"output\"}]','asfsafsafsaffas',1,'2025-12-17 19:59:47','2025-12-17 20:12:19');
/*!40000 ALTER TABLE `challenges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `course_stats`
--

DROP TABLE IF EXISTS `course_stats`;
/*!50001 DROP VIEW IF EXISTS `course_stats`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `course_stats` AS SELECT
 1 AS `id`,
  1 AS `title`,
  1 AS `category`,
  1 AS `level`,
  1 AS `is_active`,
  1 AS `created_at`,
  1 AS `lesson_count`,
  1 AS `enrolled_users`,
  1 AS `completed_users`,
  1 AS `avg_completion_rate`,
  1 AS `total_views`,
  1 AS `assignment_count`,
  1 AS `last_activity` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `main_points` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `category` varchar(100) DEFAULT NULL,
  `logo_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `level` varchar(50) DEFAULT 'Beginner',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_category_active` (`category`,`is_active`,`created_at`),
  KEY `idx_level_active` (`level`,`is_active`),
  FULLTEXT KEY `idx_course_search` (`title`,`description`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` (`id`, `title`, `description`, `main_points`, `updated_at`, `category`, `logo_path`, `created_at`, `level`, `is_active`) VALUES (6,'react','Ù…ÙƒØªØ¨Ø© JavaScript Ù„Ø¨Ù†Ø§Ø¡ ÙˆØ§Ø¬Ù‡Ø§Øª Ø§Ù„Ù…Ø³ØªØ®Ø¯Ù…ØŒ ØªØ¹Ù„Ù… Ø¨Ù†Ø§Ø¡ ØªØ·Ø¨ÙŠÙ‚Ø§Øª ÙˆÙŠØ¨ Ù…Ø¹Ù‚Ø¯Ø© ÙˆÙ‚Ø§Ø¨Ù„Ø© Ù„Ù„ØªØ·ÙˆÙŠØ±.\r\n\r\nfrontend',NULL,'2025-12-05 22:21:50','frontend',NULL,'2025-10-11 20:27:44','Beginner',1),(8,'html','Ù„ØºØ© ØªØ±Ù…ÙŠØ² Ø§Ù„Ù†ØµÙˆØµ Ø§Ù„ØªØ´Ø¹Ø¨ÙŠØ©ØŒ Ø§Ù„Ø¹Ù…ÙˆØ¯ Ø§Ù„ÙÙ‚Ø±ÙŠ Ù„Ø£ÙŠ Ù…ÙˆÙ‚Ø¹ ÙˆÙŠØ¨. ØªØ¹Ù„Ù… Ø¨Ù†Ø§Ø¡ Ø§Ù„Ù‡ÙŠÙƒÙ„ Ø§Ù„Ø£Ø³Ø§Ø³ÙŠ Ù„Ù„ØµÙØ­Ø§Øª.',NULL,'2025-12-05 22:21:50','frontend',NULL,'2025-10-11 21:10:33','Beginner',1),(9,'c','Ù„ØºØ© Ø¨Ø±Ù…Ø¬Ø© Ù‚ÙˆÙŠØ© ÙˆÙ…Ù†Ø¸Ù…Ø©ØŒ ØªØ¹ØªØ¨Ø± Ø£Ø³Ø§Ø³ Ø§Ù„Ø¹Ø¯ÙŠØ¯ Ù…Ù† Ø§Ù„Ù„ØºØ§Øª Ø§Ù„Ø­Ø¯ÙŠØ«Ø©. Ù…Ø«Ø§Ù„ÙŠØ© Ù„ÙÙ‡Ù… Ø£Ø³Ø§Ø³ÙŠØ§Øª Ø§Ù„Ø¨Ø±Ù…Ø¬Ø© ÙˆÙ‡ÙŠØ§ÙƒÙ„ Ø§Ù„Ø¨ÙŠØ§Ù†Ø§Øª.','Ø£Ø³Ø§Ø³ÙŠØ§Øª Ø§Ù„Ø¨Ø±Ù…Ø¬Ø© ÙˆØ§Ù„Ù…Ù†Ø·Ù‚\r\nÙ‡ÙŠØ§ÙƒÙ„ Ø§Ù„Ø¨ÙŠØ§Ù†Ø§Øª ÙˆØ§Ù„Ù…Ø¤Ø´Ø±Ø§Øª\r\nØ¥Ø¯Ø§Ø±Ø© Ø§Ù„Ø°Ø§ÙƒØ±Ø© ÙˆØ§Ù„Ù…ÙƒØªØ¨Ø§Øª\r\nÙ…Ø´Ø§Ø±ÙŠØ¹ Ø¹Ù…Ù„ÙŠØ© ÙˆØªØ·Ø¨ÙŠÙ‚Ø§Øª','2025-12-05 22:21:50','basics',NULL,'2025-10-12 19:57:14','Beginner',1),(10,'css','sadadsa','asda sda assdadas\r\nasdassdasd\r\ndassadsasadas','2025-12-05 22:21:50','basics',NULL,'2025-10-12 21:38:40','Beginner',1),(14,'ahmad','aghaa','hello','2025-12-06 19:54:55','backend','uploads/logos/logo_69348a0f9e39f2.44924036.png','2025-12-05 21:02:14','Ù…Ø¨ØªØ¯Ø¦',1),(21,'aghaaa','moo','hmq','2025-12-06 20:52:29','backend','uploads/logos/logo_6934977771d0f3.39802466.png','2025-12-06 19:55:27','Ù…Ø¨ØªØ¯Ø¦',1),(22,'efwfew','efeqqfqe','qefqeeqf','2025-12-06 21:01:44','basics',NULL,'2025-12-06 21:01:44','Ù…ØªÙˆØ³Ø·-Ù…ØªÙ‚Ø¯Ù…',1);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examples`
--

DROP TABLE IF EXISTS `examples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `examples` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `category` enum('frontend','backend','mobile','algorithms') NOT NULL,
  `difficulty` enum('beginner','intermediate','advanced') NOT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `code_snippet` text NOT NULL,
  `code_language` varchar(50) NOT NULL,
  `technologies` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`technologies`)),
  `demo_url` varchar(500) DEFAULT NULL,
  `requires_special_env` tinyint(1) DEFAULT 0,
  `special_env_message` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category`),
  KEY `idx_difficulty` (`difficulty`),
  KEY `idx_active` (`is_active`),
  KEY `idx_example_filter` (`category`,`difficulty`,`is_active`),
  KEY `idx_example_tech` (`code_language`,`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examples`
--

LOCK TABLES `examples` WRITE;
/*!40000 ALTER TABLE `examples` DISABLE KEYS */;
INSERT INTO `examples` (`id`, `title`, `description`, `category`, `difficulty`, `image_url`, `code_snippet`, `code_language`, `technologies`, `demo_url`, `requires_special_env`, `special_env_message`, `is_active`, `created_at`, `updated_at`) VALUES (1,'Ø¢Ù„Ø© Ø­Ø§Ø³Ø¨Ø© ØªÙØ§Ø¹Ù„ÙŠØ©','Ø¢Ù„Ø© Ø­Ø§Ø³Ø¨Ø© ØªÙØ§Ø¹Ù„ÙŠØ© Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… HTML, CSS Ùˆ JavaScript Ù…Ø¹ ØªØµÙ…ÙŠÙ… Ø¹ØµØ±ÙŠ','frontend','beginner','https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80','// Ø¯Ø§Ù„Ø© Ù„Ø¥Ø¶Ø§ÙØ© Ø§Ù„Ø£Ø±Ù‚Ø§Ù…\r\nfunction addNumber(num) {\r\n    document.getElementById(\'display\').value += num;\r\n}\r\n\r\n// Ø¯Ø§Ù„Ø© Ù„Ø¥Ø¬Ø±Ø§Ø¡ Ø§Ù„Ø¹Ù…Ù„ÙŠØ§Øª Ø§Ù„Ø­Ø³Ø§Ø¨ÙŠØ©\r\nfunction calculate() {\r\n    let display = document.getElementById(\'display\');\r\n    try {\r\n        display.value = eval(display.value);\r\n    } catch (e) {\r\n        display.value = \'Error\';\r\n    }\r\n}\r\n\r\n// Ø¯Ø§Ù„Ø© Ù…Ø³Ø­ Ø§Ù„Ø´Ø§Ø´Ø©\r\nfunction clearDisplay() {\r\n    document.getElementById(\'display\').value = \'\';\r\n}','javascript','[\"HTML\",\"CSS\",\"JavaScript\"]',NULL,0,NULL,1,'2025-11-27 17:06:54','2025-11-27 17:06:54'),(2,'Ù†Ø¸Ø§Ù… Ø¥Ø¯Ø§Ø±Ø© Ø§Ù„Ù…Ø³ØªØ®Ø¯Ù…ÙŠÙ†','Ù†Ø¸Ø§Ù… Ù„Ø¥Ø¯Ø§Ø±Ø© Ø§Ù„Ù…Ø³ØªØ®Ø¯Ù…ÙŠÙ† Ø¨Ø§Ø³ØªØ®Ø¯Ø§Ù… Node.js Ùˆ Express Ù…Ø¹ Ù‚Ø§Ø¹Ø¯Ø© Ø¨ÙŠØ§Ù†Ø§Øª MongoDB','backend','intermediate','https://images.unsplash.com/photo-1558494949-ef010cbdcc31?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80','// Ù†Ù…ÙˆØ°Ø¬ Ø§Ù„Ù…Ø³ØªØ®Ø¯Ù… ÙÙŠ MongoDB\r\nconst userSchema = new mongoose.Schema({\r\n    name: { type: String, required: true },\r\n    email: { type: String, required: true, unique: true },\r\n    password: { type: String, required: true },\r\n    role: { type: String, default: \'user\' }\r\n});\r\n\r\n// Ø¥Ù†Ø´Ø§Ø¡ Ù…Ø³ØªØ®Ø¯Ù… Ø¬Ø¯ÙŠØ¯\r\napp.post(\'/api/users\', async (req, res) => {\r\n    try {\r\n        const user = new User(req.body);\r\n        await user.save();\r\n        res.status(201).json(user);\r\n    } catch (error) {\r\n        res.status(400).json({ error: error.message });\r\n    }\r\n});','javascript','[\"Node.js\",\"Express\",\"MongoDB\"]',NULL,0,NULL,1,'2025-11-27 17:06:54','2025-11-27 17:06:54'),(3,'ØªØ·Ø¨ÙŠÙ‚ Ù‚Ø§Ø¦Ù…Ø© Ø§Ù„Ù…Ù‡Ø§Ù…','ØªØ·Ø¨ÙŠÙ‚ Flutter Ù„Ø¥Ø¯Ø§Ø±Ø© Ø§Ù„Ù…Ù‡Ø§Ù… Ø§Ù„ÙŠÙˆÙ…ÙŠØ© Ù…Ø¹ Ø¥Ù…ÙƒØ§Ù†ÙŠØ© Ø§Ù„Ø¥Ø¶Ø§ÙØ© ÙˆØ§Ù„Ø­Ø°Ù ÙˆØ§Ù„ØªØ¹Ø¯ÙŠÙ„','mobile','beginner','https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80','// Ù†Ù…ÙˆØ°Ø¬ Ø§Ù„Ù…Ù‡Ù…Ø©\r\nclass Task {\r\n  int id;\r\n  String title;\r\n  bool isCompleted;\r\n\r\n  Task({this.id, this.title, this.isCompleted = false});\r\n\r\n  Map<String, dynamic> toMap() {\r\n    return {\r\n      \'id\': id,\r\n      \'title\': title,\r\n      \'isCompleted\': isCompleted ? 1 : 0,\r\n    };\r\n  }\r\n}\r\n\r\n// Ø¥Ø¶Ø§ÙØ© Ù…Ù‡Ù…Ø© Ø¬Ø¯ÙŠØ¯Ø©\r\nvoid addTask(String taskTitle) {\r\n  final task = Task(title: taskTitle);\r\n  _tasks.add(task);\r\n  notifyListeners();\r\n}','dart','[\"Flutter\",\"Dart\",\"SQLite\"]',NULL,0,NULL,1,'2025-11-27 17:06:54','2025-11-27 17:06:54'),(4,'Ø®ÙˆØ§Ø±Ø²Ù…ÙŠØ© Ø§Ù„Ø¨Ø­Ø« Ø§Ù„Ø«Ù†Ø§Ø¦ÙŠ','ØªÙ†ÙÙŠØ° Ø®ÙˆØ§Ø±Ø²Ù…ÙŠØ© Ø§Ù„Ø¨Ø­Ø« Ø§Ù„Ø«Ù†Ø§Ø¦ÙŠ ÙÙŠ JavaScript Ù…Ø¹ Ø´Ø±Ø­ Ù…ÙØµÙ„ Ù„ÙƒÙŠÙÙŠØ© Ø¹Ù…Ù„Ù‡Ø§','algorithms','intermediate','https://images.unsplash.com/photo-1509228468518-180dd4864904?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80','// Ø®ÙˆØ§Ø±Ø²Ù…ÙŠØ© Ø§Ù„Ø¨Ø­Ø« Ø§Ù„Ø«Ù†Ø§Ø¦ÙŠ\r\nfunction binarySearch(arr, target) {\r\n    let left = 0;\r\n    let right = arr.length - 1;\r\n\r\n    while (left <= right) {\r\n        // Ø­Ø³Ø§Ø¨ Ù…Ù†ØªØµÙ Ø§Ù„Ù…ØµÙÙˆÙØ©\r\n        let mid = Math.floor((left + right) / 2);\r\n\r\n        // Ø¥Ø°Ø§ ÙƒØ§Ù† Ø§Ù„Ø¹Ù†ØµØ± ÙÙŠ Ø§Ù„Ù…Ù†ØªØµÙ Ù‡Ùˆ Ø§Ù„Ù‡Ø¯Ù\r\n        if (arr[mid] === target) {\r\n            return mid;\r\n        }\r\n\r\n        // Ø¥Ø°Ø§ ÙƒØ§Ù† Ø§Ù„Ù‡Ø¯Ù Ø£ØµØºØ±ØŒ Ù†Ø¨Ø­Ø« ÙÙŠ Ø§Ù„Ù†ØµÙ Ø§Ù„Ø£ÙŠØ³Ø±\r\n        if (target < arr[mid]) {\r\n            right = mid - 1;\r\n        }\r\n        // Ø¥Ø°Ø§ ÙƒØ§Ù† Ø§Ù„Ù‡Ø¯Ù Ø£ÙƒØ¨Ø±ØŒ Ù†Ø¨Ø­Ø« ÙÙŠ Ø§Ù„Ù†ØµÙ Ø§Ù„Ø£ÙŠÙ…Ù†\r\n        else {\r\n            left = mid + 1;\r\n        }\r\n    }\r\n\r\n    // Ø¥Ø°Ø§ Ù„Ù… ÙŠØªÙ… Ø§Ù„Ø¹Ø«ÙˆØ± Ø¹Ù„Ù‰ Ø§Ù„Ø¹Ù†ØµØ±\r\n    return -1;\r\n}','javascript','[\"JavaScript\",\"\\u0627\\u0644\\u062e\\u0648\\u0627\\u0631\\u0632\\u0645\\u064a\\u0627\\u062a\"]',NULL,0,NULL,1,'2025-11-27 17:06:54','2025-11-27 17:06:54'),(5,'test','test','frontend','','','<!DOCTYPE html>\n<html lang=\"ar\" dir=\"rtl\">\n  <head>\n    <meta charset=\"UTF-8\" />\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n    <title>Navbar Only - Programming Academy</title>\n    <link\n      rel=\"stylesheet\"\n      href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css\"\n    />\n    <style>\n      :root {\n        --primary: #4361ee;\n        --secondary: #3a0ca3;\n        --accent: #4cc9f0;\n        --success: #4ade80;\n        --warning: #f59e0b;\n        --danger: #ef4444;\n        --dark: #1e293b;\n        --light: #f8fafc;\n        --gray: #64748b;\n        --card-bg: #ffffff;\n        --shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);\n        --transition: all 0.3s ease;\n        --border-radius-small: 5px;\n      }\n\n      * {\n        margin: 0;\n        padding: 0;\n        box-sizing: border-box;\n        font-family: \"Segoe UI\", Tahoma, Geneva, Verdana, sans-serif;\n      }\n\n      body {\n        background-color: var(--light);\n        color: var(--dark);\n        line-height: 1.6;\n        min-height: 100vh;\n        padding-top: 80px;\n      }\n\n      .container {\n        width: 100%;\n        max-width: 1200px;\n        margin: 0 auto;\n        padding: 0 20px;\n      }\n\n      /* Header & Navbar */\n      header {\n        background: linear-gradient(135deg, var(--primary), var(--secondary));\n        color: white;\n        position: fixed;\n        width: 100%;\n        top: 0;\n        z-index: 1000;\n        box-shadow: var(--shadow);\n      }\n\n      .navbar {\n        display: flex;\n        justify-content: space-between;\n        align-items: center;\n        padding: 1rem 2rem;\n      }\n\n      .logo {\n        display: flex;\n        align-items: center;\n        gap: 10px;\n      }\n\n      .logo-img {\n        width: 50px;\n        height: 50px;\n        background: linear-gradient(45deg, var(--accent), var(--primary));\n        border-radius: 50%;\n        display: flex;\n        align-items: center;\n        justify-content: center;\n        color: white;\n        font-size: 1.5rem;\n        animation: rotate 10s linear infinite;\n      }\n\n      @keyframes rotate {\n        0% {\n          transform: rotate(0deg);\n        }\n        100% {\n          transform: rotate(360deg);\n        }\n      }\n\n      .logo h1 {\n        font-size: 1.5rem;\n        white-space: nowrap;\n      }\n\n      .nav-links {\n        display: flex;\n        list-style: none;\n        gap: 1.5rem;\n        align-items: center;\n      }\n\n      .nav-link {\n        color: white;\n        text-decoration: none;\n        font-weight: 500;\n        padding: 0.5rem 1rem;\n        border-radius: 5px;\n        transition: var(--transition);\n        position: relative;\n        display: block;\n      }\n\n      .nav-link:hover {\n        background-color: rgba(255, 255, 255, 0.1);\n      }\n\n      .dropdown {\n        position: relative;\n      }\n\n      .dropdown-menu {\n        position: absolute;\n        top: 100%;\n        right: 0;\n        background: white;\n        min-width: 200px;\n        box-shadow: var(--shadow);\n        border-radius: 8px;\n        opacity: 0;\n        visibility: hidden;\n        transform: translateY(10px);\n        transition: var(--transition);\n        z-index: 100;\n      }\n\n      .dropdown:hover .dropdown-menu {\n        opacity: 1;\n        visibility: visible;\n        transform: translateY(0);\n      }\n\n      .dropdown-menu a {\n        display: block;\n        padding: 0.8rem 1rem;\n        color: var(--dark);\n        text-decoration: none;\n        border-bottom: 1px solid #eee;\n        transition: var(--transition);\n      }\n\n      .dropdown-menu a:hover {\n        background-color: #f5f5f5;\n        color: var(--primary);\n      }\n\n      .dropdown-menu a:last-child {\n        border-bottom: none;\n      }\n\n      .login-btn {\n        background-color: var(--accent);\n        border-radius: 50px;\n        padding: 0.5rem 1.5rem;\n      }\n\n      .login-btn:hover {\n        background-color: #3ab0d9;\n      }\n\n      /* User Profile Dropdown */\n      .user-profile {\n        position: relative;\n        display: flex;\n        align-items: center;\n        gap: 0.5rem;\n        cursor: pointer;\n      }\n\n      .user-avatar-small {\n        width: 40px;\n        height: 40px;\n        border-radius: 50%;\n        background: linear-gradient(135deg, var(--accent), var(--primary));\n        display: flex;\n        align-items: center;\n        justify-content: center;\n        color: white;\n        font-weight: bold;\n        border: 2px solid white;\n      }\n\n      .user-dropdown {\n        position: absolute;\n        top: 100%;\n        left: 0;\n        background: white;\n        min-width: 200px;\n        box-shadow: var(--shadow);\n        border-radius: 10px;\n        padding: 1rem;\n        opacity: 0;\n        visibility: hidden;\n        transform: translateY(10px);\n        transition: var(--transition);\n        z-index: 1000;\n      }\n\n      .user-profile:hover .user-dropdown {\n        opacity: 1;\n        visibility: visible;\n        transform: translateY(0);\n      }\n\n      .user-info {\n        display: flex;\n        align-items: center;\n        gap: 0.5rem;\n        padding-bottom: 0.5rem;\n        border-bottom: 1px solid #eee;\n        margin-bottom: 0.5rem;\n      }\n\n      .user-name {\n        font-weight: 600;\n        color: var(--dark);\n      }\n\n      .user-email {\n        font-size: 0.8rem;\n        color: var(--gray);\n      }\n\n      .logout-btn {\n        background: var(--danger);\n        color: white;\n        border: none;\n        padding: 0.5rem 1rem;\n        border-radius: var(--border-radius-small);\n        cursor: pointer;\n        width: 100%;\n        transition: var(--transition);\n      }\n\n      .logout-btn:hover {\n        background: #dc2626;\n      }\n\n      /* ============================================\n         MOBILE MENU STYLES\n         ============================================ */\n\n      .mobile-menu-btn {\n        display: none;\n        flex-direction: column;\n        cursor: pointer;\n        z-index: 1001;\n      }\n\n      .mobile-menu-btn span {\n        width: 25px;\n        height: 3px;\n        background: white;\n        margin: 3px 0;\n        transition: var(--transition);\n      }\n\n      .mobile-menu-btn.active span:nth-child(1) {\n        transform: rotate(45deg) translate(5px, 5px);\n      }\n\n      .mobile-menu-btn.active span:nth-child(2) {\n        opacity: 0;\n      }\n\n      .mobile-menu-btn.active span:nth-child(3) {\n        transform: rotate(-45deg) translate(7px, -6px);\n      }\n\n      /* Mobile Menu Overlay */\n      .mobile-menu-overlay {\n        position: fixed;\n        top: 0;\n        right: 0;\n        width: 100%;\n        height: 100%;\n        background: rgba(0, 0, 0, 0.7);\n        z-index: 999;\n        opacity: 0;\n        visibility: hidden;\n        transition: var(--transition);\n      }\n\n      .mobile-menu-overlay.active {\n        opacity: 1;\n        visibility: visible;\n      }\n\n      .mobile-nav-links {\n        position: fixed;\n        top: 0;\n        right: -100%;\n        width: 80%;\n        max-width: 300px;\n        height: 100%;\n        background: white;\n        padding: 2rem;\n        overflow-y: auto;\n        transition: var(--transition);\n        z-index: 1000;\n        box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1);\n      }\n\n      .mobile-nav-links.active {\n        right: 0;\n      }\n\n      .mobile-nav-header {\n        display: flex;\n        justify-content: space-between;\n        align-items: center;\n        margin-bottom: 2rem;\n        padding-bottom: 1rem;\n        border-bottom: 1px solid #eee;\n      }\n\n      .mobile-nav-header h2 {\n        color: var(--primary);\n      }\n\n      .close-mobile-menu {\n        background: none;\n        border: none;\n        font-size: 1.5rem;\n        color: var(--dark);\n        cursor: pointer;\n      }\n\n      .mobile-nav-links ul {\n        list-style: none;\n      }\n\n      .mobile-nav-links li {\n        margin-bottom: 1rem;\n      }\n\n      .mobile-nav-links a {\n        display: block;\n        padding: 0.8rem 1rem;\n        color: var(--dark);\n        text-decoration: none;\n        border-radius: 5px;\n        transition: var(--transition);\n      }\n\n      .mobile-nav-links a:hover {\n        background-color: #f0f4ff;\n        color: var(--primary);\n      }\n\n      .mobile-dropdown {\n        position: relative;\n      }\n\n      .mobile-dropdown-toggle {\n        display: flex;\n        justify-content: space-between;\n        align-items: center;\n        cursor: pointer;\n        padding: 0.8rem 1rem;\n        color: var(--dark);\n        text-decoration: none;\n        border-radius: 5px;\n        transition: var(--transition);\n      }\n\n      .mobile-dropdown-toggle:hover {\n        background-color: #f0f4ff;\n        color: var(--primary);\n      }\n\n      .mobile-dropdown-menu {\n        max-height: 0;\n        overflow: hidden;\n        transition: max-height 0.3s ease;\n        padding-right: 1rem;\n      }\n\n      .mobile-dropdown-menu.active {\n        max-height: 500px;\n      }\n\n      .mobile-dropdown-menu a {\n        padding: 0.6rem 1rem;\n        font-size: 0.9rem;\n        border-bottom: 1px solid #f0f0f0;\n        color: var(--dark);\n      }\n\n      .user-profile-mobile {\n        display: flex;\n        flex-direction: column;\n        gap: 1rem;\n        padding: 1rem;\n\n        border-radius: 10px;\n        margin-top: 1rem;\n      }\n\n      .user-info-mobile {\n        display: flex;\n        align-items: center;\n        gap: 0.5rem;\n      }\n\n      /* Responsive Design */\n      @media (max-width: 992px) {\n        .nav-links {\n          display: none;\n        }\n\n        .mobile-menu-btn {\n          display: flex;\n        }\n\n        .mobile-nav-links.active {\n          right: 0;\n        }\n\n        .dropdown-content {\n          position: static;\n          opacity: 1;\n          visibility: visible;\n          transform: none;\n          box-shadow: none;\n          background: rgba(67, 97, 238, 0.05);\n          margin-top: 0.5rem;\n          border-radius: 8px;\n        }\n      }\n\n      @media (max-width: 768px) {\n        .navbar {\n          padding: 1rem;\n        }\n\n        .logo h1 {\n          font-size: 1rem;\n        }\n      }\n\n      /* Demo Content */\n      .demo-content {\n        text-align: center;\n        padding: 2rem;\n      }\n\n      .demo-content h1 {\n        color: var(--primary);\n        margin-bottom: 1rem;\n      }\n\n      .demo-content p {\n        font-size: 1.1rem;\n        color: var(--dark);\n        margin-bottom: 2rem;\n      }\n\n      .demo-info {\n        background: white;\n        border-radius: 10px;\n        padding: 2rem;\n        box-shadow: var(--shadow);\n        max-width: 600px;\n        margin: 0 auto;\n      }\n\n      .demo-info h2 {\n        color: var(--primary);\n        margin-bottom: 1rem;\n      }\n\n      .demo-info ul {\n        text-align: right;\n        list-style: none;\n      }\n\n      .demo-info li {\n        padding: 0.5rem 0;\n        border-bottom: 1px solid #eee;\n      }\n\n      .demo-info li:last-child {\n        border-bottom: none;\n      }\n\n      .demo-info li i {\n        margin-left: 10px;\n        color: var(--accent);\n      }\n    </style>\n  </head>\n  <body>\n    <!-- Navbar -->\n    <header>\n      <nav class=\"navbar\">\n        <div class=\"logo\">\n          <div class=\"logo-img\">\n            <i class=\"fas fa-code\"></i>\n          </div>\n          <h1>Ø£ÙƒØ§Ø¯ÙŠÙ…ÙŠØ© Ø§Ù„Ø¨Ø±Ù…Ø¬Ø© Ø§Ù„Ù…ØªÙƒØ§Ù…Ù„Ø©</h1>\n        </div>\n\n        <ul class=\"nav-links\">\n          <li><a href=\"index.html\" class=\"nav-link\">Ø§Ù„Ø±Ø¦ÙŠØ³ÙŠØ©</a></li>\n          <li class=\"dropdown\">\n            <a href=\"#\" class=\"nav-link\"\n              >ØªØ¹Ù„Ù… Ø§Ù„Ø¢Ù† <i class=\"fas fa-chevron-down\"></i\n            ></a>\n            <div class=\"dropdown-menu\">\n              <a href=\"examples.html\">Ø£Ù…Ø«Ù„Ø© ÙˆØªØ·Ø¨ÙŠÙ‚Ø§Øª ÙˆØ´Ø±ÙˆØ­Ø§Øª</a>\n              <a href=\"#\">Ø§Ù„ØªØ­Ø¯ÙŠØ§Øª Ø§Ù„Ø¨Ø±Ù…Ø¬ÙŠØ©</a>\n              <a href=\"proplemsolving.html\">Ù…ÙˆØ§Ù‚Ø¹ Ø­Ù„ Ø§Ù„Ù…Ø´Ø§ÙƒÙ„ Ø§Ù„Ø¨Ø±Ù…Ø¬ÙŠØ©</a>\n            </div>\n          </li>\n          <li><a href=\"./roadmap.html\" class=\"nav-link\">Ø®Ø§Ø±Ø·Ø© Ø§Ù„Ø·Ø±ÙŠÙ‚</a></li>\n          <li class=\"dropdown\">\n            <a href=\"#\" class=\"nav-link\"\n              >Ø§Ù„ÙƒÙˆØ±Ø³Ø§Øª <i class=\"fas fa-chevron-down\"></i\n            ></a>\n            <div class=\"dropdown-menu\">\n              <a href=\"path.php?path=basics\">Ù…Ø³Ø§Ø± Ø£Ø³Ø§Ø³ÙŠØ§Øª Ø§Ù„Ø¨Ø±Ù…Ø¬Ø©</a>\n              <a href=\"path.php?path=frontend\">Ù…Ø³Ø§Ø± Frontend Developer</a>\n              <a href=\"path.php?path=backend\">Ù…Ø³Ø§Ø± Backend Developer</a>\n            </div>\n          </li>\n          <li>\n            <a href=\"./projects.html\" class=\"nav-link\">Ø§Ù„ØªÙƒÙ„ÙŠÙØ§Øª ÙˆØ§Ù„Ù…Ø´Ø§Ø±ÙŠØ¹</a>\n          </li>\n          <li class=\"user-profile\" id=\"userProfile\" style=\"display: none\">\n            <div class=\"user-avatar-small\" id=\"userAvatarSmall\">Ù…</div>\n            <div class=\"user-dropdown\">\n              <div class=\"user-info\">\n                <div class=\"user-avatar-small\" id=\"dropdownAvatar\">Ù…</div>\n                <div>\n                  <div class=\"user-name\" id=\"dropdownUserName\"></div>\n                  <div class=\"user-email\" id=\"dropdownUserEmail\"></div>\n                </div>\n              </div>\n              <a\n                href=\"profile.html\"\n                class=\"nav-link\"\n                style=\"\n                  display: block;\n                  text-align: right;\n                  margin-bottom: 0.5rem;\n                  color: black;\n                  font-size: large;\n                \"\n                ><i\n                  class=\"fas fa-user-circle profile-icon\"\n                  style=\"margin-left: 10%\"\n                ></i\n                >Ø§Ù„Ù…Ù„Ù Ø§Ù„Ø´Ø®ØµÙŠ</a\n              >\n              <button class=\"logout-btn\" id=\"logoutBtn\">ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø®Ø±ÙˆØ¬</button>\n            </div>\n          </li>\n          <li id=\"loginButton\">\n            <a href=\"./login1.html\" class=\"nav-link login-btn\">ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¯Ø®ÙˆÙ„</a>\n          </li>\n        </ul>\n\n        <div class=\"mobile-menu-btn\" id=\"mobileMenuBtn\">\n          <span></span>\n          <span></span>\n          <span></span>\n        </div>\n      </nav>\n    </header>\n\n    <!-- Mobile Menu Overlay -->\n    <div class=\"mobile-menu-overlay\" id=\"mobileMenuOverlay\"></div>\n\n    <!-- Mobile Navigation -->\n    <div class=\"mobile-nav-links\" id=\"mobileNavLinks\">\n      <div class=\"mobile-nav-header\">\n        <h2>Ø§Ù„Ù‚Ø§Ø¦Ù…Ø©</h2>\n      </div>\n      <ul>\n        <li><a href=\"index.html\" class=\"nav-link\">Ø§Ù„Ø±Ø¦ÙŠØ³ÙŠØ©</a></li>\n        <li class=\"mobile-dropdown\">\n          <div class=\"mobile-dropdown-toggle\">\n            <a href=\"#\" class=\"nav-link\">ØªØ¹Ù„Ù… Ø§Ù„Ø¢Ù†</a>\n            <i class=\"fas fa-chevron-down\"></i>\n          </div>\n          <div class=\"mobile-dropdown-menu\">\n            <a href=\"examples.html\">Ø£Ù…Ø«Ù„Ø© ÙˆØªØ·Ø¨ÙŠÙ‚Ø§Øª ÙˆØ´Ø±ÙˆØ­Ø§Øª</a>\n            <a href=\"#\">Ø§Ù„ØªØ­Ø¯ÙŠØ§Øª Ø§Ù„Ø¨Ø±Ù…Ø¬ÙŠØ©</a>\n            <a href=\"proplemsolving.html\">Ù…ÙˆØ§Ù‚Ø¹ Ø­Ù„ Ø§Ù„Ù…Ø´Ø§ÙƒÙ„ Ø§Ù„Ø¨Ø±Ù…Ø¬ÙŠØ©</a>\n          </div>\n        </li>\n        <li><a href=\"./roadmap.html\" class=\"nav-link\">Ø®Ø§Ø±Ø·Ø© Ø§Ù„Ø·Ø±ÙŠÙ‚</a></li>\n        <li class=\"mobile-dropdown\">\n          <div class=\"mobile-dropdown-toggle\">\n            <a href=\"#\" class=\"nav-link\">Ø§Ù„ÙƒÙˆØ±Ø³Ø§Øª</a>\n            <i class=\"fas fa-chevron-down\"></i>\n          </div>\n          <div class=\"mobile-dropdown-menu\">\n            <a href=\"path.php?path=basics\">Ù…Ø³Ø§Ø± Ø£Ø³Ø§Ø³ÙŠØ§Øª Ø§Ù„Ø¨Ø±Ù…Ø¬Ø©</a>\n            <a href=\"path.php?path=frontend\">Ù…Ø³Ø§Ø± Frontend Developer</a>\n            <a href=\"path.php?path=backend\">Ù…Ø³Ø§Ø± Backend Developer</a>\n          </div>\n        </li>\n        <li><a href=\"#\" class=\"nav-link\">Ø§Ù„ØªÙƒÙ„ÙŠÙØ§Øª ÙˆØ§Ù„Ù…Ø´Ø§Ø±ÙŠØ¹</a></li>\n        <li\n          class=\"user-profile-mobile\"\n          id=\"userProfileMobile\"\n          style=\"display: none\"\n        >\n          <div class=\"user-info-mobile\">\n            <div class=\"user-avatar-small\" id=\"mobileAvatar\"></div>\n            <div>\n              <div class=\"user-name\" id=\"mobileUserName\"></div>\n              <div class=\"user-email\" id=\"mobileUserEmail\"></div>\n            </div>\n          </div>\n          <a href=\"profile.html\" class=\"nav-link\">\n            <i class=\"fas fa-user-circle\"></i> Ø§Ù„Ù…Ù„Ù Ø§Ù„Ø´Ø®ØµÙŠ\n          </a>\n          <button class=\"logout-btn\" id=\"mobileLogoutBtn\">ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø®Ø±ÙˆØ¬</button>\n        </li>\n        <li id=\"loginButtonMobile\">\n          <a href=\"login1.html\" class=\"nav-link login-btn\">ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¯Ø®ÙˆÙ„</a>\n        </li>\n      </ul>\n    </div>\n\n    <!-- Demo Content -->\n    <div class=\"container\">\n      <div class=\"demo-content\">\n        <h1>Navbar Demo</h1>\n        <p>Ù‡Ø°Ù‡ Ø§Ù„ØµÙØ­Ø© ØªØ­ØªÙˆÙŠ Ø¹Ù„Ù‰ navbar ÙÙ‚Ø· Ù…Ù† ØµÙØ­Ø© Ø­Ù„ Ø§Ù„Ù…Ø´Ø§ÙƒÙ„ Ø§Ù„Ø¨Ø±Ù…Ø¬ÙŠØ©</p>\n\n        <div class=\"demo-info\">\n          <h2>Ø§Ù„Ù…Ù…ÙŠØ²Ø§Øª:</h2>\n          <ul>\n            <li><i class=\"fas fa-desktop\"></i> ØªØµÙ…ÙŠÙ… Ù…ØªØ¬Ø§ÙˆØ¨ Ù„Ù„Ø´Ø§Ø´Ø§Øª Ø§Ù„ÙƒØ¨ÙŠØ±Ø©</li>\n            <li>\n              <i class=\"fas fa-mobile-alt\"></i> Ù‚Ø§Ø¦Ù…Ø© Ù…ØªØ­Ø±ÙƒØ© Ù„Ù„Ø£Ø¬Ù‡Ø²Ø© Ø§Ù„Ù…Ø­Ù…ÙˆÙ„Ø©\n            </li>\n            <li><i class=\"fas fa-user\"></i> Ù†Ø¸Ø§Ù… Ø¥Ø¯Ø§Ø±Ø© Ø§Ù„Ù…Ø³ØªØ®Ø¯Ù…ÙŠÙ†</li>\n            <li><i class=\"fas fa-bars\"></i> Ù‚ÙˆØ§Ø¦Ù… Ù…Ù†Ø³Ø¯Ù„Ø© ØªÙØ§Ø¹Ù„ÙŠØ©</li>\n            <li><i class=\"fas fa-language\"></i> Ø¯Ø¹Ù… Ø§Ù„Ù„ØºØ© Ø§Ù„Ø¹Ø±Ø¨ÙŠØ© (RTL)</li>\n            <li><i class=\"fas fa-palette\"></i> ØªØµÙ…ÙŠÙ… Ø­Ø¯ÙŠØ« ÙˆØ£Ù†ÙŠÙ‚</li>\n          </ul>\n        </div>\n      </div>\n    </div>\n\n    <script>\n      // Initialize user interface on page load\n      document.addEventListener(\"DOMContentLoaded\", function () {\n        updateUserInterface();\n\n        // Mobile Menu Toggle\n        const mobileMenuBtn = document.getElementById(\"mobileMenuBtn\");\n        const mobileMenuOverlay = document.getElementById(\"mobileMenuOverlay\");\n        const mobileNavLinks = document.getElementById(\"mobileNavLinks\");\n\n        function toggleMobileMenu() {\n          const isActive = mobileMenuBtn.classList.contains(\"active\");\n          if (isActive) {\n            closeMobileMenuFunc();\n          } else {\n            openMobileMenu();\n          }\n        }\n\n        function openMobileMenu() {\n          mobileMenuBtn.classList.add(\"active\");\n          mobileMenuOverlay.classList.add(\"active\");\n          mobileNavLinks.classList.add(\"active\");\n          document.body.style.overflow = \"hidden\";\n        }\n\n        function closeMobileMenuFunc() {\n          mobileMenuBtn.classList.remove(\"active\");\n          mobileMenuOverlay.classList.remove(\"active\");\n          mobileNavLinks.classList.remove(\"active\");\n          document.body.style.overflow = \"auto\";\n        }\n\n        if (mobileMenuBtn) {\n          mobileMenuBtn.addEventListener(\"click\", toggleMobileMenu);\n        }\n        if (mobileMenuOverlay) {\n          mobileMenuOverlay.addEventListener(\"click\", closeMobileMenuFunc);\n        }\n\n        // Mobile Dropdown Toggle\n        document\n          .querySelectorAll(\".mobile-dropdown-toggle\")\n          .forEach((toggle) => {\n            toggle.addEventListener(\"click\", function (e) {\n              e.preventDefault();\n              const menu = this.nextElementSibling;\n              const icon = this.querySelector(\"i\");\n              menu.classList.toggle(\"active\");\n              if (menu.classList.contains(\"active\")) {\n                icon.classList.remove(\"fa-chevron-down\");\n                icon.classList.add(\"fa-chevron-up\");\n              } else {\n                icon.classList.remove(\"fa-chevron-up\");\n                icon.classList.add(\"fa-chevron-down\");\n              }\n            });\n          });\n\n        // Mobile Logout\n        const mobileLogoutBtn = document.getElementById(\"mobileLogoutBtn\");\n        if (mobileLogoutBtn) {\n          mobileLogoutBtn.addEventListener(\"click\", function () {\n            closeMobileMenuFunc(); // Close menu first\n            const currentUser = JSON.parse(localStorage.getItem(\"currentUser\"));\n            if (currentUser) {\n              currentUser.isLoggedIn = false;\n              localStorage.setItem(\"currentUser\", JSON.stringify(currentUser));\n            }\n            localStorage.removeItem(\"userData\");\n            updateUserInterface();\n            showNotification(\"ØªÙ… ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø®Ø±ÙˆØ¬ Ø¨Ù†Ø¬Ø§Ø­!\", \"success\");\n          });\n        }\n\n        // Dropdown hover functionality\n        const userProfile = document.getElementById(\"userProfile\");\n        const userDropdown = document.querySelector(\".user-dropdown\");\n        let dropdownTimeout;\n\n        function showDropdown() {\n          clearTimeout(dropdownTimeout);\n          if (userDropdown) {\n            userDropdown.style.opacity = \"1\";\n            userDropdown.style.visibility = \"visible\";\n            userDropdown.style.transform = \"translateY(0)\";\n          }\n        }\n\n        function hideDropdown() {\n          dropdownTimeout = setTimeout(() => {\n            if (userDropdown) {\n              userDropdown.style.opacity = \"0\";\n              userDropdown.style.visibility = \"hidden\";\n              userDropdown.style.transform = \"translateY(10px)\";\n            }\n          }, 150); // Small delay to allow moving between elements\n        }\n\n        if (userProfile) {\n          userProfile.addEventListener(\"mouseenter\", showDropdown);\n          userProfile.addEventListener(\"mouseleave\", hideDropdown);\n        }\n\n        if (userDropdown) {\n          userDropdown.addEventListener(\"mouseenter\", showDropdown);\n          userDropdown.addEventListener(\"mouseleave\", hideDropdown);\n        }\n\n        // Logout functionality\n        const logoutBtn = document.getElementById(\"logoutBtn\");\n        if (logoutBtn) {\n          logoutBtn.addEventListener(\"click\", function () {\n            const currentUser = JSON.parse(localStorage.getItem(\"currentUser\"));\n            if (currentUser) {\n              currentUser.isLoggedIn = false;\n              localStorage.setItem(\"currentUser\", JSON.stringify(currentUser));\n            }\n            localStorage.removeItem(\"userData\");\n            updateUserInterface();\n            showNotification(\"ØªÙ… ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø®Ø±ÙˆØ¬ Ø¨Ù†Ø¬Ø§Ø­!\", \"success\");\n          });\n        }\n      });\n    </script>\n  </body>\n</html>\n','html','[\"html\",\"css\"]','',0,'',1,'2025-11-27 18:19:11','2025-12-06 21:07:55'),(9,'sasad','sdasasd','frontend','','','fqfwqqw','dsads','[]','https://www.youtube.com/playlist?list=PLknwEmKsW8Ov6JLhkIO1pOdHHCjdCq-PJ',0,'',1,'2025-12-06 21:12:00','2025-12-06 21:23:21');
/*!40000 ALTER TABLE `examples` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lessons`
--

DROP TABLE IF EXISTS `lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lessons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `video_data` longblob NOT NULL,
  `video_mime` varchar(255) NOT NULL,
  `resources_code` text DEFAULT NULL COMMENT 'Code snippets and resources for this lesson',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `views` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_course_lessons` (`course_id`,`sort_order`),
  KEY `idx_lesson_views` (`views`),
  KEY `idx_course_active` (`course_id`,`created_at`),
  CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lessons`
--

LOCK TABLES `lessons` WRITE;
/*!40000 ALTER TABLE `lessons` DISABLE KEYS */;
INSERT INTO `lessons` (`id`, `course_id`, `title`, `description`, `sort_order`, `video_data`, `video_mime`, `resources_code`, `created_at`, `updated_at`, `views`) VALUES (6,6,'16_ Ø§Ù„ Authentication(720P_60FPS)',' 1Authentication',1,'videos/frontend/react/lesson_6_6934950221ffc.mp4','video/mp4','wqddddffqw','2025-10-11 21:08:33','2025-12-06 20:41:38',0),(7,6,'17.1_ ØªØ­Ø¯ÙŠ Ø§Ù„ Authentication(720P_60FPS)',' ØªØ­Ø¯ÙŠ Ø§Ù„Authentication',2,'videos\\frontend\\react\\video_68eac751686462.99648633.mp4','video/mp4','dddd','2025-10-11 21:08:33','2025-12-06 20:27:09',0),(8,8,'17.2_ Ø­Ù„ ØªØ­Ø¯ÙŠ Ø§Ù„ Authentication(720P_60FPS)','',1,'videos\\frontend\\html\\video_68eac7c9747733.56253928.mp4','video/mp4',NULL,'2025-10-11 21:10:33','2025-12-06 20:25:46',0),(9,8,'17_ Ø§Ù„ Authentication ÙÙŠ Ø¬Ø§ÙØ§Ø³ÙƒØ±ÙŠØ¨Øª(720P_60FPS)','',2,'videos\\frontend\\html\\video_68eac7c974d3e7.54987292.mp4','video/mp4',NULL,'2025-10-11 21:10:33','2025-12-06 20:25:46',0),(10,8,'18_ Ø§Ù„Ù…Ø´Ø±ÙˆØ¹ Ø§Ù„Ù†Ù‡Ø§Ø¦ÙŠ _ Ù…Ù‚Ø¯Ù…Ø© _ Ù…Ø§Ù‡Ùˆ Ø§Ù„Ù…Ø´Ø±ÙˆØ¹ØŸ _ Ø·Ø±ÙŠÙ‚Ø© Ø§Ù„Ø¹Ù…Ù„(720P_60FPS)','',3,'videos\\frontend\\html\\video_68eac7c9755033.33876624.mp4','video/mp4',NULL,'2025-10-11 21:10:33','2025-12-06 20:25:46',0),(11,8,'16_ Ø§Ù„ Authentication(720P_60FPS)','',4,'videos\\frontend\\html\\video_68eaca0d9e3ab9.81027761.mp4','video/mp4',NULL,'2025-10-11 21:20:13','2025-12-06 20:25:46',0),(12,8,'17.1_ ØªØ­Ø¯ÙŠ Ø§Ù„ Authentication(720P_60FPS)','',5,'videos\\frontend\\html\\video_68eaca0d9e9d12.78883036.mp4','video/mp4',NULL,'2025-10-11 21:20:13','2025-12-06 20:25:46',0),(13,9,'Screen Recording 2025-08-03 175323','Screen Recording',2,'videos\\basics\\c\\lesson_68ec081a892a88.84757626.mp4','video/mp4',NULL,'2025-10-12 19:57:14','2025-12-06 20:25:46',0),(14,9,'Screen Recording 2025-08-23 224033','Screen Recording',1,'videos\\basics\\c\\lesson_68ec081a8974f0.28303605.mp4','video/mp4','','2025-10-12 19:57:14','2025-12-06 20:25:46',0),(15,10,'darth-vader-the-dark-lord-star-wars-moewalls-com','darth-vader-the-dark-lord-star-wars-moewalls-com',1,'videos\\basics\\10\\lesson_68ec1fe0cf1fc0.20635941.mp4','video/mp4',NULL,'2025-10-12 21:38:40','2025-12-06 20:25:46',0),(36,10,'darth-vader-the-dark-lord-star-wars-moewalls-com','afafafa',2,'videos\\basics\\10\\lesson_68fbdb0dd218e5.12108151.mp4','video/mp4','afafdasfa','2025-10-24 20:01:17','2025-12-06 20:25:46',0),(37,10,'darth-vader-the-dark-lord-star-wars-moewalls-com','afafafa',3,'videos\\basics\\10\\lesson_68fbe4280d4308.87124867.mp4','video/mp4','afafdasfa','2025-10-24 20:40:08','2025-12-06 20:25:46',0),(38,10,'video_68eac7c9755033.33876624','',4,'videos\\basics\\10\\lesson_68fbe46c9462c9.25494618.mp4','video/mp4','jkjjkjlklk\r\nll;','2025-10-24 20:41:16','2025-12-06 20:25:46',0),(42,14,'video_68eac7c9755033.33876624','asdasda',1,'videos\\backend\\14\\lesson_6933485622cd76.65382644.mp4','video/mp4','asdasda','2025-12-05 21:02:14','2025-12-06 20:25:46',0),(43,14,'video_68eac7c9755033.33876624','regre',2,'videos\\backend\\14\\lesson_69335ce00a4ec3.05125360.mp4','video/mp4','gegre','2025-12-05 22:29:52','2025-12-06 20:25:46',0),(44,21,'video_68eac7c9755033.33876624','assfd',1,'videos\\backend\\21\\lesson_69348a2fb8ff39.00282704.mp4','video/mp4','safafs','2025-12-06 19:55:27','2025-12-06 20:25:46',0),(45,6,'video_68eac7c9755033.33876624','ewewge',0,'videos\\frontend\\6\\lesson_6934967576f462.74422397.mp4','video/mp4','gewgew','2025-12-06 20:47:49','2025-12-06 20:47:49',0),(46,6,'[Witanime.com] D2S EP 01 FHD','fqw',3,'videos\\frontend\\6\\lesson_693497391f2ac7.78166929.mp4','video/mp4','wqfwqf','2025-12-06 20:51:05','2025-12-06 20:51:05',0),(47,22,'darth-vader-the-dark-lord-star-wars-moewalls-com','feqf',1,'videos\\basics\\22\\lesson_693499b896ff53.99541145.mp4','video/mp4','qeqeeq','2025-12-06 21:01:44','2025-12-06 21:01:44',0),(48,8,'video_68eac7c9755033.33876624','asfas',6,'videos\\frontend\\8\\lesson_6948486131c5b3.18275395.mp4','video/mp4','fasfasasf','2025-12-21 19:20:01','2025-12-21 19:20:01',0),(49,8,'darth-vader-the-dark-lord-star-wars-moewalls-com','sadsadasd',7,'videos\\frontend\\8\\lesson_6948486cbb5269.29613256.mp4','video/mp4','sadasd','2025-12-21 19:20:12','2025-12-21 19:20:12',0),(50,8,'asdsa','sadasdasd',8,'videos\\frontend\\8\\lesson_694848900f2fc6.94284709.mp4','video/mp4','asdasddas','2025-12-21 19:20:48','2025-12-21 19:20:48',0);
/*!40000 ALTER TABLE `lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `idx_reset_expiry` (`expires_at`),
  KEY `idx_reset_email` (`email`,`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
INSERT INTO `password_resets` (`id`, `email`, `token`, `expires_at`, `created_at`) VALUES (9,'aghaa003@gmail.com','5eeee849a970a9906d5b336fe78b4a8a9a5e73309a063e44a5ee5465f161eb80','2025-12-19 22:37:26','2025-12-19 20:37:26');
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platform_bookmarks`
--

DROP TABLE IF EXISTS `platform_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platform_bookmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `platform_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_bookmark` (`user_id`,`platform_id`),
  KEY `platform_id` (`platform_id`),
  CONSTRAINT `platform_bookmarks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `platform_bookmarks_ibfk_2` FOREIGN KEY (`platform_id`) REFERENCES `platforms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platform_bookmarks`
--

LOCK TABLES `platform_bookmarks` WRITE;
/*!40000 ALTER TABLE `platform_bookmarks` DISABLE KEYS */;
INSERT INTO `platform_bookmarks` (`id`, `user_id`, `platform_id`, `created_at`) VALUES (13,1,26,'2025-10-29 20:01:30'),(15,1,27,'2025-10-29 20:27:53'),(18,1,29,'2025-12-22 20:12:30');
/*!40000 ALTER TABLE `platform_bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platform_ratings`
--

DROP TABLE IF EXISTS `platform_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platform_ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `platform_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_platform` (`user_id`,`platform_id`),
  KEY `idx_platform_avg_rating` (`platform_id`,`rating`),
  CONSTRAINT `platform_ratings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `platform_ratings_ibfk_2` FOREIGN KEY (`platform_id`) REFERENCES `platforms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platform_ratings`
--

LOCK TABLES `platform_ratings` WRITE;
/*!40000 ALTER TABLE `platform_ratings` DISABLE KEYS */;
INSERT INTO `platform_ratings` (`id`, `user_id`, `platform_id`, `rating`, `created_at`) VALUES (4,1,26,4,'2025-11-28 21:21:23'),(9,1,27,4,'2025-11-30 19:23:30');
/*!40000 ALTER TABLE `platform_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `platform_statistics`
--

DROP TABLE IF EXISTS `platform_statistics`;
/*!50001 DROP VIEW IF EXISTS `platform_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `platform_statistics` AS SELECT
 1 AS `id`,
  1 AS `name`,
  1 AS `description`,
  1 AS `url`,
  1 AS `category`,
  1 AS `level`,
  1 AS `language`,
  1 AS `logo_url`,
  1 AS `is_active`,
  1 AS `bookmark_count`,
  1 AS `rating_count`,
  1 AS `avg_rating`,
  1 AS `problem_count`,
  1 AS `user_count`,
  1 AS `features` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `platforms`
--

DROP TABLE IF EXISTS `platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `category` enum('global','arabic') DEFAULT 'global',
  `level` enum('beginner','intermediate','advanced') DEFAULT 'beginner',
  `language` enum('english','arabic','both') DEFAULT 'english',
  `rating` decimal(3,2) DEFAULT 0.00,
  `user_count` int(11) DEFAULT 0,
  `problem_count` int(11) DEFAULT 0,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`features`)),
  `logo_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_platform_filter` (`category`,`level`,`language`,`is_active`),
  KEY `idx_platform_rating` (`rating`,`user_count`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platforms`
--

LOCK TABLES `platforms` WRITE;
/*!40000 ALTER TABLE `platforms` DISABLE KEYS */;
INSERT INTO `platforms` (`id`, `name`, `description`, `url`, `category`, `level`, `language`, `rating`, `user_count`, `problem_count`, `features`, `logo_url`, `is_active`, `created_at`) VALUES (3,'Ø¨Ø±Ù…Ø¬','Ù…Ù†ØµØ© Ø¹Ø±Ø¨ÙŠØ© ØªÙ‡Ø¯Ù Ø¥Ù„Ù‰ ØªØ·ÙˆÙŠØ± Ù…Ù‡Ø§Ø±Ø§Øª Ø§Ù„Ø¨Ø±Ù…Ø¬Ø© Ù„Ø¯Ù‰ Ø§Ù„Ù†Ø§Ø·Ù‚ÙŠÙ† Ø¨Ø§Ù„Ø¹Ø±Ø¨ÙŠØ© Ù…Ù† Ø®Ù„Ø§Ù„ Ø§Ù„ØªØ­Ø¯ÙŠØ§Øª Ø§Ù„Ø¨Ø±Ù…Ø¬ÙŠØ© ÙˆØ§Ù„Ù…Ø³Ø§Ø¨Ù‚Ø§Øª.','https://barmej.com','arabic','beginner','arabic',0.00,100000,500,'[\"Ø¹Ø±Ø¨ÙŠ\", \"Ù…Ø³Ø§Ø¨Ù‚Ø§Øª\", \"Ù…Ø¨ØªØ¯Ø¦ÙŠÙ†\"]','',1,'2025-10-26 19:33:25'),(6,'Ù…Ø¯Ø±Ø³Ø©','Ù…Ù†ØµØ© Ø¹Ø±Ø¨ÙŠØ© ØªÙ‚Ø¯Ù… Ù…Ø­ØªÙˆÙ‰ ØªØ¹Ù„ÙŠÙ…ÙŠ Ù…Ø¬Ø§Ù†ÙŠ ÙÙŠ Ø§Ù„Ø¨Ø±Ù…Ø¬Ø© ÙˆØªØªØ¶Ù…Ù† ØªØ­Ø¯ÙŠØ§Øª Ø¨Ø±Ù…Ø¬ÙŠØ© Ù„Ù„Ù…Ø¨ØªØ¯Ø¦ÙŠÙ† Ø¨Ø§Ù„Ù„ØºØ© Ø§Ù„Ø¹Ø±Ø¨ÙŠØ©.','https://madrasa.org','arabic','beginner','arabic',0.00,500000,300,'[\"Ø¹Ø±Ø¨ÙŠ\", \"Ù…Ø¬Ø§Ù†ÙŠ\", \"Ù…Ø¨ØªØ¯Ø¦ÙŠÙ†\"]','',1,'2025-10-26 19:33:25'),(26,'LeeetCode','Ù…Ù†ØµØ© Ø±Ø§Ø¦Ø¯Ø© ÙÙŠ ØªØ­Ø¶ÙŠØ± Ù…Ù‚Ø§Ø¨Ù„Ø§Øª Ø§Ù„Ø¹Ù…Ù„ Ø§Ù„ØªÙ‚Ù†ÙŠØ©ØŒ ØªØ­ØªÙˆÙŠ Ø¹Ù„Ù‰ Ø¢Ù„Ø§Ù Ø§Ù„Ù…Ø´Ø§ÙƒÙ„ Ø§Ù„Ø¨Ø±Ù…Ø¬ÙŠØ© Ù…Ø¹ Ø­Ù„ÙˆÙ„ Ù…ÙØµÙ„Ø© ÙˆÙ…Ù†Ø§Ù‚Ø´Ø§Øª.','https://leetcode.com','global','advanced','english',4.00,5000000,2000,'[\"\\u0645\\u0642\\u0627\\u0628\\u0644\\u0627\\u062a \\u0627\\u0644\\u0639\\u0645\\u0644\",\"\\u062e\\u0648\\u0627\\u0631\\u0632\\u0645\\u064a\\u0627\\u062a\",\"\\u0647\\u064a\\u0627\\u0643\\u0644 \\u0627\\u0644\\u0628\\u064a\\u0627\\u0646\\u0627\\u062a\"]','',1,'2025-10-29 19:38:13'),(27,'HackerRank','Ù…Ù†ØµØ© Ø´Ø§Ù…Ù„Ø© Ù„Ù„Ù…Ø¨Ø±Ù…Ø¬ÙŠÙ† Ù…Ù† Ø¬Ù…ÙŠØ¹ Ø§Ù„Ù…Ø³ØªÙˆÙŠØ§ØªØŒ ØªÙ‚Ø¯Ù… ØªØ­Ø¯ÙŠØ§Øª Ø¨Ø±Ù…Ø¬ÙŠØ© ÙˆÙ…Ø³Ø§Ø¨Ù‚Ø§Øª ÙˆÙØ±Øµ Ø¹Ù…Ù„ Ù…Ø¹ Ø§Ù„Ø´Ø±ÙƒØ§Øª Ø§Ù„Ø¹Ø§Ù„Ù…ÙŠØ©.','https://hackerrank.com','global','beginner','english',4.00,7000000,1500,'[\"Ù…Ø³Ø§Ø¨Ù‚Ø§Øª\", \"ØªØ­Ø¯ÙŠØ§Øª\", \"ÙØ±Øµ Ø¹Ù…Ù„\"]','',1,'2025-10-29 19:38:13'),(29,'Codeforces','Ù…Ù†ØµØ© ØªÙ†Ø§ÙØ³ÙŠØ© Ù„Ù„Ù…Ø¨Ø±Ù…Ø¬ÙŠÙ† Ø§Ù„Ù…Ø­ØªØ±ÙÙŠÙ†ØŒ ØªØ´ØªÙ‡Ø± Ø¨Ù…Ø³Ø§Ø¨Ù‚Ø§ØªÙ‡Ø§ Ø§Ù„Ù…Ù†ØªØ¸Ù…Ø© ÙˆÙ…Ø¬ØªÙ…Ø¹Ù‡Ø§ Ø§Ù„Ù†Ø´Ø· ÙÙŠ Ø­Ù„ Ø§Ù„Ù…Ø´ÙƒÙ„Ø§Øª Ø§Ù„Ø®ÙˆØ§Ø±Ø²Ù…ÙŠØ©.','https://codeforces.com','global','advanced','english',0.00,1000000,3000,'[\"Ù…Ø³Ø§Ø¨Ù‚Ø§Øª\", \"Ø®ÙˆØ§Ø±Ø²Ù…ÙŠØ§Øª\", \"Ù…ØªÙ‚Ø¯Ù…ÙŠÙ†\"]','',1,'2025-10-29 19:38:13'),(30,'Codewars','Ù…Ù†ØµØ© ÙØ±ÙŠØ¯Ø© ØªÙ‚Ø¯Ù… ØªØ­Ø¯ÙŠØ§Øª Ø¨Ø±Ù…Ø¬ÙŠØ© ØªØ³Ù…Ù‰ \"ÙƒØ§ØªØ§\" Ù„ØªØ­Ø³ÙŠÙ† Ù…Ù‡Ø§Ø±Ø§ØªÙƒ Ù…Ù† Ø®Ù„Ø§Ù„ Ø§Ù„Ù…Ù…Ø§Ø±Ø³Ø© ÙˆØ§Ù„ØªØ¹Ù„Ù… Ù…Ù† Ø­Ù„ÙˆÙ„ Ø§Ù„Ø¢Ø®Ø±ÙŠÙ†.','https://codewars.com','global','intermediate','english',0.00,3000000,2000,'[\"\\u0643\\u0627\\u062a\\u0627\",\"\\u0645\\u062c\\u062a\\u0645\\u0639\",\"\\u0645\\u0633\\u062a\\u0648\\u064a\\u0627\\u062a\"]','',1,'2025-10-29 19:38:13');
/*!40000 ALTER TABLE `platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`) VALUES (2,'admin'),(1,'student');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_assignments`
--

DROP TABLE IF EXISTS `user_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `solution` text DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `score` int(11) DEFAULT NULL,
  `status` enum('submitted','graded') DEFAULT 'submitted',
  `is_completed` tinyint(1) NOT NULL DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_assignment` (`user_id`,`assignment_id`),
  KEY `idx_user_assignment_status` (`user_id`,`status`,`is_completed`),
  KEY `idx_assignment_score` (`assignment_id`,`score`),
  KEY `idx_submission_date` (`user_id`,`submitted_at`),
  CONSTRAINT `user_assignments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_assignments_ibfk_2` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_assignments`
--

LOCK TABLES `user_assignments` WRITE;
/*!40000 ALTER TABLE `user_assignments` DISABLE KEYS */;
INSERT INTO `user_assignments` (`id`, `user_id`, `assignment_id`, `solution`, `submitted_at`, `score`, `status`, `is_completed`, `completed_at`) VALUES (24,1,5,'<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <title>Responsive Person Profile</title>\n    <style>\n        .profile {\n            display: grid;\n            place-items: center;\n            width: 300px;\n            height: 200px; /* Adjust this value to fit your design needs */\n            background-color: #fff;\n            border-radius: 5px;\n        }\n\n        .profile img {\n            max-width: 100%;\n            max-height: auto;\n            transition: transform 0.3s ease-in-out;\n        }\n    </style>\n</head>\n<body>\n\n<div class=\"profile\">\n    <img src=\"avatar.jpg\" alt=\"Profile Image\" class=\"profile-img\">\n    <h2>John Doe</h2>\n    <p>Software Developer</p>\n</div>\n\n</body>\n</html>','2025-12-19 21:30:13',100,'graded',1,'2025-12-19 21:30:13'),(25,1,2,'using System.Security.Cryptography;\nusing System.Text;\nusing System.Linq;\nusing System.Collections.Generic;\nusing System.Diagnostics;\nusing System.Numerics;\nusing System;\n\nclass FactorialCalculator {\n    // Calculates the factorial of a given number n using recursion.\n    public static long CalculateFactorial(long n) {\n        if (n <= 1) return 1;\n        else return n * CalculateFactorial(n - 1);\n    }\n\n    // Example usage:\n    static void Main(string[] args) {\n        Console.WriteLine(CalculateFactorial(5)); // Output: 120\n        Console.WriteLine(CalculateFactorial(3)); // Output: 6\n        Console.WriteLine(CalculateFactorial(0)); // Output: 1\n    }\n}','2025-12-19 21:30:43',100,'graded',1,'2025-12-19 21:30:43'),(26,1,12,'#include <stdio.h>\n\nlong factorial(int n) {\n    if (n == 0 || n == 1) return 1;\n    else return n * factorial(n - 1);\n}\n\nint main() {\n    int number;\n    printf(\"Ø£Ø¯Ø®Ù„ Ø¹Ø¯Ø¯: \");\n    scanf(\"%d\", &number);\n\n    long result = factorial(number);\n    printf(\"Ø§Ù„Ø¨Ø±Ù…Ø¬Ø©: %ld\\n\", result);\n\n    return 0;\n}','2025-12-21 19:27:07',100,'graded',1,'2025-12-21 19:27:07'),(27,1,3,'using System;\nusing System.Collections.Generic;\n\nclass Program\n{\n    static void Main()\n    {\n        List<int> numbers = new List<int> { 5, 8, 3, 6, 9 };\n\n        int maxNumber = numbers[0];\n        \n        foreach (int number in numbers)\n        {\n            if (number > maxNumber)\n            {\n                maxNumber = number;\n            }\n        }\n\n        Console.WriteLine(\"Ø§Ù„Ø±ØºÙ… Ù…Ù† Ø£Ù†Ùƒ Ù„Ø§ Ø£ÙˆØ¬Ø¯ Ø³Ø¤Ø§Ù„ ÙØ¹Ø§Ù„ØŒ ÙŠÙ…ÙƒÙ†Ùƒ ØªÙ‚Ø¯ÙŠÙ… Ø£ÙŠ Ø¥Ø¬Ø§Ø¨Ø©Ù‹ Ù…Ù…ÙƒÙ†Ø©ØŒ Ù„ÙƒÙ†Ù†ÙŠ Ø£Ø±Ø¬Ù‰ Ø£Ù† Ø£ØªÙ…ÙƒÙ† Ù…Ù† ØªØ·Ø¨ÙŠÙ‚ Ù‡Ø°Ø§ Ø§Ù„Ø¨Ø±Ù†Ø§Ù…Ø¬.\");\n    }\n}','2025-12-22 20:18:59',100,'graded',1,'2025-12-22 20:18:59');
/*!40000 ALTER TABLE `user_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `user_challenge_summary`
--

DROP TABLE IF EXISTS `user_challenge_summary`;
/*!50001 DROP VIEW IF EXISTS `user_challenge_summary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `user_challenge_summary` AS SELECT
 1 AS `user_id`,
  1 AS `username`,
  1 AS `firstName`,
  1 AS `lastName`,
  1 AS `category`,
  1 AS `total_challenges_in_category`,
  1 AS `completed_count`,
  1 AS `attempted_count`,
  1 AS `total_points`,
  1 AS `success_rate` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_challenges`
--

DROP TABLE IF EXISTS `user_challenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_challenges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `challenge_id` int(11) NOT NULL,
  `attempts` int(11) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `best_score` int(11) DEFAULT 0,
  `last_attempted` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_challenge` (`user_id`,`challenge_id`),
  KEY `idx_user_challenge_complete` (`user_id`,`completed`,`best_score`),
  KEY `idx_challenge_recent` (`challenge_id`,`last_attempted`),
  KEY `idx_leaderboard` (`user_id`,`best_score`),
  CONSTRAINT `user_challenges_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_challenges_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_challenges`
--

LOCK TABLES `user_challenges` WRITE;
/*!40000 ALTER TABLE `user_challenges` DISABLE KEYS */;
INSERT INTO `user_challenges` (`id`, `user_id`, `challenge_id`, `attempts`, `completed`, `best_score`, `last_attempted`) VALUES (35,1,20,1,1,140,'2025-12-19 19:30:48'),(36,1,3,2,1,75,'2025-12-19 19:31:40'),(38,1,28,1,1,50,'2025-12-19 19:38:15'),(39,1,27,2,1,10,'2025-12-19 19:38:36'),(41,1,7,3,0,0,'2025-12-22 20:27:10'),(44,1,10,2,1,65,'2025-12-22 20:45:09');
/*!40000 ALTER TABLE `user_challenges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `user_course_overview`
--

DROP TABLE IF EXISTS `user_course_overview`;
/*!50001 DROP VIEW IF EXISTS `user_course_overview`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `user_course_overview` AS SELECT
 1 AS `course_id`,
  1 AS `title`,
  1 AS `description`,
  1 AS `category`,
  1 AS `level`,
  1 AS `logo_path`,
  1 AS `main_points`,
  1 AS `user_id`,
  1 AS `percentage_completed`,
  1 AS `last_lesson_id`,
  1 AS `started_at`,
  1 AS `last_accessed`,
  1 AS `total_lessons`,
  1 AS `completed_lessons`,
  1 AS `total_views` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_course_progress`
--

DROP TABLE IF EXISTS `user_course_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_course_progress` (
  `user_id` int(11) NOT NULL,
  `course_id` int(11) unsigned NOT NULL,
  `percentage_completed` int(11) DEFAULT 0 COMMENT 'Overall course completion 0-100',
  `last_lesson_id` int(11) DEFAULT NULL COMMENT 'Last watched lesson for resume',
  `started_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_accessed` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`,`course_id`),
  KEY `course_id` (`course_id`),
  KEY `last_lesson_id` (`last_lesson_id`),
  KEY `idx_user_progress` (`user_id`,`percentage_completed`),
  KEY `idx_last_accessed` (`last_accessed`),
  KEY `idx_user_completion` (`user_id`,`percentage_completed`),
  KEY `idx_user_recent_access` (`user_id`,`last_accessed`),
  KEY `idx_active_courses` (`user_id`,`course_id`,`last_accessed`),
  CONSTRAINT `user_course_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_course_progress_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_course_progress_ibfk_3` FOREIGN KEY (`last_lesson_id`) REFERENCES `lessons` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_course_progress`
--

LOCK TABLES `user_course_progress` WRITE;
/*!40000 ALTER TABLE `user_course_progress` DISABLE KEYS */;
INSERT INTO `user_course_progress` (`user_id`, `course_id`, `percentage_completed`, `last_lesson_id`, `started_at`, `last_accessed`) VALUES (1,8,13,8,'2025-12-22 21:03:10','2025-12-22 21:03:10'),(1,9,50,14,'2025-12-01 09:29:11','2025-12-21 18:58:17'),(1,10,25,15,'2025-10-22 21:53:52','2025-10-24 21:20:21');
/*!40000 ALTER TABLE `user_course_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `user_learning_dashboard`
--

DROP TABLE IF EXISTS `user_learning_dashboard`;
/*!50001 DROP VIEW IF EXISTS `user_learning_dashboard`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `user_learning_dashboard` AS SELECT
 1 AS `user_id`,
  1 AS `username`,
  1 AS `firstName`,
  1 AS `lastName`,
  1 AS `email`,
  1 AS `joinDate`,
  1 AS `enrolled_courses`,
  1 AS `completed_courses`,
  1 AS `avg_course_completion`,
  1 AS `total_lessons_started`,
  1 AS `lessons_completed`,
  1 AS `challenges_attempted`,
  1 AS `challenges_completed`,
  1 AS `total_challenge_points`,
  1 AS `assignments_attempted`,
  1 AS `assignments_completed`,
  1 AS `avg_assignment_score`,
  1 AS `bookmarked_platforms`,
  1 AS `last_course_access`,
  1 AS `last_challenge_attempt`,
  1 AS `last_assignment_submission` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_lesson_progress`
--

DROP TABLE IF EXISTS `user_lesson_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_lesson_progress` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_position` int(11) DEFAULT 0 COMMENT 'Video position in seconds',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_lesson_unique` (`user_id`,`lesson_id`),
  KEY `lesson_id` (`lesson_id`),
  KEY `idx_user_lesson` (`user_id`,`lesson_id`),
  KEY `idx_completed` (`completed_at`),
  KEY `idx_user_incomplete` (`user_id`,`completed_at`),
  KEY `idx_user_lesson_position` (`user_id`,`lesson_id`,`last_position`),
  KEY `idx_updated` (`updated_at`),
  CONSTRAINT `user_lesson_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_lesson_progress_ibfk_2` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_lesson_progress`
--

LOCK TABLES `user_lesson_progress` WRITE;
/*!40000 ALTER TABLE `user_lesson_progress` DISABLE KEYS */;
INSERT INTO `user_lesson_progress` (`id`, `user_id`, `lesson_id`, `completed_at`, `updated_at`, `last_position`) VALUES (130,1,15,'2025-10-22 21:53:53','2025-10-22 21:53:53',0),(138,1,36,NULL,'2025-10-24 20:04:53',0),(206,1,37,NULL,'2025-10-24 21:20:21',0),(221,1,13,'2025-12-01 09:29:11','2025-12-03 18:27:52',20),(222,1,14,NULL,'2025-12-21 18:58:17',10),(235,1,6,NULL,'2025-12-06 20:42:03',1),(263,1,8,'2025-12-22 21:03:10','2025-12-22 21:03:10',2);
/*!40000 ALTER TABLE `user_lesson_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `preferred_level` enum('Ù…Ø¨ØªØ¯Ø¦','Ù…ØªÙˆØ³Ø·','Ù…ØªÙ‚Ø¯Ù…') DEFAULT NULL,
  `preferred_language` enum('Ø§Ù„Ø¹Ø±Ø¨ÙŠØ©','Ø§Ù„Ø¥Ù†Ø¬Ù„ÙŠØ²ÙŠØ©','Ù„Ø§ ÙŠÙ‡Ù…') DEFAULT NULL,
  `goals` varchar(255) DEFAULT NULL,
  `time_commitment` enum('ÙŠÙˆÙ…ÙŠØ§Ù‹','Ø£Ø³Ø¨ÙˆØ¹ÙŠØ§Ù‹','Ø´Ù‡Ø±ÙŠØ§Ù‹') DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_prefs` (`user_id`),
  CONSTRAINT `user_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_preferences`
--

LOCK TABLES `user_preferences` WRITE;
/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
INSERT INTO `user_preferences` (`id`, `user_id`, `preferred_level`, `preferred_language`, `goals`, `time_commitment`, `updated_at`) VALUES (1,1,'Ù…Ø¨ØªØ¯Ø¦','Ø§Ù„Ø¥Ù†Ø¬Ù„ÙŠØ²ÙŠØ©','ØªØ­Ø¶ÙŠØ± Ù„Ù…Ù‚Ø§Ø¨Ù„Ø§Øª Ø§Ù„Ø¹Ù…Ù„','Ø£Ø³Ø¨ÙˆØ¹ÙŠØ§Ù‹','2025-12-23 14:36:28');
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES (1,2);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `preferred_language` varchar(5) DEFAULT 'ar',
  `phone` varchar(25) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `experience` varchar(50) DEFAULT NULL,
  `goal` varchar(50) DEFAULT NULL,
  `interest` varchar(50) DEFAULT NULL,
  `joinDate` datetime NOT NULL DEFAULT current_timestamp(),
  `avatar_data` longblob DEFAULT NULL,
  `avatar_mime_type` varchar(255) DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_user_join_date` (`joinDate`),
  KEY `idx_admin_users` (`is_admin`,`id`),
  KEY `idx_user_experience` (`experience`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `firstName`, `lastName`, `email`, `preferred_language`, `phone`, `username`, `password`, `country`, `experience`, `goal`, `interest`, `joinDate`, `avatar_data`, `avatar_mime_type`, `is_admin`) VALUES (1,'ahmad','aghaaa','aghaa003@gmail.com','ar','+963930882851','ahmadaghaa003','$2y$10$C1HVy7bK3VV4BQjjirX7pODfGLG/qqT5lFZNZZZgVuHBbF4m42Jdu','SA','beginner','job','web','2025-10-03 00:47:49','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0Ë\0\0ˆ\0\0\0†Ä·\0\0\0sRGB\0®Îé\0\0\0gAMA\0\0±üa\0\0\0	pHYs\0\0Ã\0\0ÃÇo¨d\0\0ÿ¥IDATx^ìıyÀmGYç‹ªÖ´§w>ó2‘	0Æ0´^\'TDml¸MÿÀŸz›k;u·´×†‹íÕëĞz[¯(284\"@A\rS@’’p’srr¦wÜûİ{¯¡îOÕZµ×»ßsN’3gÏYï^«¦UÓZõ­g=õ”ºòÊ«\r\\`P\'¼û£L0ÁE‚?û›8Ÿl:ÀlğØàpAÂ\0AÔ¨;à_ùı¼ì%/.¯•RcÊßqîEQ\0 µ	ã®•‚¢0h­K?Œw\n”Ò(À0H<­\nS Pâ¶IRjÔ}ÜµŸ7c$_¾¿‹[/¯ï^EY?n=\rWO.z^Æ¹9øu]Á”uäº§²õmŒ<gZ+\n©LP’7…eFîµY}÷z]Ô¯ü|úeÆö¿\\cÛ W”¼;h¥m¹•”S(´ª÷Ãnú0úgïª\"A8Zä1ú‡ó£OÒ\0ê½n‚	&¸ø¡ªgßÖ^›8Ÿ:Ì)›ækƒÇØP=|R´‘ÈUºN~”rqŒ1ä¹$!rB4GSª‘½›MÏqS=—†1BË4jùsaüs—WÿÜ^—\'?»VJ¡l^œ_Iæj÷vuáûûaü:õëÌÁÏ“;¯§çêFkë¦„(ƒT ¶m ÷©êÜØ:óó[G½üØºñİëşÎ¯îoj¿N”ü:ñãTåG&R–(ƒ²å´ua\n\ncÛc\' (Îÿç~B–/(ŒéPcœ&˜`‚‹2`×Oë¾§ü\Zq}üq*¨ÇyŒñ7ÍïˆãØ-Æ !;Øz­ÜŠDIù\\EÒ…B)Ş%qÊ¦k\nGˆ«¶ó‰™#ß8âU¶ÅFi­#e>9S¾tWË!éVe‚\0jÄÎHÆÇ¦ïÇ÷ıÆÁãKÙ]=ûéÜ{Óû	‰×JK)“#”Ìı:b)íâÚb´~«sBãîíçÇÏ×©†w¯qåñÇ_+EwKú]àZ}…­oÒ\'ÄØ(cÏLÈòƒ1iŒÓLp±À>àjã³>Æi#d¼KhŒù§åØô~\'ÁØ2Œ8nğ½há ,‰qäe\\=ˆE²µvñ5EQH#+	Õ„½Ùø.Ä¯ˆµRº”´úd³Î‰FóZÑ22(e0&—s]¥W\'w.S»ğËVë¢(6•Tçy–Ğùys¨‡Ç+;/¥Íh”\näpmaÄë‡±áÑ˜ÂŞ·ÄeÃYwßÍÔ&.Î?Ïó‘úğóï&õr¦ëê¬rsuWI´å~.=<’ï~ıü–m7¦ÆFëx^`B–/Tœ¿}j‚	&xBª<ï3Æ;|çÍîiÀ¦iûy©åÇÇØ2•c}/Jøä†’Œ8+uà:¼8.ª ÑtD6h	Bz…8yŸÕk÷®“$ßİ‘H—/ÿÜéËZ‡‰±ÄµqDÏ/§óc©—0ô)¥Èó¼L/+\nrrrŠÔyQ€7periø$Ñ•Ï…«CêrTİÅÅqE0Òˆ¥ŸƒŸœ#¬ÎÛ¯jrç_¯£SRÕ4$®ä·(\nÑK¶éA°á>şµ|½8µ{Åôh«É¿czÔ\'‡ádß\\ p£åX×ÍQ{‹Ÿ\Z!ö½÷£FŸF®ÆAÕƒœäfõà•ÃŸóæq,ğ«£NJê×rª\\‘+Da Œ£µ]¨…%g¥ü•4\r(=ÂŞü{Õİ$/B’|¢¹¢×\nT©±M¸±œUÚ®\\Uù|©qA–eÖ†ÃÇcumµµ5=tˆ4O™›£İnÛ@£Ñdï%{™››#†aIº«|H¾êypùğá»ûyu~`ìâÊª®A\\àêù8qİVğóç»QK£ÆIğñôù÷Sj¤KX·Qr¬”âƒ7İÄŸşÙ»GÂÕ±aŸÕ¹™ã9Å„,Ÿ÷ÓËÆ8ùNÈò\\€°víù>áã^{{oN’íÀ_w>ğèÁˆ»Ãc!Íõ •ÃŸóæÈò«~à•¼ôÅßZw¶dF05ËÂ½œäRQ˜Ü~\n7hXä‡w$IÜÕˆ¾«¸9âTX5ˆ:©ó‰6Ÿã®ı|–îXK5w?¬»¯õİ ­uã¢(XZZâË_ş2÷~õ>ıufffH‡C~”á`@šö1EAçÄI,eBè€$i@°ï’=ìÜ»›}—<…íÛvÅ1˜jŸÖBÂ•µ2¢´eºÂ¸2ûpmgLÒ£*\n%µ_¶½²ØÎİÛ0ª×ìÃ¿¿ß&®~ë×>Ê|X¬•»˜O)›7ïbiY\0XZÈ€|èÃ¼ó]Ñ\ZFµş!ëxÎ0!Ëç=j½ìdnB–\'˜à„}°½çû„º÷Ö>AV#¬ğD¯ıq	jx	gì\'ÿÍâçq·³‰]^ŒOó|ydùdd«\"R>9Õk\"NâcÉ¥]PçHPXİdÇ‹İb;<¥$ƒ#·ã6O>	óQ\'Ğ¾{•_qw×¾›;w÷Èóœ4M‡,--qçwrÇ—¾ÄáCPä)°7@Zò<%/rL.<\n\"Â0Bë@J­yRÍF“……mìÜ½‡{öĞjw˜_X`naV»]¦_ä®ê\nWÆ1úÅ~¹Ê6²’ec×Å›ÊMulO;VâT÷qéù“¨quë‡uç¾;^›¸÷úH¹(Qn^ë76¾}?xÓ‡yç»€dÙaÃc½ÁáœbB–ÏkŒéacœêNÈò\\@°µ÷loú˜{oëñ$Yl¡Êàë‘‘°c#>Aø³?ÆX«½`ljN…4Ä*/6¦u¾À<²ìÃ\'=¾›kÃ’xQIöä·AVÉõcëÕ˜Ò>°rı~gãb¥¡Aà$Ôâ®j¶|;^ıü»¸îº.!÷‰\\EÚ*R˜ç9y³¶¶Æ=wßÃ=÷|•ãÇräÑGX][¶æÜa–÷“¤=âmÕ·CÆaY–Qä˜hâ¤A§=E%„QLGt¦gØ½w;wïaÏ¾½EA#I¤’Qá¹ŒÂ/·,¦sù)ÊÀÒ†2¡1ÖØivÒk×®RFÑÙØßı:¬»»ÃoC¿Ê‰²%m¿&ÆX“xJìn{äŞı‘É—+ƒ9ƒd™ÍÏ	&dù¼F­‡B‡SÀ`B–\'˜à}¨½g{ÓÇÜ{So$ÊB’±Ùi6$Ë2ò<£ğVÓŸI(¥ĞA@„„aHÆ%I3–4_˜„y¯zÛÿÍë_t-[¦¬ÓêQ¾ô×?ÍşúgO‰,¿ì%/.‰¶î„ü^Waª•”P‰TÒÖ¿ªSÜ’–Rª$>NíˆTE<ıôGÉšŸ/›¹;ñÚ(õÓ¤iÊáÃò/_ø_»ÿ~ÖVV”ÂPe)ıÁ4–j\0Ò¤Ü¹?ëjï¨€ Ğ&GÛI†\" \Z„(ŒTHÅâÖl0;;‡\nB’fƒ»ö°kï^fæfh4\Z7q9ª•O)…Á©ËH­;Â1è@cŠÂÚ8v„Z ”´p+íU65Érùn±}¤6S$Ù½7¤şœ\Zˆ)U4\\ÛUiJ=+¥øà‡nâOOB–#™œmp8g˜åóc^<cœ|8ï	Y`‚nàÙà2\nï\r=$+;h)¥È²”á`ápXxÎÇ1qÒ$£’ŒÉà?:ôœŒ4„./ÎÍğõšÿç~ê9ÓugîşÓ«ù¡_?¹dÙ-ğS#;Î‰DOWÙ<Ò%|Ğ-È³$Æ}&w»òJi\n#Ö\rPb_Ù\'LÎÖqIæj„Påy^†uğ	—;Ç“¨:écãÒ7Vİb­»Æí·ßÊİ_ù\n<ÀÊÒ\"`´.û8@nD9Ë2Š\"¯6\r±DÔÕ£-vyS@‡Q–å“ú‹¢ˆ ĞJêƒ!ÔIFE£ƒ8NØ¾g—]s-—\\şš&xÒYWnWŸÎÍIsƒ (u°Ö\"‰GvË<#äÕ•Ğd%¶ûÛ‰\Z•üW/…Òóä®]¾ªsvÑŸß–ÆH;+k=ã¦”?=‰Îrd“ÜØ#j`¬ãYG°°°åÿ¨;Np>`ô¥R¿û˜‘çYİk‚	&8¯`hï¹ûˆ{ãD(++MÖZc(XïuY_ï–ÖÎäyÎp8 (rÂ(Dë`|YÀÓ»Şô²¼›ÒÆ›ø¿ğ<¶G°ú¥wñ+ÿşùßéï¹+ı:?pw.ƒÂz¤<íÚk¹ü²ËJR$„¸\"1x¤e£›ıl¯”te?;Òè&\'	´õê§WîDWƒ/Gğ\\ëpî|¹£fœŸ;O³Œå•eîºëN>şññ¥/ş‡dĞï‚Í€±ö‘¯J9sjU¾\\İT÷İ	P[u ·éŠRVåÁJ]k]£ÈÒthu¥˜\"·C¿¿NĞãø‘G9¸ÿë~äI³Igz\n¼2½h—o¤Ñ©wiTå±M]º‰@GªjÒcßU8»`±j,‰²MÒ©VTyĞ²8QÉ¤Üv7„ Kÿºç«_åKwÜY¦=×ö\'Ä);ÿÄLpñØ{Ìc1ÁÁÕoø>ôé»¹õ»¹õ¶[øĞŸ¼•W]7\Zæ{ïfn½ãn>ô¶=£LÀèC;öùİ”([i2\n¥4épÀÊÒÃáÀtŞa8°²´H: ”•\n+Ãl°Ó\\C­\ZÎ¶0Õx˜›ÿã[xÿ]\0_áæ?ücş|=ì&°äÁ\'Gf•ÿÚX©¼Ô›˜üRØ]ù”“:½W›V™J%E•Š,ÕÉ›Ë—/uÜHää×?êù÷ËáßÃ…[[]á£ş0|ÿ_sÏwrüø1ƒuYØ—§dyj%È\"M–xWkMZi°lø0¶Œœ ´¶;ïA‘å³”¼Ü­Ğç™H¬óŒ¼ÈÊß4ËÈò!y‘Skk«t×º,?Æ÷~™O~ä&>ù·Çâ±E\ncÍÙÙ<¸úSv×B÷ë×¥ìÂ98I´Í¾õóÚtŒTØ¯w^†÷îáß¿(ì„™8h\'É—«¶ßVñMÅO	§ÒÇã‹uº1!ËNÒW*ï“œàôàEoçí?öBv;]Å`šİßøJ~ş]·ğ¾ß{3ß{ìş·ó£7lòÀg®%0Á“{xÍÿı1>ó¥¯ğÅ[oáİ?ÿÂÒgìSkÇ¨\r}”ôR¡MĞ£Û]­\"\\\0èvWéz¨À”½ZxL„y—3‹Û8p ÁÔ7ÖıN\rÈø¿BdÄß_€%R<§ªá*#DÇ¬¥‡Hğ•ûT/«ú}]üÍïU÷¬võsdË¡fİÍ¥U,ë·ÿë_çƒı7Üs×ôzk¤EJAA!+d_^ˆ$ÙH§rf¤ì&¯$Ä®D—ÇmÌbU~¬4\Z«¹)ó!¹)¬ÄYòhŒlªâ~Ó<-·v£ˆ0Èò”á`ÀúZ—ãGsÿWîàcï_øÔgöBÈ‹¢ÜAĞ/¿SÁ(ónw”‰ö‰0\ZmwTeÛ±şÆ€RÚ›@ &çì!¦½6ô¤ÊÆHXW©ÚN ŒT°”İ‘àš_)ùjá&fõIÖ‰aóSw®ã¤Î\rKI\'8+¨õ”Sî8§p‚\'ˆ×¼æì`p×ÿË¾ój^ıæwqó+Lsé·ü¿øŞ»ùĞ¯~—&0¸÷¼óƒõ&xÒá9?Ã¾h	\n‚i®úöÃÖÃ8XÎ1NíB¹Á/ĞòI¸×\rt ßëÑï¯a¶R-G›±e/Ë_q°(£œÍ÷ß_ñ+ÿã“Í·ğü_ø8ï{ïM¼ïã·ğÙ/ÜÍ­wÜÄ/ÖƒŸ\0>‘Ò³QJ+eS£¡@ÙÏîØÅXÔôK]ÚN= JÏ\'Á±õóâ~+?‰çÜüôÊûXIª;|wwîâ-//ó±¿ı;¾ü•»è­wÉòƒì((–0„h:åc¥DuÄ\0Z!zÌ’yKJíä¢¼Ÿ§bàˆ*IÒˆ´ÒdiNVˆÚ’ÖJÌÃyõ„R¤YF8ÀCE´šM’$F)Èó‚Á`@¯ÛeñÈ£Üöéæ÷QV–Wl¤¾©TÁtu¡ì¢L™Üq–|»ÃeÅµãÆ6?mã¶5ÚÒ=\\\nSX«!H=\Z9­êÔZÂğÓ3…˜Ñ3V|¤¾NŠª<\'Ä†`Î:&dùÇ¹ïBO6ÜÈ7ì–O°¿õkÜ²î~ÿ[øÉ—ßÀ«ù¯øÒ•2äê½âÿzÓ/pËHü	”¸t\Z·Ì` „xÜó»É¸SIK\Z†ƒ!ıèu^¨è÷ºCÑŸuƒşÆ\ZÔêe$Ô&QÎ^õÿÜÂ‡şãÙ\0É.½îr.İ>M’ÔC,ù¨_»‚‹û(¹µ4¦Ôç(\n‘Z*-]Ü:¹r×¬’®ê¼ß…w¿ãüıëºÛúú:ûz¿yÿ_óÕ¯ŞM:ì3I³´&M—¾à$˜£y’ûûy©ßÓÁÅÕ+A·¤¹™$$QL¨ƒj‚*‘äÜl¤YJ¿? /rÂ0R\ZhaîÆ0fC²,åÀğñ›nâk÷İG:‚]çÃåµçîÎëmXçŸ‹4|´İ¯ôÛn¶œÆûšaÜ¢=¯(%1ªWùÄÕö]VŞãÔñØcœ{L¬aœWÓ…Æ8ùp¯ƒáúÈõE×¼ƒúÙq\Z¼ÿj^ñæZ˜	&8çxïøìÿÎ3Z2ÀîıŸ¼é•oæóõ`nĞöéŠ(S~Jw–.|(¦gçì@.’,Ü ìB¸Ó1ïÂ2ÔÆ“3†×üÑÍüøÓbV=ÂÁ‡¿Â‡îãŸï¼Ÿc·Œ[öKNÅ\ZÆ·½ô%#ä«&àH#:âeJ=o!-\"	õı|8	sEˆ*²ã$¿EMõ(ù~~^\\:¾{=\rwò~J‹¾¯)ø—ù÷wËÒñãY&ª¦ +2WP°ÒLìıœê„#u\nJ“ÃtX³.áò õ#îíå-	¢²,Ê.js~Êk ´å h&\r:6y^°Ş_\'/\n4ŠP‡D˜0E…\"ĞIÌS®~*Ï}Şi·;¥Dy\\İû÷«×§s«n¿Ê²X‚+uéÒ©¬“(­í#âÂÙ~„ÿŞ¥¿&Ï‚Àõ7IÓ¥ÿÁ›>ÌŸ½û=U¼1ˆ6”ÉÂ7ÁØ\0cÏ\n&dù¼B­CÕûW\r•÷hÀ	Y®…™`‚ó×ık~îG®gzğ07¿ã·øh}1˜ã\n#ã•½°™R½µ•ó~1ßcA\'´:Ócõ/KÎäw:æ82~ŸÃÁÔÁœ\"Y~ÙK^8ÁÜ˜‚!¤¯Eq„µÚ¦\Z¬º‚[°ewòµv\0)*	–çæÜ}Â;Î¿o„°Ù0išrÇ·ó×ı?é®­Qd¹õc¦F1VBnËˆMßåÉD_òºLZ³s8‚¯Äª†˜†ÓA6ùÄ®´.æy^NZ‚  L^è€™™iĞ__§?hMàÌÑE1aŠ¼(H)èÌÌñüş+.¿ò\nÂPHº+S=Ï>êõ=®=FÎín~\\	/}¬”Ô—*È¶İÜ¦\'t`ë\Z·)‰½R¢ÏìI7Á\0øĞ‡?ò¸Èrõ÷Ø`ƒÃYÃD\rã¼A½3*o¼	FñB~ş½·”Ö-Şó«XLğ¸°ïµüßùŸùüm|ò#ïàßú.~õ?ÿÿù¿şwÜøëüÕ\'nåSŸû\"ÿøîÿÌóì°Qh²txQe¬•Œ,VÃQYl,¸Ó•v`¿0J„©©eè2NI”•BÈt!3	K”%¬Ó#u	X	³—#Y¾´ÓxD—rÚxé³£“ìÈeÌõûë|ıÁøøßı-««+dÃE..YT¥kÑêßº4Üá´VŸÖİÇWæÃ«WwZk±âé:+qÕöp’lw®µ&C:y‘³¾Şós@š¥dö^(1ßšF£A–¦d½>‡÷}ğ|ás·f•Y×ª6.œôÏ]»ø~îºšHØ.aáêAYË\'B’Eç»È]ÅQÖi{[Ò¾Õ}A¬¯Tq¥NÎv¼\'	Y>_q’>qï	+~âÇøŞë¬Vi0ÍÕßûc¼¾f¼æ,É¾ãnnıô;xM=ÀOJ¼æ¿üÏß=M’$Lí¾‘xí\0P|\'ozıwò”ÙXü®ıa~ìç÷l°z1ò£D6\\œ\r}”-\'ø/¸ªRê6q>óxÍ;ø\'÷Üßqğ|Ÿ€x§€#vØ’UtÄYt\0©$7Bşœ*#SÌImŠŞ¯¦°vİµósnş¦$£y¯ˆ,6]—^Qôz=>óéOóşz²Ôæ]ÚZ[’ŒÍ£²Lm ëùôóŸq6åFUxWs~~­ÇAuyv‡«‹8‰ã€(i4\Z´§:¬ú¬v»¥­ë¬Héôû}»cfNg„aÀ`ĞG)ÃÊâQşéï>Âûÿü/8ôÈ¡Ò³Ü¿ª7??uÔëº*»¡(ª~äüKI4\"5İvG¼¢lë[|Ü=«‹ÂN²¬T9±»-i?‘çï¤qO\ZàìaB–/hœG=éBÇö)FÖç´¦Øí_O0ÁcÄ¥[İ’>yN“9go{«µÓ+0v]ş’Êaƒ¼¦\Zô‡™TÙah­\rªÒ;Ú3‚<¢†óÿ½èr(ÉÅÊÍÒ!Ëe…Ø“ˆ–ìˆ4Ğ\ráÉ½vëFEÄ™ÄŞË\'É(ú¤»±ŒOÒü¸•t³\"ªXÕ‹»¿òe>óé¦×]Å¹l7(Q‘À M199²‰H.ÒrO²íÃ¿VÈú:…AQh%*Öª…Ö£D[£•&°\nNÊì,k+¹.¥ÍJvõ‹ƒ\"MSÚÍ6:èõû³!V¤ÃS†é€şpnoş`‚‚a>d}Ø§?è±´|„;oÿïÿ‹÷ğĞ×\"÷äùårnÊÓI®·ŸËŸ*¥üXsp\Z%ZİeØ‘t-é5–:wÄœœX!cª~!=R9\"Î©<›âüN}LÈòyÇÖiNú„lŠGW¡!½Uø×Lğq`±êQƒûxaĞw„Cü>òñ2lù«êJ¡HÓógë34zÓ»\0©öJÛLc´Î.\0¸²ydÎãC¥	°Š\0;‰£f%,ÑzbIŒKÇŒš:‰uaáò‰—»64Ú‡ëHœsÃ¾*Í‚õõ_¾ãK¤}«f£äaZIµ%…6¿\n¬L³’úé–ù´Eöó,y©È£¶*eşÜ<ÃÈı¬<»¬ÿ×‘t¥QÑj·eá­ğùÙyt Yï­3¦(y‘‡³!ëëët{]Öû=t\0Ã´OßZıXë®rÿ½÷ğ·7}ÅÅerk‡y´êù+Ë³¡ïl”:û×Ws”jbZÌÇ+IÆÚqvqŒµçí&L¦0äY.ítª¦ã6v¥\'ğÚ=ÆéÀ„,Ÿ8¥¾pJ&8UüÎçıwY³où\nw¿ÿ¿ó‡õ0LğğGïø+î^´«_æ/~ï×íÅMüê;ÿ‰ƒ–K¼‰?ûE·q}®•wŒn™§ïx1\"Ë2ÁKx„ğ¢{ß/OIvJ‚H9LWÄÇ\'MöS<¦´»¬œäÙ‘)kÙÁ\'g.MGH+Œ#[•Z†‹«<]e?½¼È¸çî/óğC_\'M‡äy:ßCa¥¸…İOÎ7?ã-âs÷siÊ¹¡(r´R´’(FĞL.›œ8Õ	‘Ô´ÖDQDÉn€n§½Ân­€(ŠJ«\0ƒl@šÉ‘İ\0‚,MÉó”^wáp`ó¦)Œ!7 BÅ¸ã¶ÛÉó´L.ü6ruéWnŸ4ûõíÚÓ×g“şäFÕôGÓ]DXm¡.›—(ì\'*ËÃ)Ä?… g²|1á<éT&>É¯üĞ\r<óéWóÌëoàÕ¿üÉz€	&xløÄ[ùá^Ë7~Ã5<ëù¯ä×¼.uğO~Œ—ßpßtıu<ïû~–¿±îãa7 –pœiìİ·ï„Ç™‚+ß¸Øw95éòÆ4Î/ŒfŞ‘G®Pv1•<rë¢\nm±–/pqj¤Ú¯“#—Î‰ÜõÃøş.|nõnığYñÈÁƒ|á–Ï1è¯“¤–çy^n_m<õƒ’(Zé¸»WEÜL)\rõı\\ı(D\Z¯µ¨Z: ĞÊ@QävG˜mÚ¶Ş£0\"¶¤ØåÕØí«£0\"c!ÔJ‘D	QaŠ‚4MI³”a–‘¹Õí¦C!ÛZ¡Ùtƒánw…[¿ø9–#¦@eÙÃowîêÖ…ñ\'7~;©ròâú‰¨äHıH]9•\nÑa®ÌæI¼*Æ©[”’~!Ó¸]şŒU\Zó¼Å);_1!Ëç­=¶ĞL0Á…ƒ’İ”çşóçbjëLà·~çwøü­·rèØ1>ë­\'<~æç~®ı´À/_Uî‹SºìÔMÉ)ŠŒÂJ~\rÛæŒu/İÀ.’³éx¤(„ÔTdS0hú~>Irnõøş¡¼ò”%kk«|öS7sä‘CôÖÖ+5®È²¯íÒÅ–Êx¤P)Ñ?V®õ-~fPÆ ¬ôXÑÖ5YÉÅşq D{7D¯Wì:ç¥-BG˜µÖh­”¦Å4\Z\r”1Ö\\dÙ@)”•ˆ+ ÔA’åYQP™‚A:¤P†A:$ÍåkPFA(÷Ã0Ì‡<ôğ×¹íöÛ¦éAv¿A”mâÃå×¯?Ÿ0Ëµ¶ôN¡U\0V÷%}Éõ1ìöÙãîïC6¹1¶4Z‰ZJ=o=•Çã‰bB–Ï7œRhŒÓvÿÇ÷ñO}?õn±Øç/NğPÚ±hÔTÜ(e}6JùNû¼çqèØ1^õêWŸ²ÔxÿşºèÓ)Ÿ-ï˜AØwÙÌ2Æ(N)Ğ9oÙÂ\"çäÚ¹$\"Ş@1©&îb-Bº’Öòy\\)ráâ‰ƒ^\'[uRæ$‡õ¸.#³î\\)E–g¬÷{|ù®;øò]w²Ö]eh2+ı®ÂŠµˆj!Kß‘@ÿ>>üü—dÚN;”R„a@†Äql%¢£jbsÙÖ¯±uÃ,.Õv”8Šé4[DaÄp8¤(¡UÍ¬.t³Ù´Cše²±J–‘e™XÅÈåÜ2rù©!>rà Ç™Tıac];Ôë¢ÇÁMR0¢RáÒªìU ×¾›H§«<Sé;¿Ç„±Æ:â‚œiLÈòE‡ó WMp†p#?şük™Ú}#¯ùÕ÷ñ¾·ıÈÄbÇEûÜªêÜ\r\\¾÷éÄŞ}ûxß>\0À§o¾™W¼üåü·_û5\0şü=ïaÇÂ¯xùËxhÿ~v,,°ca?Ï‰7 xBğ‹\\–ÿÒåœê‚OE’[]û¦Úpú¢ )åÕ‰˜öª¬bHxW-.“û$Ù\'\\ª¶ÁGxÕÉ”ûU KSîıê=|òÿ‘îÚ2¹IKJæçÃ»4İıÜA©?,“\0!¨~c*®E…@iQ£°›ˆ8ÓsaÊ¹µ³,nÍfƒf’ •¢Ûí’¦©A»+ßüì¤Á`Ğ§°’^€<MIÓ”8ŠÉ‹\\šÍJñÄ¼ßïcŒa8”İ‹¼ÒË6v³8X[]%¢²]»sWÖz›ÔÛÊG=–»>b¢ëÂº0®o¸øJ)\n«OYßò·úòP¹§æüÆ„,ŸO8IÚÔ{S	NWï›xûŸ|œúÜí•½ä;îæÖÛnç³Ÿ¾™÷ıÑÛùñWŞxî‰é÷¾o*…Ó\\úİoæ=ùf?\ZêqaÄVô7ñ‹õ\0§€s[oå}Ş=ß÷–ºÿfxği/¯xk=Àƒ}6Ç=¢›K•‘÷Ür+Ÿ¾å‹|êsŸàÿz•ûhzñÓ?û³`‰ñ+¾ç{øô§>UrÖ¡v?‹Wıìïñ®~‚üç/ò™[nå³Ÿ¿Ï}îşş#ïç·~ö\\eÃ“.—NåÉnxí[øı÷|ŒúÜí|ö¶ıò=¿ù&¾÷º2‰³\nGtò<·¬R˜—*K¤•µá$±–èTŸÅ=?„¸)!Ğ\\9Âë“2—G(}ò´)sñ\nxàşşo?ÆêÒ\"Ã4KTÔXÉ±#¾¾Ô¯É$œ²ÒW1ïfŒ!\nBkî-	#(¬\n†R„¸‹)¸€<ÏÑZ¶¢ˆ$i ”ê$Œ(ò‚\0M«ÑbªÙ!‰bòLHíĞ’a€-DQÌúz~¿_ê8	Ãˆ@$£ 7†\"7hˆ\ZM¡0FSäf9…GP³,ƒaŸa:´õ0:±©×z[ùõ_‡/VJ>?éµ6“½ö—&(DíG²Q©¹\0ZŞb>	o0è@¡F?dœ\Z6‰°‰s…“8³˜åsŠÇÓú\'ÎcqİùíŞÎ{ŞòF^ü{˜jXZ† !™ÚÂ¥7|¯ÿÅ·óóß=ê}ÖñÅò‘[˜¸›ºúGxûûŞzZóãÆ…Vç\ZÆ7ûL«ú¹0Ëp§{÷íãU¯~5íßÏ¿ÿ‰Ÿ¨{Ÿ3¼ÿO~‹ûgqÉÖIâ½î‚m—òœWı¼óŸş’ŸıvO\rilíáÛúùàg?ÆïÿÔ+¹áº=tš1‰/°µıòê¿‘_|×ÍüÁ®ñ<Ï*âBC\n»øŠr#ı@Î„D:½f©ª¼ÈK\rc·“¦¦àÈ—ƒïOæ<	¢ûõáÒµŠ‚Ûn½••¥%²,…šä›®#qÊJİ¡­ÚV¥ÄI…E\në®!P²Mu 5¡öI·”//\n\nkY\"KøÃ  ‰Ğˆ\"X‰qF(Zq‘g…•w»]VWV™šA¡é­¯‘åY)-6EA\\ZĞ¦½áaƒÒä¦ /r²\"/ÏåÚênç†¥ÅEVVVì$¦ªW—]³cíÚÑ~»:ò¬kâjâU‘p÷«,ÛUZÙ~dÉ³5ó§­êŠû•°ÕcY±ÄòÄQõÇSÇã‰óø±ñ	˜àÆÙí<4^ôVŞ÷\'oâù»kÄn3½‹¿ÿ`İñ,cÿ‡øû|~úocÕsN®|%oû£×!‰íIp!ÖãÙÂ)>›“AÍI•7õøğÜç=¬zÅù„v9J?İ9€ê\\Ãüâïñæ“ìHéõÏd··ùË	lá†Ÿøşàugo-@ä¸2Šy.×òâætœ]ŸI lMJâ1ª¤‘fiõëÓ¿vdÖWqé¸4›ƒÖšcGğè˜,Å£{àİ£°DÑA\'evaDUAòâH€²–$Ü]%;ì%v‡=¿<n!…¡™4H¢Øê6+²Şï‹$ßî0¨EÇ´šbO¹?è±¶¶DĞe˜É®|F…¢Û]¥ßïÑí®‘e©”Ai²4%äq˜¥¤yJZäÖ2†BœÅLœb˜öÉ‹Œ¥¥e‚@¤á©•j»úóqmè·«o÷[o+Î\'ÜÖ£ªç²ßH7+ŒÕwöû‹İ	cuèKŸ“áÔC˜å	|Ø÷:şà¿¾’K}~·z?·üÕoòŸ~òûÄ|Ü½ÿôË¿Ïûÿù6,ÂÑ;?Èû½àç7ÿÆñêßø$G=óÔ\roâ·ßröpºq×ãÆ[n\ZQ]ù/#ÕÀ g¯å¿ÿó]|á¶»øümwñÿãßxaM#+çïxšñĞCÕÎ-˜lÀÛ>Ê;Şş¿ñÚ¾‘çŞğCüÔï~„×$ˆ1_ÊËßü{¼|L½ˆÓÃüŞï~ŒöjğèıÜòwïâwÿÓOò†ï¼šg>ıûøÉ_ş}şş^k[€inøwo=+ÛÕ;İVŸĞ”ÜEh0”ªÖ¿Ô¹E†nãˆ‹\"ÔX„ÿ€ı¬ïTp9(OåÂåÇ\'k.L=¼;ÏòŒ¯|ùNVW–H³¹· RŠÜêëúéùjÚJQµ•†æy.úÆ\"_·¡ÚNB»˜¯ÕjÉ¦!BG^‡C†ı&Ï‰CÙ…/±RàĞZ¾0&G™œ^w•,Ï‰ãˆN§Ãôô4…)èv×X]]æèÑGí“`r©—<ÏúEA„4\r¢0Di)\n²¼ ËsÒ<#+ª_·k_ä…¡×ëñµ¾&äJ³u\"i®Ú²ŒJìıÃÁokwíÚË¥3%íá,º~ íNNzìn¡ìW\0ïíô¤À„,Ÿ/óÒ÷±©÷¦l†ïı™Ë\rsÕõà¿â\'Ÿû¼á—~Ÿ|â+âx×\'ùÈ»“_úÿÿßõ‚«yéO~¨ŠpàÀ¿×şîg=	sÂ¥ßıfŞö¢‘`gC={ØØK[²Vª|Æ#\'QŞ»woİëœÂ<ò	~ë\r/äUoüÏü?ñ)¾j¨¯òéwüG^õšÿÆç—*ÒÄÂøŸ;$ø³?Ã_¼ûCüáÏ¿”ç¼ô»xãO¿•?üàÇ¸e?ÀW¸ùİ¿ÉO¿âüÆ-aº‘ïø/3‹eeÛ»Æa­©/wá<1’k­%@^ûŒï‚;âäˆ–;|øR`?¬CıÚ1eU09Ì—ïºƒa¢õ\rã¬Kh]ê+Kø]Z²Mµ!ĞV’®ÂélÙÜöÔJ¡hÒš,ÏÉ³LT3æf’ĞˆšIB»Ù&ÒaJ–Š8\n4q ˆÂ€$D*†DaD··ŠAñA(’d¥X__g}½ÇòÊRiËº(\nrS0´»öå¹,ò‹¢˜8É1¥‰¸ÂÑ6 »H+ÒL61ézÒ÷Üóî½÷Œ“¬›‚¢”ÎoTQJ¡õFÉ<¶Ş]{ù’yCª\0U”¶”«H²M¶)´äÑp°:ÉÖvµ7‘Âë[ëõ´	oÙÄ¹ÂIœ9LÈò…õ”ùMPá|ß\r[ªËŞm¼ó\'~›ı üñkùOï¿¿Òaöğí?õVn\rv†pñÔãÙ´j#Ë‰Z‘æ8Ât¢ŸşÔ§xhÿ~ûüçŸ1»É÷şóáı÷Ø‹z‘z\'?ñ_?ÎAÏëªçıo|eõnÀ;ågø½»İÇáaŞùKïæK½Êåêdáã™DI}Ój„¹\n!Ÿº+Is1¢apRbcíWRF­e³	¶GŒİ9ÑòÃËµGŒ<2æ®<úKÇ’ç²‹]nÍ‹á-(,Ïª‡”İê$#’Ì@¢“ŒBÙ|¢§,VŠ8Ši&	•‹-d\nƒ6¢>ÒHDÿ8B\"¢(Œ‰£„PÄaD«Ù¢‘4h4›ÄAÀÚêŠ,ì3²¨­ÙlSè§Öz«¬­­Ú§RÔb”RdyN–gh­Dª­5QbŒHÆ]¸úœÄ¥ÑÊeCy”Ïáôû}ƒE^XlKVmû8ò[µùÆ6ñÛÍıÖ	5^Ÿ¨ú€¤hQ«Pâ)şrQ…µi¸Å—\r\'\n\"¿s	YàÉ…×ÜÈ¥ãêËï_j›	7¿ù\rüÅİ>Æ¥ßÍ¿Áq†p‘Õãù‚r¸0•©&G•N7şâ½ïà?üìÏòªW¿ºî}NĞ=äˆ¤¯±ë•ÿŸ~ƒyPN1°ëRDûú	`ÿoòÏş3´ûÚ3®Š¡<rZ\'2.„ìÌgi²1b$NÉ\'p‰ç«\\8Œ^÷ëÎİ½|é Ã¸|8b†§&á§?¹÷î»EÏ6Ë„ j-XGæ\\Z¥Ğ‰Sî(mSôíQ»ºÒ\nÂ@Ój4Kr8é«SzQFA È‹Œ,O‰cÙl¤ÑhQYA:HÉÓ‚f³M†¬÷×1¢4›\rt¦ËkKô}»mu™)2»vnë7ÃÒ\\]9ªz+¬Š‰Òa 0&ãöÛnå®»î¢ÑhE‘U%Ã|»ºpõZÖ¡7)‘:”¸t´Ûåe¤Í%Œô‹êË„¤\'å¬`-jXÉù	ÀEŠ	Y>gØøbzÌ8\rI<éğÔ­L•¸õG¼/<<ÌoüÆy |&<ãåo?óÒå‹®Ï6|¸Tå”Œ)¯K2s¤_ÿÕ_-m&ÿÖïüïû›¿á9Ï}n=ØYÅ¡¿®—ÓÖG9XäóûVõlå’Ó`]å?ÿ•êÍÔ¾á9£ş§–Ô8Òê“Weû€0.2ÆØªÂ\"„Ùˆ$Ò‘i§£j‰§;|”„Ô#Y™ªôıpu‚mŒaee™í§È†Òeíf”ª¢«ì¶šVL‘“çä9RbN‰J†2…%Ãai/Y)C\r(\nB­ (DÍ#Ğ\n”† °åÁØm©EÊÛj4³!qœĞl6ˆã˜,Ké÷×9zô0ÇjE¤\rış:A :Ğ·™‰fXd¬õÖÈ¼İù,Š‚\"suaFJkÂ ”º*DÅ\"Ïs‰£yš£µl¤²¶ºÄ-·|N¶ÇVŠ K>Ñu¿õv2©–_@\n“c(Ğ:DëĞj‹:Œƒ¡@Š ´iÙr¹òÉ.¢òãßÇéÓ×ŸØSÆiá/§%‘SÂ„,Oğ¤Âkvmõ®ô—½ËŸùşôÓG«ë}7òšïõœ~\\”õxÖ±ù‹ŞWÁ0æñ3=5üûŸø	şÛ¯ıZ©’ñÜçŸS#„ÕÄÁ•wL¹ÿvÙu6ÄÄ³µ\0x˜ê	ÚÊÖgø18ëÈ‰ÀX+Vêl,I¶_D°)LNúˆ\Z½¶DÖ¥épùÄÏ÷sñ|7\')Å¦{ôÈQºkkugvÍ…—°•„Ô¹cÙ¹²‹Ê\nƒVBÈ4†P#»ñ…!QZûÈZ	ñÃĞê\nÂ@c¬¥AĞhÆ`ŠR_:Bzkk¬¬.S‘‡¡&Š¢8¤×[áÀ¡ƒdyN3IÃ€8	£­[èYäfŸOGZs#fë°ªÊ’KicG8«IüÚºÄpèĞ#?~ÜJl%ªİ*©±«{ÿ¯ı”%¼nóc\n±Ã]HŠ¼2ß§lã¤ÊÒ÷ì‰ºVòìç!Ğ”êq³å²|À>ug\'ò›àÉ€÷¿ó³(¯¶ğ\rßıºÿ	Î&<Òá¹zãÚ)¢úÔZíWvúñë¿ú«|Ó3ŸÉ+^şr>}ó¹Õ:vûå|Œeöêw4æ)¤³ÿV,º‹„]W}×¨ÿ€Ox9­<«Ó’ X‰¤[Ôç¸­rÙ-\ngÁ ºÇYµğ%Î.ÌH>,\\1‚\0c«++¥­1Ñ	ê¸û•çÖƒñ,5«sÇq¹ùˆhÏ&³ÕƒØJŸµ’…nQÊöÕı>‹Ç‘eCÖ×{¤icrŠ\"emu™ÅÅ#t»İRİ!šƒ´ÏıÜÏêê\"y6$‰\"Ú&qJ¹,¬K3Ù°Dòl¿)E†„AXª?(Dı\"”–0Æ©aCNA8`8LQ\n†ƒä+ŒdQ~EğÚÚ«KwíÜFú“ç\':Ë•”Ú¹E¥ï§UÆ~såÈwĞõQÙ¨çéä8Qx_æ}~aB–Ïœ¯½ã\"Ä;©;]øÌoróİÕåÔ5/<£z—m=EÔ{wmìù8Òr&ñéO}ŠÏ|úÓuç³Š¹GëEyƒ´sÿ¶™ïzÈpÉz<!¼‹{­®¶ì¾Ñ÷<#ğI†±*JÉgo!Jq0FtCE¯ÔJ­ê¬1ö;ÜÂº\r=¬Â±ªuëîK…Uç¥)¸\\T-²ÌªVÔÒğã97p&ï*h%10mu£  D\'9Ï2LQ‰¶×aŠå0\"*Õ64˜œ KE‘Óívéu»¤Ù”a8ì³¼²È0í“4\Z4’ª0t’&s³¬õÖ8~ü(ÃtHhš­Fƒf…!:I³Œƒ±¤¿(ŠÒæu^¤ƒaÉp}?l»ËDÆé¢ËWƒ,O¹ï¾û‡–°\"¿–œÂ‘Õª­ğ&×#!=–[©ÕHé#î°ö¼0¢/._\0FH¹²ys¿3Í»õÅ„,OğäÂ£«ŞxÓl½lÄ÷ÆÃüÊ-_®.§®à†Ó Ë¹).Úz||Ø0hœä…>\ZÚV£úÊŒtOtJ+~ê-_:_iË›ì0È\ZáIÚÁÇÍû=«»¯àÇ}Ï3\0G>y!G•u!RØ~`B\r²ãšò,%¸‚æ–¸	yªÈŒ|b ûd¶.!¬HØx¹˜7ÃZËÀæÇm8R\'É>ÙR¥v‰”0·DFa(Š¥¢H[srEiY«¥y6$ÏR¢(\"\"’(!Ô1ARä)y‚1ÄQäYN:’Eâ<¦¤éTA£Ñ Ck)#ÏS–—ea`ĞLbZ(’Eyb\"Î~ó	”’Êíc¬ì‚>G’]ÍA\0¥ê(»½¹1Ræ;ï¼ƒåeÙ¤Dü±}£R‡(odÉ±k6åvÚ³ıEX³p£ê0.­Âd ¤¿H:Ö4Ÿı\'w……%1¶j#\"¡v;=†‡ìÆæOÂç6í†›zLpBüÎ½Åp°ë©oò}/lüù­Ü]–m—¾èJÇ.æz<›Øä9vä6s1bn÷‹ORî×óìË“jà?ø\0Ÿªyœ¸å÷WzË­ËxÆ™ü4ãˆbI(+=^!²Õ„Ê¸-ˆ¡ÜşÙMJI ¢v¡½Å|D\"Vnu„ÙÁûnd»¼ºk÷ø±#`Õ3°–8”g¹Áİ?°;*§Ê¡µHe•Á)da ²±H¬ª(ĞÆĞC’ @YƒP+”1diJ:è£(h$Í8¡‘4H¬:šívËê#‹måá`H½Ç0çZk1ÿhâ0\"5CkÊ-‰\"\ZIL§Õ¤ˆ©¹†ÖÄˆÉ8©Sä(K2åWÊ®µF»ˆ¶îr7Ù°“¢,Ë8p`?Ÿø‡¿§·Ş³óf×~€,dÛ\'ÜâB×>Bz]ªÚs¤İüv°¶°erSIºñ¿d—>[\"U ì—\0I¼?Œ}Æ7u>§˜å	dø5şşöJ&š<ã»xûYÜÈãŒbÿÇ8p¨ºÜ½ï¾ïiÆE\\gßs#—MÉ°Ğ¹ú[ø‘Íö±ƒOIZÀXt¡a~ßsØYwôFÎgÿ—ïàiªBíÿŸ¯¼Ÿ>ø1î.Ùò4ßğ’7úŸT¤Æ~nwDÅ®qtdS®\\¹+É°Â±ê\0…|ŠGÉ.kuÒT\'P>)v÷©îç$À•»Ÿ1†ašrôğ­d±—\r+äÍ-¢n¬”Z[]d	k­_Ê2‰„Ö 1D&ÔŠØ.ôs‹ı‚Rz­ÀäY&$:P´\ZS­SÍ6óÓ3ÌMMÓŠbĞi4™nµ˜ét˜mwhF	q[2Í ¤\'$AyA¬tahè€¹V‡­3Óle¶Ó¡İlÒˆcÂ °Z0ÖJ‡İI0B\"{„Zt—Ã ,ëÒ‡)\n²lÀƒ>H0pM	V»F»OÈ‰±RùÂ»©K¥¾ã·¯#Å’”ô-G°ËI”ÕSvñ¤zÿl-­æÙ	›‘B[Ç‹²|Áã|œƒßøÃßÿ ”<oÏÿ©·óíûFÃ\\˜ø,·ğv#Û~-¯ò½O3.Şz<İxo~İ7³à;unä¿ù+|Ûf„yOgÜì¼œYäWa×ËŞÆxÙ¥#nÏ~-oıö=îëğÄ_ñÎ[*UŒä^ÆÏŸ¡ş\\ãI8Y¤VJ‰õ¹qAŒ²}A$ÏB€,	2ŞgÏâ|.¯nV—0oF˜}¢ìÜêÇÚÚ*«+‹EV~¶/ò¼”®†&ÒšH+\"­ÅÚ…-{àK -*b\rB¥	•Ä•HoC­i%	Í8!ÖŠf!íf“fQ9A‰Ò´¢ˆ©Fƒ…éi¶ÍÍ±mf–Ùv‹¹v›-íó[¦¦™ou˜kµ™m6™mwØ:;ËÂt‡İóó<eÇv-,pÉìİ²•…N‡ùös­6Ó&3Í&­8&	#:Í6íF“$i„š$PD\n’0$\neb„ò«íbE¥QŠ,£È3”~Aˆñu•í×­­ŒW‹\n„lv2şƒ/yVˆN¼è kÏ2†ûcuÕ‹*¼VÚRf×7¬´ÚˆÉ¾Ç‡\rÀyÇ]Ô	&¸`ñ™_à\'½­¢“K¿‹·½÷&Şöú—rÃ\ZÏFŞÍmåjßótã\"®ÇÇ‚úàTáj÷ê_à¿ßô›|ÏS’º\'ñS¾ƒÿúÎ¿æ7~æõ¼ì[®ªùZâRs=ÓØo·Á~ø¡‡ê^g	—pıëå•{7ÏúÖËOı_ÿ“?ş¥ÿ…§Ä#!¹Œo{Ë_ğ—¿ıŸù_¿ëÔkñ±â–ß}·8«Áµ|ïï¼•3bL¯ä@îsx%í5Æ-²²:ªŞ!–ÖœZ†%4Ú\nú¬ÔĞX‰a}g@×OışZ—Búîş/6W˜‚µµz½.˜ˆŞ.FÈ²VDBq€8é­ß€P	qŒt@„\"šDÈ%Š(Ğ´\Z1íFL+‰h%FÌTS$ÄÓÍ$¦Ä4£ˆ8Ğ(“S¤CŠ´O1èSĞ#f;m¦Úlé´Ù6ÓaËT‹]ósìYX`Ûô4³í66Ûf¦Ù=?Ï¾­[Ø57ËùYvÌN±sa–]³l›n³µÓfçì,í)æÛSÌ¶:Ìµ¦hG\ršADL5š´“˜F‡¡VrXsvSäY&RÚB¤õKË‹|ásŸe8TmêÛZ®ZÄ.ò«ÚÅµW½=}7IÇIø­Ş±%Ş#íî,w‘>—÷Atæ‹¢°$ûâ‡ºòÊ«7Öêg¶ƒ¤Ÿm:d–NıoïÖ‹¯yÿô³7zdŒAqš¦…«Ÿå7ûZŞYs~ÍİÂOİ0}Â0o¹‰[¿÷òºëÂéªŠ\'„ÓYG%ŞÊûîx%£rÇ³ƒSµÕ°\Z¤À°Ìƒ_²óš-ÄF“ÔÈ€åvÅB‚,+HÓ”ç<ëÚÚ}N?öîÛÇ½úÕ|êæ›ùô§Døg~îçÊëç>ïy<ïùÏç½ïyYb}:ñ™ù2Q$ú¢(Ñ—”_ûÙÚJT×9@²k±’Ao\0Çö®UDê9+Üòk7ğ†quäİS…3@5ê¡Gğªx%/}ñ·–×R6Ïúb#×úz¿Æ+‘|`1³•ª„\ZY\0hS£–¡Æ©Ô¬a8\'©Î²”¯Üõ%>ğW‰\"4İŞ\Z½~·L³´¡\\^ËfZ»]÷ä^Ö\"}ÕšÀJ‘K*CF¢ÂZİßĞîà\'e•ZQJ¶Ì.«È‘TÎpœÄ„¡¨‹¸FœÙ¹4†Z‰I¼\"/<³o\"Y!­E^0Yï÷YïéSÖ‡9İ4e¥»Ê0Ke£¥D“Ü(†yN·? Š#²iÊ0MËº‘z¶:ÄQÌÖ-ÛøÑó¿rù•W€ıº m,u¦”É®}g(¥0EÕ†Êš†smèÚ¯jsªgÂ›`™Bl|»WZÙóäÑ³zËÖÑÆÿğGÿ–?{·ln´¢±EíMFMWã\'@à¤!OÆ•`‚3\nåuÁ	&˜àbÅ†§|p€Oıæò?ò¯yë_~…5ïË¹ƒ#\'›]Ÿi<´?¿ş«¿Ze¬fwı¼ç?Ÿÿğ³?ËûşæoØ»ïÌ}>¨—»¼.VyğÃ¿Â¾ü;ø¹?½…cŞ.Õ\Z”“Ì	·ÏT²\Z{bÑÀ ’@#®ÊnĞ!éä–49•4*¸ú3Æ}P…ïÏ©’_·Í¹:duyÅJ#5XûÊÆK2‘m·²˜ÛE|U­ˆ´&RšH‹¶t’„©f‹éf“éF“NÓiDt\ZÓ­óSÓl›™eûü<[çfÙ:?ÇÖ…9¶ÍÏ³ua­[æÙ¹m+Û·.°mË<»¶ocçÎílß±ƒİ{ö°c×.öìÙÍ®=»Øº};wîaû¶lÛ¶•-[·²uû6æççiwÚLMwè´[öh35Õ¡3Õfnv–ù™[fÚÌw\ZL\'!Ó„vÑŠ\"ZQB+Jˆ”\"Všfk™D:(·ÃÎìÎØÉÈpØgñøQ¾tÛm¤Ãìf4…{_”}ÄöÛ\\»ùÄØõ/â¯÷Ü\0Eî|¬Ÿ–ûk¥å+Fi…CTBêÏêÙÇÙáT²<ÁLp1X=Êƒ7ÿ1¿ğ/ãMò0ğ0ıåäÅ¯ıe>ğ…¯qtíÂa|N¢¼wß¾3N˜KäC‹¹óÿˆ·½îüĞ/¾—ƒÀ§ëõ|û¿ıEşß¼ƒKµÉÇ™>Ÿä‹B¥C\\çY–ÊÅVúgìú=m	¾$²TÛpøJj(:ÌpËf\ZB°Gmæº_Ig#éq’d!å¿(\nŒ6DqD¤­Ê­ªqBD•Î«6È­\rè‚<OÉ²!y¢Œ½dqD!fƒ©fƒévƒN#ba¶Ã–ù)vl[`÷ÎìÛ³›}—ìeç=ìØ»‡»v³gï%ìÙ»»÷²sï^vïİÇ®=f÷¾KØ¹wóÛw0»°•¹…-LÍÌ253K£İ¡Õ™¢3=Cgz†ÖÔ4­©i¦fg˜šejv–¹…-LÏÌ1;?ÏÌìÓs³tfgXØ²•…­[˜ßº…­[Ø³}+—lÛÂù9¶OM³mfÙv›™f‹N£A#‰˜n5è4\Z´“†İ\\F¤ÜZkò¼ªû@kò<çàÁôºİÒò„r“)ûÕÉØÉ“Û)1íèÚÍ¡šœÕÍèÒÄö>#]Á¸İ#ÅtœÁØ¯Î²Æ“ƒFNÔ0Î:j¯ğ“¼Ñm÷ç¸ÑİâI¥†1Á°A\rã÷_Í+Ş\\rÖ`-Ô+3¥B\\ä§zÊ	²ù¯À’›Å£©“\'\0¥—^úøVvîÜÉïşşï³c×.Ú¿ŸW|Ï÷œ6•Œ¹-;,óXò_ˆaY?`+Ó}€•¿Êı>„`VaÎÌ)¨aüà+¿Ÿ—½äÅ5’ã‘HİgtœDY(¶\\[ÓÆJüŒ±_X•êó»OdFëĞ?¯Hû¨ŸO¦GâhÅm·|†ÿõû€‚4›Å:HÓ”~¿Öb#Yk)Kçvã$ŒäW+ÚIÌtK¬J4ã˜$\n˜j7ˆ£ˆv{ŠF«I7Â0ŠD•#°&òŒìğW†Ğ–O‡·ì/J¡œŞ¢«Q¯ĞJSä¶ŞËîR•=\ncÄ®´1äEVZûHÓ”|8¤Èú½ËK+¤ÃŒ~š±²Şe˜å¬®÷XO‡aŒÑ«İGVVš‚ş`@ñuõäò{ÕS¯ãÇâ£ÙnTÛk›jóé/ªÜIÏHª6«_»¶}¦¬Z‹uÓZƒªˆ²1RWV»F&D>òÑògïy¯Mc<Æ«aP=—Ïqß?jØ`ƒÃiÅ„,ŸulF|ÇÃvÿqİ-&dy‚\'&dùTñÑœëŸùÌºóc†²ÃÓûµ_ã×õWëŞ§“,—›°ŸÊãÃœY~/}ñ‹¡lwù-6ÙyO9±¢‘BZ@eLÙ«ÊÆÑZtp±dÉ2–$ªòÛx_l8W÷Ò?EByçmÿÂGşú}YJHÆS¦ıAŸ ‘0I­~n#Nˆ\"Ùª:	cæÛm¦’˜v#¢İjÒLÄr’ÄÄIBÜh\'	AE!J„ˆİ™÷•MîÜÄÀöc„èY][ÛSÄŠDÈ„Di Ú®[4ªEOŞ”í#*(yQ¢-$WHs–¦²IÊ e}}õş€n·ÇÊÚ\Z«ı>Y^ u@oĞg©ÛãĞê*½4e˜evGFi°Âª¬DQH»=Í¾ößò\rÏ|f©OLmÂãwùŠ<Wa\\›–çµgdÄÏkkJ;bAù…ÃNØPÜô‘?NeªçrÃãyş‘åÍJ0Á‹ñ/¼	&¸¨ñœiF%Œî¼{Nğx^İgãé}ôĞ!Ò4}BG–e«|g£^Î&Œ%tIZªH¸OîJHŸ0T!„BZ)·½.ÉSI¡Ètµ:´C„ìıœdÙmR\'ÏÆÛØÂ†</h$Íò3hw¾u€És1¦Äâ…)\nL—D9‰\"¦\ZM¶ÏÎ²05ÅÂÌó³ÓÌÌL‹šÃô,­™i:3Ó´Ú-Z­­F‹$lA¡T€\nB‚(&Šbt g¥tD‘5¯ u`†(´\nˆÂe4Q ‹ú”’²‡AˆBÂ0-qAt´µ-O†„qDœÄDqƒ8nĞh¶iµgh´;LÏÎ1¿0ÇüÂ<[¶,°u~ÙN›$Œˆƒ@)«·\\Õ±XµPJÚÉV:ép(Dİªµ8’\\Í‰ªIŒk£ú9öË±“zpm/}Àš„S8)³,Š,oïô•ÉÛÉqá?Á²|Ã¾FëÎ\'Æc>Á“{xÍoœÏŞv7·Şv;ïûo?ÂnçµïuüöGoçÖ;îæÖ/|œß~İÑ¨ç!nøŞk«üs”_ñ…_¾ÏİÄÛ_U•o÷ëş€}înn½ãn>ûÑ?à5gA%÷lãßüëÍŞ;÷ñªïÿ~Â0àÓ7ß|Ú¤ÊO&8	OtDğg%êòá{DÒ\'.VÅÂ#¿…ÛrºJİª@Èg}G˜FÈ–GØìT‹ôD\"í+GŒ•R&ÅV°1y–‚)P¦B©¢0\"ÅúEœ$ÄQH³Ñd®=ÍÖéYæÛ-æ:Mæf¦˜šbjzš©é)ší&¤AÅÄqB¨CÄÖ…B#å\nİæ&€Â”»ÿ‰.°¸k”»Ï¹-Ÿ-V90†@WÖU¥ù2öN•-bÙ¢Z£tˆ\n\"Â0&Ğ1J‡„ØO‚@ÔD’A’%\r¦f¦˜Ÿa~zŠÙ©’(Ò&\n5Õ!êR “$e­]<øÀdi6\"g-ŒXAqíçæI®m\\¿r¼vu$ÚGÕÇl_„r‚U¹´IßT$Û°2©;Òq\nAF1îûÊ¹Å„,O0Á“ßıf~ôE{H H¸ôe?Ìë-1Üıï^Éów[»ÀÉÿ£oæÛG\"ŸgØ÷&~üE¡ï=ÌíôŒâÛæßVåk]Î‹ä–hïáõß÷Bv·Ä+ÙıB~ôg¾Ë‹y6Q\rYîïù°fï¾}¼ï\0K”_ñ=ßSò¸Q•Ï§§\"µºpáˆ”]è ±ÄÎùƒU)’WJx±V&„]Yòì$Ï¦$Í>|²<ä8·òÑöİŠ^¯G·+¦âœ4T)M4’˜(ˆì®{Í$¡GÌ5,4ÌvZÌNµ™ê4™²D¹ÓéĞH\Z4›MZ­QI~¬Ù9­…¸ºsG–‰ÇIMíæxz¹Z[\nìIÒ•‹tÔ+\\E[›Äa ‹å¾BtY:—­5a‘4Z$QBœ$´ÚM:ím»Ğ/B´]tê01ş¶ØZ†!ÆÀÑ£Gdëp¯İ„Ë©ß†õ¶õ¯\\>}?×_¤¯(«í3ê/“.ûd*igQÃ	Ü“çşí;Áœ}Ì&Œn“±•]/”³oİµuÄ‡$aË¨Ë9Â~ü·ßËÛÿığâö\0×ğü×¿•÷üÉy†%¸\0Goù+şĞVÃ–Vmg‹-{‹·/eW­ I«V§\re€‘°:5v.ğC¯~5œ¢ÌHù{İ8ıÕù‚g¯laíÈŠ7!§ÆúkgSÙØÏçğ”K(«ÖQXieIˆÜBÁš”ÑI—MM7Ü‘±’@ú[\'›‚0T¡\0SB˜ƒ@T1:&sí)¶´¦™OÚÌµ›Ì´f§;ÌÎÎÑn·KrÅ±¨S(ew»õß‚Æ LeøLòêH¬H—-£7[feıİ¯¶DœšTÖİF9ûÕu^\'¹÷êÃ‘\\\'eÈ›Éq#¡=Õ¡Ñİ›AH#¤´Héµ¯.…`mm•á`èIf¥ÔÛ¯­ğü]—GW5F·ÙX^åÁNßìÄÂ•]Òuæ\0ÅíÉ€	Y`‚\'#–Œ\Z,;ÂÁOÊÙ?ø»\0u97xÎ›øö]Ï‹_ÿfŞşGçÖ;şšßş÷¯äjŸà.~–?ıõ¿ò6âhoXsx˜\0àc¬tĞ«ÕÅÄ)‘ºz;x…¨>œK¼÷=ïáßÿÄOœv¢Œ_¾ºD¬^\\‘Dšçdé¢³ª4(È&F!4Xzè¤ÈArŸğ¢ÿ\nB %w_wOË=²V’\'ÆJñÂ’}#ë1%¾MGaĞH:Í&[ZmæÛm¦›ÌL·™Ÿ¡ÕjÑH\ZÄIŒ\nDš\ZZê…&PSŸ@6ì‘ccDÍ[h›%Ó‘%­\ZQ³P®lÖ‚F ­ê…RJ¡m<­¤ °¿tÔPIÕa²‚@i«(\"êŠÀª¡h\nEÒˆIâˆFÜ 7dÑ[QH\\[À—˜+H)ı~JÉ¯%°v0:y©ÚÎ¾¿ósäØ‘gWÎ«>`ŒUü©õƒ25»Z¹î±bB–\'˜àÉˆ¾…?ıÄÃb›6ğÀß½›?´Ö¿üwó÷X*=x˜›ÿô-|d$ò¹Á\r¯¼ŞÓKƒÕ/óçÿåµ¼ó$VÌ>òëÄÍlùz÷ó÷ïú}\0ğ0ø®¿ãkLfpà“üé¯È‹yp¢q¦ô“.Œë{=Ÿ}<´?ş¯|¼ãØ¼v8>¥º¹0Q\'8–Ù¶VÂ>½™•ÔŠİ\\å‘ca­)H’’¾ÜG	\Zg%Âƒ#`î¼.)uÄÊÁ¿ŞÇ1Cše•^¬M+BÚ&s­3Í&sÓM¦§;t:â8!Iâ$FQ†!AØ–Ô<²W;//Ô*¢X¹‰î­vDÔSU	kËì7c%Î’‘®Š›•²*…²úÑÊªy`Õ)”’Åo.QÑˆšQĞ#Ú&IY¢¬	tàIi%şp8`yyyDÂ­j–.œ›kK¿ürºóqî.-<Ûß®.Ö$¡¿ÈĞ`ŸV}ùbÇÄtÜYG­c ŸÙG¡îì9óSúİºë\\øØw#¯yİù¾?“]Ó‰è[ƒÅ‡¹ç‹â½¿ñ›|ä$DùìÀ>—VÚUÂ¾iù¸r`TŞÕÈàe­\" J;«KÇ»Ô.:Ì.l+I†Á­X«u,“‘[â8—’Wzn£ûWgæ”LÇ}?/}ñ·–dE2nË‚m{¹°Î•$¹(LigÙ2v‘›Ówv¤È\'†nW½q„K 6#].^a_ùÒ­|ìïcmm•4Šõ«Š$	8a¶Ñd6i0ÓŠètÚ¥>rÇ„aD”D„QLEÖZ…\"\n£²øÆJåRê t÷$£u8Õ©/!­Z%iöëHü<]oU™Œ“´\\ÿ«úÎT±îŒ!Ï3ÀnÚ’‹\ræ4“MXÒá^·ËÊÊ*Ç–VXYëòèÚ*‹İ«ƒ™57L‡ä¶­â0fvvıÚ×qÙ•WTj76_õ²Wmî=µk¿İıø.ŒR\nC^ÖF•ª?F•Ş`\'7}ô#\'7^õaİÆyLzƒç‡ÓŠ‰dy‚	&¸0°ÿ³¼ó—^Ë+^ğ\rÜxıÕ<óérÜø‚—ğoŞt¾åSÇf¯öŠ6	LId4q£éù\\<ˆÍŠØyîÆÖ‡;÷Q¿¾ Ä¬Nx4ZÖæ®ƒ#ÎN¸œf!.¶o DÙ¹¹ƒ…µ	¬K,=²)„©ºO’}â5|Z“¦²³Û$D)QRĞJ E7Wk’HÅ†,ŞCÑEC±V¨\0M`ÕlY¥`BPŒ±RZƒ)*ëY–Qä…øñ“ÃÚª¶ÒPy€(¥ñÆ³\0âÊçÚÃYÏP(Ñf)DMCJÙÅ~öŸKßÉƒ®µ’€„‘X±­\"í I,êF ¤EbrÏ\ZÊÖJAQ QSØ…v³»ÈÓoõ¶raüğòåa£®s•›X À}|[Ó¢§ì¾jR{ñcB–\'˜`‚	N+ªÑcdå°qÌñ]„<$\ro%ãE„¤Ñ‚T/ócW¿£1c:g	jä¶©<·úÆÊ~–°u2Z3Ft›•/µjJ¤¯üh-x”‘=é¨O”]6\\~™ÚŒ4k­ôûB0K5+ıF‰¥Äşr4\râ8®Ì¬š 	t(z¾%!•{(¹9…)Jı`ù=Z‘‹5…,xt¤ÙR]{^‘]ãëıú}¥\\\'ÕdŒd!ş¢úâÈ®¤i	e!ä[f·Q;³}F=ª@QÒHâ0¢‘$´š\r\ZqD¨‚¬m\\«¿œÄ1EQ°´¸(í`Û«*ƒ­+¿0¶<Ònb/Y$ÅâçÂjív†¬È·ÄQä™¨ò…S†FÔXLmr\'Ö0Fİ.fLÈò…†Ñçb‚	&¸`q‚AÆ#7–á`0„atÑI—ãF“0ŒFT/FË¿Nèy^Ã‘G4„¬8?Kd¨°èÚÊnjx¼À”:¾.¾#5¾jÜÇê˜Z‹\nu’å£Ê_uí“³¢°[59¦°»ŞYÂ®­4ÕÙ;Ã€8Nª²XÓhA |(ÇR¼<+ÉpEê°Rg	H^ÛxÃ±BSS1ÁË·Ó=vá(Õ0ìõénéNDê«”í§6­ÂmOî©:hké¢¬%ç8‰ÃH4âaRØ-Áe#!ùY:äğá#¢B(UY·pywğÛG~ŠÜÈbQ[6Ç˜QË.oejıÃ‘x¿=©×óãÂiHâLcB–Ï%.€2Áœ^l°ˆáb,;Qªºöa?#·ZS§g€: ”¢Õš’‹‹¶><‚T¯š\rõyÀ\'<®=u¹¨m$¤ßh¨ÔJg­Z`ÓòWéí:$|Ïš]³¤Gò1`ºÊö‰˜±’Ø,Ke¯i«\"!Ã¼ÈEb¬ˆ>¯eAifMt”µÒ£„ØeO=ÂİSò 9sÒ`‡ÂJ–ıü:ŒæßJï-)v÷Q¸:#y°ÕÖ‡ö\'\'V_\\¶ ‹U~ ín‚²ĞO[ËÊâ Éµé³ØWıåÂîà×í®’g\"v_üü¹ûøõæ&JJ)QU±~®}ÔİG¨ËÇÎõA7AğÛfC=K¨wÕ3Œ	Y¾`1®§Œs›`‚	.¸aG•çş_+ÓšVgºŒs!£Õ™FÙæ°OÁîv†ã3Ÿ¬‰­â\\jA95\0» ÏªiX®²ÖêözG”(Õ4FI [’F\\ûGG¢”°6”ÒdyQ² ³@^aI}arŒÊÈ³œ\"Ë„ ¢ĞFar!^ÆŠ,µÇ\nŒÉ…0Úß<O)\nIÇ˜ŠSä(SP²Ø°ğòf¬Ú\'“Î_Ò0ÎX=glÓJ<C.v£ıç@G˜BÙ­±=¢ly“e9E–“¨Â@.[|+O:-3e7Ã0%Fô“ƒ $°i+¥Éóœ4Måy7ˆé;o|÷ÛBÚ«\"Ğ®½+?Ïz‡×qêiŒ¦g¥Ë–$å¢[×wd¢â6t95Œ7ÎíüÄ„,O0Áœ-ÔÆ†’@çi	–N\ZS4Z4ÛV\"{¢Ù\"i´dàõ;RîñØàuáŒ¹Y•¤Ea[Ú¹–ËJ*Wö·$ƒ–x{pÊ¯´:QrÖœDÒ‘-Ÿ4ãIb•}aÈ\'~¥”İ\ZYò„!¹[xgD¢¦0di&ÙZPJQXÂ™§E–‘gyQ˜‚‚‚Üdä…È’à»…suÂgë¡$r^ı8Tu ®¦’]…İXÄ1jguCÒÌó\\ÔOLA[)p‘—;íõû}2kJ/M¥Œyh){„$qDÇy±ñ*İo;!!ÌFZYÚÅ’ı\ZAuuèàÎë’d·ˆÖãÎ{)•¶u%µiUeTU…FvY÷êöâÆ„,O0Áœ3ØÆo„}øTh$ˆ±ŸM›­ÎK˜›í)š­ÎˆÄ²ª¯ÜÊWÁğ]Ø´#˜r^©Tş²¬êBzÄªEÅğœZ†pÙJ¢*Õf‰jIŒ*’Uªe8É«%UEQŒì–çÜ‘].McÃaßÚo®$ÓÚ~%(lu*»\\–e%±3ÆPä™FŞù)eUJk–À#ªÕÓvG½îüs­­\Z`Œèä\n)­TSÀÚLVòK)Uu×İ+Ë2²,Ç˜\\Îóœt˜’¦)yS9EQ”¤9Ğbí\"pã„©V‹NÒ$´uç–p#»úa›yee­õ†hNTõ°ÒW\\]TuîÂ;7	)_Jx:ÎàôçGÏ‹²|1¡ş\\L0Áç•$oÜX2^ÏÖXöJù¦ºpÒecÍV‡öôì˜Añü„RŠöô,ÍVÇ’®Í¥Ê®D(ÏÆÕcéäÕÙ…E‘Šb£ÔO˜ŠÂä\'+LáH¯BY‹®ÌB`„D	•úé;ò”çVÂë™X«Â™2=İåb»‰ŒKß‘lcD\"šç’Y¥E£±j…ä¢z…M·‰GaŒHls[cõ‹Â*Š&ÂÖœ\rdŸü+­0JzUi‘Âö‘š\"V(¤2-Iv„Ş©È&0âol¡Õ4c\';½Ş:ı^Ÿ•åV»kt»]²,c½·Î`0©pa¤|¶m‚0 ÙlĞn6˜ŸnÓ\nCŒ5\';ÿ…V\n-Ïx†v’1ÚÔ$Ê#D¶ÖêmïÎ…„WäÙıº¶¯ˆ´ô±À·Gm6Yf°.ŒWÔ¦˜å	&˜`‚sˆjˆ«A)!>P†²Ã\n¬9§‚$i2=¿õ¼·’7$ŸIÒÒSäå‡ŞªjRå1Ø´¾. ød¬=`ÛäÊ\nÓeˆV9ÀÖ	Â:¬Ò­#8nÁ–ÈÙ3‘[‚ã‡qÒÃ’üZÉ¥O¨|%„Ë‹§5éiOB«DÔh¤ofYJšå¤©%yJÌÀYK–¦diJ>”\r;ò\\¤³…¢4…d”Té÷r/\'pv›õHÎ>7’%-ù²fÙÙÔ¨”Òd€İ´Z«Àê&k±]­fÃ,¥Ÿ¥¬ú,¯®Òí÷é\rú¬®vyôĞ!Ú¿Ÿƒ?Lwul˜“2²4Ç†,7²HO+\ZIÄT§ÍÖùi:qLd­c(D­[ï;vï,w„êkk\'×&\"	¯Èt$;×xÄX·ÊÍ‘débC&7¹}EO\\Òÿœ^l˜å	&˜`‚³‰\rc‹üLu^’ÏÛù›Ò£ú„®•¦3=Ëôìqr~‘æ8i2=»@gz­ìgz§KYZ\rÛDª\\_ç¶\"0®>/”åSRN²ii‹\r$$Ó`-.`õI­Õ¬İeQ¨J²Şb-g×#\\S÷wğ¥ĞÛ¶ï´&à„„9ÕgNN¬^€RnÓ‚\"ËB³”,KÉ³T\0æ9y&Æ`r±í+Q¦Ò_ª<û* 2Ñ¨È +{V¸\"Ã˜\0E\0F£D­À(aAH\"3†¼ÈÉŠŒÁ0§×OY¦ôúCºë}zİ«+«,;Î¡‡xôà£;rœÅÅeºk]úı>ƒş€Á`H–fåâEcd±_…LwÚÌ4„Z¡ôÆú\'—É’_¶ê¹¨H°ƒ¯V­‡z»:?×\'œ¿èlÆq*åµÕávÓÛ‹²<ÁLp¦p‚qÄW!Ø4˜“&„2Õ¯“ÇÊà+[ìQÌÔôs[vĞ%i´Ã¸ÔÙ<ÓPZ†1I£E{z–¹-;˜š#ˆbùÔì[_¨•g¤œŞ\0ïÃ¯§q*%NäwÀØÏóK-	*%vÆI-²?±Ø ŸÅ…8awï³^ãMµ`OîâİÍÖo%u®¾§;å³RÕ¦ív›0\nS	;BÌ$­”0Ö’KgäiÆp0$MS²,#M3ƒıõ>ë½ƒÁ€ŞzAšÒHÓœ,ÏÉ3§¶!’tc7DA9clÖb„•’\n®±¸‹ş²HKEjªl\Z(ùÍC0`˜e¤yÁ°P,®®sle•Å•.Ç/s|i™#GrààA¾vÿ×xä‘C¬¯÷S?Î9ğğ:Ì£‡sôè19Êòâ*ıõy.‹!Ã(\"\":ÍˆÈ¶K†%“„…ù…²©©^Ô‰3–èú™²İ*øı‚²İª~á·;°ïù­ú…ÔóøgõbƒºòÊ«Ïó×ÊÅ¯c¤ÙÇaœãFw(˜A¿[÷™`‚	Î:ì3:ú#p„däuà´O¿%I‘œYG?4Æ…+½íçjU½ä§ŠápÎêÂcÁFÅ	›†ñäLÆê5Ú]À*çêv.šq“€PI•})VI–½ìW÷ŞprÖ`€ jÔGğƒ¯ü~^úâo­²gU/iÆJOM!dÙ‘”óª~ÜDHÚA¤Ì2å%-&8Òä~]šN‚ì‡Å¶Ü>ÈŸıÑÿàø‘#²-³UiÈó],LM±oë¦›1­$¢ÄDaJ¡‚€ÀmH‚µ¤aõgÃ0\"3bQC‡!YÇ1I’ µH‰›I£TÁĞZhÙ:ŒU¿(\'Æ>;ŞD¿?–å²*\rÃtÈp˜1È2²ÌpôØq—XïXôÉÒ!8`¸Şc½»Fe»İò<Õ» /BÒ,%ËsfÛSìÚ¹“ötƒ!Ërı!.çË>Ìâ`\0Úê\nqÜä\r?öãì»ò\n!ıÖr‰qæÜÜFû¼œ¨\rËrz¨ÇÓ^½A`7I=oyù_\Z¤ŸŞôÑğî÷¾w$İ:\"\'©®İß:üøîœê	pÒĞOÁÂÂ–ÿ£î8Á™„÷f?É%Şµ@åå˜È¶çYZ÷™`‚	Î	œÉ¯Úë»•çåTÉ¢¾’0»4%†r4É#BBÂÅ\Z–ˆÉûIßVV4æğQ÷³ñJ	¨Ü‹’ÓÚ­‡‘¿\"ÂòëréÂºÛ(T+Œ#Êqâ4Î$tÖFpİµ×réS.-É¢4’#BVJ‹èÖ–E´ª®ı•ér§š0ú©ŞD	ïâVœO‚„m$Ë.Œ²ªi¿Ï—¿t;ë½´¹cœ™4ÅÖéæÚMâ0 @$¾yaH‹‚¬(Èò‚Á ¥Ûí2I‡)Y*zÎƒá€non·Ko½/˜¨€õõ>ıaJ0 ?Ğ¬i5©«#ê®n´F\níÈš-‡H¨Ew8L¤)ƒÁõş€Ã‡rèĞQ:ÌCòÀƒûyôğQ–––9vüÇ—yôØa–VWXY[%M3¢8BßlF	(Å0Ë‡,­-³>è³> ´Z-QY‘İHP(Ò,cm½ÏÊú:Y‘ƒ•šw:SÜøÜçÑši_<U×Æ<ûp}Á‡ßGêm^µµ#Ó£ñ|Ü{ß}Üqç#nucˆû…†	Y>ëğ:Ú	_ôÎ»¨zsº#/&dy‚	Î#lB–}Œ¼üÀy©¸ã	óhxKªpÒic?×—«sãÜÇ¶àa!PÊ˜*o¦ÊÕ‰‰r¥~!E\Z•[—dÚs-s8&«çNJ–¯¹†+.»¼¬j! öÜª/T¤W\\IUå¹CEš”%Ãeš¦úäî7«/ôÉÕ8’ì~U¹]´ì\n(Ãı_çøâñKEÓH¶MO3İŒ	FÔÃ”ÁpH0¤ß°¶¶Æ`0$ÏriJ·? ·Ö%I³!‹Ç±¸´ÌÑ£Ç8zìKËË¬õº¬¬¬ÒíuYï÷É­9º,Ë	±ïœæ9…#V2Šgİ!MS²¼`µ×¥·¾Îz¿O··ÎñãK,;Î£‡Ñ8xèK+K¬zô†ëô³u†yJ¬õºPZÍ&[çèt:4›-š­­f“¹¹9\Z­V›é©iĞiuˆ£F£A£‘P˜‚<‹\"½Ş:‹½äMDÌÏoáÙß|#I«Y.´“†”vñI°Onı¶ÆÁµ¿âj’Òÿ(ûJe¤O\0Üwßı²<Á™€ßë|÷°]rœãFwÜC4!ËLpşÀ>§£?İ¼çºº®B«’$Ës^¾l8V5Âú”£›“B\ZÑé4¦´,Pıİx¿Íá“×ÊM¹ÏşÊRÚêG”%Öµ#?QCÌ}—Í¤Êe˜ÑÏ:NJ–¯½†Ë/¿¼4}&evDFI!<†R„øã«ÒŒJ}¥3øıÀâŠ$û¤É\'O¾ŸïïˆU†Ê°|ü?´_šÓŠ\"‰h³ÁÖÙiÚ­Ò4c­·Î±Å%zƒi–ÓíõE¢œ¬§)kë=.-±ÒëÑí÷éöú³œµŞ:‹+Ë=~œGæØñã¬,/³¼´Do­K¯×#·v{ëë,//±¾ŞGš(IÑ6R †©H¦»ë=–/²ººJ:²ººÊ‘ÃGX\\\\\"ËrÖºkY:Æjo•şpÀ <úäENhZÍ³S3t:Slİ¶™¹9¦g¦™š™¡35EgjŠ©©)Úí³³3ÄaT6mQ¢/mŸŞÕµ‹İÃ<“–4Û¶ïà™ßtA{í-pmî·K½½Æ…õIq½m±:Ïå3[{ı4\\ü{ïŸH–\'8#ğ:òÆ>=ûº\Zç¸Ñy0!ËLpá4H—‘ç»¼*“ô	³Ú„0{á¬¤YYrêç:Ô	ygEÎ´—K°ŠujD¹*ß¨»\"æ~šenÇgÛbóœŸ\rœœ,_Ëe—>m¥èÆÕe)1¶õ¨¬$Y6Ğ³õS™ó5_…k»º’\Z;wŸ(ùaFÃ»Ïï67TÙÅÕJ¡LÆ—ïº‹\"—Í7$—†V#fÛìI‚Q†99Æ‘ÅEÖ‡ëÃ”õõ>Ã4ee¬v×XYë÷8¾ºÂñÕU–{]–ºk_^äèò\"Cı,c=2HÜa:d°ŞÇƒÁ€ÕÕUı>aÆ1a¡œee+U^<~œÃ¦Û]cØSÖVWYYYe8LYíu9¾ºÌrw•AÚ§?XgEN’ÄÌ/Ì³}ëvvnÙÊÖmÛ˜™)u«E-#!‰c¢8&Ù²Ú¶³QŠ ­$</+«=­uš\\Ú17<å²+¸îÏ Œb¯+ë·ß¦r>Ú–£ïƒŠ`»v÷ÛÚ?÷ãùi¹óû&jœøo-ß}#ì£1Îq£;ÕqB–\'˜à|‚}VG6ºyÏöècî½	”Gˆ7æ*®òèâè Y‘f9µá-yVr‹2¹ÒÍZñ¯dÜÍ*‚Z¶e^¼Ù°.Š¯§ì¥0\ZÜâB*s*dùºk¹ô’KËë šR–<W­haë§jËÊÏm|5\nïKDü¸puå&¶îïÜ±~¬w×¸ó/ÑïÀ2˜nuØ>;C¨²¼ ×p|y‘¥Õe†Ù4KÃlÈ KÉ)XëuYî­1°„x˜g¬òŒB)òLLÉ¥yÆ Ké§C²¢`˜§ôú\"¥î÷Ö1…˜¡Â¸‘Å²0°0Pb/ùø±c?|„ÕÕUz½Ã,ÃX^]eiu…£ËÇY^_£09(h4ÌNÏ°sëvlÛÎŞ»Ù2·Àl{Š ”‰KjmGÓŒápÈp(ªy£t€Öš(ŠĞa@FäåšEš¦¬¬õXê¯“å9aÇ1W<õ\Z®ºîºšnz×†£“œÑ6wpn.¼³pâÚ½ì;^Û»¶®Ò\Z}ğ”RÜû$QÃ¸ğK0ÁLp^ã±2¸ú*p¹r)ÄRY2Yúxl±Ö,éuÒ#ço¿ãÛS«Ë,ëË,6ß_tŸí=]Z.\'NªeïïR+3(…p?›å‘³ê\Z6Œ×cPÂ¬}b»é†•È»z)ÛËJ›ñ›Ø#¬£¤ÆØªtõ¿‘ØŒ»vmæÈ“ïæ.w]í\'\r\ZIƒ,—ÍGDµ@ÌŸU„_‘¥A2Õé073ÃÖ-[Ø»g7»÷ìfÏî],ÌÏ3ÕéĞ™š¦ÙlÆ1ƒ4#Ã.ÌyNwĞg}0¤;°º¾.’çµ–V–e½õuzı>k½l5ådiNaEam&g™İ¬Š¼ Ï2V——yèá‡Øğa.\'ŒB®Øw	×]~%ÏºúZ¾éº§óìëÎ³®{\Z×_}\r{¶le¾3E«Ù ¢jgB»Åw%DQdÛFËVÖ…0$ŒcdÓ•¼°u¬d	/®Şóœ8ŒØ±cGYÿuhkC\ZÛ6–¶õm%;¸0.|gTúìŸ»xBªGûU¯½è1‘,Ÿux/¬“¼ôíëpœãFw(G§‰dy‚	Î7øÒßÚÓk/TÍ£”\rÖy	ç$ÌîÜã…W€²‹ÂÆ‘­ñX£Çæ¢O¨ÜıÜß:I®N+å±D¹tğÒv§µ¬o³s‡“I–Ÿvİµ\\~ée•ƒkJ×Æ!{J{Ë¾«5ç“éâ8¸4tMR©•55è®7Ù\rÎww„êş{¿ÊñcG1…è,ÇqÂ¶…9fZ­’(öú}Â djjŠ™é)æ¦gØ2¿ÀmÛØ¹kOyÊS¸üÊ+¸tÏ^öíŞÃùy¶ÎÏ±ev-Lµ:V\ZjˆâP‡¢[[d–\0k­	u\0Æ •bvn©™‚0­ÉsÙÅ0/ëë=zkk,¯,“4\ZÄÖšÅÂü{wïbç¶íÌ¶Ût’(\"\nB”\"KôûyÎp°Nš¦éA·ËúÚ\Zk««û}ò,»â¹!Ï\n‘>ƒVš,Ë1Ãtˆ2ç9İî:Ç–WXìõ0EAÅìŞµ›oùW/&iµGÚİ\'·îÙóÛÃ?wğÛÏ¥áû98w_ÊìÃ¿¯#ã5Œ	Î¼7Rí¥_‡}MsÜè²<Áç5N »ì»¼\"ê¼·‚%ÉJ¨”—|=1ÎÓÀ¨s)À<ü–òåëÇÙ´»x¤×X\'!ï6Â	ˆ²ï³Q»Áy€“‘åë®½–Ë/»á¬¢Öâ\ZF)ÙtC¤Ÿ¶vU©Ì\\BY	\"Şæ#uòä¢[ù´¹k»æŠŒ×Óvq\rppÿƒzä Ã4EÍF‹­st’Ún]$a~aİ»w³wß>¶lÛF£İ¦PŠaËF vƒ„$qÂìÌ³[ffÙ³u{¶²kv]ssìœŸcËÌ3íišIB§İ¦İlÒn6É³Œf«I«Õ\"ŒcŒQ¦ (A2è÷X[Y¡(\n¦¦¦hµZLOMÑiwHâ˜0m§‡Ã”<Ï(²œ¼ÈÉ³ŒAŞÚ*y“\r‡¢Âdl%ù`È Û£¦˜,“1Xï1è˜ßº…(‰¸ç{Xîõ˜™Ÿgm}G§;è£´[m÷üçsÙÕW£‚Pº†5wçÚÚµ©îÚÅ÷óQ¿iK(ûmíÿÖÏq¦ãîšå	N;6¾ ÆÁëš#îÕå˜È¶OÈòœ°ÏìèÏ¨ò»®G	\'DjS)³÷ã¥d‰³]<ö)¦*QÂ%iØ”Ê=W_š¬NQ®İæ¼ÁIÉò5bg¹‚U§°ç£’½ªKr­Dz,õ/‹ïtÙl?¨‘bÿºN‚ÆÿV¿ê’FãÔ6;r˜¯İw/`Pâ(fûü­(F[]ã0Ø±{7[¶oÃ X[ë±tì8ËÇY_^e}e•îò*ËKK¬./³¶²Êz·K¿Û“xƒai\".4qÑH¦Úm¦Û-¦Ú-Ú‘(ŒaË–-¬÷ûQÈÊjåÕU8È#>Êââ\"ÃtÈÒñã4šMâ8¶»ŞIÙ\nK‚××º¢§j`8rìØq=ü(Gİæ•«ó¼Î ÍXëvÉóÌnæ‘‘†¤é\"ËôûäƒË«]ù¯^Äô¶íüã\'>ÉÒZ=W^G75¬­®°eËâ¤ÁS¯¾Šg|ã³™š›åØ#ğõÛ¿Ä± wü8íé)‚X7^»ú\Z¬İå:aVŞBMïDpı¡¿/I²<şîç²|Öá5ÿ	zBåUT^‰<!ËLpãäêÎaSÂŒ¸IR–²ŒŞ¦×]xäÙ–Ç=jIŒH+Ç‘!ÉŒJ“-Ùª°9Qf|‘aô®›ºœ+œŒ,_{­¨aø’_Ñ°-hÛSÔ%†­Äü™òÈ´3=§­i4Ÿ;Âë«oø’H_zX\'Õ.:ÉöıÒá€¿vÃÁ\0cm,o_˜§ÅcÈóŒ¤Ñ i$,=N¿Û#]­÷Y_ë²¶²Êââq?ÎâÊ2++Ët»]†iFwmÕÕU±¯¼¼B¿¿.;ù0yFˆêE¤â $TŠápÈá£GXZ]áØÑãÜvÛí|õŞ{yäà!=Æñ£ÇYïÙtMYÓrFtÓaJ¿¿N‹¹¶^¯G”$¬u»¬­÷Xê®qty‰Ù™Y”V$­6Ûvìfee…#Çe­»F ´L‹‚\"/dÑa–Ä1¦Ùä‘ƒòğƒ‘†aÈáÃÒí®°Ş[\'Iâ˜§?ãé}è\0~áVÔêô×ÈV—¦¶mõ«£>¾ı*]ow¥äK…Û	Òµe]:]ïOÎÏxjg’,ŸO˜å³ï_{ùûğ^I#î›PD²<Áç+ìs;úSÁwßğè×ßµ·„eµ˜:Ò<&ä†´ck¨Ò‘K Û“’l	áh\n£+×ê¾\'’*—88r‰“‘å§]{—]v©-—#$ÖÓ[BS…İÎ~(­(´­˜:©©®=R>æ×Gİotb#ùqşaÒl¶h$épÀz·‹Öó3Ó–Ğæ‡C¦ggé­¯‘õÖÉC²Á^·ÇÑãGY\\Yd}Ø·Ö1Rò¢ Ë\rGc}ĞçĞñc<²x¥ëı>I£L²\nıu”]tj¬õŠ¥•–×VX˜áÆg#Ï|æ3¸êª+xúÓ®åª«®`fªÍ‡ğõ÷³°°¥Š_(Ia†EğÔgİÀŞox&<üq°:Ò5†k®¹†Á`ÎìvöÜÅ®K® \nÖ»+,¯g¸.–9L‹\n†öÌ,Ë+k{èafÚ-æg¦‰4âcÇ°´´ÈÌÔó­6İ#‡é>L3€0s&+(LÁÌÎ]è8);ÿfmV\'ÊøVMFú\Zy\\xGë}À¿Ï½÷İÇwİ5â_Ç„,Oğ8àuĞï©•W-Py9&²íÀ²<Áç3N ]ö”w^y‹X{[XbZUçã§ë»ƒï¼)õ×‘¹¯Ÿ—±$Ùû‘ÓS\'Ê³´Ñå\\âddùºk¯á²K/Õ‰²€VOÙ˜rëkñ©*BJéµGf¤ª7’!ËBÀ}I¡×ØşüOõ¾ôÛ¯ápHËF Q°wïò”KX^^Aë8NøÚ×¾ÎK/c÷e—qäÈ1Ö/QÖI‡)ƒşŞz—îÚ*™IYï÷èõ×I:3\\ñ´gĞè´YZ<ÆÌì&Œé¦Ï¸ş1Ùë®6W>ızÖ–É‡ë:ÀXÏUù`ªÙäº«¯fÛİLÏÍ0=3C³•$1Jƒ*\n¶ÎÍÓl5É‹ŒÀÃ(ŠÀš)v_}3—^qÂâ£xtÿƒ]^d=Mé­,¡Ø¾ç\nö^õ4â©iÚÍ\r‘*XY[a 	C™ì4;S$ÍífÄT»I#i5´[-”1¬÷ûLMµ¹l÷š¢Eh¥Ñ(Hº+«,-.±í²ËH¦¦FÚK^ñ±»®úHÕîÔÚÙ…w×NrìÔ9|¸~\0pßı÷O$Ëœ	xoş1ƒ€CåUT^‰<!ËLpÀ>»\'zxA”wí\\7¾FS8–4#ÎFÉ±œ¸¼*GÇ’d	»ñÇ#wÖ¦³\\”Î%FÒÛ˜øy“’åë®ãòË.³’?WH…)ªkÇw•ÒU?q¯*Ç\'´>9?€J‚íÇñº__Î—ãşÛïä‘û¾Êñ‰ã˜ÆT‡V«Å¥—]ÎôÌ,Ë««Ü}ïW¹)øú0\\ï£LA–edYJ¯×eXé­’™œm;öråu×³÷ÊëĞAÌ‘G¢Ûë²¸²*æãf§Û\\ûÏeÇeWÒi7Éº]úİ.Q!Yš‘v‹\"/˜™ejn–8n†1Fî­.¯pôÑG9z|‘8h5›$a[vìF5g0AHÅ$qDwñ(†-ÓÓ´\rf¦æ¸æ™70µuİÕUVf°¶H>X§Ç´“­fƒ(’ÍQ\Zí¹Y09J)L‘£İ/J±º¶F‘ì˜_`ªÕ\"\nCŒ1di†¦¬/­@aØuõU„)\nC9IpmäÎ¥om´ â‡©÷wïÂÕDG²î½\"YàŒÀët£ıoŞ+jÄı„£ˆí¼²<Áç;ìó{¢×AİoÃ« `ä¤„ÄİHœİa‡Ùz´`4¾Â°îK©³c{:\Z²”&3>Kã‰òø»Kœ”,{:ËBj-™ğ%€¶ql•Úê•J©HLUvŸğ\0\"™VF[İTW©0mLo\\:NJ	é0åá¯ŞÍÚƒ_#_]¤¿xŒåƒ‡öd¦àÎ/}™[?ÿ/=ò(Öôº«¤İ×<õ\n²õ>Eš1è÷×éõ{ô]‚8fÇ®]ÌÎnenûnZÓ3DADe‘a¿K»‘°Ğn1Ói°uëråµ¤YAŞëæCÖ{]b­ˆÂ€‚‚ÅåE\n£YïuÙ²e3s$q\\6cÈ²”îò2Ça¹Ûgeu•ùù9Z­&J)‚0bm¥Ke™aw~·‹VšHD¦Zægç¸ä²+HZV/sìá‡X?z˜ÁÚ2yšÒi4™î´i6Û4›-¢8¡0ƒ!iÈ|Öh­(¬Y¹ÅåeL‘±cÛV:qƒ@ië}Š,#TCÒj²ãê«Ñíö†ç¯mıs×Öş¹Î[Æê$W¤zcŸp}wB–\'8CğF€1ƒCåUT^‰<!ËLpÁ>Ã\'z%ÔıÆqÚü¢rñ‰m)Qd‰{8\"U?NFÇÖjÿrcÖ/¢Ì)’å+.½ƒ3Í”ºËRxGt±Ö/Ä±üƒ*U$ªëQ\"TOSÂ9i£R¢~áâÖ«ô+ë}ğAò•ETfĞFaÒK‡ğàW¾ÂC|¥Å£,LuØ:3Í–©¦šmvìÜÉÊñãbNÍnŞ¡µ\"IbšIØ Šòv7Àf‘ ™j¶™iO±03ÇÖùmÃ”åƒY?~˜şÚ*º¬+8ôèa–ÖÖ˜™Ò¹}íé¢8&#R/ÙpH¿ßgme•Ş`ÈCAQ°w×.Â0¥‚­ a8¤·¼L\réLM1=5M»3FÓ[Z!ï®¢³!I¨Iâv«A³Õ¤ÑlÑj·hOuˆ›M–––ĞJ15=%Û	Z˜¼`8Léú˜Â°gûvb Œ\"N,ÑÏrŠlHcz†-W]MÇ#êe_±“ ¿\rëí[GÕwF¥ÕØ´”gMÃı>YÔ0.üL0Á\\°ƒÜYCÅsDE¡Æ\Zå_yYÕ‰ºú¼Zˆî¨àq‡\r[Occ¾í½GòãNGó5R&¯¬>FÒ//6ŞõB‚«5!%F\nn	JÙ6v\"#á)§FÀ¸Åv•ØO»\n¯í6ÇoÔúÁ¸ğ£0ô»+ôaØ[£0¹B‘†ØäEJ3Ù³mó)ÙØ£™ˆ45Ih&\ršIƒ©ÖÓS3ÌNÏÓivˆtH\0dİ5VàØC’®¯³eë6vlßÉÎ»™%C‚|H;Ò4“ˆV»ÃÔô4I£I0àkdy˜3È¡·„Š‘>+PDaD\'ÄIÄÂ–yâ¤A¡4A(M a Iâˆ(Ğ$bªÙ¤İlÓnwh·Z\"=n7h5B¦;\r:í33St¦Åvs«Ó¦ÑiÓš¦ÕnGQÒh4D²¬q‡¡,4´öœÑšF»I’$A@ 5&/hNMÅb–ÏIqD×ZÀÀë®Ü.l½Çµ¿©IŸı¸ûÆ…ı*&dy‚	&˜àœÁ4Şx³éĞãQ£„„zÕH«qGy26õ*Ø\\?Æ¦ÀhúÆ#É#¾cŸLšL=Fy1>„Œx8wdq•ÓUF(”GøÄÍ¥á5KÆ.Ú«¤€²[œR•qäÈ¥3$¦ ¿x”Áê*Ùú:E:$ËR0¹¨(hMäyJGDQH†ZÓh$4›1N›é©sÓÓL·;ÌLM173Ãt§ÃT#a~ªÃT’h6(ÆĞˆb¥(²”,H~ƒ\0T€Ö!Qœ°wï^víØ‰VĞl4ˆ£XKz=Œ<)q#azn–$Ùµs;ûöí•JÔAœĞhµi4[ÄqÑl6˜êt˜nO3Õ¦ÓìĞî´™¢3Ó\"n„ÄÍˆ0h6›ÄIBÅDa„ÒŠF+a~n$Šh„²Ev 5²ÒaQš~¿oUdD¥@+E 4Óóa´¡ÍŒ1v×\\ÿpçõğî×ïCÆ³ áàÇÃrå&!e¨‹²<ÁLpNa‡›\Z¹Wm”2c)é‰ˆsıbÜ1õ0µcLt¹t9M÷T¤ÉÔc•£i]0–¤PØÉŒ8…ÔW^HÉv3Ê#Ààˆ\\W$fTâìœKâkdCgO¸N¤ªt«´iÒ*ÍE‚€Pkòõ>:¢òm2‘2Ch­(h¥Ğèåfƒ!aĞî4™jÓn7è´›´\Z	ÓíI)Mj\"­h6bÚˆV#¢Õ”İùšÍQ P&GÙ„%\n„(aDœ4Ø½}SÓDÚĞl5¤J& &Ï¡0(cˆâˆ ŠhwÚ´Û-L\Z…‚ ¤ÙlE1qÒ ‘4H’F³úc\Z„¤\'!‰]\0Øˆd³”0£X$ÀAˆR*ˆh¶Z´ÛòÂØID€ÖÊZÌˆÃHê>0F‘gyVP¥CŒ1´¦§É%TùÁ§|\'Ôô•ÇıÖ¿>ÔãÕİê~ÆÈ„L%núè^t˜å	&˜àI‰]W¿ü×ólµ×ÿÀwñ“—Ë@õ˜1{\rÿéG^Ê«fëy.³Wóó?üÍ¼¨rªpRÒŒGUktÕ]lzX	œ0:{ÔÃÔ‘Ë\rw,ñXHòHìòbcš$”•ÖY}d!2Vâk*OcdW<)µ#G¾”o£d’ÙX$)QÁğI°Ÿ—¦“TEÒš0N˜ê0•$4Ğ„…%¬ˆâ@‰¤4tu-ëh’(&Z­N‡8iĞéth5[tÚ-ZILEDa@…DQHG$qHj¢  ‰9’˜ Ñ: ‚0\"\n#‚ @“jˆ£Öb„“²C„(Q“$	Ó)(rt v£µÒ˜T Ña€â$!¶á˜¤Ù Ùé4ZÄI“8D]\"ŠĞ: Œ\"âf‚\n‚8$ˆt !PI„P ÃbN)™D!Ù`€¶$5KLšÓÓ4gg)´í&\\£%¶uß$y³sw]\'Ì¾»¸m¼ÇÅˆ	Y`‚	&8%$¼üÛ¾‡·Ü¸v^Ï[~øy¼¬Úuö4À:µ±ç„CÑÒ¼q®hì‰è¬‡xº¸SÛ©¯W?ŸÿóûÎµõ€R(6ø\\°PTDGJe?k[iRCÙÚcTdg”ìVäÅ‹ï‘wîÈO]_Ù…‡¼;Æq#¡ÕicòUä„b˜8ŠÃ€^¯F¤Úî~J)²ác\nQËˆ\"Â(\"Iš„QB7H!ÀÍFL³™D	8!cÂ0&Il»`l¥·Aˆ>¯Õ?N’F©²ÄAŠíjdÎ§¬Êƒ”= i¶Ù²us33t×º:\0»S\"J¡´&CĞ\nh9wj2A@†QB‰n±H’5JiÂ(BJ¤Ã”(‰MÑ‹\"×ìs¬ì®0èv×ÈÒc‰AĞÚ¶ÓiQ(ÀØ/ÈËa±•òWêTÎ½p3	¿¸p~Ÿqé¸s©Ï‘$.ZLÈòLğ¤ÄÁ»ÿ™ÿø—·ñó(ø—â·ï?¬ÈØ‘ÇÈ`è»pLRöp—\'$Î’êãùw²½-#hîäıoã—^õrŞöÃ/çm?üü×ï¸‘ïß™ v%6¿×…ã[¸p‚|¡·^%Ue®²‹g\0U~Ç#IBf°¤{I¬ÂmŸÏ‚†Ö3[·¡ƒSP\nC€¢hÚF™{­ª(Ğ@¦Vª ‚EQ@\"•mˆåˆ¤Õ¦Ñh7¢$¡Ñl’4å:i5ä·Ù JÄn±4AY¾Ö]#	c:íe4Ê;9ĞZô·) #Â  Š¶mßÆ°ßçĞÁƒ(mĞ¡ÔŸ•ıÛ¸\Z­tˆ]g+ñ\r‚0ŒÑaDÇht£ƒˆ¼P£éöÖ9v|‘0NP:À(k.Nk‚PÂAH7hF1F›ÄZãÀnV£›\r¶<åRT³i?üQ/1¢¾ãàÈ¬OG	®uŸš\n‹ëÂø×>\\Ú…ıà´ùC}qab:î¬ÃÑ|÷QT^µ@åå˜È¶ƒOLÇM0ÁcÁ¯zù·ó‚Á=|a©îç#çûïáîÁÚ!şñ‡¸?\Z[ù–§N³xï×¸«_óĞØÊ·<µÁÃw<Ìƒ5¯1O¿@yÇ§ÒkÓ;”ŒÙcêŠù©§¦Üùp—ş˜ü¬ÛÏ?Ü}˜#öÚ\0dƒeî¼í.şéîû¹å+³?ßÂ7^ÏóÂGøì¡£vÎoœÔtÜ5×pÅå—Qª¶õ°#¸iQJâª0Ö.³\\9	/ª‚*M±™;J¬éu“t¹Rª¢ï#fÚÒ«ˆI5­0ÆyQĞ	[Mfff„\\—$Uë5“˜(NPJ$²ZèP˜iŠ$8#´ÖÄI‚´¨F(EÙ©“Íw†€a˜¦<òÈ#äùN§ÃT³M’4‰RºëÒr¥IÓ”ÜÖ@$Ô}íA<„Öš(\nÑ¡\"Ï30†PK©«ÊÎpa¬E\ncH‡)Y–1LSÒ,£?°´²ŠRŠÙÙ9¦§gĞµHb„°ºó<Ï%îú:3í)’P&\0JK¾ƒV“…+®¤Hš¨@¤ß^ë•W~»º6Eu½ÑOà·¿ƒK×¹¹ëû¾vÿÄÎòg^çßOa´;¸W—c\"OÈòœÂæv~àEßÂİx/{Æ¥ìH`ù¡Q²|Õõ/å§oHxø£ó#?åF~ùS•û&dyßå×óÿûWÏæ»¿ñ\Z^rå¶?Ä]]ŸòE<ûé7ğÃ/¼ïzæ5¼øWsCp›\rÅ»±…oyjƒ_²dYAcz¯¸ñY¼êÆgğÒo¸Š—\\µ—gNt/ñhf“MxÅóoä‡û^úô+¸avÀ×^fÅ9ôD½ğå¼zÎË³‚\"\ryú³ÅK¶­qÛ×WÙ0¸ä›yÛ¦ØÿU¿^,w92ÌYMsVÓ!‡=ÌgMxá{‰ï±‡dßÿ-7òÃÏ}/{ú•|óì€¯?´Ì²ä\\âddùiv?©EÀJ0)-\rÈg|ƒeÍFÂÈ¥·ğ®fgy„>ÕH„«¤ËNÙÀºTÑ?Y…19Q é=Ä`i†»aE–et‡C\n­iw:„A€²Ri­5…µşĞh4P:\0CiÙ[ë@Â\"¹Õ¡\\‡V]írç[È¢Ãå¥Eî¹ëNL–²}ûV¢(&\"tÒh¶	ã(Š%¯Š<\'/\nÕÄ Nfçç1?zŒƒäè‘#=r”Ã‡sôèq;Æâñã=|„å¥%VV–YZ\\fmm¥åe–WVév{¤YN\'„QÌôô³só$&X©®RŠ\"Ï1v1§ÁçÃtH¿Ûe¶3MlI~Ëcf×nšÛ·S!¢É.pó5†Wm/²²A©ÀŸHUnŞÃƒë{÷İÿä Ë~	&˜`‚	âü»ïº‘«†_á½ïÿ0¿ô®à¶Õz \'ˆ-ÏàµÏeÿçş·½÷ƒüù	×¿øy¼\\L­pÕõßÂ÷_ñĞ§?Éoşùßğ±~ühÇõü§ï¼ËóøŸù[~ù/>Âoÿãİßö^uÃ>â¥Ï}×q?ş¾ñ–¿¹ƒÅ×óú·‰½ÙÍMğÂ¾œŸ¿~ª¼~êõ/áÿ|Ñî2¼hÈÖänú‹»Åk¯Ø¸hrT\"foáU/ş_xÛ|oû¡oãM×/0dGà«k[¸ö?ˆ—=OÊøŞÿùA~É–ñß=g»UÙ8ÿa,ÉÉ‹ÂVŸ_#Ô×TÙ÷Ç#²ì9’í`¬é¸Š‹{aí,»ø4×‰–ƒ¢Š¬‚\0İn³óª«ˆ;-ÂPˆpçVåBkMF„aˆ²Ä>Š\"â8beunot8Ä(KÔ•\"…\0æÎÆ°•ÔfY†É²aJ:LY[[cmuãGòµ¯ŞË—¾øE¾öÕ{Øµ}—]vIÔ$F!yËæ\"vBàDönw:WA\'	S³3\\råå\\ÿMÏæ™ßüM<ı™×sÕ5WqÙe—²cÇV¦ZMB¥ˆÃ€$ŠH‚év›-ósìÜ¾ƒKöíã’}—°gÏ^æçç™››£İn[S€Õ&/…e\'¥_ ~AÑjµìÃ¶MÑÚº@¢eÄZŠ#¿~Óm$Ç•gu.aü	ÒfäØÁ¥•çÖGÙGOïbÁ„,O0ÁO*ìºâ*öeğ?ÿéëÜÕK7J>O.ßµ…æòÃüó«yÁm·ŞÆ=ı.ßeIŸÚÃ·^ÛâşOÿ3~`•ÃN*¼),¯²¢|í¹}yÀj–rğØáØá#–„ná²9ïİÏ—ıŞ~Ş}ÛQ¢Û¹®¤GvkÇ82|*ÈÖäO>”m×?o¶‚Ñ±$Ù\0Æ’ßp?üàßów¬2İ³ùÎ-\0«^f»áEÚÂå;r~õëÜ5(èw¿ÎŸİv”pÇvæ…:¯a+B‹]3Ë\r…\09bOüÔH\rÖÄœcg3ÙI+©´„¯Ú°°dÇIzåş•³ƒ©-,Œ´¿äHS¨€Ö®}$»v“éŒA\nˆ\"Q¡Ğµm-JDQD£Õbnër«kk>|˜‡~ˆ‡<Äƒ_G9ÀÁ9xğ _»ÿkÜyÇÜú/ÿÂm·~‘¯~å+Ü{Ï=xè!%K‡,l]àÚg\\Ë7Üğ,¶îÚNÇ$&¬Z‹L:ò<}v·DéÆR>ÙnZêÂ\0Jk’fLÜŒ™›ŸejzŠ¹-lİ±m»v°÷)—pÙ•WrÉe—²û’½lß³‹¹­´:S´§ÚÄIB£•Ğl&4\ZbA#CYøg\'.®n´UÔ1D/Y)EgjŠ¤Ñ B¢@¬s„IDĞhˆiÛ¨(—i*!Ñ®½ı6ô	³`”pK]Éb½zûû¿ÎN7ÎBŠ—âÅ	Y`‚	T¸d¶‹Ç9ñ‡Ã\'†P[IV‰”õÌ#}3SÌ©«İÑP\'|z÷ñ©B®{æ>æÑ=Ür×Ïãöû6˜¤òÉéJšC³%q6ÁÔåÏåmß}5O­{È0ú˜®İ}ß?÷é\\·kÄ»dâÕâ¿m\\¶³Ï×şå.>³²Êmw}/KØ»«’hŞAÊècõÊx^Á’Ïêº•Ô!¤¹°;q++jE¹aˆ¿[›|Òw)Ïó’è(K¶}2T—*+§§l¯]:.\\QhL³ÍÎkN<;Q…RPä˜¬ Ïr²\"Ci‘‹-aQ©hµÛÌÎÏ³eçv]²=—ìcï¾}lÛ¾™Ùæ·Ì3;7Ë¶íÛ¸ô²§pÍµ×ğôg<ƒk®»–§=ãi<íOãÊ«ŸÊ%O½‚­»vÒ™#ivâ„(‰ÉócÄr‡)\n”2ÚöPcĞºRa1V×Ø8	¶1–Ô²»^ˆ8±&ãš4[\r\Z­˜F3!ŠB¢8¤ÙlĞhÆDqHG²­¶RbòÍ#ã2‰qÎÈ?·0Oi%¤8ŠĞJ“g™‚Ûg%ˆ0JâaDyÅ‡¸«Ê’‡]”ˆmÃªTm¯JIwåV¦eáê*³ªU¿\0ã¥ùdÀ„,O0ÁO*ï\r Õb_İã4â`·„’î©SMX<nõ=œŠ`}Ô;	>ó/_âà–ëyã3ç˜›~\no|Ñ^V¿x+8–Ú£¿Òô±û¦\Z˜•e¾îYw8\\·m––ùªç6^~ëiÕÓÄ<Ê]Á%û¶	à;äµˆVû\'\Zz¬¯4›•Ë¾©¬,³ßv>Ã”¦À«VãÈ“ûkÃ9’‹‹:\"-¬Ò:(­7Èµ|æ÷áSE–*íx4»s­ÅtZ¡Ú[·ÓÙ³•Ä¨\" 0²\0.Ôa£T¥†Øtî:²,’Fƒf»ÍìÂ[vì`aÛ6¶ïÚÉ¶ÛYØ¶•ùmÛ˜›cjv–ÎÌ,v‡¤Õ&¶fâ’¤A†$”\"ËR[O¦TQJaŠÂ<WvgİCT\\İºs¡´B)D[IÙâ¸ÖqÔ #Â D+‘ GÖF´Rš ¨ê°(dâRNr”BÖ´ÂyN§İF£)ò‚l˜‰*IŠmf¯\rİoÙŒüqetğ	®kG?¾ëm¢’2šv–É\'¯Àêà»~‚µĞa$Q{§‹›¾&˜`‚	.FÜóàÃ¬Î^Á÷_¿Ë“3ó\n\\=x„ãí­<­\raØâ9ßt—sÛC6ÀÊ×¹óX‹§=óR®kêMum7CÃƒ|àæûH¯ú~æ»¯£qßgù‹ûº–0à÷<š³mÇvB£™›¿”—_=Ëñû÷óµzZ^¬N°²²6BaëGgjÿêŠf×•üèî)æêÂs/Ò]G–æ¹|Cj>á¿<ä©7>ƒç´«öØPöÇ«2¢™[¸”ï¹z†ã÷ûëAÏW”DÔ¥BY!³u+!ŸÆ7ª]Tpñ\\8ŸìøDĞ}f×Zl;¢$Ÿã•M;(kŞ\'\\y.d3Ï@l«8aÛ%—‘tÚ¨PÊ…š8\nÉr0h”¶ÙaX›Ì!qÑl6í®vm\Zö<ŒcÂ8&J\ZbW9IJrÇq©ÚYõ†@k”2bûY\n“‰I;K”eU°:ÊúEà!*E†29¦ÈE/×¶Qh·™í¨•Um‰¢ív+ÇØs7Ñpª0Îä\\¥‚†!ı²’§)&7Ö³´O Œ4M)€ÜDÍ&åÍ|#ÚZÅğH³› 8Â/¹}ö*í«ïØì—)7éRnûuWon\"U%ş¤€ºòÊ«Ÿ$E=_à½è6\r<¯Z òrLdÛÙıÚ·İ	&˜`sÛ¯áµÏ½œm­:ã;Æ#«ì¬4\0,ºh“¸ËÕ¯ò|…{°;ø}çS­y|ülåşù·ğwşBÂd;¯}É³¸j¶¶îğ#¬nÛYI¥ºÇYoÏÓ\0ÈSz€–f¸ôŠ-Ì\'R†Õ‡1µgÁù€Ãw?¹í‹£>¦øşïşVúĞ?ğË·®t|Ñ_ÎËv»«‚Õû?ÏŸÜ7Ã¾à©lkÚûŞõüòm«ÀŞø#Ïbß&£çØü_†ùÿFÛ€ı_}”}Oİ>êhËøÛ Œg\"_Çz#~ğ•¯ä¥ßúbğÈ®/ «Kÿœ¤XÈtaœŸss¿NRX’ {¯2-K”u’çîkU@JÂ\\+%[GkcÈ{+<pË§XÛÿ0ë½uÒ\"\'cÚÛ¶Ñhµ1Ù(IÂF£!–¢¨Ì·R²“Ë£ssyj’q­5xÏş`À`½Owu‰•¥Eòá\0”\"#ÚSÓt¦fÄ]£ÃÀîĞ§È‹‚4ÍÈòœÁpH:MS´»ËÍVKväB[‡EQ`]÷œ\n¥Ê‹3g¥Æ…¡(¤½ÜâÇ¢(È²LHpš‘eEQ0Hû¤Ù4Ïè­®š¦Šàÿcïßãíªê{ø=æe]öÚ{ç²s!$!!$$Ü‰((Z¨EJ¡¢G+ÒBµÚC­Rş>=¶}´¥>ü\n§U|”ªE­WT \"å&wI¸&’û¾¯Û¼ç1Æ\\s­ì\0\"l4|ß¾–k­1ÇsÌ1æ&Ÿñ]ßñı¢)U+”g²øğÃñg\r‘XWseó7“fi×ÆN\nÏ‰sáQ6¤RNÜvÿµ™©µ-»C…_4œØ÷ò…~tıõ|ã›×v•õ7Xî…-Ûë}ş{‹‹t|Îš¿1\"–§â‹åİtõTÊ¿Nq²ˆeAøåôSÿˆµ#7ñ™—<4Çósò)góŞ½|òæ-tö\Z†œñ{gpÔn\'†òOÆs¡_€X~ûÛŞÆéoş=#Â´‰z¡T\'LœÊ7ı™±ö<gyî+Š`#.õÙ¡rS×Ôwç™vÌÅœĞ‰BwÌˆ%ÛšÛTæ€,…¸Åu²ëÑG¨Œ“èŒ8ğ©ÍŸO_m\0Æ„O%0é ƒ  O¯çy&ÙFÁÊ‹½÷İˆc#öÜ-( ŠL’“8‰i·šLŒîftÏ0*3VÚR¹D¥ÚÏàÌY”«U<{M<“qPk²-M2Zí&Q[g…„T«}TªÊaß&2QJáù>iO438ÆÅ#ÍRt¦IÒ…‰¸áü¡sqÜn“ÅÆ½ÂÄdn“¤1­¸Mc|/Ê˜90?P”«}ÔæÏeñá‡…%R§+‹CaŞºÑvÎ‹¢Ó<<Å–kËÍ·yÌ¼»9Ç=7á¬Mj~tÃõ|ãÚı_,¿<¿A\n‚ üÎrú©gò©“æ,8šOıÉÉœÕ×[ç7¥S8˜£C‚2k9Ä<»cú…2ÀÏl\'9ğPÎ[Xe@i*åkV¾†æ·Ø¼eÜşCä^ÂoŠlFëh+jíïß¹Èé[ã†Ñ½ÎkD§µzÄµ9æ\\œËGñzfc •¡ö¼¢¹ÛGQšÆİF?È<Ÿş¹sQ6›§=<åÑÑm…şäıêv#(6ìÜœXÓZŸa<¿ã^ <Eª3²,%jG´êMtšu…«óß¤é¶íx‡¯Tn­|Ÿ ğ)…%—`$ËP˜k¤iJ’™˜ÌÎuÅ¸”›¬}ÎÍB)ß¦V(<#!•oçÄ\\7oÏZÄµ³8§iîË¬0éµ«ƒƒø}Jµ>b­)×j¤JÙkÛ‘²“’Ï—ïæéÈŸ{Ü.xlP›\\ìöD½pcîÜuìÀÙ¶l›ñì)ÏDXÉkìßˆXA˜nJfÏ_ÉÛÎ<ƒOü··pŞ1ı<{×Í\\³­·âô0ñô½|}›Å\'ŸÆÇÿäøä¹oá¿QfÓ·òİ½µ…ßmOš‚²~­Æp×‰0à‘‹ààÄO¯P*Šç¢ø)¦@vE’ÁE‹d–¥Qîêw[ÓÔ3£}*³f3pÀøå2©ÎPYG@)ß7KSÚ];Ófƒ˜Ûø†!¾ïáy\nßŠbóÙù$»…„õÙUq‹¤İÆ³ıöÏñ<“\rPù«µ²Öa\'Ô•óK¶şĞ¾oRXg©êG&j…]Îx—e¯ÑÏ%\ZQÊøøbİ]”÷zKfİ6¬&%M2Êå*µAJÕ\ra@P®…qaƒf×œ[7‘\"f;bÖ<faÕ‹i§³¹Ñ=oÚıšà®c_nañjAÜ0¦ÂÃõÏYçPO¥üë\'ÛÿÀ‰† Â+ƒ~nÆgùM¹Ï‰Wg…ìú`/Ónw™Ù2g­51w»ÛqâÊ¼Ë;\"Ì”u¬]‚¬Geei‚¯cêÛ¶òÔ/ï¥=>N¤ÂÙ³éï0aÜ´¦\Z–(Ûy¥R	ßmÎ³Â5B²ÌXaƒ ã·¬\\ÿìõ´\r“—¦	QÑj5Ş¾=;w000\0V¥\nµşAúj5JÕ*¡Â87?0.QDEÄqB«eÂ/*¥Ã2a)$,â$Û×Îòí,ÇYÁ-Ã}v!û\\8‰c“\n­‰ÛöºiB’Ä¤YJÇh\rå°DXQÊ£T­°xÕ\ZJ³f“6ó9Š³¡Üƒàuá9)SœÏ\"®Üó}zD¹;K™@k~|Ãõ|]Ü0AAxéq~¦:ÿ‡ŞYõœøê6½ŸÍwçfÑÁ•›Ï¦¬WôÏq\"Ôá„`Qlõ\n,­5Ê÷Q^HeæúX@eh6åZ?òÀ7ÂRkóû¦5Iš’X!é^N`\ZzGÄƒd>˜[ò<ã:’eš¸İ&‰#*•JGHæ	Y¬Š2ÊJAî²‘$)Ib\"`¤i!Œa¦Éâ„ÌFÇ(Šcç‡ì®ÓY t²k(Š¢®±ã\rÄÖ‡Ùm\nDkßCùæ¾½À\'¨”ñ«2{¿®]®¶ sŒÎ¸õÎ[qÜİ÷â1÷îîÇ¹]û_|&lI~lFÄ² ‚ L\'¥£sb~ÆÇºUè.WŒ‚µµ z{‘R*w¥Àú%›:.ü[±^Gx9qn5[Ş¦²½®iR\r~¹BiÆÒ À«”HtBš&ÄIJ§´Úm’Øl¢s!œ85íËzš¥&)‹¦y$;Y–ÁÄe¦M¬¸³îI·\Z´\Z“Ôë“Äíˆ$IHRMœd$™¦ÕnÓlµiµÚ´ÛÍFƒ¨Õ$‰\"’$&I\"ÚQ‹$MM¸<m²×9Q­­(.¾\'‰Ù´gÆ.#M…Ùõ;Ë2+œSÚ­ I“ˆv³IÔj¡ÀXßm˜6tFµVC…%´gâ=cçK¬íÊ=Ct²Ÿ	÷î*çÏÍ¹©gŞEÙÄ¦¶…v#ª{&\\‹îYy5 bYA¦+fA› ^Ú}ïX* UJÙŒnSˆÈ‚è¡`‘võœ…ĞÕqõœàr¢ª(šöE¯\0sç)ÏÃúgÌÄ+UÈğü2xøµ$±E‘ÉVX:‹­±î\ZXãl©K¯ì|€1Ÿu¦ÛBš‘¥&z‡Éˆ—Af’{4ë´u#FÛ-ZÍ&Q»M£Ñbb¢N³Ùdbr’F}‚É±Q&ÇÆHÚ-tšFQÔ&#Û×îñwcĞû1Åú0»˜×N(»EB‹²»7_Ek®²¾Õ•~ğMJqs¨çWm£R(ãË­”‰g½W½¼şŞmø¾ÛÈiÊT—À¶šíB­1µ-y:õıË‚ ‚0í¸MrÊ„+üœíÄŠPïw	\Z\'Š]]\'Ú\\Â\'ˆœ¸+WüîÎßnÃaVü‰¿ç·®æLüj‚H´&U |5Á¹ad™IçíÄ¢¶VÙ$1áàt(wÖYWe)i–æ‰ZLô\rS/‰c\Z““ì|v;;¶nclx„ñ±&ÆÆ˜œ˜ ÙhĞ¬<:2Lclœ‘»yæñÇyjı:v>»…ÆÄ$ÍÉItš™(ZCfb\'wÄ½u¡°ıu®Eñœeİ®nÎŒõ\\“&)™6ş×(xV‘™øx¥¾*µYCh:›#‹hÈ¯(UğW¶Çİœ¹ãªà.Baİ½˜Âü°ÅZ°Ï£Ú‡ÏóşˆeAA˜N¬ğó”‰#¬µº­(‹ŸsË_+=\"ÆÕ-Öï¥Øv¯€Êº²iÓµç~š7m\ZËµçùhåá•ÊTú@ùæ\'ûL“ië«œwU¶V¤¥©Éšg|ƒM™ëŸ;¤	ifŞÅÖZ4ø	Ó–Ä1õ‰	ÆGÇ¦>>ÎÄÈ0#;w0>¼›ÆÄãc£Ô\'&hMĞ¨·ÚTÂE‹3oŞ\\ˆbšcc$Q„§5Jc®Æv³b†NS+3´õ76†]3ÎîŞt–™û*ì4IHã„8È²˜$n“&	åJ•¡yó	ÊüR™ÚàLæ´„ RËcQçÔ¡€,ÍÌóDGìê)b)»ñ¤ğL˜zf“¥{Šó­\n¢:oÃŠtW^\\äíÏˆXA„iDç¢—\\lèÿÏ^±ãD$=bGÙMoFlc7¸Y%iéµ2Ûrï®ÌÅvÇŠõ\\ŸŠeYf|XµïÓ?s¦\r©ø(¥=’ÔZa­ vb2KSó^°”»\ru\n\r ³Vce&v2\ZÏWø%Ÿj­F¥f¡gqB)™;o³fÍ\"ô}Ò¨E}|ŒúØ(ñ1ÆGGiÔë¤i‚çAP\n¨öU™9gµƒå€R¥Ê4KHÉHuFš%$:!N#2‘é„4‹È2cO’¥4i\Zƒ×èÆ%¥h’¦ij,éÊWÌ]´ƒV¯æcåà£bñšÕT††Hm¶A7?½ó–fÎŸØÍ¶™ÃÎ»g6&øF“¡uŠ&3ŠÎPh<ûÈh[[Û_\rœ{‡Ræ—·@ğœ5»ğÌîÏˆXA„W\0\'sK^A;Q4ÕñŞw&ÎDŠèˆcsÌ	ìÎwg©tß»ÅªÛì··*Šhgu&ïŸGµ¿Ÿ°\\6?Ş;a®M¤c¡íX”İ+cÓ†i8oß7Øh.QmxO†Tª}ôõÕ(—Ë&ºÆâŒ|¡Ó”¨Õ YŸ@§~èS.—ğ<,Íˆ¢P”«U*}}ø	k—¤	™6}L³)1j·‰“ˆv»E\'$qBœÄÖeÅøR\'qLlı²Mˆ»ívÛc…¶ç ˜=Ê}øµA‚Ádå>´*“KàÂTôÎ½›+;rù2ÉÙ™+[ªğLå™d*ĞIÓ]˜óü³×íÄwáÄõÁ]h?GÄ² ‚ L#FÒöF²èÚ\"E‘\\3¦Ì	Sæ6•9œØt‚Êµã|k³Ì…9ëÔ.eV8æÚuïE1«µ±@V™1g\Z(…%<›¤ÃŸeÆe ËL´WæD³ócÆúÒj­Mˆ5[nbk¢8²™ò<”–ÊôP›9ƒÁÙ³(÷UğK!~)$¬T˜1{&Cs†˜=4Äà¬ÙÌœ†&~²ï”Ë”úú¨Ôú(W+¨À$S	ƒÀ,>R/:ÍLŸ²ÔXg“4&ÓÆ…Ä‰ê4M	ÂĞÔ/„‘ËÒÄø?£­u6#KR<?$(÷¢TˆÂïH3?ÛºyäÂX›6ÜØ»yÅÎu6…è5›\'U¾!ĞÌ‹Ù™o\nÌÏêˆq]ˆ {\ní.µ_#bYA¦\'DŒÏ¯B~Ñ.Šc‡¶ÖYãaüe{ÛqßM›Æú×íËìÄ4ÆÏc™uí…·ÑN˜õöÇÑÕ>@0oÉA,<t9µY³Jå<ä™gWÚİ¨Í—ÙjNÀ§IBl¿gYF–ÄDq›4‰ŒC–’eÖš›¥¨ÌdÚó<EµÖG¹¯Jµ¿ŸÚÀ\0ı3g00s&µÁAÊµ\Z¥Š±+ßÇ‚RHX*”m\"Àß³+H’dx¤QL–¤$ID’šë»Yš’&18÷{_ÆÛlHMJJ’%dF£=PAH¹V#C“èŒTA†ñ\rÖV$ç‚·°IÏ,D:s`„pG(;\r«1“š^çï­3ã3I¥­ÍÃgâ_6Ü1ÜÜéÂ³ñjQË\"–Aa\ZÉ…‹İÔçÒ%÷7‚¤˜‰¯&Ì	`“È£#¦ŠÖ^w;Şqk0–Æ,ßLg49Çˆi‡ÖÚøçMw-{,ËL?Px\Z‚Ú\0CK–3ÿ ƒ©öõå®º‘œ|8«²™æs«Õ2ÂÙ\nÒ$É’…‰*‘ÆÆÿY)EÇ$:#C*•\nÕZj_~”+xAHX.ƒg„¥ø¡ñOƒ\0åùfã\Zä~¹¦	Ij]+¢6Y’%±‰ÉEè$!cÛÇl^š86‰SÌæD+ƒó$0Šr_^¢İâGkŒÛDç(Î…›×ü™pî¶ßĞ#”-6ğ©gMÅùt˜ÌŠrûœá]˜kiû3õ:j¿CÄ² ‚ L;èFğv²ö¹8Êî»FE²yY«_AXyG–¥¹u9+ø#û¾ß%Z±ºXO÷dóÓK¢»¶)7eùw[ß÷“^º\\¢:Ğøhm’‰l¢K˜—ºBÎøú:—÷îÄudÅsîìÜA4F¬‡!~9Äó}¼°„–ğ|Ÿ0	Â0·æ§ib¬³}ù&\r¶çù(å®iü¬“Ô¸ƒdYFjÓVkë>búÜ‰îÑ±”›ºFœšH#¦¯f´|ßgpöl¼ \0”9#@Í\\ìÛ²ïæÃ}Î\nõ\\mãra\n´]˜åm„r—µÚ¥>7³f­Íg\'¢;×Ú»oû#\"–Aa\Z)Šàê|.ŠY#J»Å‘3º\"³éÊ|6‚¨µ¢ e¦ünq1š@ëòF8dERQ0)e¥Y\'‹G¥¯fcD›£Yfb,g™‰aŒIäœ[E]lb\'˜s¡j_ív›,3b4‰\"â¨m7j3~ò}Â°LPª†%³Y/Q~`İ\Z\0A¢íÄL™14îF\0ºÅFw¨_n£¢ë«¶•¥2÷Ç1FÛxÖ\nî¦Üó|úúˆS“öº˜¥¯3®Üsà^®n÷<tæC•lÆÇs3®‹iºİB)·g˜…“¶B¼ˆ*Ì÷‘ıË‚ ‚0¸MVNõv‰[K·5ß€ÕY!Ä›vmt„•SJ±T<æ,®-e-˜nÃ]—¬6?×QåÄSÑ-Ä·÷f¥5^˜¤$ö~İÏùR(£¬ñğPZç±–Ál~#•RÄqLEÄqD»Õ¤İjÆm<¥ÈRÇ9Ó •Oš((…ïx*@é[ƒçyøJ(Ğ÷)!¥ Ä¥ğQ ]f@e­­j-Êª TÍXeÖÙ0”C€Àğ”q÷ğ<RµJ?ï£=mÃºuDpïçâ°»ëºy¢°ÀÑÚ\ne{×nÜµ9˜/˜´›‹‚Û6Şu\\ÄŒ,ë’ÓXW\"–Aá¤#\\›ìÃ	¡½éˆ#\n»Åq¯ÀbŠÈS•;Ër‘\\(u…“ë\\Ãa¾w®€§¨ÔúñËU”ä\n–s·Ñ@D½§ib#IØş&ilÒO§1I‘f)Qd\\4|ßÇ÷|Â0 °.œÕTi+ê´ÂÖûÏ÷L,hKš¦¹¥9MS#2ïY1Ÿf¤YF’¥{‰I­5¾à{ÆÍ¥¸a2KM(;· p‹\n?*}”kı œ¯ôÔ.X±JaNÜç|>¢7¯“”Í(+sù|´u\rÑ6Ö²ÊqmÚ0OÊ3áæº˜º»û\"–Aa\ZQV¨8AG.|ÌQ#`»p.Šl¹<~šwî\0ù±‚8.¶£¬+@Q½å6ı9?fÓ«¦ºR&w®cŞ;–N¥( \\¥R«áûØŸù]êæ$Iˆ\"“Á.µ!Ö|Œ%e„™Ö&Õ3yf¼˜v»Ç.N’ÄKãbá)’8!jE¤qB»Õ2©¨ÓŒ¤Ù&bÒVDÒŠˆ›mÚ&i;&iE$í˜´Óª7I¢ÄÄFnµˆÚmÓfÑœ¬Óœ¨µÛ]ãá2\ZË¸µ2»ì„ù8Y¥\nÆ\'ZkÊÕ2Ênî3¬e¾gÁøëwœÌ&„Q6J\nî9²òX[±k•¸{+ˆis\\kŒ»H¾*ÄTî(nÛF·{§óû7\"–Aa\Z1¢‡Üi—æÊÍ{GÔ:?ÚŞÖÜy\nÏ·ïö{Ñêì¬ÈÑÜ9ß\\³[øÚ#ùµhîX¨‹çwêç‚…ø„}5IymÅw¦3ğŒ¯¬ç®4íl–Ó:3q~•\"jµÙµ“İ;wÒ˜˜ ]oD-Z	\Z“ãÔÇF©R#i´ˆëMÒf›¤Ñ¤1:FstŒúğã{FhÓ§51As|œÆØ8­‰:õ‘1šcŒìØÉğìÜºm›·²}Ë³ìŞºg7>Íäğ(¬ã®Ÿfl4iš˜¹µ›úb±#ÉRR2—4Å·ÉHl¨:có61+Š‹î—#7‡JY§\Z­QE9gEp@ÄÎÊçÌg\Z´/sÄ³‹6ã[nÛ\\~_`Ÿ­\\¢ïÿˆXA„i¤#)FxË°Ÿk°-×%P!ãòw+àÜëo\\\\ÎâI—eØ´é˜ÄX=Õ[Ï”;!İ¡«İìVé«ßeÛNj7îÅI\'Ë+OmúkÏF¬pm¦iB»Ùdxç.vnŞÊ®-Ï2²s;·>Ë®g·3²s7{†iŒ7˜£=Ù0¯±:ÍáqZMZc“Ä\rš#ãÄ“MâÉQ½I\\o’L6ˆÆëDõ&I³MÔhÓlĞ§1:NÅTûjÌ˜a®x&b†·ÑBÒ—|>°´¹/*™5o&Ï´SS§ûÜõ½0®$L‘‹cçV‘¡UîOaêZ\rm¼cÜ¯šÌ¦ÅVö¾òkèüÿÌ\"Æ.º{¼ÿ\"bYA¦•;CGÈºdNàtdHQ´¸úNTº2óîåááŠçõ¾LyG»úºğóº«k¬‹Wß‘÷Å]ÏÆ0vu2­éŸ1¿Z&+Ô7ÖÊÅ»Q¢èÛl,¶\Z”¦ÒWahhˆƒ$QÌäØ8£cLÓjÑ›6cü¼D×Û´\'\Z4ÇëÄÍˆ¨Ş 59I}tœÖDƒÆèQ½í/Ö„* –¨Uªô×jöÕ˜ÑßÏĞ¬ÙÌš=‹şş~gÍÀ/$©‰\rA×˜Ë¿[hØrëŸÜ9®ÍœùPêëÇ¬K¦–œ]cÛce6	EºÇÔˆÙÎ|¹ä\'.Ê²iÊFÈpb;Sù&Qğ Sy]Uğkw­\ZvÑçÕÁ«ënAá•Æú¦b¡ûIß,\nF#†èAöHApºôÕ\r{\\\\ÛFŒv¬”z\n?g\'t;ÂÌê-Ì»Ö:çê¹k\ZkcÇšêû>a©D_­ŸÀ\nÆŞ{ñüÎ½\Z«³sópaR®V˜1{3‡†˜1s&ıııÌ˜1ƒşúûúè«Õ¨Õj”Keú*Uú™18ƒ3fP«õÑW­R-W0åƒ208H­¿F­ÖO_¥Ğğ	<ŸrXÂ÷<B? \\.Q*•ò‰RŠÄn.ô¬\0M“ØŠ“–[¾ïx¬ı¾08s–Šaîq*:B¸cevsªºÄ7fLUÁ‡Ø	j7×¦pÂW)t¦É´ù•m6ø™\'³3¾o³LšFÏ­½Ÿ©»¾ß!bYA¦+K­±LJxf-•Î?Ù‰Wó“¹*ø«:¡¤¿:ï^´v,Å{[‰)Š WËöÁY/•QÌ]B®˜D¥XWÊó:`>~XÊ#.àúäAœÆ¤Ylâ[¿k]HïíyAP®”)W+ôõ÷Ñ×_£T.¡”\"Â0¤–ƒ2A„%J¥\n}}}”ËeúûœÁŒ™3œ1ƒÁƒÔúè«öQ)W(•Ëæzv´}¥ğ•‰—û^—+¥?44|ß7\"8³®Vhº{Ì²Ì4–oš4e©N)WjôÍšEª\\œâî¹p¸¹pÂ¸÷XqaÑ©ëâ}ØçÂàæ]¹¾šùòl$\"îš†ìÀ(mbA+WØyŞöwD,‚ Â4be©İ,eËŒµŸM\r#\\c5ìüÌß±<ı’h*¦Ğîµ0»öÜ÷by±­\"¦kÛúµÚëu	¹ÜÇÙX±•ïÓ78“¾³ÑxNñƒRÖmÃDsĞ…ö@™°rZã)#˜=/ (‡TûkÎœA_­F†®s~`E»q#ÈÒŒ4N@wÂ·™ÎoÚ¸$qBÜj“´c¢v›,-,2|Ÿ’éAàYaîÜ/|{ßZñ|œUŞ÷}?+xfc_PéCy&¤»o7æÅ±÷<¬°9Ó-LŠõ”O0s”‹á¼jG÷š°¶¦yy¶¢aãûìÚvî:v`¢~dfœ•*´¼#bYA^ºÅQG º÷p4ÿT;Kbñçw\'şTÑ¢Gxu·7µËE±=mR±éCGœ£Lzf\nı2\r>ÚˆA¥™óæ¡ƒr.=ç&»d$™I_íúãy*wùÈ´Æc5®”©T«T«U*å\nÇ1Íf“¸İ&iGD­6­F“¨Ù¤5Y§>>ÉäØzƒÆdf½Nk²A»Ù$Múm£9µÚó<ü  T)–Ëåe]F|›ä#ÓÆÒª¬Xucæ2æ91İn·Í<dšr_•9‹™qY÷B¥8Å9ssèæÚ‰ùâyN²š„ªãStÃps]8Ç¹ğ¸\rƒnî[†ÏXK¹ÎRc]¶ãdúP˜ğıË‚ ‚0ŒqE«¬ F\'9Qb]\'”²B³è§Ú²º`áuB«øóG`õl.t\r\\9Œ vaëÌ÷.Al*Û>v„vÎºªÊèŸ=„_.µk©Öd™B+cqNµÍkYÏ÷ğ#bË•2Õj3˜1H©\\ÂBµNÉ’„v³AcrœV£N»Ù$jµˆ[MÚÍQ£AÔ4\":j7Mìå4CaÂÖed(ßÃ/‡„•~)@{\n/ğMêlg½¶.\"ZkÒÌ,\Zœÿ±+Ï´6m…43æÎ£:sXkzqñÒºÂbqóèæ+Öqâ×Î·Ùœgü/ºrÁÇ8·‚+c…70¥Ÿ‡´ç¸çD™XÏf«`Çucª©ß±,‚ ÓˆK1\\EÊZ†{Ëòï6¤œVFv+÷İ£¢[@w[ÅzNÔvxós¿ÛÈ¦µÆè3\'ËÅ>«Üâla,«™6áÈ*µ\Zııd™Sà\n_™Íq¾oR@gÖçÖ·BÔó<Ò,±Â]å~Ìø~èã!}ıı”«}”ÊeüPA ñd(?%Îš´âIÚIƒ4kÓŠê´ãÍö$‰nÓ&%\"õ¨x}A9 ,‡TjUü0ÀÍ¦>0ê0·ÆöøÇÂˆc›TÅ\nÚÌI½qZËº§Ì»ñ,¾é-ËmÅ6&²™#?÷YîÌ’3£v;®>î°Ræüü¹é9Sw|¯§ä‚{ïîŸˆXA„iÄé‘¢8qÂË}6rH“¦Ñ[h½eÅ—¡(Æ;\"L6†q\"Ï}¦ şœF±®Ã³–H÷3¾Ê-×&[_«³qãîğ1&3Ÿ,ˆ’Ôø¿bB˜¹xË¸lx:#³î¾€îº\ZÂ€°T¢ÒßGµ¿Fÿ¬™”k”kxıe‚}ƒ}UJ3ú)Ï\Z ¨à×J„JıeÊı‚Z	UöñûKı%Jµ2Õ\Z•*aµ„WòğË>~àÊğ=ãKİe™/Œ™ùl²š±0Ù£(&NSšQÂÏïü?ÿÅƒ´\"“uĞev‹7G®Í\"ÅïyÄÕqÁZæÍq ×ò¯İæJgiî^×²¶uÜsfBÔuê‹Ï`Ç¹cÿÇ\Zšó÷½…ÂËIááïş;è¢ğ\'ÑU^Xv—“ÿu&qïAašğ|1a_¾f5‡rh—(r¤#ºÜ«mÁ&#±{Ï/¶Ñ+Š÷n¿[ OEñxñ<÷İ	òŞz&í3ìŞ=ÌM7ßÁ¿¸‡ÇÛ@¨JTË\nÒÄÜ\nß	a›ˆÄd±Óvó^G”¥i’»ø¾Ö·¸T*”LŒ°R&,W¨ôU	Ê%ÂJ‰jå¾>‚r‰¾Á~ÂJ™r­°¯JX)Sé«Péë#,—LjîR¾‡ø&¬g\"z\0øÙPè$¢s·p/ãî¢Ñ\Z›‰0E§f#aœd¤<±y›¶ìdÖĞ\\æ0k¯q%Û½Ç¼+†¶«ç®oNè”ÛZn£§ÊçÓDY1e&^·‘¶;ÓóĞ…_:”êl\"ÌËP<¹q¯_oÏš\Zç»ı»Ìïş‚ ÂïEé>;—[œ¸é‰¥ÛuÁeº+¶åDr±Ì½»¶ŒUQ[AjÚî|ví;‰ Œ4²>Ó`~ÎW=ÖÅ\\0jÍcnà[ßş÷ß{?Ûw<ËÈÈ.{òqÆëM´‚$Š‰â„(mje“À#I#À¹:dæ•it¦È4(ß¸xOøA@†”ú*Tú©ÔûªTú©Ôj„ò­R­âåZ¥j…r­jêV+å2åj~XÂCJÕ\nA¹DP.á‡Ê÷ñÂ\0­4Ê3!şßŒ½¢cuíŒ¿Y,$qL»İ&bÀc¢>Édc‚‘‘=\\ÿ“ŸòØã›Híx¹ñs¸¶ÜgÕ³ÓÌFÀZË²6“’»ehmÆ”\\›o]>ÕV4+ëãl\\„Ì9Æ­Æ|É¬¥Ü=£Ú¹v¼J±,‚ ÓJá§ñ‚\0q?ï»c¾ïç¥óê„¡íÆ¼^+r±İ½…rç³a¹*ô«[ˆw6º2Œ„îêw–elzz+7ß|;¶o£Ùª“¦MÚí	vogtxñ¤F0\'iB–¥$IJ–™ˆÎ•Á½r+®í›R\nå{(ßÃB¹T)ã—BJå2¥Š±—ªUJµ\ZåZr_¥jÕX“«UÊµ\Z¥jÅ”ÙW©\\&_¹TÎ}ª…´³yNg)Ju6Vf6ÖÚˆä$!Ë2³ñÏŞG«Ù$J#ê“ÜvËİŒON¹isª¹Ò…N¼ëÜ0°scOÄYéÆêMñ×\0S©ğØÓÜ1mDt.ÂİY…>ïïˆXA„iD;áâ„OAhRÇ.4›³ğ\ZŸÖN\n/\\NPÛuïÅ:EqÖÛ/wL[ÁZ¬ë(322ÆwÜËÎ]Ûi4ëDq‹$‰ˆ’6©‚8ƒÌ3î$à“&q“¥©qµ°ıÏ²,¿s\r3øË¦oc‡!¡µ4—J%‚0´‚7$,™ã•¾*åJ…rµB¹Z¥R5	IB+ş3×·Ùó<|ßËİE<å¡ÜFC#Usëºës»İÎSxãyÆòëh¢8\rq’²mË6î¸ã~ÆÇ¹uÙ-\nÜø;\\Yq.5ä‘8\\LçNJ«zó¹´ó­5¾ç±Ÿ[¨óp\"ùu´ßZO•¥ïÕ#’\"–Aašqâ²(Œ\\˜ŸĞ;±t—ûC/F¼v,N$›fÍ1¬àtõT!™‰9fŞİõŠ/ws/ğ}¿Ëı¢ã xä‘\'Ø¾}­vƒV»I5‰¢ÏóH’OA%ÄIJ’F¤QR\'˜c¢¤E;jYk³	#—$‰ñÆø×*ß#SäáÜ¼ÀGù>ø¾Izâù¤h´ç™2?Àó³9Ïğü­lÒO¡•Ùh˜)»èÈÇËÄƒ‚ĞºÉø¤Z¡ñÈ´\"SêŒTg$iŠÎÌæ¾$¶BY›\r.ób«İ²¯6I–Òh·¹ÿŞ‡¹ûî_Ç&ÂFq~°‚X›ÎäŒ•×Ì¡™‹ÌFİè²ş:.££²óåÜ~œÜ·«‘Üí\'××¶œÜEÃüº‘\'2™âyÜ±,‚ Óˆ²nnó•GF:ÖcW·+Ù}.–å?¦ÚêãèŒ–Yf²¹9‘fu›VêXó6íõ\\}­5“““<óÌVêõ:I\Z“ÆM+âLT#(3t\Z£²…§ \"’v›¨Ù\"iGdiŠNSâ8Îİ\Z|_fLt×uHwşÔÊ.\0|?ÀË-ÃÎJlüœƒ °ÿBÂÀ¤Íğ=+¾=*.+\'\ZtÂÇ)²TGÍV“v»M;2–eÏóŒµÛ÷Étj,×hÒl6‰â˜z³Á]wÜÃC>IšAj3š¹é<æZÆ‡=Ó™±l[ë¯õ]·\"×uYçóÌyVpã,ÔNTç\"Ü¨™c÷È¸E—ëìÜ~´±8÷>/û+\"–Aa\ZqnÎ\'˜‚Èud¹²‘:y˜/å\\Ü9F°äbÇâ„­ó§-\nİb\'x\\q±År\n>ÕÅïÚºg¤iÊ–Í[Ø¹s\'i\ZGMR’XÑÇišÄ:Iâ6IÜ&Ói\ZEfƒF½ÎäÄÍFVc’v³N\Z·‰Ú-#0£¬-8k«I Ò;†Ïİ~ÅùÂ¢0În|²^·+;SkévÖø,Ó¤IJ»Ñh4h6›LNNÒl\ZÁ¬¬+G\n$iJ\ZÇD-cYn¶›´â6í8¦EŒŒó_7ÜÂƒ>N\'¹kÅT¸…Jqˆí²$›Ú&»£»;*ÿ?×^çs±İ¼Û^qóùØ¼:±,‚ Óˆ¢#\\øšJÌZÃ¡µî¹M`\nöˆ ÓùŞ+~z…àThåÂ‰KÓ?çÒiO[!†µ²¶Û›6m¦Õj\Z?å41Öä,!ÉR2L»,‹„Ğ÷PZã{\n”G»İ$j·ÌÆ¸v›f³I›ÅQ»MÜ!Ó&l6$´í‡çûèéP6mµRÆÅÀXŒ±	<Ì}š{5Q!<e²ğ\rí¡µ±Øz.qJ–EqE1í–ñ­f“8IÓ”r¹L¥RA)…ïÙä,YFÔjÅ‘İÌ˜ffsc+j3<:Æ-?»g6íÈı²µÁZc²8ZŠ\"ÖÜ¤ÂN4ÛZæ91Ç2÷İgë9ksş8¹E‡«PR3Ş¦®sÃxµ bYA¦‘¢OlÇ‚lP¹év}pÇ´ÎH’Ø\n_w–•6œQîİTr\"ØµÓû2×s>Ìï•·¡l²\n×F3>>É–­ÛH³„4Mœa’ê	y—Æ±IE’eÆÂ¬5:3‚<,•HÓŒ¨İfblŒÉ‰	&&Æ©ONÒ¨7ˆÚmÒ8!Mâ$¡GDIb\\2R>¾‚öĞ™é¿Î4&®0VjeÄ¹ÖŠÌú+X‘ìòÉ´y×xdÊ¤ãÖ6Ÿ¨ij\\)Úí6íF“¨Õ†LS­V©V*xI“éŒvÔ6é¼“”Œt‚&ëXíuF«UgûöüèºŸòôS;ì3Ò{·xq\"Zç®¶mKÙE2_òcgçÙÍ9¦ùÜ#/7âZÛE¶¬3×>˜M‰î&öoD,‚ Â4â„‡ûì¾;á\\¶XaæŞµvÖŞÎñ^œ 3m›²\\7ÙcE7×‡â«XÛ–s»È\n¢Ñ±{÷&\'ë¹»B¾)Ï\nªLÛ²gL—Æº‹I£í{&9I¹T\"°.Q³IÔj5›´[-\Zõ:FÃø7G1¸Mk:#IŒµ×X°ÅÙlôË°âÏğ¼Àˆ_ÏGç„ QàyvãŸ)wÂ0I22kŒM2ãVE‘‰£Ül‘¦)™µ>ûA@fÇÛU(4í¸mü±³¥dÚY˜5Z)¢$âÙmÛ¹áú›Ù¾mÔnÖ3cß=§¹wsáÊò¹s$n­ğ5ítDtgd¼¢HWæ&Ì1[ª¬à&û~÷\'D,‚ Â4Òësj,u…ãÖâìD³*ºÍgö¬½«Ã‰iw¼sN‡¢àrô¶çÎ+\n´^±f,¸ŠmÛvÇInõ6BÓŠ2Rlæ= Kb|‚Ğ#¾¯CŸÀ&\Z)•Ì¦»¤Ñš¬Ó˜˜ 19I£^§>Y§ÕjÑn¶HâŒ$ÍH³Œ$Õ$©&N2´Á©6¢1ÓË®Æ”)ÕÑös¸Ìâ\Ze¢cı˜‹L³H‰â˜8Ih5›$qŒÎ2JåÕ¾ªÙ<†f¡ò|&d:#ÚdIŒÖ	™6IW”§Ã€,ƒ$Õ4Ûm6=³™ÿäfFFš¤i†*Xô)ÌSW™]ô¸;pÿïyÆ*¹Mƒ¶®Ckãç‘Ï½}Sî£°¡ìg¥ìóå¹„%S?ƒû{ÿ	‚ ‚ğ²¡Î:µS–×²áÚ\\Ø/kª×EAì„SQP¹ãîåêåW(XMyGø8‘Õ©çD}÷&:ĞìeÇa¢(*$16^×wŒ¯q’ ´ùìÛ4ŞJk|¬\\*™¨Ê#µI=¢V›úä$“ccF4OÖi5[Æ?ºÑj·ˆ“Èl¤KØøke²ñš†8M‰“”T›ï™u\'ĞöîS»¬‚:#JL˜»82î.ü[£>I™zA¹D©\\Îı£]È?´&7Igš4ñã­<ódYFœ˜ôßYf\"†4¢6?±ıè§LÖ#ëî€Y˜»—\0Æ†“Ó˜Ëª|f\rneÄnÇ:lÅ…gÇÖé<—çLkã3®§øeaGÄ² ‚ L\'ºóó9[´Å«¨E¡Ü}«Óû¹WĞô–Ïw˜²›	{Îw‚Êïy­V›ÇØÈğÈ°Ù€gEr’‡V³Û‰»43›Êl*ë¢îü\0¥<‚<ü›³ê&IB«Õ¢1Y§>>ns½N\ZGÄQL;iÆ-šq‹VÔ¦Ùjw‰Ø„‹“Œ$KI²””Œ8K‰³”v\Z“ i§	Í¸M’i2\rIjDrj3\nÆIBÇÔëuš†‰­¥J™0ñ<J¹Œ˜XÏ¹ø,Œs¦3›<Äg¬{Š²óíÄr\'Ô\rb#7ıìZÍ$_Çäsæ¬Í62JG4ï=¿Êº›ƒ…çÂÍ§ÖnÉ µÙiÒywT·§ºã_èâ—ıË‚ ‚08!U´.;Ú-`;îNß¸:N„Û+RüîÎqeÎÊèêMÕŸ.z,,ËØ¶mÏ<½ƒ(ŠÈtj„eïÕ¿4M­ Ó&2\n¥Šóx¾\"<_Q*•Ãr©l…µ±fÆQD»Ù¤Qo096f6Óª7ˆZ1q;%Š\Z­&‰µ§iJ;‰‰Ó$ÏªgÒjg“^;#MµÉ(˜e´Û‘u)Iˆ¢ˆf«E½^gld”v«EÅxÊ#CJ¥år™ TÚ(O;æ(tš‘&1åRˆïAšE$idÜT´	CçBf¬Ò,£Ş¨óĞƒsçİ÷å	aÜxæ‹›‚|Íç×¾wæ¬WÕZiœÙM†ùó¥L‹Êú:[­4FqÓy×ÚEÔèm{ÿDÄ² ‚ L3E1‰ifDœÉY!®o§îŞ®ÅvŠÇ:?½ï-¨ŠŸM_Š–îníD“ë³ëO«ÕfãÓ[˜Ÿ$n±œ÷¥§OÆBl²ÌÅqb„r–Øno,®&î²Ièáù&Ô›ïû&EsšÛPrzƒ‰ñ	F÷Ó¬7hÕë´\rZQ;¡¥´ã„(6.Q”\'q’‘¦G)QÛXÛíˆ$ILØ:ëJE-®>>ÎÄØ(íFƒ¸Õ ğ}ÂRÉ„¢|ğ”İÔh,¼~˜Å‡u{Ğ(­=_ƒÊRâ82–e;ÎÆ§Ûv–eÄqÂØø¿üåıìŞ3–§ÓÎ«{^Å¸—â¼‚Í`häÕµ&KMŸÌœYM¬‹‡õ£·¯¢ÿóşŒˆeAA˜fºı“\r.DW·H6î\nÚn0ÃntÂ§ØVñ§x×NG4dêw6\n\Zñä¡”_W°È¯£5Iš±qãví\'SX›şkR²4ÁÓ*Ëğl3sfÎ z@J„aˆ¯¾Êıé¿¯¯BxvãŸÉ¸W.—	‚R)4â“Œ¸İ¦1Ù`dÏõ‰I&ÇÇh7ë$Q›V«Ádc’z£NËŠàv«I»İ21£6­fƒ¸Ùh“´šuêõ:““LÖëŒ11:Êäø8íf­5•J…R©D†¨Àye­òNØ‡A€Î:™“$%ÓaP\n|P&ít)òyÔ\ZÒ,%Ib´NI’ˆ(n“f	“<ûìn¯›êº+šENÇÛ©`eŠ­àíö9îœo5oüÕuÙ¸Ğ(Õ‰Œá|¨µv17ööşkAáe¤c$¬İÕYğŒ8î:9WÏ¦-mÂó:B¹(¨;íu[§‹×ìÅÕËã*+H“„áá	xhõzB\Z§vó¡y¥i–[¢\0ö¨–fUBÊ>„¾Oš&ùF1O¹°n>~’Ú{	K%üÀ\'p>Á•2Õj…r¹B†€&j7hL1:¼‡É±q\Zãuêã“4\'\'iMNÒlL211Æd}’‰‰	&ÆÇe|lŒ±±1FÇFerr’I»y°>1Áøğ0#{ö091A’$÷ÄåR‰Râ¾M£í„³±È:×\"O§©İÈhÆĞó<›d%#MS|ßïJôaæÆŒg£ÙbÓ¦-İóc}‹ó˜*VËMÃE¬€Î…´SÑF[ëÜ¯Ù,¤(>Ê†¤Ë¯»Wãû%\"–Aá W¬æâ¥à†a´W¸±–L÷½hAö<,ÓyD\'XåÖ8gM&?\'\\İÕ©Ûé§Kòñä†Í´ÚÚ†Š‹Ñ:ëJTâ,JÚÁjÈ`Å‡,kİÂĞˆDß\ne? ¿r`ıÃRHúa@¥R&Mh¹üU.ãû\n¹\r€L21bü™ã“4ÆÆablŒñ‘QÆ†GÙ3ÌèaFwífÏÎİŒí6Vä‰qê´Ûí<Œ³&ûö{†ày¹pVJá{>a\ZAm]*òqF¡´\'m“ƒ¸4MA)ãÏm­Ôç+~’ğØcO2<<Ï)…ç¢(¢;ÏRQàÊm=Ó6ÎPª³Ğ´]PĞv# SâÎ…C,Ë‚ ‚ ¼tû”öŠgµs‚ÆˆšN\rWßÔsb×µã6:±›7\r˜ú¹¢#nópv=ş¯¹øµıIuÆ¦g¶óø›h4Ú´šuš­&™NìN0@g(»sÊeŸÕ2µÀÇ·QËòş:† ÀóÆŠí³ç{ø‰úàÔ•r…Z_}Õ\n}}U<…ÌÍú„Ù\082Æ;Û=ÌÈŒîÚÍè=LŒŒ01<ÌÄÈõÑ1\Zv³`cr’æd4‰	|Ïl8|;ÙYÉ˜Å÷P¾g\\2”Cl<ìÜØ-Ê&(ñ|È2üÀZë=…ç›Priš€î¸>X/ÊSìeÇÎİy›.V·›GgácÊİ3Ó‰‹lÚUÎBÜãVAqdr×ó™ÈUu~lFÄ² ‚ L#EÁKAË°qwèu<W·#œmíüT#Tİ¢˜RÛTrbÊ\\Ï	(\'¾;õ{…y–eìÚ=Âƒm QOH¢¶õ±Í0Î¦mKØ„Dó<EÉ¨úzfS»m¨<æ¯9¦< (™¾{\n?ô©T*„¡‰_ìy&œœRÊø\0—BÊå2•j…r¥’û4gYLµÈâˆv³A·MÔŒF“¸Õ\"nµI£˜¸m6ì)­QYFà)ª%.J ¾¾¡µ„;íÛäÊ3ÙÿŠÀóÉÒí¬ıvu–á‡d)òŒ?°ÒoÅ´™Š\0î4ËØµsw^æ„­›\'p;smpâ9ŸG;G:KÍ3RÍy\'Ö»ÓEÏZË;ÏMñ™İ±,‚ ¯\0EáÓ+J³¬[¨¸Ï®^‘45ÂÇÕµ:Ê~/&;éX«;íºö:}ÈÅQÁÊ˜eãÜsÏ#lİ¶‡v«I’4‰“6Q;2B/Õ¤‰Ùô¥P`]3||+8üTfü”}ß\ròÀŞ·cÊd×ËL[N\0:áç\\4Æb\Z†¥0 ú”JaèS*‡ø¾•™\r‡YŠÖ	š%h\0©ÙDxôUJTû*”Êvã^¢”2©ªíu]?ò±V&Fš¦d©ÙÄ—$1I“¥&Œ³&gZ££Èltëc®Á÷}ÒB}3«5ív›­Ïn#¶q£UAˆ»ùuå¹eİ>”›wÛÏ3şí\ZãR‘?/ÊœcÏ¶m9ñì®BÂµögD,‚ Â4’—‹_GŒ9Af;§#€‹ßÁ÷m‘<¬œÑ4¦½XÂ\nªî~äßºú£¬Õ1Óš(i4[<ô«\'yêé­4\'\'h6\'‰ãˆ$‰H3“9ÏˆtEënà›ğp¾Ö(›ÜÃYIµNI““åÏ\\Ó¹8$IbÜ<ÏÊ4{Ùó<”×¹÷ÌtÔF_á¥R@µZ¢¯Z¦R)10ØO­V¥¿V¡¿V¥Zé¯Uéïïc°¿Ÿş\Z}µ\n•Z•°RªV)•Ê¾O`ı†•èn¥»>v#¢BAfîmıÆb’.ÉÒ,\rAæÂ8MMåÜ½ÃºFxgÆÌ^gË–g©×›¹Q×õEwmô³‹÷ËÂaå°ÏFä¾1h»ßO)e-äµ~›:æ*NœwšŞŸ±,‚ ÓŒùeŞeµ#|¬˜±BÖ‰¡^k£©‡•.½mvB‹™ãNÕ¸¶ŒĞ1ú¨c15VJÓ—v³cç0O?³ƒõ>Í>B£Ş M\'M’´M’Æh…Í|g·`Ú¼tj–Z£ÈP^†§ŒuÒóÍ½İPÊdÁ|? J„¥²é—]x(ÂR@P\nPò}®R®—ŒşÁªÕ\nÕ¾*ı5û˜1ÈàÌAúúéè£6ĞG¥¯BX\nÍBÕÂ÷LtŠÎF=3~NĞ£A§¤ÊÆ&.Š~çº¡56\rw\nJã)?¤fğ¾\\*ø¾Y4ÙùN³,ßàÅ1ãuví\Z%ğ´KmSe»k)¥P˜9wÏ†ëWş¬Ùqv¢Xçn=ÂÚYó5ö—ëúQ¨ëÚŞß±,‚ ÓJÇúKÁÿ¸ó|·ÅÎ‰5cÉë¶şËètâ×µUÄ	ªÎµŒˆrZ(IšíOmŞÆmw¬ã¶Ÿ?ÌÈHÌSOoc||’(j$1išEmë>`b	ıgd…‹Flß\\e-•XKlÇ·`ít.%Fvú§!²ZkûÙ¸„6BF˜˜ÌaÚhARíë£T­Réë£Ößo>×j„•2^©D–ÃÚ-,¬Õ5³ÖyÏºÇÛİ›³›¾˜qMlÃ4MÉ\"Ïó<G9K­·cm²N!VÉç“fãÓ&nsšñÄxàuŒ×íÂÉô[Üz:í¹…XqŞÍµÍRÊİw~USOCf­Ê¹»Fñ©ê~¼ö[D,‚ Â4¢­\0*Š\Z‡±ìZ«_Aì\Zc >N uŸãD§¶şÎİm»k¹6<›^ÛE¡ˆÓŒ;GøÕÃÏğ³›îáŞ_>Èøø8Õj•Ñ‘â¸]ÈÖ¥\"M;}óL¿Ö÷ÕŠK_)Ò$1)›m™çÑ‹Á®_î#RWÊÅa¶ìJ¥’mÇÜ;v\\Ü}¹cårÙ†}ñ­ˆ6şÈ^\'|]XBy¾i?·ÆwÆÜ÷­µÙ¾\\¿<ÏXÅİ\"Å«ù½e™IÿZŒÌf1ìÌ§™Ïóºâ,§©É†èÚIÓ”(ŠÙöìN’$ÅóißùÏóå/ƒÛn»›f«Mš¤ùb©ƒ›³şpãcŞÍFJ­Ì\r›·\\>›ƒ`5…È®^Ç¿yÿFÄ² ‚ L3FeVØt„sQ å¢EAf£G¸s¨t¸ŸØ•r±}k5ç›HÎM£snœ¤Œ7xôñ§ùÙ-÷ğ“ëïà¶[ïbËæ-LN3kÖ\0qÜbtt”L›rN ºş»MgXÑø¾6±…uš¢”Ùˆg:÷è!ò»R>ñÛYäÂÎZz5ÊHµe®·:3âÏˆŞ‚eÛ3áİ‚°„öü<\\–±*å¬ÄÊX{=»1Î·‚k-/¹ôE_æâü¹:ÊùşÚÍŒ\n§»Šï”Êe”RDqœ§Ì.^»ĞZ³uÛFG\'Åâƒ±fÍ\Z¶mßÃw>Àu×İÌı>J£ëbãìÇùbÄ«‹QtÅ(Œ›ç›è#î§ÏÖÊl†Ââ½îÏˆXA„iÄ	\'8mi.¶œ q/0\"²($•°c)vm˜ãæçr#;×+’¤){FêÜ}ÿc\\wÃíÜôÓ{¸ïŞ_ñÌÓO³gx“ãÏÜ¹sÙºu£c#$IB’˜”ÌF?)“‰Ï¹}`||ÃRHf“\\ĞqË°½Gab&+k]ÎR“ Ãİ‹»×¢¿°çy&\r³?ÀFÓPÊË-¿g6ÛùñıÅmšÔ`”¶-Õ\Z±Nãù+1ùØ)”²1–}ŸÀóìq×?×\'\'˜‹}7í˜ïùœ¢H³Œ$Ml„Ÿr©š‹à(vÉZºeYñYAÁğğ(»v µ¢\\\nhµ$iÂîáaî¼ë^¾ùÍğï_û{FÆ@·â¶óh+‡Íp(¥lQç×\0œ«Iá¹qı2ÖocQVÖêÿj@Ä² ‚ L3¹Ğ-ş^p©èXo;Öä«¹à¡ Ì:\"È\"­‹a¾i¦iF	OmŞÎÏïzˆo¾‹»ïúO=ùÛwl£İj˜ˆ\r©	q6kÖúúªlxòIÒ$!‰“Ü\nœeq_[­I“Ä¦¹öPø^@ˆ‡‡Ê¬kH!ÃŸ;_+“œÃõ·s/æ>|ß$øP¶^ñ8ùÂÁmf4Ÿµ¶Qrá©Ñ™åhMVpqp¢ß´ej¬º¹°´×,\nz‡¶~ç_k×Wò=½CCš«z–™k9Ë5ÖíÁá®ãîÀ<¶íØeúèûøÏÄÄ$i¦©T«ÄIÊSOmæúëÁ¿z’áÑ	ÒüW	#¸]ÛÅû±ŸòÍ…Å\'J9±nváÑËÅøşˆeAA˜FŒsVNWZÅÖÀ÷MÍÜÇÔÕëcNø¿›wµ!MRší˜Ã“Ütë=üä†_òÈúÍ´ë1cÃŒí¢Ù¤Ñœ 5	BŸ#:‚&	###F¸)ó#¼óÃ¢­mªf+œ<ÏÃ÷Bká5şÊo|xİæ2\'P+•\nïëwÏ†CO1ªPxxxÊX`Í8ôZÔŠsåùX¹ĞlIbÄ~‘Å‰½†¢=Üº¬k¹)÷|cÕvÙÕwıuBÒ÷lÜä,Ël<å\0´6óP„¡	ƒç)ã_í6åeÖì¬åÅ{UÊD¡HÒ„]»†É2c^pÀÄqL«ÕdÑ¢…Ì›7—8‰Ù±kßıî\r|éËßáû¥Ç¹Xï;kYÖfÃeñŞò\'Í¹ÇXwS´·ËÉşŒˆeAA˜V¬÷nAl-—İ¢°#ÎÌ»g<G­«€±H«\\`ƒÛ„¥IuÊğè$OlÜÉÏïXÏOÿëÖ=´Ñİ{&ËRgéŒ4IIR³9L)Ø½{,8€ÉÉIÚí6¬m(8¥´±T’¡”¶×ŒĞÕ6°ïƒçÙ0q€qÅĞÖíÂX›•ñ³¶øÀ#Õ\Z­”ñœP€Ò(Ïn+Ä;ö”Ñ\n3~)DYW\r#ş4Yb…¼GŞg&R­MÜãÂ\"¥³z1n	Ú§İB³³P)\nø4M19?2P&“¡Ö 1cë{ÆU$Œí]gf^ƒ „ç»qPh<´çƒbÆ#N3†‡Çh´cğ|˜\0~ĞŒbî{ğ!¶nßA3ŠØ²y3“õq¶lÙÂ÷¾w=_»æûÜ{Ï:FÆ&ì=›EK÷½¸wc•w1˜ÍpZksá¤<Ì«\0Ë‚ ‚08k¢\ZKy/~.Z‹Í¹ÊZù:=÷¡³q.Jb†Ç&¹ÿÁ\r\\ÿ_¿äÇ×ßÎı÷şŠ\'”‰±=Ôë£´Z\rÆÆFCáñõÕP¯7f ¿Ÿ±±±Üòéúâ~nIõ<ã¶ ÍÏø¾o²Şù~@gŠ3>»ÆUÃ¹_^×>Ú0Bõ¸^¸ñèô£3~à|ˆ…×ì ÷±U6å¶kÇsÙõ\\&<;7.\\\\ñ>]$wM3f,\\„úÎ,ŒÀ5ï™ÍÖç!^`âA¡± gYFZX)¥lLis\r³ùĞˆò‰É:FÏóYpàÔj}ÖÚÑl6ˆ¢ˆVÔ¦Ùl¢uF©°yóv®ıæ¹úËßá¶Ûd¢Ñ¶Y\r32å%İµÍ3jŸE+”İrÂ\r¾²búÕ€ˆeAA˜Vl6°Å}îÀ\\°,Ïæİş\\o…¶©“‘¤c“uŞ¼ƒ_Üùßÿá/¸íÖxò‰§ÛÍää108ˆò<ê	6o~†±±”‚åË—sØªÃÈµ¡Z©†»víD)•»Ä±ñivß]ôsÚ$ÄPaX&JxxV”¿]·iÎ+¤¬¶\'ç­(ÂMsV0Û¹p·\" KS°ñ—UÁ2Úù®ğ# ua|Ó,Eá2ê9wƒKÉ]ÈXY\\0`£U¸yË2ÙYÁÓ,#Jbkñ·×M5IœXŒÉP¨\\Æ<[ÇZÅ‹>Í(E³Ù´¡å``°ÆàŒ~c1·é¶£¨E©rÈ!ËÑZÓjµ¨ÑN\"|êi¾ÿÃÿâ«_ÿëßL36íWšîÅûÜùV\\ší}lFÄ² ‚ ¼¢Xñf3ÎªZiNˆ9×\0\'¦â$exdœ{ï”n¼›»ïy‚‘‘»w0:¾‡8nÑ\"2­™={ˆU«VQ*•ĞÚøæ\Zq—±yËyôQ´µ’Î˜9O)†‡÷ĞZ´Ú-Úq­Lf9M·ƒ‰”ãyÆ×ºTî§VëÇ÷ –Ğ˜\r}a˜{ÌŒŒO0\n§93®\Z²4³f`œ5\Z+R•³Lkm-Ëõ÷\rñƒ|/P¾ç‡x~_a7Æa¢”6™sWã6áæÅ-NÜµµ³B/‰¶…ç·•À÷Q¤™TF)	‚QÇ	™VøÖ#C‘f •‡\nBĞ\nÏ0á™û²ÔZÃ•G©T:­5lÜô4V“=£#l|ê)ÚQ›4Mh·[¬{ø1n¸áçÜúóxøñÍ4¢¤CÙ>„n“dşìåËˆuß=¯û;\"–AaZéˆ\rœ….7ÑÕGGœ9+26šÃîá1Ù°•Ûî\\Ç÷r?¿c=şÛ·ífÏî=LNNE1qb,Áí8aç®]ÜqÇŒO˜„A˜[\'&&ˆ¢ˆ XuØ*>úHâ8¡Şl uŠç™,u™\raæÜŠ÷‘KÏG 	¨Vúğ=ŸL+â,%Í¬³scp’Y9ë¬gYj,¾V¾M9fùu=ëæeV,û(ßºf	Sg…fnÑÖ¦æ~L<åNóÖ\r\"ğ·ÚÜö>‹¢İ÷}J¥0?æy&\"H–r÷“F»I’$Æz¬<¼ D¹Òg˜ hG‘¼¡	geq–ßk³8Ê(…&KššŠ¥RÀ¼ys\0ÅÑGÍÑG“÷¯Ñhu°oä^¥RåĞC¡R.±éé§¹åg·qí|«¿úCn¾ı!6o¦[WÀ¹[tÆ»ğY©Âs»#bYA¦+°ÀD#p¾ÌE­”qeh4šlzf\'7ß¾ÿüŞ-ÜpÃíÜ}çƒìÜº‹vc’¨=ÉöÏ²áÉÇ™œ§İn1oŞ<æÍ™ƒN\Z­:æ$Y–2wîN:é$fÍšmÅ¨³’jvíÜE\'ŒOŒÛ„#İâÔĞòî•$1q“i@Ar¹Jød™&ÑŠÄîÚË“€ l2\'Â:.®}\'@…İá¬»g¢~€qÙ(\nÙ\"ªàm­B)ãÂQ¼?ã¿knÑl 4E³ë“ëŸk3°¾Óë‹œfÖ\Z¯(%¿B’é<¬›k£Ø–v¡ó”Y,àü¾“”$1·1{p€ÀóX¿ş1}äñ|“eÑ}ã°U‡qĞâ¥´›m†wî!M3ší»‡‡fÃOğ³ŸŞÊ5_ı.ßùÁÍ<;<^`ÂÛiLÇ|äßss‹¯\nD,‚ Â´¢ºH3Yî:±wµÖÔ›m6n~–Ö=Å-w<Ìoø÷Üu{ví¡11‰Ò)K–,¤¯V¥µ‰ã–u)Ğ”ËefÎœÖÚø¤ZkªøDQÄO>ÁÄÄ¥R‰$¢¨Åøø8•j…ñññÜ\'¹˜±-MSÍº ¸÷$IÑ™9îy>Z÷‡(ŠiEq.´f[„ÖzjJ5F+Û¥Dg|l´\r\'ÚÜÈ%q’ÎCĞu‰ßĞ.\nS7ÎÆ±Áù‡p”É`çÎ/ÖwBÖaã»]ñî: ñß$r‰Sëø>ZÛv²mÛuãœÚÔÖ½íy6%w’¥DQ‚²áKå2\Zh6´ÚM!Dy,8`a’¦)O<ù{öì!Õ[wlcbb‚4M©õ×˜3oIšÒb‚ĞçWüŠk¿önûÅŒM6ó¡Ô¹½Ù\0™¹„/¯ü¡¡9ß[(¼œ–aÏ±\"+üÙu•w¾Nq²ıcMâ¶ı°¼ä%/yÉkZ_\në»o_s8Ë—-ï²|*ë& uf­È\r6<µƒûxœ|œíÛ÷02<Îİ»i·ÛdYB’&¤IÌ¶íÛ\'MS‚  T*ÇI\Z³cç&&&É¬p›9kf“F³ÉØØhÍ¼yó8ì°Õlß¾f³ÅìÙ³9òˆ5ìÚ½›§6>mD°ÆY»!ÍaÜ(´ù¹ßF{pÙûœÿrÅWè¤E’Äô•û˜Ù?@©–ŒKÆ#ğŒëiÓ¸FPÈ>˜¦©µ˜ZQíÄrtÅ\nl­Qh2»áÍE|0úÙøø‚Ó\nr·6«Ÿ‡òC“ğÃòì‚hã«íÒ_k¥¢ ¨µÖ6ş´ÓÍV“ñÑQFëãÄiFæà÷£‚~ü°B–Øş6ò…aÉoîU)ã·ì¿§Ë—/eÑ¢\0Ø¹s<ú„yÒMJ¹\\åMoş=\Z:ccc´ÛmÚmç–ab `ÆŒ™,:p»vï`tl”Ñ±1RQŸ¨³áÉM<úè&Ê•\n³fº¨\"œ\'6<ÉÃëÖñ\\¸Ôã¿Ë¨C]eDašxùÅòîÏöA¦Ïó˜5··¸‹w¾ıœş{§Ù˜Æîg}ˆ“„á‘	ÆÇ\'Ùøôv¶=»‹ááZíÈF9ˆPÊcîœ!††æğè£Ğh·ò|ßgåŠ”+|àâÄøÁ*A°rå\nªÕ*÷Üs‰ˆRôõÕğ}Ÿ‰‰1”R¶j¿ÿûoâá‡×ó³›o¥µsñ‡³¼ö µ&ğLäˆşş~úJOSÎê¤õ’¨ÁÜÁ<>³fÍ¤æLÊ•*Ah~î7ÖY³èH­ÅÕäj¸`áìˆi‡³Â*ßX†İ¿”Nì;°¶rw¾²±=?\0åãû™† 0î\ZZ›³*÷^Ï}6V÷Ä¤¶ÚŒŒ°uëf6nyŠ‘‰I©´4ÎF}´£ˆv¡”\"Š\"\0‚ (gc6Öq\0ÅÌÁAşğÌÓX»v5\nÍ½÷şŠù?ÿ?2<²Ì¤W(jıDQÛh÷+@–144—eK—òä†\r´Z-”§H’˜$Iğƒ€0ƒı³˜7>­v‹¥ÌÊ‹9tùÌ¬™1Vğãë¯çkÿñ|<¦\"tY{æÊv½õ–ïU\\¤ëàsÖüùİ—û‚ ‚ğ;EGp¦©I²mÇ~~ûƒ\\Ãİ\\wİ<½q+““æ§õfv«IšÄ¤IÄÈÈ06<A»İÊ­§Y–\0›·læñÇ%ÓF`i™hiÂ“O>Éı÷ßOÇôU*ô÷Õ\0M³Ù`bb¥,à¸ã¥Z«2cÆ|ë[ì,‰Ğ	+•Rd6MwE$YF†GªY¦Â2(Ÿ(Ih¶Ûh4a©dD±6Ñ#ŒÕ²c=uÂÖ]_gYî\Zá®YÎhã†Ø:w“0Z·	Ğ¹N-ÄEÍV¼WgMwõR›­p*\\_\\ÿ]È¼8Í‚%Ø¡ĞîQÙæ|ˆm–Aç>R*•Ã¥Ì¦Ì$N/qj’‹x¾	ÕW«UX½z5}}54š‰‰q\"»Ğ™5kGuår™zc’;w’&‰±ÁÛ~ú¾Ï¼¹s9òÈ#QJ169Á3[6³s×.Ö¯[Ç÷¿ÿ_|íÚÙ><i¿ıË‚ ‚0h\r:ÓÄqÂ®İ#ÜÿÀz~ü“ÛxğşGÙµc\'Æ8»ví`÷Î]Dí6³fÌdÕÊUxG;Š˜˜œdlbœ4Ë¨õ³ú0s¬Õj1::Â¸uÉ¨”Ê¬\\±’Zµ2MÔn£3Í@­Æñk_Ãa+W†e|? T\n	‚úä$O=õ\nè«V)—Ë~€ïyÖM¡ã+¬°!àœêÓiQ‘¦\ZT@êàû¾O§´SHµ\"IR‚04Ø¶«|<åÛ—ç›Mp(<›6›Â8Uˆ¬1u–Y±š¡0:ËëÏl¬ãY–å.ØëSH‚¢l„m-ÊÎªlæ¯#‹ŸÍ/vá`ı[Í¦qñğÌñ8ÍĞÊ3ãi¹h­Œøµ~áaR*•ü\0¥AiH¢Ø|Æ.$œ»6üƒƒ38äĞÃ¬u¼#ŞµÎ(•Jfñãû$qÌöÛh¶šdYF­ŸRX@)Ÿ4õÈ2ˆâ6õÆ$Fƒñ‰	²4aû³Ïòßø1ß¿îv6<³ƒTÄ² ‚ /5Zgìá{Å-·İÇ÷?Æøğ8³ìf¼f£ÁØØ­v“(n3>1Æ†Oæ¾°©6Ñ”ï1oŞ<ª•j.µ6‚`ÎĞ,0Â1Mñ•YF–f¬_·Çœ0xÍk^Ã‚ˆãˆVËøµzG­F¹T¦lf8AŒ©.SZç	5Ò4¥İnÛÔØšLû¤”È¼2*¨iˆ¢„f;²\"Œ@6±}ûİG+#š3\0å²ïyx^@vÂ´9±Îî+2­~6eÖ¢Ÿ[‡ó0ÆaYÙë{Ö¨¬\n:Ğ³şÂI’æ~ÊEœhÎûâyd©	%¡íæA¿’hLx^h·2š…†k_å	`´YhEà‡TÊŸÙó	ÃĞljÔ&qJ__A°sç.~òãi6Z6.s§İíÛ·sÛm·‘$fc vq‘$	+W®â°ÃÖ%víŞÍƒ=@³•ĞnG´Ûm‚  ‰búúªÍ™ËÎíÛxø¡õüûW¿Ïºõ{FbÿD6øM;Îƒªûc/C=•ò¯Sœlÿ\0\Zõ‰Ş#‚ Â4 ”¢\\­õwÑ?0‹MÏìaÃÆ­ìŞ5L»Ù&ÕÍV‹ñÉq<«V¯$bÆ“´£6íV­3úúYµr¥0¤Q¯31>Î³Ï>Kœ$”Ã3gÌ$|²4¥Õl±}ûvêõ:¥R‰%K– ³ŒfÔ¦E¤YÊŒÁô÷÷³{÷’$¥VëgÅòe,_¾„¨±îáu´Z&™h´µX:«­²÷ìP.Î°V”Je<Ï´qçPšÀSTJ!}}ôÕ*”*U‚R`Ä©ÄEáë)e7¹ÙˆIQ]ô-Zw§Âlg3uœ íú\'Ô–™Œ}.ô›ÉèÎqø¾Ÿ_O¬Í®]\'NÓ4¡ÕjĞœ¬SoL2Ñ¨Óˆª2‚W&É2â$1n\Zö\\ß÷\0¥<³IÒZºM¹©>Ë^Ê’¥P\nšÍˆ»y?í(F£qÑîV¬XÅÌ™³4Ê3)³«Õ*«WN«Õ6¿FŒM0:6J’š~\0(Oãû‡­:Œ•+W±cÇvìŞÅÈÈ(­¶ñŸ£˜İ»¶Å“ùøLÅş°ÁïwÿAáwˆ­[v±mëNÚ&a269ÁÈØ»vï$#Ê•2“LNN mJéÄŠÕZ_ƒ( ‰hI¬¿kµZå5k×24{ˆ4N‰¢ˆz½ïûpÀyä‘T+Uëö\0™ÖŒŒŒğÀ099ÉAÄšÕ«™18Ã¸>k¯q&@âãu|‹=cØÅ”8‰©×ë4[MP>*¨¢½²ÉJ‡	Ÿ†µ­ÆIbDï‘Y+¬²İ|UÃéUßYı€ ò1ÕÖŸØ‰=\'hóM|Ú&÷°aëtÖ¼J®;7Ë22,Ò1ì^Å2€r¹Œgı‹`Î’ÄD%±™Q¨Ï/£Üı[·“ÑD³0Z^¡0âİø+wäZ\'(<ÒÄX±=Ï#ôë¿‘e¦?Ì_ÈààlĞÆe&´À²eËXµjW¢Ùl099AšfAH­fúŸflÜ°‘{ùK\ZIÓhÖi¶\ZDQÌÌ™3	m2–ıË‚ ‚0dIB–$6õ³¦5‰âˆL§Dq›=Ã{xbÃ“´Z-|å±ô %¬Z¹ÏóØ³g7÷Üs7Û¶m2”Ò„G iñÀ÷±yë3d^F¦Rğ!%ext˜Ûñ&\'\'ìëgŞĞ<ëjìixJ±sû*ã¿Z©”ÂĞXe=e²âù!¥RÅ¤`Öi6÷ÙB+M+nÑÛDIB;ÉHT•L…fs[ªImÃÒ)<?DyaX!+¨ Dù™²>Åcr’¦h¥ĞG†ÂL¥Ì:m]Q<iœ 4è4C§ÿeW®lœâÀğı€ (áy&\Z†§üBØ¶në±RfC¢¨À\'(•òĞ|®^–¤&›Gj1ˆ2b •Gèû&·Æ¸Ó(e,Ù€ï&)Š§¬8VDwa ¡\r[§”qÍI3ë\"’‘¥š|õë×ƒç–*\rÍÃJ´£„ë~ô#î½ï><ß¤÷<ŸÀ	ƒ“N8U+V†%²LÓhµÀÓaÀP\n|êu³ùôÕ‚ˆeAA˜Fš­&“õI¶oßÆæ-Ï €ƒ\\ÈÑGiD^–\Zßß(¢†Ì5+!G‘±&[ßÓµk×rÄG Œ[—Œf«À‚²téRÂ ¤Ùl1<<B’$¬^³šU+Væ1‘ÓÔ\\oË–-LLNf1Ê3â3TÊˆim3ÃQj,·™õUvBUÛ˜ÄÆ:™ĞhµiÅšÔ+‘zeü°j,¥Ú3ÉM2GÙfö3ô¬<qÚøzë‚[„®¾q—Pİ}‰“8÷gNScQM¢ØX—­uŒë‡ïùFp¦&æ1v&ÖÊìÚ5Vnë[\\C‡ñQv‰L\\¨İ&MSvîc2ñÈ‚2xŠ81ãm’•$vÌximÄ±s¿ ËİÃ„kK¬ëF–j#ª}0X´hï~÷»Y¶l09Y§Õnšò–·¼•A²ÌDèÈl4¥Kæu¯{=(hÔëüâwğìÖ­Æ-ÅóÌó‘e”Ã2\'¿îuwÜqø¾bóÖÍçc¹?#bYA¦­iµ›´ã7¬<DgìÚ½›85ó*•\nAĞlµxxİ:}ôQ#Ø‚€Z­F¹\\¦T*Ñl6i6›(¥ğÃ\0|ãbQ*•X¶dsfÍA§ÆÕ Sfsàc=Æ]¿¼4,;xK—.µ1ŸÕI0R*”K%|ké41)¬XU\nl9÷r.\rN0GQL’¦d:3Yç´&%$ÉL’\r&ÎCgf£š³n{A€ï~@†6!G€R~¾¹NkMf7Ş‰¨áY1K‹„#¿û»gØÍ|F\0·Ï·!ìlè¼ r—“0ÍB\"0.Î]$MÒÀÄ6Î2v\r³«Ñ?\0||¿‚ç{DqLdCÊ™û1•µ+»\0ÀŞ£©cÚõıĞrÏ¦ùÖÆ:<::ÆÆ\'Ÿfr\"¢TªtÜh4ìÚµ‡[o½•±Ñ1ÀDßp\'&š´[	¥°„ïû4Û-&ê“$iJ­ÆêU«¨”+4\r®ûÑxğÁÍâÆóğ¬5}GÄ² ‚ L#Ifb /Z´ˆ9sç‘fÆªûäÆ\r(¥˜7o¯{İë™3gN—uÔó<æÏŸÏßø<p!Iœòğúõ<şÄ“(åQ)Ué«ô¨€$Nxxİ:yôQWÃ¼¹óMâ“ÑšíAÙˆ®f³iS){&v¯6ÖÒ,3±w]È8ßğ=ç½l®Éªg„\\nµuïÊ¸¸ÈJAê…´2ŸÌú(åkI6\"ĞnöS>\nãí|Lxê¼håáùa©B\Zá Œà|ü0Àó}Tà+rX\"K„aÉú—ãÎa|£5Ø¾Y—kÚ¾R¡­/.Ü\"\"ÕI3>>ÁÖ]#´=?,£=Ÿ$MiE1q’Ğj7IR36¾ï›ñ±ß³<\r7Æv­ÍEÓ\'£œÍ›ÕqÓh´¸ı;&LÖEóüh&\'Çyúé\'HÓˆRpğÒƒ©Uk ;wîàŞ{ï¡ÑlÅ	iš§	JÁàŒœpük9`Ş<Ò,£ŞlĞh6¨õõqà‚…¶û7\"–Aa\ZIÓ”R¹Ìì¡Ù”Ë¥\\¹Ÿùã8áñÇgb¢ÙÈ	²z½Îƒ>Äîİ{¬¨óĞ€çù,Y²„“NzÕjZÃx}‚z³]¹’#4I)L^;E«İæéMO3::B_µÂª•+¨UkÆjˆQ2é}Ï§\\6\"3Bëom,›yZfû?lÔåyd\ZÌ6s<ÓãqFKû(Û†o¯áÜ<+:•Rø	OçùFì:7\rß7!ÔÂ°„òü „_ªTªåŠ‰ß†¥A¹„„•*A–Bs\\ù”J%üÀdî3~Ó~€R&åµ}…ah²ü~§‚uÙÕS@Ü¨OŒ³kd˜íõ¥J\rÏ+¡¯ÊHlh8›t;·‚£v$ÖõÃ÷ÍFÆ4ë$EÑÚXìAÓ×Wå€@ac7£É²„¥KóÎÿöfÎÌûçùŠşş~N:éDV¬Z‰„&K¡~á‡º’Å.­Ùúì³|ûûßcë³Ûñ	Ä%wQJ180`ĞıIw=í¸•b÷Ç^:‡z*å_§8Ùş±IºkA„Wï¤»®”gR\n«V«U©T ŞhäJ¬ÅqáÂ…”Ëeyæc¥µâXa\"RdIŠÇ1FƒÔf²Ó6\ru¹\\µ~»Aè£0~«Æ?XÓßßÏÒ%±õÙm¬=æhÖ¾’v«ÅıôV6mŞÒÉ~—ËcššïIš’¥©³€RÖªìÙ$#\ZJ¡‰ú¾ò!‹X<w‡.œM%ğ­Ïm¥Z±Öj@y&2„ÖÆúš¥&nqáŸ>¯$D)Ï†·+DÀ@c<}›‚sÃĞW­Ï#SßcçNØÈ¾g$Z‹·W°*;ës–™ˆq11:ÊÖÍ›¹ã‘Gh¤ŠJ¥/0–e/¨’d!­85ÙõÌ\r@a±ä¬ø•’YHi³Á+år™ã×ÅÚ×:er²É5_û[¶ïÆW>™ÖøÇŒ³X¼è úÕı`ı½Ñ\n¾A¢(&Ú6,èaòÚã_C£Yçû\"IS›àÅ¸¯Š±Ña»0ŠIÓQ;#S³?¤»±<íˆXAØ_y!bY^MìbYÜ0AAaˆXAA„} bYAAöˆeAAAØ\"–AAaˆXAA„} bYAAöˆeAAAØ\"–AAaˆXAA„} bYAAöˆeAAAØ\"–AAaˆXAA„} bYAAöˆeAAAØ\"–AAaˆXAA„} bYAAöˆeAAAØ\"–AAaˆXAA„} bYAAöˆeAAAØ\"–AAaˆXAA„} bYAAöˆeAAAØ\"–AAaˆXAA„} bYA˜ŞûMîÛ´\'oú\\ï‘)8‡+îÜÆº\\aßÿÎ–ë»Úø\0_ıÕ6Üt+Ÿ-œ-‚ğR!bYAAöˆeAá9Yôş/òınäŠ÷Ô{èeä;\\tÂÖüáEöı÷VA˜D,‚ ÏÉO~«WÎ‰§‘—-zÏ|ÿÎGyrÓ6Ü´û~q\r¾´pÒq¹Xzÿò­Ü÷¸iãÉMÛX÷«¹ş‹ÿ“A\\,Aø­@Ä² ‚ğœ\\ó·ïå³W|Ï~æJ[òzşæ½Ìê°åqócc.z3ó/Ç¢sŸ‹ó>ıYşüÔC)?Á×ı\'ßÿÙÃ´ûæ±|Õ¡½UA^1D,‚ ÏÍÓ?ç‹—şß|ÈœÃš¥ÀÓ?å¼wş9ï=ırî‡òŠ×óî3Ÿ“k¾»€ñ‡¯ä=ÿı\"şæG;h°ë‰ŸrGoeA„WË‚ Â¯É8í¤ğuéAÌèÚ-Ú…âçåÚOğıõmæúI¾yÙ¹ş½™¹Ã?çßşşk½5A^1D,‚ ÏÉ¢ı€ûÖ?Ê÷ÿáõ\0¬ş³AÊ\r`ÑZ>{Ù5\\ÿƒX\0åCùıï_ËW/»‚~ı|Ê\0ƒ+øçË®å?¾óÍî²ÿ>ÿñïÿsŸx‚qfpÌŸÁòÁ6îÛÉš]ËW¾qÿ|Ùë™çÌàË®à[×İÀW.[Á`w÷A^VÔ¡‡®Ò½…ÂË‰šòc/C=•ò¯Sœ¬LÙîÏöAxÑœuÕƒüó[æ1~Û\'8öªµÜ|Íwû&\'clùåOY7ûÍüşÊ˜>Ââq I ºJH\0Æw²~İ3®9‚Eƒe\0š1T{É\n&\r_ã7}Änü;N|‚o.9…÷œ2İxÇÀ¬¹½Å‚ğª%ô}óAO%7mÙ^‡LÁ^ÅEº>gÍßËÓˆeA~×8ˆßz(c×ı”õïı&÷ı¯×3øØÕœuú\'Xß[õUˆeAèfËâ†!‚ <ÏpÇu?íÆãÃÏì[(ÿñ¹cÓÓ|ÿ2ûş‰Ş\n‚ ¿;ˆXAA„} bYAxiùÏ?çÄ%K9ëbûş™Ş\n‚ ¿;ˆÏò´#>Ë‚ û+â³,İˆÏ² ‚ ‚ ìÇˆXAA„} bYAAöˆeAAAØ\"–AAaH4Œiçå†Ñ˜ë=\"‚ğŠsäÒE,3«·ø%å›·ŞÙ[4­H4Aèfˆ†!byÚyùÅòN>¹÷ˆ Â+Î¼²ÇšaoñKF¢áÃW~¥·xZ±,İˆX^/¿X–8Ë‚ ü6rìò¥ô•K½Å/)?_ÿxoÑ´\"bYº±,¼D,‚ ì¯ˆX„nö±,üAAø­à~²ßÅ5ôy>>Å\r¯gã=WóŞŞCSñGŸç®Çïç—Ú÷Ùò®æÇ×óÀWşÌüší>ïıÊ]l||=7|¶÷È‹ÄöuãO>Õ{Dx‰±,‚ ‚ğò‰ÿ¼Ÿ·~ËíûY½„ßYD,‚ ‚ğ2³ˆ÷~şÛÜğŸŸç½Kz½|ïC¼vÅ1üáÇìû¥½¡ƒˆeAA^fNá\'Æ!‡ŸÀßÔ{ì9(¸\Z,ş“K¹á®ûÙøøz6>¾~våsï%oå_¹~eêoìr¯xéİ>óÇÇ°ì”ñaûşıÏşpïköğÆ]Ù¹§õ÷sËW>Êó£‹8ëãWsË={~Nw%oåÿöÃ®û}ä[¹áÊq\"°øO.å·\ZW¯ç^Ê{kü„Ë‚ ‚ ¼Ì|èR®¸êR>{uï±@ß1|ñãg2oä®ÿî­¬ÛÕfpá)|äŞß[ÓòZşáŠOóŞÁö»¸şİ½~ø(ù³S8¤o‚u·ŞÈ}»añ	ğW¾\r€?}%ÿxÁkYÌ.nÿñìê=½‡÷üı\'yï)Ë(oäöÿïßúí¾9²rğVş÷Eg²æ\0Ø|çÜüøƒ+Îäÿ÷GYÜÛ°\"–AAxÙÙ|ç—ùÜç¾ÍºŞ/„Â?Ê¾åşòcàÿäF6åe\'ğŞº\0¯ûN\\Q†]·ò™Ó.à/7Œ÷Öxixİ¥Üòb­Ó¬fq\0ã÷‰?|ï‡8÷sw±˜»ôhàµœÿºe”ÙÍÍŸ=ó>´çK7öÕŞÏ.`ü‘«9ïCãÃ?ŞE;€]nåN`Ñ\\`ã\r¼áüqá™ßb]å…«ùıŞ†„½±,‚ Â4ó6¾ô‹çq+(²ıV>ó±ëØì¾ojÓğ¡ÜUÑ²b\0Q»sÎËÁŠ¹Ì\0Úã/Ârt]¼r.ƒyùa\0´hoï®·O¾ıi¾÷H›¹§|Œo]úynøø)Ì¹‹ıÔ·{kÂ›1/\0RÌ8\nÏ‰ˆeA^YfÇ’ù/_V7A~XÄG¾~ÜómşáuÀÆš¹Àî-ü[oUJÌ{İ¥üçw¾Å5¯›kÄ°?—³/½”Ëó×r#†÷ÅÕëÙÜÀ?|åó\\¾|€ò¼¸üË_äß/½”Ë]ÛË¹üÒ/ñÍÿøR§ì…2lD{ùè?á†+öïÒüš½ÌX~)—å‹\\sD™±—ŸÎåÿöm¾õÃ(Ófİ/®¾ÌúgÚÀ\"Nüû«ùw¿Á\\NºôK|õ+=ıÿò¿óÍ/ÿ5ó6ldœ=û4lóäı»8ü‹ïıÇ ŒÃ—>5·\\z\Zs]÷ÿ¯övPØËÂ+ÆÂ“ÏçØç‹İ¿êBŞuÚ©œrá…,ï=ö‚XÍéÏBû­räùœ²ª ÌŸÏ»ÎZ½W½½™Ïñ¾ŸÕG¿Ÿw<€…\'_Èñ/ÈÙëtŞuáéæãñó®ã{¿Vsüi\'³üäó9j¨÷ØKÀoÔÏÂıîÅ «Ï<ŸÕ}æ[íè÷ó¾w¬¡ÙÃ}\'sÊÉÇ±úÌsY,<ëbN_\\œ§—šçêk÷uó¾ì‹çyV½ğbí-|òúÏ7Ïsİ}òœí¾”Ïìj?ët^Ç´‹ß¸ŸÂËËQ²p€òà\"-f—)ã;7ôVÊrÊ™}ØjN:e™„sæ¬³Ï,¼æ¹ÿùø\'şç•·²¹1ÀâNã¬£ç\0P^v\ngt4kÏ>“³ºÚ>£8¡SöBùŞ§ù×›¶ĞN8ä”bÿÎÌ¯ÙËÜ£Ïä¬ãæ¤³fq`¯ÊaÌMwsß×ş–ÿşÙ-\0|æ“WróÖ6ƒK^Ëï»ûí[ÆÏ>cëéÿIGrÔIgrÖ™‡18¾›uw>Àæq8äMgrÖI«YsÌi2hÏÿƒ×²¸o‚\'oü<~`‘¡ù^\0\0}»IDAT\n«³°\"–…WŒÑ­ëØ´§·´‡G¿Ä×o¼—\r<Èhï±AkÇ:6m‰{‹_\0;¸ûKW±~ë=¬¦	ÀÖÇdÇHo½éb;ÚÌ­ëØòŠõáÅ0Î¦õëØÑ¿‹?^½¯]õ±sÒÚÌ¦­[Øñè¼ˆ5s¼AfÎšÚ\Zô¼ü&Ïjß|f¾Ø,ĞS^·Jmhˆ «â+Åv¬œçûSÿµùMÆLx¸¿|ÏüåşŒó¾ÚqA\\|\'æuŞÆ¼€-\\Áj–­ZÍ²ÏóZ{µLÿ/Nïúë®ø\0o8ÚÔ{Ãw\0ÿÅ§Y¶â8Vö¶³b5+Vw>}ş—m+{·ÛÍşí§sXáÜŞ—këßÎm§|Íq{Õ[vô)œû÷W“‡¯âÂS1ÇNû¡)¹‹¿[±š5kz¯s+Üçµ§ğ‡çÿ	oXkÏ]±šCz¯µúµœ~ÑU/ÎüUˆˆeá•aÉÙœõoå/şçİ{Ğâ-åØó?É>øQŞ~ö)˜7!•~+f*CT<àè÷çmÔVŸÏ{>ôIŞwáù¬ì/´ÔNº˜œûûœş¾‹8¶çØó‘·ûgïâÄ£0ÿÈµ,°\\_¼Aj•8•sŞyjW¿ı\'púû?Å>r1ÇŞjNú³Oğ~Š¾óT`›êk9uù{2Œ8ê¯ô‘4ÿ´÷sÊ€¡.â}ù$üÉ[²õ«ßù~^­6ßã8ıCŸä‚¿ü$ï;³sfíè¹àƒŸäù„½^%gó®‹>Éû>Ò™ç%Ç¯e~óWLmş©üÉÅŸàœ–šƒÙÓl\Z<›Sú¤ŞÕP)Úœ[ï|?«í|ï»¯ƒ,?ó£\\ğ¾s9öøs¹àârÒ¯c\nòYİÇï5—€·‚Sÿòâ_û¹œêºCÇ_Ä}€×­}+ç|ğ“œµºP¯8ÖÁ·òö‹?Áü$o?ş×¹éBÈÂ7œÏ›şğ|>ğÑ)Æb*¦ú[ºè\\Ìï9+8å\"ÛÎ‹3á•cÓ]\\Ó#æóWÈ}»€…§ñ/?¼’Ë/ı<×Üø1Ş8Øô\0_ùEïÉ¿.§pùoå†¯_ÉåŸÿ\ZßúƒEÀßúµŞŠ¿µ¼ñŸÈ]?ù\Z_ºôó|ë«§±ìq›x±,¼Ì±úÜOğ~‚Ó—8÷‡Eœò–…<ø/—ğ¯·\rSÙ‡u¨òº·³fÓ\\ù…¯³>ß|(§¼ãlO?ŸS¥>ÛÆ\n^wr•Û?	ÿzg•ãß¸¢«½úí—qåŸá_¯KXÓsì¹9ŠSN­rû.á_oÙš—Õ>*Öt—÷eáÙœuú¡FÔ÷½X?Ü¥œò§§ÃO.áÊÏ]Æİã°ğÌ³™÷?qånc·k7è£Ru¶Ã“9ë\'pä;ÎçÈ®ş½7µ•¯~î®İvo²³Ò×GÅıœäã{/7|ş®ş—ËY·ğ÷9\nÀ;³NæÚ/\\ÂhæãaXÍégÌç¾yv×İqãg¸ò²Kø×Ë®bÇ1ç˜ö(^o*¦ns*}ó¡<ö/—på7ÆyíY\'?O_ÇIJ	›şóKÜtıWyp$æ„ÄÔÏêÔc<å\\NŞÆw¾¶™5|ú^õŸ‹©®[/—ıÅÿ—®ÿ\n·ojGÀÑç°fÓå\\Ù;Ö\0ã×ñÍË>ÃÕ_¸ö1§[Qú\"è?™³.ú¼è],tÿ²ıoZ|W_v	wïÙ{,¦bÊ¿¥JŸµ’T*¶9fÂoßæÂÿu5·o`pÅ)œuöiœ´°ÄøÆùÜÅãŞê¿.G¿–Es8ä¸S8ëf.¬ûÚ%|üÅ„­{E8š“Íeğ £yãÙ§qìøk|ò9‹·0ˆX^±|•±¾VN¾×|‘+?÷]8ãBV{\0ƒT²	Æ²Şóº™1#¤5öá~¼)~dãÃÕ³Ë¸‹Ç§5»ÇºöœÌ¦ßgôyúæ/jŠ^½ *KcaÀÁÌj2Z¸õı­úq	Áï-3ãRÒì…´ñ|Œ³a+¸˜5HïÃ\n<D­ÔdòyÇm­öÔİŞ›Úæ<g_aÓ\rë:÷|VŸôW5zw7zkì›ç}Vìs.w}u¬±#/Œ©®ÛúÅõÔOü+?ò|NŸù ·>iÊƒÒ Ã>Çî^65èİÂÜãX>`ãß}2£_»„/ü0ät»p£¯&ŸÏcÅ>÷Ï×—]ßcGq¤õ~Ç¸éŸ8ïÔ‚kÂêc8ú-âŠ‡{+¾ø\'Î}mÇ\raÙ¯å‹.¿õ<ÀgŞñÚ{Çêc8ú?Í÷7õÖ¦hhÎß÷\n/\'jÊ½tõTÊ¿Nq²2eúDï‘éeÁ[9sm›‡Öo#˜s\'x\"ğ07İ7Èï½ûTæ°’‹eíkbñÂ¹x[ÿ‹‡;Ûœú³°òœ÷ğš•3ÿ€¹0{>s^sË<EŸÈáó|J+N`åâ¹,XtóZÊĞ¼ÅºæXò«ïü„mÑ\\–¿ş\r±j%K:™£:‘5GÀÌEGpÔŒù,8f%sêsßc°ü˜Ùuÿƒì=z[›q:gıÁëX¾x.óæ-¢6kG¬\\ÂüÅG°`ù‰¶l>óÁG\r‘•VqÔá2÷ÀY<÷ ½f5{Ïrçı`á‰ÁSŞïš?:¹ëogsü4ëÅIúnVÖïåÑmvÈÉgÿ‡®\\Ì‚d`àP;v9\\Ââ¡ƒYrÂj–x ‹}‡3OxÏŸkûw\0s­`ÍÒc8êà*ÁÂãY¼ôµ¬XÛn»“m½Xx\"¿÷ÚY¼ò\r¬9dßã8ríëYsÔ‰,™=›ƒç6¹ó—÷Âª?â-¯9–%ç3æ|fëî÷çLÌıÎ8u-Ë—ÌgÁ¢™d¿Ï1«æsàÁG°ü5\'²æğYsÔ‰,;p>|3z#kŸŸ_oÕ²™Ô×İÂâˆÏòğcuµ¹¯g‡ş“yÍëãˆcÖ°rÍLúé·Ø´mÛÔ}=ğ@/ZÅŠÃ1cp>KçùDŞV.^Î’cV²äÀ%,;äµ,?hÀôe\nM<õ³ú{V¸¯5ËÍx?TœKïYî|æ şàíçpÌQÇsàÜù¼æ vêo{gfÊë®=Š¡¾ZÚOÏbÉ²å,:è\0¯:‚Å«OâÀ­?à\'ïêã£gÍQ\'2Æ|V­=„ù‡-gñxfç¿é<iÜÎc{ÊÌYó{{ì\"¼Gş“úÏæÜfŞòƒXtØIµl\r°¯çí8?!ã¾{%WÎ	GË¡‡Ï§T]Á1GÈPuœõw<ÈsY~Ò!4¯rt>f5Ò§naÃÀ¾û9(¥(Wk½Å‚ğªÅ÷oÕûÛ:ôĞUº·Px9yùÅòîÏö™^†Îå‚?\Zçê/İ`¾{ƒ{ş‡™sı%Ü°÷¿”‚eõŸ|’E·]Â\rÎôQz+ï9/æ«núÎæ=çñÕ¯ü¬Sö\"©-\\[ß§¥Œ¯ë’¥MÆâÄ›§ÎK`Ó“O÷Ödù¹eù/şiÊ9®¼á£üáÄ?ñÍûz¼x«Í…g}”#ü\'~¼+Ìsõõ%cşq,‰¶ô%lİ:…uõ%œËßo)K–N°iãı|fö	ş`ìŸøúİÖR^9w½oˆ›¾ğuvôVŞ\'\'sÎæî/|…­Ï;7«9ı/OfÃ¿\\ÅT1~ğ<YÏ§A^M„¾ıİPO%7mÙ^‡LÁ^ÅEº>gÍßËÓÎ«@,3Äêw^Ä›—öá{@Sß|_ûÆmÏ-Ì^í,9—÷œ»–!·¨Õn°ã§Wğö0ôæòö£	³qüÏË¹uÓ?ãÿZ²úÌ³á¦¯°ş¹Ü\rúNæôaKõ`[÷(N9s»x-€ÊÉœõ¾ÓYRÖ^s¼”SŞ÷ç¬	Œ>È¾ø-¶îÓà…òÂÚ\\xÖÅ¬¹ÿ²ÎÂƒçëëKOåÈó9§¨·ºñ‚—a._†NåôÕ;¸á¶õ½G›ş“9çÏßÊ¢šq£Iã[n4Ïì¯ÃÂ7”?|Í•ô9ş[±ø]\\ğÎ£à‘¯põÍ~N#\"–¡ËÂ‹àÕ –\rC«N€Mæ>Åc›¦øíZ^&f®=—%O}‹=Í&¼(±üğ€=¨m¿“­Ïµøz bYºÙÄòï¾#‰ğ[Keğ\0fRûµ\"¼ÂoÎè=\"”§Af\rQ”¨‚ ì—ˆeyÚyõX–A^mˆeYºË² ‚ ‚ ìÇˆeyÚË² ÂKK•ù«V0ùèsd~œ&Ä²,¼Ô,™3³·è%gÓîÑŞ¢—ŒıÁ²,byÚ±,¯\ZV]È»?ÅÖÅ³õK_ê	w¶šãÏœÏäØÁô?}\'3O[Ëº/™ği/„c/¼¾tSDÎÛ§ó®áë_º¿˜wq_¿»§Êsö÷Ğw2§¿©;úÇTt¢•¬æô§ºïãøƒfÓæƒY²ùŸøñ£]»£x«9å}ç2ÿWßà;·?şœùˆ¦ƒçË‡Ş•?Q—w¬œOÉŸâßü—ˆïÜÿ8÷<ñToñK†ˆeáE bY^]²ğØCiİw/İ{MÌê­%fì\n8îÏ¦û¦W,ı‹(G[¨G=s^€X†çèïôÏgfcG!»e1÷q¼é¢³Y5¡vÿâk|çNŸûùÅ²¡²äT6~Æ†]İåó9êü÷3tıåÜ´ã· ßË}µşŞ\"AxNŞyüêŞ¢—”‡6ïä)bç¿TˆX^\"–áU·”cÏ;Ÿãg„Tæsë\'°]ıÎ÷Ã7®b=À‚s9çğ‡øÎAG4ºó†vÜa¦·š“Î?›#ª„»nâßøYG,Ï=sŞ±–`óSŒÍ<”e¸ò?·ïİÆó‰å)ûRé¯Òš‡Ê•h­#ßÏ9\\Åw0±Á/8£®úŠw}*ç¼¾óŸ!3y=+fóø}ëYrŞÅıø3Ü´ëùÄrÈĞ	Á¿n¿<ÄØ}ÈôóèÎu;çŸÊ9}sZ1ÔŸæÖk¿Âc“…{zx>±,¯6ö±,üA^*¯{;k6]Á•_ø:ëÇ\nå}}kA•jĞ9pô9¬Ùt9W^v;9‡£€…gÍü»ÿ‰+¿p»ûÂîúõ`ä6¾ùı¯sÃÏ¦5§lãù˜º¿‡rÊ;Îf!°ğôó9e!Pê£R²‡7}‹«1Àég:ËWHÅö¯rò‡yçñ}´çş>o?ó`|´Éüƒ]»ÏAßéœqÔV¾ö¹KøÁÃ…øìÅëæüŒïüÓÿâ_¿p	ÿzg•ãß¸¢·‚ ÂoŒˆeA„—3BZc/.OP\Zb°î\r3úZõ}¸4nàöÉ“yûI\'óg±î†aŠ6çí¯×#êıŒ­sÖ²°§xÆxöëxğÇ÷09gQÏÑç`Æ A}Ï¯¿Qo¢I²¯>\n‚ üˆÆ´#n‚°?³ğ¬Oñ¦Ÿá«¯åœ??•ş‘&µeC¤ıŠMıóX²h>lyœ\r#3:`63w|ı>œşÁw1l+£Ş<–˜°uO@ÿÖo™ÔÎKŞÅg/br$dá\"ØğD“-´3w€¡\Z´³	&\'€ò\0çš6f–’h˜İÍÙ,îáò}¹aôŸ<EdÙ¢Aê[šÔf@=‹iyCwıO¾>|.o?i1\03Í‡-O³Ù,_[ŸÚE\\]ÀÒaÇ3	óÁÖ‰A²ƒ§¶E.bÇµ—ìÃ\rcˆÕï¼ˆ×Í˜ Õ¿¡h===ƒ¡¥óç/¦6¾ƒ\r[Ç˜9g†9­ìÆò•M…-n‚ĞÍşà†!byÚ±,û/!Ç÷´¾vë§²èÎ?%Ñ’¾„­[ŸwûÜŞôÍ{Îã«_ùYï‘ıo)K–6‹go~ü×·:O#\"–¡›ıA,‹† ÂKFÌ}×ìC(•ùkX²xkYık¥†zóGùÀG>Åß(›nùyïáıŸÊbV¼‚:%}½A^^Ä²<íˆeYaE,Ë‚ĞX–AAa?FÄ² ‚ ‚ ìË‚ ‚ ‚°D,‚ ‚ Â>±,‚ ‚ û@Ä² ‚ Â~H¥ÄQK°|şP^vÔ’µdı{çöˆeAA„ıŸu*¾ò8õ°e<o6\0ÏìÅWï<á(]Ú›¨^˜\nË‚ ‚ û‹fÏàÛw?Ì}Ooå§ë7pìÒxÛkçØ¥æeµ²X˜ŸIJ2íHRA„ıIJòÛDÓ>v9ï^T§î‡løöÇøç›êÔŞô.}ç*İÌ=ÿ~	x9<6d¤^bV|ÿğ±/±ùMç²w/¢^/QzêZ>öõ\Zù»sXÔ\Z!¬±ùß?Ì?Ü4›·ÿïOrÚ`µ:wü>ÆÕ\\È?şé+¹æ¯?Ç½oú8—½Ó´U¿‘Kş.ü»Ó˜?ÅÜñò¼[ÿìr¾÷–ED)ğÔwyûß^µù«ÿı×¬İs%öÙ[zo¸‹E³g°rÁ\\~ºîIŞûÆ×ğÓõxjç0³jU]ºƒçÎâ©]#l›`İ–½§¿dHRAA„ßŞğI.ûøì—ÿÆîá¢¿ş0ıã£,?ã¿Qã­üÏ·ÏâÆ‹ßÇE»„«„{¿úÿâ¢¿¸ˆ‹/~·x\'rÆağ3qï__ÄÅ}	üVŞ1q#ŸûÊ_\\üa.úÊf–½é­pÔ;8­v_|ñƒˆßö8éHúïú0}ì\"n­¯â¤“à¸×.bË7.ââ‹¯bã¼“8mûu|î¼‹>vßräILy^ÍÙø“syû»Ï5B™ùœ÷‘·?3Ì±7£˜ƒçÎ`¤Ñd´Ş4ŸëMî{z+#&w\rÓW\n{Îz±,‚ Âï<³–É‘C%J•ùyÔ‘,ª¥‹*-â¸“döDe¿œË>ûqÎ^Ôë¬ú£÷óş‹/emı~ô•ÔÀŸÏâµuêC§qŞŸO¾u6Şt4öl ğàZ7İÎğÚKùÇO_Á‰Íëøîípëí™ÿöËùÔ¥ïgşƒÿÁµÔ©×MÛ§#O1åyÇÍ+1ëØË¹ìÒOóş×ÏvpÍ%ËUãqÏOÍÉ\0Ï›Í}O?ËÛ^sx~l¤ŞäÛw?ÌS;‡ùåÆ-…³„©±,‚ Âï<Ë?‘Emp9\'®=’Ã†şƒkï[ÌßüŸåŠ·-†VÑ0$‡ùÑß~˜‹¿\rg\\ğ\06>|<¹™hŞ‘œx\\ûí{X|ñÿÿsÙ;XÌ$“£ÀGyèGÙ<²ü˜µİßµC–3»ş(w<¼¬åˆƒ`ÕÁ‹aÛ=ÜûdÚê“8€\Z\'~àÿÍiõïò¹[¦>ïÖÿûÃ\\ô×æâ¼ƒEüÔº/ùBøö/æÜ×ÎS;‡yj×}ë)ÌªUyóšCxÛñ‡3«Ví=E˜Ë‚ ‚ üÎsï÷®âª{v0²óv®úâ5ÜøL;¾ø1şâ/ŞÇÇ`Û£<4Z\'nÕÙ°s’Øï`dÃCÜúƒ/ğ£-óYõZ¨ßuÿ×_ş)ñ·y;xôA ¾™‡¼‘«?÷²–#Ÿ!\\L\ràM‹	÷làŒ7-cÇ¾Àw¿q	{ÿ,NzÓ*Îx-ÜsÉ5|÷ÿ|˜ïî^Æß`„òyƒ×ñ±Ko¤Sœg,Şu€=7³e¼Æ¬Cºï÷…0RoòÓuøè[Oá¾§·òo7ÿ’÷¾ñ5Ì¬UrkóÜÁ¡Â_eÈ¿iG6ø	‚ ì¯È¿ß.ÎøëË9mQÈ¬ÚşıcŸåÆzÓ>v)o_WB6óclxÃÿÃ«#D„Ì\ZØÂ¿ÿÏrã>Âeo\\LifÍßø0ÿĞú\0W¼{Q=¦40‹è®Ïrñ—ë\\ğÙOsbe„¸÷\\öa®]ùI.;c>õ	¨\rŒpãgÿ–g\\ÁûWÇÔ[!µÊF®¹y>|Û|¶l1Ür#ûÔq{Ç{ş•7Î¨Uf1kä:şöï®eÀŸ]Î×|‡?y\r~EŞ¼æ]z ßú¥q½p»t!¾§^VWŒıaƒŸˆåiGÄ² ÂşŠˆeá·•Yµ*o{ÍáŒ4š<µsÄFÅ8ÿç¿î¤Şz«¿dˆX^\"–AöWD,B7ûƒXŸeAAAØ\"–AAaˆXAA„} bYAAöˆeAAAØ\"–AAaHè¸iGBÇ	‚ ì¯Hè8á·‘×¯\\ÊAC3™ÑWa¬Ñâ™=£üü±§{«½,Hè8AA„—„Åœöî³9®·øw\Zµ\ZÀZÎ~÷i,ê=ü2óŞ7¾†rĞW\n¹ëÉÍ¬Y4ŸrğÑ·Â¬Zµ·º0bYvÄ²,‚°¿\"–åß„7ğÉ«ÏaóæêŞCÏÇ>Âï\\F÷SÛr\r_z#ÇıõœwHL\\±)«Ç/ä²¿\\KiÏ$áPÌÿøa®~Xq6ÿó½§1?­…5úëqÍ¥WqG½÷\"/’?ş4—-¸–‹¯XËeW/â;\\Â­½u^&ŞûÆ×ğÓõ˜ÕWeV­ÊO×=É±K2«Ve¤ŞäØ¥òo7ÿ²÷´—”ıÁ²ì\rÍùûŞBáåäåËúDïAa\ZPJQ®Öz‹…¡7ğöÿ”wıŞ*ª£òÄÎ˜ÚkÏããù¨¤ÌY<—\'*ñ†³Ä—sÆ»ŞÌœÖı¬ß\Z3ëõïà½ï~oY]eäÑ\'Ø×8òŒ÷pÁ»ŞÆëç¥¬[¿‰?üÀ…T¿û>qå½,ùoÊŠ[9éİU¾ıWç_\\Ê»Î[Á-_¾†›~z-ßıÑøÁì·ğß×<Í~=Ÿú¿äŞÏş?jùÄÿß}x9şÅR~~Ó:âoå¯.zoY¡‡V>µ‘Á7ÍëWÉÛŞı.®ì¦µòüÕŸ¾…¥ÑC<ğLkïş–™;±‘‡ZÎ[ÎäÑïİÂ¦â¸ü÷÷ñ§o<õÌ½lÌ÷w4‡ôñulj.æ´?:™UkÎåü·CuO‹CßşAŞû{K‰¹ŸMÍîa.R-…¹ø\0–ÍÍI+–\0pìÒ…¬^83˜U«rğ¼Ùüjóv\Zí¸÷ô—ßûİwbøİ¿AA~»©EŒŞs5ÿüƒg_ô¬½ƒOşù‘<ò/WqÇAïà‚34õ²ÙÌ\Z¼«¾¸™µöqÎ\0jñ÷~ås|7<›¿ú‹#:áøf®½âs<zÔ…üÏ·/fş`Í·\0lfËHÅ¿?ŸYõ-Æ‚ûÌf†«‹8:õÃÎæışşñ¨InıÉ£ÔŞ¾núµ‹/å‚¡ÂÓŞÏy_à!-g°–¿¹øJ?ü_Ú}\ZxÏ‰,–½öÎ;	®ùâÌ>û“\\pĞ\\õ/[8òİä”©ú{ø9ãµËºÇ€µüÍ§ÏcùC×òï·İËægÖò7Ÿ~‹ö9şùgó9çï>Âq,ãÄ³ÎãD®áª›fqöß^È²;®âÛä¼¿xCoƒ]õ÷qßÓÏòí_>Ì}Ooåßnş%ÿvó/ù§ënå§ë6ğí_>Ì¿İüKæ\rö÷*ô bYA„—•Úàb;ãƒüÍ-jÌ\\»ŠYÛnç›[7sï•÷²ÅUôv°ñÙ²u3õJ?ó©1{áZÎøËpö\" 2˜Emõxÿ_#k%J=†üzuP\'vEO=Äm`s<Ÿ#NXÌqJìxl-‡U6sã7na4ª39\nø%ú9’ÅÙ£\\{ßf¶üèFİãÚ+±ã©kÙ²õ6×cF¹‡-[70R™Íò)û»/dqö×ÜøıüåH·âªûFùÿ·wÿqQÕ‰şÇ_¥‚…AXhŞtŒüÕFºî´¤¬?–¾š–váº†w5Ø$)VŞ­6\\\rÑv1m!İ•Ìë”•¦™^$kr5ÌŸ‘‚+?6V¨VJ´Úï3ÀÌa‚)¾ŸÇ<œù|>çs~Ì)Şó™Ï9“ûyß0Ç1ÙTLÉîª¿ù’ƒ¹Å”üıKºÜdìĞÅ5¨øÚ>ôì{­}n²¯×5ÄE®›†p­G\'—å¤!…eiE™–0ŠÓ/?Îüßí£àÜ9<¼ºâàÕ	ã\"µnçá§yùÉ\'y*·Â^•H|à>JzŠ7ŠNÅœªò¢û €\0nî~â¬ST\\Óİ~±``(İ¿+á#€/Npp÷üñíbºßbá«3ĞÕŸœ	`LB\"_/&,aĞ7°{Øµ	{€cêm£Ümocêú8ÍÙÎmæ|;;µ»\0_şš}ƒŞ/_¯këõ#®wº ï±1Céí×•½\'ê>ªˆ	…eiEáÁ ‡–“š:Œîç€^g×÷ÃHM]Nê¢;0Í/¦¢ó Y²œ´;ºsàï§8İcÏ,Icj°=f[ß>Aï‡ÒHM]À-%[ÙX½‘­\'zóÈóËIK¥xÛÿRõkŸ_Nê’å¤İ@Şö­Üš‡×ğ>Mş\r¿MKæ©GçÉ%“´‘jş—mŸğÀóËI}î^B›^İmoºq91ü/Û>\râ´å¤¦.ááAÙúIwb_NêóĞûï[íı}}ö¾^×ğUõN”	ÀWÕßPñõ7äü;0¼_½üL¾8ènm®õ/ğÓİ0DD~ºÆ|„gTóà£/kÚ„Wÿh‰ºƒ€^œıâo?Éw[İËÓiÙĞ2w²ğòò¢ºº¥n·aîÇİºòŸƒû³ãH#ú±tka½~Ä»ùâ{í5¼¶÷pİtŒÖÒî†¡°Üæ–EDÚ+…å¦²ğğ’‚8‡Çõ¾|¹ıIæ[‹~pQşDD—jğò…O_\"áù)ú’çëu\r÷\rî_wOåW÷&.b0éÙ{ù{™}Ä¹5),ËPXi¯–E\\µ‡°¬9Ë\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆH­Àh˜1ÆXzYëõ#3”û~ÚŸ¸ˆÁu÷\\–¦QX‘+ÎĞø¹D}„§ã‡9•51ˆŠêÛy\"*À©ü\"LYNêcaÛ	ëõ#ÂzıK·æğÚßóÚŞÃ.?R\"ç§°,\"\"\"Wœ²¿çQ’{œıûœJ¿¤äğAv½·‹œÿCûÄËXx	©\rÊéÙ{ëÊ*ª¿Q`n&…e¹²xbä¨{™–ô\0SÇ·—İĞ›Ş7TcÛög¿;HÎ1s™‹Å¾\0–Øå¼˜ñg^L†ÅË^0êRG5=0ß1—ßÏ¶÷ÈıKxÑñ<tâ3¼øÂŸY»&9w\0øÒ;È\0ß Şø–ÙKuMÓãúë\ZåZÎYÎOaYDDD®(¼—€}³˜òà.Nuö°Á#cÆóÈCãºtö¢\0ÿEô­<ûk–•\"ú>€j¶§Îb»w4s‡£ç’ºd9©Íwîä…Gíú:yĞ¥³x=À´;O±ì¡_óÒ±sté„Ó6À½Íà^ SgG]Ów¿×ö6×©¨ş†Ü“Ÿ‹Å\r…e¹Dóô3Ğ¸¾3T—UØyuÂg]uò +pú»³N…ÕXß.¦û°1°-…ÙÏböó[ê› Ø¯³gq?éÃÆ²¦éÒÙÓåõˆ~Á<6f(#ú»”Ëù]úoc¡´¦«Ü>5ª¯24ª{éfá«ìeŸ—é“¢ˆÈáê«¯æ:_?c±\\\n†-àÅáy0é\r6—´‰½9û/ºßU_Öğç\rtçøÂ¹Ótú<nèBõ?r²$€~Cºsö_âáUÂË\'Ó)v9£ü¼è~µI¾d\\£İ”å¬_Ô\\Ã·WwÆ«ô%LŞe/ïñ:“’O159Kç\nÎywÇ«ª”òs×ñ£›àÔàÛá,Õ€ÎœúËoxj—qîı¿[oæÃü\"*ª¿á¾ŸÚ§[ì<RÀ}ƒû³ãh/û’°^?\"÷ä?Œ‹¶¨Niÿßîâ¦£¬A•½ A±3—ÊF[^4…å6§°,\"Ò^),_ÂnË‹“+˜ıèKÔ)÷y„ãªyğq“ Û‚B#Çà»ïK|U°-+¦,çÅÎ)<¸ª~LùŞEi„f%°ø—E/ˆsX‹Ìk{SQı\ra½~„¯×5ì8’¯°ÜDš†!\"\"\"íßUXÿq;iyëË¯b}ùÖ?\ZJŞÛÿklÙ*ºıøvBï¸…?îCÌ3¯°şÎ³ØvÃM1<ıÂ+¬_ó\n£;Øx£‚r­ëu·‹¡‘å6§‘e‘öJ#Ër©¸Ö£‘û‹]T}SÃ#ùÆâÕF––ÛœÂ²ˆH{¥°,âª=„eMÃ1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"rÙ\ZÃ9GùxÍ$c…´…e‘‹‘ü\'åã¿L1Ö¸1…Ì}G9qì-«šmsWİÏu;Wğ§ŠQ¼ôøPc\0âş²‡Çö9ÕQĞ¬í…e‘Æ<ş\ZŸËá…%ï16¸XcX¼1‡åÄ1Çãè~>Îyå“o16v2”ˆŸÿ„ÛŞ†eè,?bl -@aYDDDˆ[Á–·^ã…8cUóõ|’-ûŞ!Ód´×Õğô¤²ğ>øë[l~c;œø7İÂ¸ùëÙ’h¶=K; /·Lˆ\'fP_n™°ÔØ@Z€Â²ˆˆˆñóŸÑ¯Ï-X†t­Xr·ôÊC;ş}óiŞ9v”ûÖçÚ²NØo~F?oîˆ[Á;Éç	Ì=o¥æ;èswŒ\ZÅm7•~÷P~™ö15xÒïî\'‰6.cfê\Z>Ö‹¥°,\"\"\"¬[8ƒgW¯æÙ%kUÍ–ûäİ<ş1Ux|ß3¼tŸ±E½¸§0¹ÿuTıãùğ³©,Z6„âoñQàçOX]kcPw¼~ûi§¥%),‹ˆˆˆ\0î!=eaùö‹»/{É$fıµ¸ËN3V;L\"âæë€²§ÜÍ/×|LĞçn`=%\0~øO6.\'mEaYDDD¤[¸ÑøºŠrcU3dÏÜÎ‘oÁó–aÌ5VPÉÙoíÏ<ıïÅÛ¸y]ë?|ŒeÒ¢–EDDD€€¹ëùøã=lyfPÎÙ\ZàÚŸ0ù­U,_²ÄéÔh@ëÜÖš\nàÚ nsö&xÉKXÿ÷>j*şø±ä5^ú¹\0×±|É‚¯ğ ÛÏ—°é7Ô¯»£w,YÁ«s‡àĞûnv½²‚åå=»ıŒåk_Æºv	wtóp^±4“Â²ˆˆˆp[o¼¯½€[IZ“Cñ×àİg(ãî½Ûéñ{@56Ê¹íİ„Õ6v¾‘°{Æ­~FdŸë\0ğô»…ˆ¡½íaÙï\'NËz<ôn~Ò`ıº¯íMÄ½£»É“šä°ñàsë(Æ9–÷ì=”qwäÖ;î&¢·§óŠ¥™®\n		ı·±PZÓUnŸ\ZÕW\ZÕ½t³ğUö²ÏË>3ÖˆˆH¸úê«¹Î·±%—6,ÿ¯7UÍáˆ±J.H§ìOşí.n:Ê\ZTÙ\Z;s©l´åEÓÈ²ˆˆˆ\0%Ø”Å@aYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYD¤\rYR÷_°‡e‹·s¤ğ\0iŒ-DDäR¢°,\"r	›şêIòY™n¬h)d–’¿3Åñ:u‡JÉ/Ì!ÙĞ²ù}²k¬jŠyöéÑÆŠÖÜf‘†–EDÚmö‚ƒ†0ç‰Qôëy+	›Œ-¾=ßBSÑôÕ{È=z’üÂÒºÇ‘ı9¤Ï¿S»Vå³i©\Z!‘öMaYD¤UŒ`á†²6<K„±\nˆİG~a)YK5®VN%ø¶(2œÊj<¡æŸEìÿ¿MlŞ´‰ì½EÔx‡·ëêIN-/cÏÚ?LÄm4Vˆˆ´-…e‘V1\Z‹%„ K8‘ÿÉilşĞ>\"œhñ1´‡ä¥äæ±.®±²şxŞ=C¸íˆèÙ!lÚ6J\0¿‘SYØ«~ù¨EV²ö;F¡N’½!Émxo6G˜M˜];BŞ´iöıq2aXî¶$Ö}hÿ ‘_XJşÑ=¤OtîBD¤M),‹ˆ´Š¹Ì~l+ŸG\ZÀ)dÌŸ@ßP²wÙÎ+šÎ²t%s~Ç)(©Äûæ	$>7ŞÅö)Ğ1€ ‘µ­“˜NW%GÿoûËÁßÏÂçÃ];½”ì?NUU%ûÿoY{Ë¨ñ\n$bfZ+ÍÙ9¿«BBBÿm,”Öt•Û§FõU†Fu/İ,|•½ìó²ÏŒ5\"òC[šC~tU¶E„M\\Eì†<->lìAäcö&É;K‰\nªÄöt(“Óİ—%¿SJÔÍ•Ø\rerV\ZÙ»&àÿånŞ…gmŸ¯ô ò	 ÎJîüpp¬“iVrç…ã]°àás£º“ª{ÏºCIX¼cí9”D—\0gÙ.+ãz¹«wôUµ›äQd4xmgßçåİ·³\'í}+‘ş•Ø’B™¼Ö©}“·¹m]}õÕ\\çëg,®sƒ_7c‘H£F…ÒıºkÅ-æ«¯køsöcq‹éÔ¡ƒıÉ¿İÅMGYƒ*{Aƒbg.•¶¼h\ZY¹ŒT}Ğ™Î]€“gìşuOçF¿MFş7\\ooWSe¬j¢şøuª+)7VµŠİdå•>üô\ro†ë®óÑCf=<:yĞ­Ë5­öèØ©“ñ4,·9,‹\\&±lç\"¯İÇ²ŸÅqg\ZÙ™ğ§’ÛûäwAD\'åû7ñN!|}ì8×Ü9Ûüj(ø¿­ñö\'°°„;•ıË»EßßÈ¸ÁPU„í½2‚ÇÂ¯ú8ÙY‡àÖ1u}Ú¾ñãÆ^Cà¸AøWìcóáÎXîèŸ\'PuœO‹ÎğÅ±\ZB&Â¯É£´ãIß·’?¨útÙG*ê±L„_“F–ËØ¿i7WõìEQá÷öåª“õO<z”óy©S·× â®¼«s¤èßT6{›ÛÖùF–Eš«k—ÖU®õåé¯E-¦=Œ,+,·9…e‘+C›ÅÓ×³>Äõ’FêÌ1uu†ïİ}Ïwğp-:4uèÜ×ĞÉğG¶ºŒıY»ñŒ˜@ßëÖÙŒàé?-“Ì™#ğ÷2Ö84),;^¸ÙŸoÎÁ5fûè|œš±ÍmIaYÄ•Â²\\\0…e‘+ÆÀDz\'ËVd¬¹BÕÎA¾4‚mkPXqÕÂrƒ±i!w49(\'n9Iş‡,sü;ÎØàr—IÖû[°nI#Â¨:E~]åL¬GKÉİ0Óe‘K…Â²ˆˆ´ªqÁİñóÄm»áY]DöçºÜõâÌwÀ·v+=‘Ö¦imNÓ0DDÚ+MÃq¥i\"\"\"\"\"í˜Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"Ò.õø\\F‹å¢(,‹ˆˆÈ¥cìÒfÇ0\'u÷\Zë.ÀÔç–3`ØR‡«{Y:—˜Ùi,[[6ˆ9/8–àRŸ{ îUsøG%2g¬—±\0ÿ¨¹<<6š\'fß‹ûNÛßşQ1}qšAô\'Í§_ğks­ÿ~?úcˆÈ®ãÕWsÿ >ÆâõúGŸ°kßGÆâ6£_ğ³›úÜrxtkêJ õ9˜ıèK×¾ŠgÔ­(Ù¹†­7Dsï«øãÎjG}\0£î¿/_~ƒ‹}7ë¶eØRïØÅìä]Æ&\0øaPU&oì³¿ö\r\ZˆïW9ñn¶¿é¼†ŒaXÅV¶3Ö8êª¿„U°-+Ï^Øg ÿqƒCQ,C™–œˆåúÓœíĞ…s?$¿c)óş\ZñğC3xĞOywç»¬{ù/ÆêÑ~Á¯Ã\r7Ü¸ĞX(­©õÃòµ×xòı÷ßé¡‡z\\Rşı=aİ¹êª«ZíñÉgå~Vjü¿c›¹êª«ğ¼æ\nÓó\n``ß^„ş)Ÿ•p¦ËYN_Û‡[z‡0d°%ŸÁëÛSôÿ\\¿µoàÔ—©¾éB¿ÙÇßÊ1íwI<5\nËOn¢Êú6g\\ÎsŒeô}¿äÆ¼·ùø Ï½,HJdê¸Qìx‚]Ÿ~÷/áÅ‘§Ùòa	–ÙKˆ¾z;¶b¸í—wÁ;oóq¯aÜPHÖîBç\rÆ»”ÿŠQ?D÷Ó¯Õñ~ÿ?ÓàGŸ‘¿fªå\ZŞØåÁ]¿„¬wö;-Û}bX0í.î¸s£‚?cÛ‡%N•^DDOç¾ÈA¼ù&ªwíæÄ9ğº5†3Gqf×.NœsÚ~>çD>gÙ™¶œ2ƒ_ìäİÃç\0_z]CÙ¡ƒ|~%{s›Ó1p§_ß~<7Î;Ó÷–¾¼»c;_óµ±ÙEëpõå?‰A#Ëm®õÃòçeŸkDD¤\r\\ñ#Ë£ˆÕ››‡Ü{> äóØú¯PÆü8Ë°í)æÔÕøNü^Ïÿ†?¹.îÿ`\Z‰Wÿ„UİY°f<ÅSF§Ç>CÚ-[IXbÃòx\Z£?I`şÎ{ù}ò-¼1#Û”å¬ïñ:“’w14q9Ìâ©]çYœFÚ£üaÆè–ø\nãKÅìÓH}¨š\'3©¶€´a‘ğT÷óŒ,{1*a	QƒºP½+™Ùkí£ºQÉ\"èµß°ØË|İÉ3ş@Å=Kx¦w&³SÚ{‹ZBjğVLŞU¿ı‘Ï°vL5»û2¬O	[üy¦®Ïú‘ïÚöNÇÀ7õ`UÚj\0*«*™ûk¾ÿş{c³‹ÖF–/ÿ¸/\"\"\"—†¢ídf¬æDU\'2V³úÍ}”ìÌduÆ	*ªN°:cµ}šÃ÷tı±qa¸ŞƒÓ_™…n9ÁÙoqÌÅõÀ£3P\rgíšÃ¿+ª+pYcQ&Ûª†ñÌƒ1,ˆîÊ¾\r[k0êQøD&Õc¿šÌÁ¾0g½E—Ng©øÄ°X-ÿ®PQL	Pı¯Óøv­«ª¶n¥¤Ç(×õºw¡úh&k^ÜÊ	ü¹İ¹®lz>¥ÿ,åü/¿ò2-h• Ü^hd¹ÍidYD¤½ºâG–›Èkx\"i÷÷¦â‹³œ=±†7¼aÚw`Ê–P~ÿè(º|u\Z¯À®œ=TÀ)Ÿ.tq,ç{SwÎPrC¼¾¤ìLNïMæ·kó`Êr¬wvâäçßpí?Â«úŸŞ=Àöß&#Ë„óL\"#½+¨öòÇ÷ìA\nşÙ•.×{áÛÎ~_MuuG<®ñÄ·ÆÆ$—‘åH}Ş‹” dX\"kcC©8°•5YD=4ŒåÅtşôîtŠÿê‚WéK<hX÷Ô%sD5ÜàEñË³XÜ9Ôˆ\0\0¼n²o7Ï½‚åû/8çå‰ï\r]¨(ú¯›ºPıøzæTQ^İ	½	N}¾ÎRİèìÁ©¿üÆtd¹­´‡‘e…å6§°,\"Ò^),_ //¼ª«©½¼Ï¨±‹äêLYÎ‹SxpU1¾á£İ¿›Y‡-\"šß¿ÊÖ‡\"\0_F%.gô?~ÍìÖ¹Vî²ÔÂ²¦aˆˆˆÈ«‘ tó@z÷0–ÖêNÌ3¯°şÎ³ØvÚ\'Tè?ŒÛS!ZÏVŞ=Öşò*Ö—_Åú—•Üßã Û^3¶“ËF–ÛœF–EDÚ+,_yü‡G3°¬¯ sXßtÜwNêhdYDDDäJvCwºwëN×kŒÒ^hd¹ÍidYD¤½ÒÈ²ˆ+,‹ˆˆˆˆ´c\nË\"\"\"\"\"&–EDDDDL(,‹\\¢–naİ3£™¾:‡´®u1kl;‰®Å-/ÎJnaY;KÉß™b¬uH!«°”Ü\rñ@<ëÕ>w#ÎJna)YK9oÛØ\ryäïÌ!«®}ëKŞYJş!+±µÏM÷¹qVróXW_dßç¾\\÷=vCù…9$ã~ùËY×®7ĞÀ@c±ˆH‹RXù!õ\n\'rdc©C\"Æ„ÛJÕaÜâ-Xw*fdµz¦k™c?X~:ˆn»cùi7¼«\\\Z“¹l9+W¯d]]I\"&ŒÆÒË¥™{G0Î°ÍÎúZœêÒ£ë9”Èá=>×µaØgYş2&†<|(‘={ù˜±öòbß—æ¿×ø‘Úú¬9ušæ|ıº\Z1œ?:ÈoeñâKúi=\nË\"?ˆ@b3¿ËJZÆvòw¦p›SmÄÒn\'}¥•l§Àá×+„ ^İZ!…º–94ègJ&ÙGs×‚&$aéêCØã{HŸR¿Lì¼ß2}Æl¨‰ÜNúâÖí:IÖÒD­=@~ÁvöîL#»°”ì•#ˆÍÌ#K&ÉÏ[É>–CòH§\r˜b%sƒëêÑ.Å:Êš8¼‡#ğ†29İXÛöQë¶\ZYnú‘ïÆ?$ï,%¿°şÑ6û²ŠÉz6q•±ÂÁ^9|(Á¢È0V›:_¿®Æÿg4W_mÿ6|Ä(0‹H«QXù!Lx–¸;»Q²5†àaQÄıÏ\nö×U&1gBì_ADÏQÄÍ^DÆ3Û9rô$sûà=ø	İCú™d=É‘{B ç}9z’ÍÏ8¯ÄM?Ù«H^¶›òêÃd¾rˆšòİ¤=¹ˆŒlçåœ¤/\"aâÆMŸKV‰\'A·Æš±’ı	›\Zˆ%jşÇ¶dKâ˜<l	On£Ä3„°HC_kW‘şÊzÖY·Õ\"æ–äÜ¨9£‹ÍiëÄ1]#¿p.«v™¢P¿}ù…®aŞ>­ÁQî<rjœâ°4§~úC3Õ|‡2ùf“~â¬DÇÚ³Á=a3|CĞ:ì0j÷ßı±w>v®aßõƒ‘Ó‡•º÷¤é¡¿ğï\'êÿı÷|ö¸Ô‹ˆ´…e‘BWO<©¤8wœÜM¶­È©ÒÏPr|1%&ûİÃ°q1‰OÎ&óP%U‡Öøä\"22W‘üälß-‚’$>9›eºqÓOÌü–=>?¯şDıj¾ƒI˜;‰ “ÎËÕ‹]Azæ¬Kgæë(|o\r¹\'¡ïOKÌ­pt7i\'ãI{!“u;ŞbÙÃƒp—Ù¬|b.+ß…Ø\r³°°›ä=°Ûµ¦xÖÍÛ\"‚{®Ç|ÕöQÎà=Şx‚ÆÔ…èˆ~>lìa_Ş;œ·ñ5\'`§ïàHU‘âaé$,ŞÇÉm±)%õ×9\'ïœDPÕn’	çÎïm²\r,3›0#=Š°öãm-€ »Î¿LjÊÒOå­-oò›©“ùòË/ŒMDDZ„Â²Èá[\0Ç¿W8±S&[àšD_ú5m*–ƒ;Ø¼éuÊÎ\0gN±yÓ6lïï&kÓël®®ï¾bó¦×É>hìÅµŸªôEd­¤jÿ*²J <{‰Ï®ÂıÀò$,·âY²‰ÈÛæ‘[v³,û0øÀÒ«†ıGÉ¯Â	ó÷¤dóPÂ’öá>G`úâ¦§g\\ê[­Ê‡~#\r¡8.? ¼¸iÓZŞ*&¯Ø\r–$ò£»a{zh]”ÏºCIô;bÿ@QnIªÌùe•ÆÆççİ`cY#?:ŞˆhdúI­Ô”%Ìz8]Ù;U\"\"-F¿à×æô~NâéÄŞæcùé\Z\"Œ {\\A£([½‡9wâ	P¾ƒ…ƒbÈ4ô`&vC‰Áû˜3(?7ıô{§”°ó(ù[XÊäÕ@¯4²wM *½oöË#ÑR†µçPò× ñİ€JJJÀ¿f«ıb²^Ï²yÇTúÖìcYß±¬$ô}IDøUE”HÍÛ†‹ç&dbKoÇb™ÈºCIX¼êÏ}\r®u*øšs\\K\' Ê¶ˆ°‰Ô/ó¯*¸Îyá³€\0{ùX}àk06ÎJîüp\\Vı\rtrş©ÚıÛ}û-tìèTP°¾şâ:§~«şŞ×Õ6:Cå™Îøtªv“< Šà¥Dá´l²ŒÓC\08µçPÖñÍ9¸¦“¡Ù™JÎtö¡síës@\'ËàÈÓÆyŞöõ²Ñş%ïtL)XOğpÈ*œD ñÕ½/Æ®ûàÜ¦®_Ã{İàø›ö}éÓ/øµ.///ª««ÅR\'€¨Ç£©^’Â6cÕ¤=ü‚ŸÂr›SX÷æ¼q’ØoSé÷Ÿ+ŒUÍNÚûVú}EÄŒİÆJss·p$Òú¥fC}Xn™‘Êz}-áTÙvSb¬hLƒèeÀÂËaÙ®‘(ÙôCBû¡°ÜšòğsÑœzôI¬Æª‹r/Rƒ8QÔ›Şù	<µ`s^ˆ¡â¡Y¬àRŸƒÙ¾d\\ø¼ü£‰>ó<Ë¶4ùşQs¹÷L1]‚Ïò‡Ô7hØ¦>·­İÆùG%ãı%Ş§H1éÏÈÓÓ“šš\Zcq‹iaYÓ0D.oÿq6	O]LP(\"óÙX—5#(l_NâŒ°ì+%ÑâCÍ§{ÙllÓ\'(_Ìíà.ãb3ÃíÎšt§¥9öÓæ‡ã]°µ>(/mî­Ó~@éQd@P´óİ5’°x\'ë¢ƒ²óÅœ•ØÖ×å”à}–Ë[ŸîßÇ	À7<š‡ŸaÁƒcèGÇ0ªö¦@ƒî%fx@ƒ60Œ‡çÆêÚ)ğOÍN!û€ƒ¥µeûXóÜKìºÁµå…¨(:HŞ§îckEQ\'ş^ÌÁ£yõÁ¶Ï@Çö\Z…2-ùÏ¬}!_ü3i‰÷6Ø—Š¢ƒÜs}Îı5bÁÿ,`ãz+3nìö£¢‘å6§‘e¹Tbs;~UäoÚÁQcµˆœ—F–[Ó0¬OñÔYl2Š€’}Tß»„‡=şÀìÒR´‘Söqï¢?qû¿aõW®mLõåá¹¼›’I^]Ÿ^XbÇÔ;|ñèìKÅöqÌ>ü\0¿ŸjÁ£ä¾½é}z;Sêra#Ë}bxzæ0:u¡ú“çIHµ9Uz1jö¢‚=ğà/?Ìöjğ\Z>—Ôû¼°>şÛ«]G–}Ã£‰¾>yc+çb—soÑ,~»¡\Zğ¥wœ(¨À7¨7œ tö,{gÙN«t2pÀ@^X¥ß<GYY™K›– ‘eiGŠ°m}Í\nÊW®&ıª¢ÈÍ‹®?\ZÄè‡ær¯?ĞÙ—ê\rû¨è=ŠÛ½b°Üx‚7²\Z¶]üÑ%(1ÄÜZÀ²Ø_óÒaÇXlY\'<ªvñdr2Om-¦ºIc´^ŒJHãÅ5&uJıxoÔÔaT¯ù\rS^ş„³í×UÔ	ŒáŞçñTÂoHxÇ—ÑÚï^½3…ÙÙ]ˆš1Ìµ}ä3¤Fq¶Ã Hü/î)ÆãÇƒ•ãyä!ûVİûĞî:uö ‹ñº\'EÅE|ıõ×\0”ü£¤U‚r{¡°,\"\"vù«Š\"mâÖxqš—Ÿ|’§r+…ÙuÊŸ1ñé’¿•Ü¶qÃ¿+ª+(v.+Êd[Õ0y0†Ñ]Ù·a«s­“\0Fİ3Êş«¤‘‰DõØÅo§&s°ï#ÌqdØ.ÎRñ‰a±Zş]¡¢˜ ú_§ñíV²«­[)é1\n—ŸpêŞ…ê£™¬yq+\'ğçvçº:^x8rÏç«¯¾böc³X¶bOüÏoÕâDÓ0Úœ¦aˆˆ´Wš†ÑšÓ0ş€ĞçÇĞå‹\nèäe/‘¼†-àÅ‡ºòÑã³XıE4¿oĞ&ˆÔù(z–Óİ…B‰y&‘‘ŞT{ùã{ö ÿìJ—ë½ğíg¿¯¦ºº#×xâ[cc’Ë4ŒH}Ş‹” dX\"kcC©8°•5YD=4ŒåÅtşôîtŠÿê‚WéK<˜¼ËiùP¦.™Ë ªá/Š_ÅâÎñ¤F\0àuØş{<÷\n–ï¿àœ—\'¾7t¡¢èK¼nêBõWàëušSETxu\'ô&8õøv8Ku ³§şòr^å =LÃPXns\nË\"\"í•ÂrkªŸ³Ü”;C¸Ó²·‹æ÷/„²õ¡§ÈÀ—Q‰Ëı_3û/Æ¶W®ö–5\rCDDD.qÑ<‘\Zÿ?²İXÕ-”¶òî±î<ğ—W±¾ü*Ö¿¬äşÙöš±\\î4²Üæ4²,\"Ò^idùÊã?<šeÅxÃúæ>cõO#Ë\"\"\"\"W²ºÓ½[wº\Z~…RÚ,·9,‹ˆ´W\ZYq¥‘e‘vLaYDDDDÄ„Â²ˆˆˆˆˆ	…e‘VHìÊíX—N\"vCù…9$›4ÕÒòóXg¬h	)d–’»!ŞXádiï—’_XJş!+ÓÕÍÕ+œÈ‘ı¥ÇéE-İÂæ•ñö_×ºqVr/â¸\'ï´¯Xj·ï\"Îià¶Ûáååe,i1\nË\"­)úYâÆxS¼y½Sa\"\Z„ÄşDL¥—¡ø‚e –1#èk,ü-£‰èZÖwäúREÍ·®å\rİN°?”l\ZBÄØ¹¬¬-8‚HK`]«¾#İì\rÛYæ¤6oªK¦ûînÿÇ´ª¦®Äº·¿È‡XíÒğ<RÈ*Ì#kgù;SŒ•—½ä¥äîÌ!÷¢{<ë5öÁÊ^Ÿµ3§şCB“œ¯_W:uâÍmï`İ´…]ïï%ôwg¼ˆÈÅÓİ0Úœî†q%‰İGb·­DŸKä†<ByGü<¡æÓõ$ür.ÙqVrç‡ã]xÖP°1–ÈÇ›¹…Ä;»Ù;*XOÔGƒ±FwÃöô/ÉØB¢l+îgòó‡ëW82…¬•“¢<Ïptmã’F“U8	ïÒJüzø\05¼Cä$¿“AÔÍPSIÕ·>ppaWÕ÷Wg*éû%Âq‘•íôû%Á%‡ñìÛŞ›GØÚşöu{b_ÇÆX\"aİ¡$úU—áÙ£@ùÿ-ÂrlG¦\rÂ€JlO‡29½~mKsH‹\Zğ¬9LæìQ,ŒÌ!‚åUİğë\nÔÇ\Z;”DOÇ>{BÍ—•ĞrŸerz8iï[±»Ù§¥9äG‡Ô½¬²¹iS+ÎJîü1lcS%ï,%Êo7É¢ÈXšC~4X{%ÑØPšeôİãx>muİëÒ\'eÉ…h)º†ˆ+İ\rCD\ZNX€UeÇ)©-òª!wzâ6áyób§\0é‹H˜8„qÓç’UâIĞí£aÂ³ÄİÙ’­1‹\"îV°€\Z°d2çNOlKÆºe qî$‚¾ÜF\\Ÿ^$Û ï¸xbu~U›×3†¬RO‚~:¦Äy³§}ÓwPeO®&Ö7h=@ÁÆ„M´àämÉtæ,Yc_wÍn’‡\raá{•E\'‘ìaöîxŒäaCÈ8Xƒßí#ˆ}v,›ì‚{\ZChs&„Põvıú,ÂFÆMqŒ@wìFÕÖQÇn£Ü3„°q3eAEdÅö !»ÒÀv“[\\‰w·úPl—BVt{Ü³ÖêÚØ§Ê8¦š˜¾ÆYÉ­kS?=ÃeÙf¨Ö²O…©í#ki}MòÎR§‘nûlm»ú‘XûòYKÍêÛ85‹ë6ºv^¿ëô×ıpÚ—cÚ´í+.*ty]ø÷¿»¼i)\nË\"­¦?ŞŞP^ì<bYIÕ»}¤ˆ*|è±«3HÏÜƒuéLÂ|ÍºzâI%Å¹;àän²mEŠnXF†àYuˆì¬Ú²zŞ€ßÒdÎÀÎÔ|]?-¡êË\"²ƒª¯Úu¼{ˆâÚòæ(ÙMBÚëdt¬»¼ˆŒ“Ed–VİğéhWUDæÉ\"ÊªÏ:pÇÏà÷‹}‚°5N³+*);yŞıŠ*G‰gG{ÿ¹uÇÕÀ³3·¹Ìe£­’ ÛS€Â‚*±­ŸqV,>ö½ñ¸ËõRÈš¶E?½Ûi]ñDôs,Ûs=Şá$¸\r’æb7Œ!¨j7É={l«$è.“À7‚~ŞÇ±ö´o§·e–K \rŠ+ììõ“Ü‡şFÕ^ç@œ¼s’cakp íb7ÌÂBí~€e¦É~8K\"¬gı‡Ó}wrèàf?òom~ƒß=•Ä«Ö\rÆ&\"\"-BaY¤Õl£üKğpM>øO$\",o*)ËŸ„åö@<K6yÛ<rkÈ·ö¶ƒÇãß+œØ)“5M_ÃQÏpæ¼Ôàâµª\Zàë½,İ‹~}ïfáŠ5d\ZÚÔ©]G¿0r0ŞÆÍSUÜÔ‡9½‰\rè”Qr¾i×^Oø»Ìq¶ÏŸ®Ê]Ldß^ô›8´WÖ87pQó-pm ıFâ8®Æg£òõ2&.Çæ7‰üÂIøÙ–ÛG¶Ó‹(7´»®’Î/£¸¬îyp7—ºÆ¹ç‚Æ‘úæŠ·O9²ˆàë)·$Õæü²JcãóóîN°±¬‰ïD4á‚Ê-›ß`Ö#±&ãEc•ˆH‹QXi5E)­Ä;`0–Ú¢*˜¿‡ô1Ô|º•Œµë±.ƒ^È.L£ßw0²vÖı•øßµ’ì]V\'Õ^èv†ÊÒyL_½úN%céˆÚHNYÃQÂIÜUJ~áv’§ºÖ»X»Š¬OkğŸIşÊşxº)ì•Fva)›ç+\ZJNYÃÑï1}×w¦`ã¢FçånşÛqjzŒ&½ğ’kG XÄ²ÌÃ08‰ìÂRò·¤09Â¹ŞUæÚ­|È¸ŒRÒníì4ÚkŸSş÷İ.íX:	‹#U{[’È/,&¯pA@Pt©Ë|fWöQioKùóÃñÆËüRå\'añv,[8‰ ªJü¢K9”_JT±7â¬äF‡€w8‰…¥DURE8‰Ÿæq¸ĞÑGĞ$ûvÎÇ›¢\níÛYUÕ¨Â>qŞşÚ)\rÑ!àh›{Ø±mÆuƒazÆ*JÊÇe\'D:ó\'y¥$Z|Ûhß_w2&n¥À±‰ªlë]Ïƒ IäçÔmKPt)Ÿä·Ù‡~#›72/\"ÒZt_›Ó~W”èLlÉ8’x+q•—¹[8i}ÇÖßıâr‰mi¹±CHx×¹\"…¬ÂI°±‘9—7ÓE^øç,vC‰–²îÂ?ÇE¦å.Ç¤~„ÙôâÇfJŞYJë	>×XÕnè?WºÀOD\Z·1†ÄïR0ŞXsyØ¾œÄ‰—_PÆœ\";e!(_,§Üæ‡CíV»!üC9djÚ…o$=Š¬Ã¨taïãd]tP®ŸÿU;?ênÓw¡÷¯i+\ZYns\ZYù¡ÙGró‚~ø‘Î|dYZLc#Ë¡×\\¦šE€SçRñm±ø¼ÚÃÈ²Âr›SX‘KTœ•Üùİ)/!¨O—h-…å_İ¸…ë;qÕUö?íW9şÄ;ÿßüßÿ¶ÿ¯¼î_7íŒeÒGm?˜Õ5µ§zÌêšÑ‡s¹K]3ûp®¯+k¤Íùú¨kc¨3¶9_µõ´@îöÑ¬i½›¾\Z´qÔ½òùX…ei+N§£ñÌtR_ehT÷ÒÍÂÿ–ED~çË¾İ_b)r©SX–6¤°,\"Ò^5–\'Ş¸…®°|âÌ»œı÷¿ŒMD.)?ö‰çÕ×Â²ÂrÛRXi¯š\Z–/4xˆÔ¹g{–¥,ı6Æ.1V¶Œ–8gÛCXÖİ0DDDÚ€›!‘&xšwåÄ¾54éæ1S×ğñ±£œxûéº¢¸¿ìáÄ±=dNu$¿Å‰cGùø/SêÚ¸£sÖNaYDDDä‡òøk|r,‡–8ş½ÇØÀÄ›3Ò§õF•¥Â²ˆˆHhİ/ŠåR·‚-o½ÆqşÆªK–ÎY;…e‘VñóŸÑ¯Ï-X†t­Xr·ôÊC;ş}ó<Ó.za^ú[||è(\'ÙŸìËáU3±ÛJ‹PXišÿye[·pÏ®^Í³KÖ\Z«šeòÂÄ\rígÕ	>øë[lÎù„ško$øæŞÆ¦Mç¬Â²ˆˆˆHk+ÜCzÊ\n6ÂòíG9qì-ÛÇº·öST}²†˜™3ë¯åÔt„ò‚lÆÆÒ\"–¥y–æ_˜Ç:7ß\rõ9\ZK/ci#\Zéë¢<“C~áÒ&+~1kl{ã?cÜ+œÈ‘ı¥æZëØµˆ²\nKÉİo¬pg%·0‡¬¥äïL1Ö:8÷ÏºCôg%·°”¬¥œ·mì†<òwæU×¾õ%ï,%ÿ•ØÚç¦ûÜˆ8+¹†÷İ¾/Î}¹î{ì†<òsHÆıòÒv4ÿSêİÂ¾À×U”«Îçµgxó“\Zü†>Î«KVğNâPü*öğ§§_3¶¼h:gí–åb3‚¾u¯g²èùeL7LÅ‚@,#Ã©½œ¡ïHçe\ZÓŸˆ1õËá.Œ›ÌôTV¦-\'mSmA\"&41ÈÁ8Ãz\ZlàoMÄ@×²Ú}È^¶œ•«W²ÎXç´í–9)¤Í«½§;®ÇÑ¥Üå}p*wÛŞÉÀõÛÜ+œK ¡nyãïi,fı¦GÖs(‘Ã{\\ĞÏ*ÛgYş2&†<|(‘={ù˜±öòbß—æ¿×øçA¦mÜ:O¿n,]ö<Ìcé²çU\"—œ€¹ëùøã=lyfPÎÙ\ZàÚŸ0ù­U,_²Äé„qa€~Ü±öUŞüßt+8A×vï(‚½kÈß_Nÿ„—X÷—%,ÿ¹\0×±|íËX×.ánÆŞ¤–å‚ÇïaİÊL6Ë!ùÎñ¤½ÿ·yù`™ï1[šC~Álû÷°.ÃJö±=dï+es†c™¡º^ÄÒn\'}¥•ìCVbïL!ëX)›Wg°nW)YK»ö\0ù»¬¤­Ş^7ZW\'a6Ó~Kb\\íîí¤/Î`İ®“d-AÔÚälga/àÎ4²KÉ^9‚ØÌ<ò·d’ü¼•lwÛèf;èÏº}¥doÈ }‹cÛ6ä‘ÿáv6ÚNú33™7ï·LŸ1›„ÚQ¾£°ÛNzÆv¼“BÄ¼-¤ßA“\Z;FmûÇqŸ•X§ îú>œ¿}] ùğ\0G¶d’¾¥Ûû{8²ËJú†=änˆgğ¢íNÛñÖ£¥yã	æ68æ#H~ç¤ã==€íhÃ “ù*ë6l!-Ò¥ØÅ…²&ïá¼¡LN7Ö6…}Ôº­F–›£~ä»ñÉ;KÉ/¬´Í¾¬bò€„M\\e¬°súdÚÆ­óôkğŸÑ_>>>Œ¿/Šû¢şËØDä’r[o¼¯½€[IZ“Cñ×àİg(ãî½ÛéñÜş¬Íµ½‰¸£/ın»›qwß‚wÕçùğcŠ« xøİŒ»÷g„İ~7ã†ö¶‡e¿Ÿ0îÜzÇİDôö4ö&Í °,À‡ª·G»rÏÂÆ½NÂšİTQ‰íi§QÂİ(ß<„ˆÕ‡©ñÄó£‚Ûa_Æ4<%1gBì_ADÏQÄÍ^DÆÍøyBÉ»ó76Š…iûìU‡É˜3ŠÉ.\"ÃØM­ôE$LÂ¸ésÉ*ñ$èöÑX3öQÒ±?aS±D\rÂŸãØ–ì cI“‡\"áÉm”¸ÛF7Û1nşCXüŠÈŠíAÄÄ¦í³·í‚÷‹™óØ\">2tƒäNïÁ¸uÇñ¼y±ŸesP°`·Á¯3å›†ñänÊıÂ‰®Ë£Æ÷á|íëyw<ÄÂ1d•‚Ÿo™Ã†y¼û``Ò[ì¯ö!ì®™0÷çôõª$÷­ÅÜh<æSâ‰¼Ù“’M1OßM›ÿg®}ë+/aÍ2ÖØC{~a)Qö‡r)7†n÷šÓÖ‰cºF~á$\\Ví2E¡~ûò]Ã¼}Zƒ£ÜùƒšqŠÃÒœúéÍT?òÊä›Mú‰³tkÏ÷\\„­ÊØ 5Ø?`Ôî¿Ûc_w|\rÇ§Á#§+ÎË41ô_åøÅR³×\"—šÍ	“¸f<÷O]@qz<Ã~Ò—Ş}Lƒ¦bÿs0Ÿ_:•×ÕeìObØ Ûêêúõ3ö3€>uÏ‡³Æ±1‰wÓ»O_~òßw±á•BaY.@%e\'Ã»_ÑøßçJ*‹‹()ûŠ\Z*ÉÏİOgo<;BÉñÅ”p˜ìwCú*6ï-Ãï®gÙüj\n±‘¤ıï6\nèOìóÛI›7‰c7±«3HÏÜƒuéLÂ|…ï­!÷$ôıéo‰¹5î&íd<i/d²nÇ[,{xûOõn¶ÃÏËªŠÈ}Jl;°¬m\\„mÚ\n6¿{Øµ\0*©z<E>t6Ö¡²¬ˆ’uETŞ7Mr”›½fíTÂÊª¾Ê±îdÅ••Êlü[}G’~ç\0<Ë÷±9†Ç¼#@%ÅGvÀ»‡(şÚu\0¼»‚Ä\'Vm(İ0»IîÙkó=õ\"Ä³nf8ØÜs=æ«¶r÷ìAğÆã4¦.DGôó¡`cûòŞá$¸Œª9;}GªBˆÜK\'añ>Nn‹M)©ÿ°àˆ“wN\"¨j7É¦áÜùø.ÂFOza=íÇÛZ\0Aw¾-rÃú¿¯°ùMTWŸfó›xuãc“Kâü•®Û_s8b,¾„éœµSX–ÔŸnø÷2™£ú±Àœh}éOÔ´©Xîô&÷©[é7vG¿\r$ì£	şç[ÄÂœ·ËğqØn–Ûñ,ÙDämóÈ­ûã¾›eÙ‡Á–^5ìÿë<J~N˜¿\'%›‡–´Ï} w³5ßŞ„İˆ¿%˜hãBîøà?9ˆ°@¼©¤,ßQ|íõDˆƒ¹Õ>tëÕÿ¹}ğªşi•0×Ìöß¡ÄPdİ|ˆr¯ADğ¤üÀkX¡á1ÿÀ‡€~#`ä\0®5t0r&É‹gš~˜¹,<¶[•ıF\ZB_\\ ~@yqÓ¦\r´¼UL^±,IäGwÃöôĞÆ/\"m²xÖJ¢ßûŠrKR]`Î/«ı@ÕtŞİBŒEJüè8x ¢‘é\'µæÌLàÖ¾!Ì™™`¬i1\nËÒ2ÒwpäKOúNÛCöK3µç»!ü}™Œc.ß.‚ñl.ÜNòoF4‰…[JÉßO_Ï2üß6\"V’]¸‡ewu£æÓ½dõ²Ï=Ş<ß¹×õØ—A¯	d¦Ñï»ú?ô%körôZ¼«ñÏ¯ìæH9øOØC~jjÜ¥e7Û‘¹úöWùü²7$1¹ÁE~nT{<éc©ùt+kaóßSÓc4é…ï<Ò>ªgËïX ï»¶“=cå»ÙxŞlÖ°}ıñm¢M«ì£ä‹°­} á1_»Š¬OkğŸIşÊp¼kŒÀ¸_=@Ô¯ Êği&cârl„“X;\r#hùùä&añoKù…|bœ*£îğ§†¶…äÏÇÛĞ¶!§€éè;(º”OòJË;æİşÔi.pızò\nìÏƒ¢íÖ.´/Ÿ{¸”üè „¨Â¿óÑ§Æé&&ÛK!D9MI°÷ãÌ¾CùµÛ\\_–ÿi‡K~)‰·—\n8Ïß^EI¹cùéÌŸä9úò\'Ñ±†V1ùíã÷$	‹w%¶õ†‹ëŞkÃñwÙ_7NÚİY@.7:gí®\n		Õ±hSN_j4òıF}•¡QİK7;æì}^ö™±æNÚûVú}EÄŒİÆÊ¦™»…#±Öw,›S÷=Á[R(“/±éX±òH´”aíÙÈ(àdgö\'7fsÆå8F\rİÍevc©»ör|Gö~&‘5ë‰>·ÁÈsC)dNÂÏ¶ÈpV,–*l¶\"§²v*ÎJîüiê{u)‰³’;?œòÎw©anêEwç“¼³”(Ö·ñİ;ÚÖÕW_Íu¾n\'r1ñÆ-tíhÿÔôÊçc©øÖ|\"È¥ %ÎÙN:ØŸüÛ]Üt”5¨²4(væRÙhË‹¦‘e¹‘ùl,‰Ëš\ZäÜØ¾œÄ‰¼SJö„@øòÙ—XPn²â5$OŸË²÷Œª™Ç7ÎŠ­ “È›ÊÈ^ß” Ü˜ÃÍ\nÊs;¸‹ãYİ™ãrQZ“îÔ±4Ç>\":?ï‚­õAy©k_—´ô(²\n#æ.#êÇÉºè ì|1§óHsÊğ>ÿ°Üqˆ\\ÒtÎÚid¹Íid¹5õ9`ï\ZÊs·9]lwéğ·Œ&¬G\rù›vpÔXéÎÀŒölúş4·½;½Â‰ó¦ªY}ô\'bB¥‘ÕŒp,ÒŞhdYÚ“–8gÛÃÈ²Âr›SX‘KTœ•Üùİ)/!¨O—h-\nËÒ´Ä9ÛÂ²¦aˆˆˆİEşª¢4ÎÍ‡È%Mç¬Â²ˆˆˆˆˆ	…e‘6Ğº_‹´<³v\nË\"\"\"\"\"&–EDDÚ€æÊåFç¬Â²ˆˆˆˆˆ	…e‘6 ùŸr¹Ñ9k§°,\"\"ÒF>är£sVaY&¤±ù¯iŒ3–_¨8+¹­ş¿ñ¬;”C2­°ıç³4‡Ü\rñÆÒÖÓÖûW\'ØÌ9v’#»2ˆ4VŸOKowcçÕÒòw¦¼³´Ñ÷&ygıO+;?o ÎJnİO\\§e¶ŞóqéçB9ëMæ¼ÌEl¿´\nÍ•æ\ZxS«?\Z£sV¿à÷¸Ä~Á¯×T\'Áºg×Pb¬»qVrgBÚ€(2ŒunŒ[¹…qKÜZcMcâYwh%†’ØÒÛ>KsÈ\rXOØÄUÆšÖÑÖûW\'…¬c±ırO^ÀûÔÒÛİÌóÊäyø¯erºóó²\nÇP¶ñıîrôg%wRaÃç:Âf /d½.ı`ï«p0¹!ê®S$7©O§sİXå¼³”È²õé7V„29İy™‹Ø~ûz™Ÿû÷(ëÈ\0¢ºmmÆš8KOó}tçF??*¾¬à»ï¾5Vı šú~¹İùºc3ş_-W¬Áİ¼èííi,n1\'¿úš?½ó±ô~u–ÛÜ–\'‘¾ ¶±	?šñ,ÛNù®S„ıÖıç\\6œIZü$,7w¦üä1²Ó£Hî™AV¿ƒDN[À¸Å[ˆül,	ÏƒÿägI\' +TßÁ²)‹È6\r5Ä<“Âä‘ğû®Œ‚Ö³¹0œØØx—§¼|/iëaò$Ç¶\0ÌÈÀúoõÄëĞk*Ë‹\'\"\n²wÃÈÁäJâ„¬uË2nş³Äİ5ŠÉİº˜¸gw¸l\0½Æ“¸p:‘·@ù>²~Cr…SYÉ>²VÄü®½yÄ¼LÇ\rÂ»j›ÿB”Ï\ZG`AâÚ$ÆİêCUÁnÖ=š@æIãÊÌŒ\'ùÕ»©ÉõÄRÛwÚü&Û÷±Ä¶†éÓWQbºeänCÜé‡°şÇ^rošDÔ­§H¿-Šì)i,úïp‚®­¤À¶†Ù³í5bF	ÿõs‚:”Q’¿ƒô˜Elv>uû=‰…f5Ø‡ò‚2J+Šè1Àé}ª}øÎ«Vl÷–‘<<¡~;€Ø\ryD‡ù˜S¡÷aÙØÊrÏ6?µ¢nßë\Z„åqş°ÜPë„åKIÊò?rÏøûøæ›o˜?ïqŞØôª±É¦±°ü«·àë¯~5ŠïN›ˆ40ö¶›E-nÓß‹ÀpÎ^ÉaYÓ0®{wPÓuwÍp¼;†HïJ²¿\n$èæ@ü€Ä¹³é÷ÙbÆ\r¸Ÿä··‘ÿ&BPH`]7~½B¨}UÅşuÓ‰xhÅ!S™3¿®YC%áÎd=Ê¸GWñöŞÃüßë9R^IAV*ik^\'·kı¶€cİ½º$¾D¯“0>–¦¯·£ó23ÒHö!ûÑ_³b/İ~•µvL.•¨ö’öXÉë·aÛï(ë²ƒÄñÿIZnw¢ßÂt€èL’§„pdÙ•t˜¾?­?Ó_M#ªó6æŒ¿Ÿ7¿AâIø;¯¨Qİñ¿y4ãÂ³pâ²®j±Ëfá½}.1Ó_§æÎY$Oq·İÉıcs]CÖßöA@·M˜EDÅ\Z>¹‚Íw¦±rŞ ŠWİÏ¸Ùë)ûi™Ï‡IÌ‰ïOñ’_öà\"Ş~÷8›kEƒı>HöÆÃ”}œ¬U©¼¶Åğ>9ïÆp^ù×TQşYåà†¥ä–’hñqi—¼³”¬¥.E&RÈ*lîTÇÏC\'>6Ô”›¦g%·Ğ¾­ùÎë3N11é#ygí²\r§›4}_/ĞÒœºuç›NëH!«¶ËôÃñuš»!¯	ıº\Zùÿ¸gü}\0\\sÍ5<úxÓ?F\\JÎ}{sçÎê¡Çy›şv¨ÕÒ8…å+Æn2?:EßáO\08r\0å^ÁæÔ\"¿¨¿_Ì&ññ”¥­ÁêTçNÉº·È½ön’§şÏ\Zğ¬\r°îä§¼Ã\0Æ-H!’İd¬ÛM‰mUßÁ™²×Ù¼uw#_×¦¯%¹ëc;yëìm­6¶Ø;B¨úÛK,³qtã<’ß;EĞÆĞåæJr×ÌÃúî²Ö®\'»¶¬¶ÿ¤EØ*B°LâW°9Sb[ÌJ[‘S?P^@ÔÌ‡>Sşı›9··’#Ûíë\\ùö!ªş¹ŒÕ»9j[L~¹İú¹¶¶ïßJ¾²ƒì­k°:F¾)Ÿ…³×Øá¸ø×mï*6ÂïÖ_áÏqŠ«º‘ÄœĞS¬\\»¾şX4ØïÃdoúŠ\ZÎP¶éu^Ílì}jûóªdu,ãba’w&ÑïÈ\"‚{ö ÙVéÚ°•5:ï¹xÖÍ§|c‚{.ÂVe¬o\\ØÎRÂ>êApÏ÷\\O¹eÒ……ûFÔ×¡5…¬ènØ¶¯Ûı¸’}4›ömL.Ó Ğ»“11Ô±O=°–‡İ„Àïééúuô5×^ëòúRÖºc_\"-Oç¬ÂòÄ¶l}F°pà³Xz\'{Ùn—zë´[‰JÙ‹÷]°Í!y¤Kµ«^ñ¬Û÷*‰Pº‚ª3Æ®N.bÜèÙlşb q9Ø2ã›1\n{=;TR¾©öõWœùÎµ€OçÎÔT}T÷ÚV]ƒ·Ow—6ö¾ÎPå2<j,ÛMU>İÀâåIUå©º–¶ê\Z§ej¨úÚñ²âYoîàh]Ë&rŞš¯\\B¦‘qÿê8-gÜ^*ÏPãåCëIøÙİ,Ëõ&2ñ-¼“BD#ûİ?Üy¿ßq²ÌæĞ¶ªxüıÊ(q7Ã­º±›&SD\Z‚_Ù\"§é%sÉ-è†“ƒz,Í!±ß!’{ö ùÈ\0œƒn\\ ~[İOY©ãºï‚n!ÆFJüè8~çØom~ƒ½{>¬{ıâi.õ\"\"-MaùJrr¹…!„=5˜ Âİ,t3¿öèÚ¹LJÚÑ@Â\"a®CgG°AX€ã«î‘#èçyˆSH\\R„¿ŸëWàn|eÓFa™¸•š[G8Fa;Ó¹vQ—ët™S÷5ı§T~H¿y×#ìfÛVt\n¿ĞÚÈÂş”7ÎYŞMqyw‚§ÖOhPÖëYúù‘Ÿ\r¶Ò*¼{\r&ìÓABk—ÛMq¹ŞÕ/0gv‚ıñäª†a·W8‘cÂ›ñÁÀœëş¹gË+Ã38œ(Çë¨ğ>xÜë˜Û{˜Ì\'¢ˆ¼-•£şƒ‰ld¿rzŸŒÚú¼êNäÈşÀ*JÊCkÂhdëhN`=Nİ	67Ië| p\rèFÕ‘d\0—s¤ß¬úQóô\"ÊıÏ3Eâ8e ¢¶¿‘póŸhãÛKy¿çYİ¯¢Ç3)z<wÊêşh¬¾d¹¹ÒDä’¦sÖNaùŠRÄÂ¿\"è¶şu‘±’…=Iî‡9dí<@ÜÍEäf«¶±¿ë²>Ì!{ß2‚q|ÕıîÔ&áı²÷=K·ª2cw®¦db;–Gö;9dÿyvä¯ä¶iÈz#˜µ¯“ıå`æìßCÖ‡[ç[‰}÷uşi/~Sr°íÜƒmqp3\rÃ6c›;L`ó¾²öåuíÒ\r£œ°›eëwã•Cîû{È=º…ìfÎÓ¯á9ál;s°m›„÷»«Xöğôb¬U#HslSd×Ú‘ÎİÌIÛ\n÷¼Eî‡{°:É‘-Ï\ZÖ$<KÚÜñÆÒb[¶›÷$²öï!{ÿI6?cl<ŸÀ²¼,Ü¿‡¬÷óXØ¿ˆÌU+€gÙ|,ÛÎ²ö=DPÉ^²\ZÛo—÷ÉXÙÆçÕmsRHKM\"H¾¢ëç,E—’øSòK‰\nÂşúÓ<;^×óÁ2¿”üüRò\'DQ…¥|’WJşüğ&½UL^qˆ~óëçç–’mM\ršD~a1y…IX¼íëÈ¯{şw>úÔ±>ïpK9”oïÃÛ’äØnçåêQAöíÏİ{Èu_óı»nFC®#ãCIc–c¾qˆcßòX÷fıø8¶Ï~¬ÜYÅä·ËìÇ´°”DKV—Cˆ*Ìãƒû4‰üÂ>qÙ¯Iy×îóùÛÉ?~ÜX|IÓWÚr¹Ñ9k§»a´¹ènMÕ+œˆEd×ÍÍµó·„ãmÛİ`šA_K8U6ã<Vs}G€w\rÓ†c©Ú­vDÒøºN ‹76Ûac…+Óå]¹ÛÓıi¤OËJw¸­›óF~É¸$×ãyQ ‚d4V8éÅ{76C³m5İogƒójÑóª?K6C_Òñ¬;”D··{¸Ş=¤EîàaÔ>ïÈa¦±»a´Äm¸DÚRKœ³íán\nËmîËÒ¢¢–,>ïEmÒ²b7ä‘ÀVô›Ô0^R\ZŞ{™\ry$6ë>Å(ÎJnƒQôJlO›ÜR¯ÙìÜâ\rU6§û3/Í!¿É÷™¾ü4–[â6\\\"m©%ÎY…e¹\0\nË\"\"í•Â²´\'-qÎ¶‡°¬9Ë\"\"W,Ç=—æ¸¹eœ´´Öıs.ÒòtÎÚ),‹ˆ\\±æYû£*ítZ„ˆÈÅRXin&Ï‰\\ÒtÎÚ),‹ˆˆˆˆ˜PX‘v*…,Ç<Üéö°n†±ş\"LHcó_Óg,¿TÄYÉÕäKæÊåFç¬Â²ˆ\\âÆ“öF¦›Ciº£ìÀf¼™óÅÈİ‡í½}¸üjúålŞ¬î~ä€$¬o¸ùÁ¹ \nr¹Ñ9«°,\"—’^SY¸!Û¡<²ßÙÂ²¸˜“ñ÷NÖÅãaFY«gÖ-2nñÒjGG&‘şÎr?Ì!}şõx:Šûö§__Ç‹SYöj¶ıÈz5˜^òFô’†u§½_kêTëOXXÂ\0FÎ$íÕ=ä:@Ö+‰÷\02n~&›ßÏ#÷ıÒç\r2”m\'}Şãjìfd`]šÄ²W÷»ÖÔ©Ø7=˜g¬lŞ¹‡ì®Ë7Ø>g½âI{ÃÊÂ1\0#H\\kØ÷è6G\r¢ïÈ²ŞÉ`ºËÂ“Hşë¯¸­Ï²ŞÉ!mL_½…äiI¤ïÌ#wÃÌF¶Ëİ1€ˆy™d}˜‡mç–MvüÔúŒ¬‹ãI\\›Cî~«aÚÍ½|„Æ§ñûûcø}ê#„\Z+Ñ3‰rœÂÎ¦>·Ã…õn}€\'â‡Kë—™²œÔ)ÆZ`ìÒfÇ0\'u÷Ö–\ršË‹Kpjô\0©Ï9^[@j¢}=nOèœUX‘KÈ¸ù³×y±~Iâš­ä~ú.¶M‡)ÿú8Y«RIó#!(¤ş/”_¯‚\0&‘¾x*Áy¿\'fâ<öû9ş6!µmÂYö‡$Â>[Eìø6~1ˆÄ?§a©ëÍ;ÓX9oe¯ÍaÎ“kØ˜½ºts ~@âÜÙôûl1ãÜOòÛÛÈ˜‘Frtwrÿ˜Àœg×õ·}2²ı%1+öÒíWXİM\r	á¶è	xoŸË¸_¯¢Òò,+Ÿ·×U|ÄºYC˜¾ªˆà)OˆÉöÕêÏºWg||·ÂôWÓˆê¼9ãïçÍoGøBşyÛ°VR›JÚªõd×/\r$ë½ãT•ï#mU*ÖlÄ¸‡GPõ—DW¼noæn»Üƒ-,‹ò$kö/‰}ãó3HìåØç	³ˆ¨XÃÂ\'W°ÙeÚÒ]>òV%ğÛ—ó°íËã´±8ñéAJ¾0–Gş\'üû)\0Îş©ÿml`bËS$¤îâĞ¾ƒ×–í{‰Å/gãëÚò‚Lšx?Ï,ú¿öc•ÎY…e¹”ä,Ã³Ïx-\r¶Ud¾W„mëWÔp†²M¯“ÕèO\\ßN€ïq²f¬çèÉİ,K{ßÍÏe§Ÿ}›Œi¯sÔoQ.€Á6Òvıî\Z¬oºnC~Q%~¿˜Mâã)K[ƒˆ½#„ª¿­dá+;ÈŞºë»µe/±ÌVÄÑóH~ïAwÄ»ôUçän®ŞMÉÁ5Ä½wÿĞñ@™Û÷âyW\nqOj¾õ´ÿúéö]OÄK³x/ÈÇv\0ñXn†òÊ\0¢f>Dğ™2ğïOäÁ”šê×Ù¼ÉğSô&»ì|÷›7½^÷ëåïÍcÎÚÚ÷Ãıv™Ê«ğş-q?®¡üÛ\0út¬ªü}Î^Ãæ­f?s~ù»J£t—>÷²àù?³öÅ¹Ü?ÒBoGqÌ3KSÂ,Œ7Œ jcy½Ğ—³6-3–3µ£ğÖ;Ö×o(Æ+¨nœØœ—…iKşÄÚŸáÁ{\"Ü>e	/¦%32†/ü™§\'jºŸÜúş+ê¿Ğ\03I§NêêtÎÚ),‹È%£äéQD&¾NY¿‡Hç\0ë¦¹ùÓÌ×ãùõW”Õ¾~ï+j\\[4lÃWœù®3Şa.­\\X¼<©ª´¹cv+Q){ñ¾kÖ£9$ŸÎ©©úÈ¥±ÌV]ƒ·Ow—6u¾;ã\Z;‚ÿ4+¶—“ˆè%Sõ½Êtû¼è\0~ıF;FÎ¯§s‡\Zª¾vÔW\"ëMc8nššêİuÏÍ¶Ë¸¿ue_Ÿq¼ªäHÖ&²?u¼¬ù\n›S[‘Òè‰cè´}:SÜîòßb§ÎØ£¤]®­}î\\^/ïÅYLIHàÁ7N3è^Ç÷W¼ğèìa¾3\nß º,Õÿı1<‘Â”_â#œŸòğ â½ÿá©”§x½è48Ê/Ä¹sçêŸ9s†oÏ}ëR/\nË\"r‰)ys1	co%jëúıb´½°Cg|j|gmŸb1‚°\0GÍ{ET]Û‡0ÇH¥ÿ¼uÓ0ê¼wò}°D;^G‡Ü¡ˆÜM†v@ß‘ã‰¶¼2<ƒÃ‰26prtí\\&%íh a‘`+:…_h¼Ëú]ËYØ?’ãNS&œİÔÇ1o79!T•\'òğ<²¸ÙsYVˆŸ·½©éöUbİ°²<Ç°pé`7Åå>xW¿ÀœÙ	öÇ“«êª§—cª‡;×›NU1İ.“cà}m%éµëŸ=Œ÷œ\Z´sú:ûòÑ½T—^Du¶ågo¼/c96Š;ôÆâå…‡ã¡İ	¸ŞƒÓ_ÕM¾\0 äå­Tßù;¦M\\@ŒïG¼œåRİ,GaõŸV‘“ÍÒ”%üÛéLÕ9kwUHH¨E›rúB£‘ï6ê«ê^ºYø*{ÙçeŸkD.1kxëJÊÁ¯Wg¤ŒeòêpÒ>L!¢ãq¾·†¨İ±n‰§ouå}¨©ñ„B‰|\"–ævO7ÊKjğìpOï\"Òn‹\"xg)aõ ò1ûH¨uî\0jNVâİ«3kçõ¬1´Æ³îĞ,XÊäô,Ü’FTP\råUpä÷DØF“;ÒDğ×“Œó-¢üküü*Éš=”ÄüxÒ_~Ëµ§(§;U[{1îÉ$¿“Fd×2Ê	Ä¿zÉ¿%ó¤aÕKsÈ¿Ë‡r ªÊïb¬³G‘T¿İ^e”{úpdĞPi|û2F¦µre)¿drÅoÉš?¿êSÔxuÇûäzú‡ÿüídM	 ¼pYÃcHvŞ^Il~\'ÿòãänJùÈúc‰cdÙívõrw&±lç\"ıj(¯öÄÏ»kßQ,\\šCşí{	>×yÍ—¥«¯¾šë|ıŒÅ\0L¼q];ğÊçc©ø¶ÀØD.^Ãç²db(|¾T|RÌ)¯.øß¶ÿÅ\Z†±`M<şåŸñ/:pİMİáŸŸpªº+İƒºÃ?¿àÜ5ßrö{¾7uçlA%7à_úDjD\07tÇëÌi¨¶±øñ—È›²œTf1{­ÓÆô‰á÷¢ËW§ñ\nìÊÙCœòéB×ë|éÄY¨®¦ºâ4§}ºtœ*ıß^s>¥/ñ`ò.¦>·Å\Z§.›ª%ÎÙNŸşí.n:Ê\ZTÙ\Z;s©l´åESXns\nË\"ëOÄHÈ~÷°Ki_K8U¶úù¬ş–p¼m»İL#èÅR…­ÑùÍX,ŞØl®ë¨sgÙ©¤\rŠÁZ[Ö+œˆEd»ë×¬nà\"ØQ7××^¥j76cH®UW¸ÙÆFöÍlÜğ·Œ  t‡ë6ô\nÇâ½›ó¶Ö9Ïñjl»Üƒflëå¦±°ü«·à{‘ÁC~ ^F‡Wp‚ |woÅV=Œi£8˜ğ$Û‡ŒaXu1ç®?Ëöİy®‹\rÃ°Š­l;æR|Ùh‰sVaY.€Â²È%ïÎxæô=Ì²ÕõssÛL;\Ze½),·SÑ<qßYò¾»…N%g5v|ò³—lÇ7*‘h\nğø1d.Ùè2Çyà\'2´0™?îr*¼Œ´Ä9«°,@aYD\Z1#ƒ¬~‰œ¶ÂX#—…eiOZâœmaYø‰ˆ\\JUP¹„(,‹ˆˆˆˆ˜PXi­ûE±HËÓ9k§°,\"\"\"\"bBaYDD¤\r¸¹,[ä’¦sÖNaYDDDDÄ„Â²ˆˆHĞüO¹ÜèœµSXi#\nr¹Ñ9«°,\"\"Òf4T.7:g–EDDÚŒFéär£sVaYDD¤M\\¥Q:¹ÌèœµSX1¡°,\"\"Òôuv{ÊÃ©Kˆ¹	iñ¡ÆÊf™úÜr¦LYNêc-0vi³c˜“º€{kËÍåÅ%85z€Ôç¯‡- 5q8÷}tÎÚ),‹ˆˆˆ4[œı8™Ÿ~€íXµ±²Q¾Aé}ƒ±´[\"!u‡ö¤¸¶lßK,~9_×–ä‘é3xñ…?1áŞûŒU¢°,\"\"Ò64÷³}	½gi/ş™µ	1ŒÒÛ^xÇ\\~?ÛÒà¹eöŸøııÀ ø}ÚŸX=†˜ßş‰µ¢z4áeaÚ’?±öÅgxğ·OYÂ‹iIÄŒŒaÁæé	Æ…šnğíƒ9b$İ»uç×“Í5×\\SW§sÖNaYDDD¤YÆpÿ]lŸık¦ì*©/îä…GgÏ;uî‚G\' ¬U»x29™§¶SÍùG¤ıïaà‰¦<ø‡ÍOyxPñŞÿğTÊS¼^tš&tcªâ«ŠºçåŸ—óÍ7ß¸Ô‹Â²ˆˆH›ĞüÏö¤;]¨¦¸¹!µ(“mUÃxæÁDweß†­Æ\r\\ïÁé¯ê&_\0PòòVªïüÓ&. Æ÷#^Îr©n–ü‚|~·ø6¾º‘§Ÿ}Ú¥Nç¬İU!!¡:mÊéKF¾ß¨¯24ª{éfá«ìeŸ—}f¬‘6põÕWs¯Ÿ±€‰7n¡kÇ \0^ù|,ß›ÈeÃ‹Q³—p0T\\İ/ù¤ø×u\r¢»×iNUPqC\0ş¥/ñ`ò.†&¾B|à)>«‚^øv†³ßWS]ı%§«»Ò=lÿ=‹5S–“Ê,f¯uZUŸ~ÿè(º|u\Z¯À®œ=TÀ)Ÿ.t½Î—Nœ…êjª+NsÚ§;A7Á©Òñí57àãX÷Ôç–Ã£³XãÔeSµÄ9Û©Cû“»‹›²Uö‚ÅÎ\\*myÑ–ÛœÂ²ˆH{ÕXXşÕ[ğu=§WPı]™±‰\\Öz0pàµÓ™®EG( ˆ>?*áØ‰\Zn3…¾ÿXËë—¹´\ré2¯İ@aYa¹m),‹ˆ´WçË×wâª«ìÚ¯rü‰wş¿ù¿ÿmÿ_yİ¿nÚË.¤Ú~0«kjNõ˜Õ5£çr—ºföá\\_WÖH›óõQ×ÆPgls¾>jëi>Üí£YÓz7}9·áªúò+9,kÎ²ˆˆH©\rJµÄPêêig,»>j_›Ö5µ§zÓºfôat¡}8××•5Ò†&Ô;—ÿ­u¾>jëiB›¦ÖŸã¦i½›¾j9oë•N#ËmÎÍ)nÔW\ZÕ½t³°ãÌÖÈ²ˆÈ£±‘åá>¿3‰\\6öW¿tÅ,+,·9…e‘öª±°,r%jaYÓ0DDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ	…e\nË\"\"\"\"\"&–EDDDDL(,‹ˆˆˆˆ˜PX1¡°,\"\"\"\"bBaYDDDDÄ„Â²ˆˆˆˆˆ‰ÿÅ¢IRÎB2\0\0\0\0IEND®B`‚','image/png',1),(7,'test','test','test@gmail.com','ar','','test','$2y$10$8VyqNXr7NQh2Qzaq0HwI6.IbJTY.S9GU0qBzISrYXbWpFbl5uoi.m','SA','intermediate','job','mobile','2025-10-05 10:56:38','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0½\0\0î\0\0\0SXkÜ\0\0\0sRGB\0®Îé\0\0\0gAMA\0\0±üa\0\0\0	pHYs\0\0Ã\0\0ÃÇo¨d\0\0œ.IDATx^ìıwœ$×yŞ}ÿîSUİ=ys°‹EX`‘3@H$Å,‘\n¤%Ë¶HK²ıH2%Ëz,K¶ü8½²dÒA‰%YbÎ	Q A‚DÎ‹ÍarwWÕ¹ß?ªzfvvX,v\Z×w?˜îí©®[Wsîc€³ÀĞÛÿváE\00·ÅW?sÌúı¹9Ñãâ«—ôÔ¶ß»­ÕÍ{Ú«¯}*Û<’şRˆˆˆˆœĞâ¢c¢åÃ€€êËÌCºUìûq<ÇÎOå>\rp?Æß¨w¥úß±î—sÌ›·jßŸÊö?æ<¿ıcÛö3Í¼¾nõc©.–ªŸª÷Ø±fì‰Á¥ÿÆğc~/<µt|ç½ÿTöëXkÏäÿ¼¡Îj¼ã¶…çœ(o²\'2ÿ†{¦,|æïk9<7\"\"\"\"O·gşØë™Ôë¶`Ñáğs÷¨JV°çj\'ÿşn©~X6wé©¼¶OÕ‰ö^8Ñ²ÑÌ{¯=2ô½ã/>\'¦÷§’úyŠÉÿ©n[DDDDäDñL÷.÷íŸHÊcå8ïSÙşSİöñx&÷ç©l`æ}×Íé8¡˜Ù\\{ªşî“5‘åjñ±íµã±xOÔÇâm<Q[î?\'kOÕâß¢ölX|ŸOÔªÅ¿ÿd¹Aæ\"\"\"\"\"\"\"}H¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆˆˆô-…^é[\n½\"\"\"\"\"\"Ò·zEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘¾¥Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆô	Ç|é&\"\"\"\"Ï_vD8ô/,¼(\"²,wìğ¯3¨¢0-¾ZDäyËŸä+Ñü*}Òß9QM¿÷ZõôŠHpŒH8¢)ğŠˆ]\\ÔÇ-Ñõ‘ˆˆ,+êé‘¾`®x+\"r,z~‹{o[rÄÌ<}ËŠÈò3ıŞkzE¤?Or°&\"\"=K}[ºU¡Ö§á: ëÔ¢ˆ,G\n½\"Òê‚Uõìİê+má×š×Ô–:ÄyşY8g÷Èk‡}]Î}«ZF´dá\rED–…^Yv~aN0ğèdt	^T³Ò¼$z=-*ğŠˆ,tdĞg€Õ=¾=DkR&\rJkÌõøÎßê‰¶(\"òÜRè‘eÇñºçÁH‰˜GÌKšq+ÛD/À‹úVÀ-ŞˆˆˆÕRß™…eÄt€\"¤ #b$Öû†]ê7DDN\n½\"²E\"NiFƒœ´ÌIòYŸÁ<Ç=Î€™Õ¡wQ¯…ˆˆ,ÍëµÍ\\â<â!«Bo2L¤YBœ¾\"\"\'&…^Yvªå4œÒ¦whÆ6¡3Ş!X/ğ†¹²¤ÕºlG½‰ˆÈ\"½ï×j<ÍáŒ¢5«Ğ›á¡I‰ÍÀ9)ôŠÈ²S9ÑZq–´;MÓ;x=¤y.ôÖ=Á{?y\'\"\"•^Øusâ\\ùªÊ\\¤u$äa˜Ó!\nKˆêé‘˜B¯ˆ,C£€²CVÌŠYR+ë¯²ÅÁÖª¥7T½Y¤o‡W#–ïqQ†­«q3F$’“dÃtC‹’ôğ_9L¿÷ÚúLDd1œ„‚;$‹ÿz««8‹H_zæ?İ½“fO¥=Szóg{gä¾fŞŞÏ½uĞÇ(Ş…Ø%<M÷)\"òLRè‘eÆÀæ9F\\°NïÒ‡„\"ÒßùØµ8X>Q{¦-ş†{zï¿.‡p”ïĞŞ}”˜—XY.UñJDä„£Ğ+\"ËŒã)Ëw§*ªƒ.‘ç3·jHnÿ7Ç‰ÕzäÛ(¯‡+k{2s·™«òüäû \"ò\\Sè‘e\'Æê KK‰Èó‹W£[(«ÚGßgï;QQWD–…^YvÌê^†gïøNDäà@$PÌµùøyø€ä…—–ª,\"òü¡Ğ+\"ËÕÉWD¤§\n„{?«™½ÿ‹-¼ıá¿´¥~ó¹åõâª–AUHÊÁ!ôÖ\'w#ñ@ğ@À0‡$‚÷ÊQ‰ˆ<¿(ôŠˆˆÈ2W¿%.W?#¸‘F«+/£ƒY#)Mï²Ò¦X°2ÌÒ¢˜[“¶×{Zµ…IF4#·’fÚa$™beg”XT÷n€4¬ÍJ;ÄZ²š	\Z6…Ù,fù]D¤¿Ùâo>­Ó+\"\'¶eò	|šÔK\rÜyŞ‹õÿÒTq4’-`8itañ\\XêÓnİ;š`ı@›—]·UC%]†ùÂ7áëïÇâ|¯Áâ^dg¾ò3£ ‘•ÜråYœ¹q˜$æÜuß8ŸùÊ½t+ÉCIÃ;œ¼²É-WÉ`\n]7>şµ»xpï]š˜7£ß£:U­$88ŒĞÍF)BsñEDNZ§WDDDúD¯÷¶×\"WU‰«•eéè$¯ÿîğÛƒÓ\Zà)KV®âÖ_Ì[o¹”yÅE\\rÆzZ^’º<%xòŒ÷í.–:¬nd¼ôÊ3yóË.ãm¯¼œ]º™¤œ©¸gàÎú5¼ş•—ñæ×_Å[^{\'¯kËNRoiqèé_\n½\"\"\"Ò‡œ„œ–Ï2\',ÇiÅ²˜bõ!Q¨C¡á^Rä³˜•4²ª§8zIA$Ç)Ì)ÍëğüìqœŒÔ •Bâ9¥—t(C›h02KÉB¤AIŠ“Ä”f:„{º wúÙİw‘çŠB¯ˆˆˆô‘Ş,[HÜÉÊI¶¬ˆ\\ºuˆó75õIÊ£„Şêw{ı¾½fD,€#RÎõ{xöccoFH¼*Ô-)‰xıø	FF ó…­ªÇ™,xŒ\"\"ıO¡WDDDúHxƒ\rË8iÕ ïy×›ù·ïº•ÿô/ßÀË®<‰”bñ/Íq\"nUp„Ëëm–$¥“D#yf\'îUµNoA2Wa:«³kŠÓ˜ïÃv7‚\'¤F(ë­ôÂ¯ˆÈóƒ¾ñDdùyn5Eä„UõĞR-Ğƒy|»ù4×^}ç±Š\r+†Y3:ÄÕ—]Ê`k°Ç‹ë-;nN4¯‡	—÷¹ˆXİÒÌ	®³åÂ~áãø~2?¼-tØ¶ë{gn«ÂR^/áÖ{Œæ¸A‰“›=TË››×•ªŸJ/oïA=•ß9q(ôŠÈ2c$¡.Äâsÿ‘çµ^Üs#`„úû!M\0$D\Z\r°¤\nÆ½¶ ÔU‘Ğq«Öï\rxDç¾oêXÂmİ©zü÷°Àú$†l§œû¬:÷.U·ŠÖ‹è£ë?¹…¬şw-•.\"ËŠB¯ˆˆˆôÃhdÜöÅoòíû§·ŒûÆO~õ¦Ûùâ›/0_œj¹äº…Qw)î{õ‘ç#…^é/F Æ”‡wNóËÿöÏùG¿ü—üÌ¯ü!ÿÒ½e}f¹¤İ§DWD¿zEDD¤Oô†ïö†ä&„l„½Æ·ØÇcºtiá°\'Ÿ;¿•\'[…wn ñâ¿8Oç¶Ø3\"\"\'…^é‹gÄ\ZîFô„è	NJB =†\\ój) jÎïâ¿í9<¤.:¼øò±yúCïâÇÚÛúÓ{/\"\"\'6…^Yfü8&E¤_UËø8æNa‘ÒºDÑò¬Mã´¡]œ»j/¬;ÄöÕãœ66ÁúqZá\0qy}@txh~JKûxBğ‚sBtRwÌ‚`¾ôvÜªŠÑU£®Ä\\…ß§ë›náé€…Û|º¶/\"r¢[úXDäåşt\nŠH_ğ\0õ2E\ro“t÷²eUÉÜt>ÿì/ç7Şõ:~ç~ÿ?È¿}×ù×?÷\Z~ñÇoán:›“WvIóƒ4¼\\P¥˜+õdß7ÕmÌ\"x+ÆÈ÷1Çi–S$õ²GU(_êw!‰8óõ¢C]mùé³ğ¾åQ‰ˆô…^Y~t´&\"s§	d$DFı?põéü§_ø!ŞıÃ·pëÕgsù¶œ{òÛÖ¶8c‹+Oæ—­ãŸÿèuüî¿ü!.=u”VwŠàóP5J \0‹˜G`bDF‡,Ë¹ü‚MüÔ«/à_ıÔËxùe›dŞ!«×EÛ©¢®ƒÅj`ŒH†“~ÃïÃÂøìßÒJ\"\"Ë™B¯ˆˆˆ,[†Óğ6å8›GrşñİÂ/ÿÌ›8cãJBÈ)´I˜‰\r:P0D´([4óÛ7lä_ÿüråö5´˜!3\'ˆ)­$Ò+õì˜Yİª{^,ÍR^ı²ëø¹·ŞÌ+¯=›s7¯¢#æ:È8çJey‚Å¤P]VC¶Ÿ Ø–ˆˆ;…^yš¥[ô0Oè÷Š.Å<bù!Ö´ùÙ·¾”Wİx)F§tÒŒ‰²·ÌØ›ì+\ZŒÇSa€ÜZÄØ‚nÉ)k[¼úæKY9Í±zM[7#ÖA×’$9,øVõ¬Šœ’çÆÎS!uØ¼a‰G¼î^x¡*–•YBæ©Ï`Å!RŸ!\rîK¬­äO^SZDD§Ğ+\"\"\"O£ŞŒÑ\'J¬½%…ŞÌëLO´À(Y9\\ğ®Ÿ~=/¿æ4\ZÈì‹)Ÿ¼}’_ÿƒ/óOûüø{>Ì[Şı~ŞöKÁ»çÓ¼ÿ³³¯kx–P¹ô’³ØrÊÛ˜;Oqê®İÃz{+±~¤	eÌèï™b\ZèX±fM5c7TC——bIéx{¸“-ëJVDBÙ®çÏ/4÷Œ™EDä	(ôŠˆÈ²Tõ¯{;<Œ-ÊÆŠ\'‹¶ãÔËÛ,lups°^!£^óª¨ÑRí™³ø±şT÷¿`ß‰@	”Å‚€÷äªù°†‘VÃvëH±¹Cùçøğ=ªö¡÷:x¤±Ë`ç\0«Â+³.YìÆ‚¤ì0œvyóÍWğÂË71wx¼]ğGŸz€ôÃ¯şöŸğ¡OÛ¿û0w?´‹ÇNsïîq>õÕûù­÷}ı?şûxHÎŒ+Î9º3Õ^¸UCŒ=Ö¡³÷ú…úÒü°g(ÁºDwvìÚCáP–ÎŠ•¤YŒx9÷xrO|İ‹ùıßüÇ¼÷WßÎ½äÆ’iÕ½y}ÿ½×Åòº8V¥Ú¿j¿ÿ©ú#\"ò|§Ğ+\"\"ËV­-V‹¶Tõ-lGuäv‡Ç¹¶pÅëc‰Ùß¿Åû]Pê…ğÃG]ÌÉÃatá––æõòAõBD¼ìò)\Zq†]RœàÕ}P/XB½nd¡àü3Öó–—_Æ;ßr#/¿î\Z±MƒœĞçâ36ğª—^A°À™¿ÿşÏó{ú)¾÷ğArFH³1’0@š´ÀšÖ l2ùì×¾Ëßër‡Ä\"gl9¼ÄÌæ1š-½ª×—’º0Ç-a÷Şı´»ÕRD££\rFGšàE}áHUñª‚Õ+\Zœ»u-§­n°eÍ\0™w	õıT¯GıœêëE¬ÚX}¹>qà¯yşRèyJ–iËE5µx{•ƒşUœòFÕÜ›DO1š×Aº^Â§:œuòkÓ$í}„¼MR//Tı÷p½^yó*â%İCÜxÕVŞıòÖ[Ïá–kÏf¤‘“”³¬n¼ı®cÍ\nÈƒñ×Ÿ¾“O~ñÛtJ#	F†‘y ‹½f¤–9Etî¾ç,q<”ŒáîÄ‰Î\\Àœq¯{¼#@†Ó ÒÀCF$0>1EYVa3cllŒ²,ˆKÍÏ…êÄ@ÌÙ¿‚¢tŠÖ­[Gi5§×«[A\n$àx³ZÖhî­Ø{-EDd)\n½\"\"\"KX<ìx¾Í×­Úòû§t~NªÍ&³ˆ“lšÀ8œÔ»¤±CÃ™ªÕò<‹VTƒƒyU{˜Xù,›ÆàWî\rü»ù#üØ[^Æ`+©OTûpdìeA(À\0÷Ü½ƒéY(;pê†Œ4Œ,âu·¾€ÏYÇŒğáÏÜÍ>øU\n\"z8eˆäII7‰UK#E1Â`šÑ(,ï\"D‡¢ˆ	îu®c¸Ì¼\Z¢lõpgë\rİ„^$õ’˜·«0jh4\ZõI€¥©(\nØµëeBƒÑ‘!2Ü«áåÕóÑ[Å·z]ª¡ÏUGn4ğ£l_DDzEDd;lDò‚ë{ƒtŸÌaavÁoõú÷æçqö./l‡ÿñ¹?½xøåïËaómÎy}2ó{C/âÆŒà½ Zí/^%]†\nRflä¬„²Mğø$÷¹àQšUózói®ºğÎÚÜâ‚m«8uó:ºE›h½gæHNõûn1\nËøî};Ÿ‹ÎhÎÜ´’ó·®ån¹œÄ#wß·›?úÓOÒm`eFCç¶6÷¢`æ¤ÁÈ¼ËhV²}ëF¼€àĞí”Ñ©ÊXU=©D7‚Íf£\n¾Á‰©;YtR/É(i¥Ğ»ûPÍ„6{¢÷c ¤ƒ88C·[à¥18ØdÕªa äf9FN CÆ,ƒÍ\0^â8Å‚Æ½‡\\çîÃîuî_bÈºˆH?Sè‘eiaœ«‚Ru}p«Ûâ_ğ¹á»~Ø¼Ú*â¤©é¿»xC½‚D‡Ç	7Ÿß^çŠ¹éÁGd‹¹½>&‹¶q¬Áwşê…Û“7mdÕè(V”¤î$N]ú(<rÙ%çpÃu“…¶œ4ÂË_zYZ€Õ2>GùW=Õã\nDV·xùK®£•ÂøĞÇ?Ál‘SÖ¡·\n¿K©N5”Éìš˜açx5{ve.ŞºšW\\{1[VÓq>şÉï0~ĞiyJ+\ZM ÅÉÜiÄÍ¡&98É…ÛÖqÃ•ÛhÒ%”‘İ{-@¨¼[Pä!$$–°iıj²Ôğ<\'‘F,hÆ‚¦ç‡H+v¹pû6²´zeéLÏÎVw~,òaœhràĞÓ9Á ™%ğYo“Ğ&¥Sÿšë\ZlZ?†{Oƒ%sïçŞ{kñ«äPŸè…ğÅ·éO\n½\"\"ÒGœ4uÖ¬Ä|†*¢lZ=H#í\r\r˜A,#î`Ş%Ä)VŒ›OZÁ@Ó”òj§ÕC\\—ˆ©î‘±±&ÍfYUù]¦çÕ¥%™Áp6­ŠÚõ>‰W­Şò\\›¿çÅ­×K½0YÏÿ¾Õá3Æª°êœáŒÓFØ°®Aš–f$IÕ“cÁàP³@š´ğè;4Òˆ³pÉ#á‘×UéãÚ•l;¹E,ááÇñ»#„V½û‹‡H÷TÇë	æ†w»<zÿƒ„ÑyÑåÛ¹éŠ3°n—ı»wL?ÄUgµ¸ê,ãê3KnØæÜt¦ñâmğâ3áÅg:/>ÓyÉ™Î+ÎIxÛ¥ÃüÒ/á_üä-lYİ\"\rÆd‘ò¥ï<F7Pz„`tÚ9³íS>K9W_°…_xíÅ¼é²an9§ä¦í97œİå%çÁ+.äçŞp?÷æ+£ƒì›ìph\"ÇCŠ%Krø4y1ËÔTIŠ±&M¹nÛ&n<{„ÕäEg5¸a[ƒ›ÏmòêË×óÎ×ßÈÚ•ƒXšÒ¡Á¾²0BÓúÀ®z½ªR[‘àN4Àz±¼\ZÒ~Ä;ZD¤?ÙâÃ‡Şñ……EDN(î‘à¼;Î@œ&¥Ğù»ç­Ã‡È\ZÜÙ¼q¯~Åõ¼ï}`*oÄ6?ò–WğÉÛ¾Ì£;‚µ0J,B0gå(\\ó‚+9ç¬MìÜÕá/şê“tK\')Hˆ–ÔÛ/ë%l\02£(fyÃë_Æw¿ûmî¾{X:÷~tÊºpnà‘$–gn]Ï+o¾”ßı½PØ¥e$uÍ¢?®Ş’5GÍŞ­ê\\_í`½9±NQÕïÆ’—Üx-í™C¬æ®»â¼óÏæî»îàŞûÃ’B€\\~6ëÖó±|m[WsùeñÇùEfÊeÈê¹©GKU˜rœ¬˜åÖkÎæ7~îÅ7şæ“_ã×ÿã”­õä4aÉ!ÎUx6Ÿ/:Èèàg_=ïxÍ4Ë‚”.PPàt¢1İ²—¡{Ã˜çŸ‘ê½aPF#MƒY m\0I$XÂ´7øÊ={ù—¿û)vOv)-%#0ìãüüÛ_Ê«oÚZ÷ì\ZI	¼ [”)Š.ÍFƒ,KI‚xÑ¥“ñWŸıÿş}š¢´FïAÆˆ/X•Nòë?ûz^yéfbé˜œ “\0±:éN–­FJ#Ip3:$ìêò+¿û	¾uÏ^ºÖ¢‘†OsÕYëøíz+«ZéNäş¿¿âówíg*ŒÌU3ç¾?ë“*æ8‘hNˆ¡A#t³QŠĞ\\üK\"\"\'Œé÷^û¤ßt\"\"\"\'¤Åq©‰å4kW‘Y ó+s¼˜bÕXó‚Ô µ’u+xÇ¾‚-\'­àıòaşìıÿ—\"¯ÖT$uÅâ*ôÎ­WkUYâE—fê4‹e½OIğ²7@#\'õ‚4–X,É‹6»¬m2r,v‰¡$†ùŞâyÕåùaÛóÃ·çB]Šç†=Çj÷èè¿ø‹oç”SN\"¸Ój“ç\r¼„hìxäQ^~óY1ÈèBaOê%…æƒc/\"y/\0-ÚÃŞíH’ÀØØ`ä¥³kß~ŠXÖU‘{[]ZïdÁ\\sh·ÛDƒªU€¡Ä‹6­P°j0²nÖÂºQcí¨±v4°v,eíXÆêÑ”•Ã)+‡al(ÒÌ\n’ØÅòH×ìm—¼ÿ“wrp¢ÀÉ0«N°Ítûå{Ù?)=¥,º„8ÉØ€±jÀX7³aV¦%Ã^Ğ*\nb§ƒ·Zì88Åç¾r\'9ƒ8Ù|Š_Ì«ŠÌE	ããXâJVŒ¤l€\rƒÆÆÁ„\rƒ\rÖ&´|†Äg07J|÷¡}ÜÿÈ>Ê4¥^Ÿğp/ê•\nJÏIÉë½çş(û$\"ÒgzED¤/T}Œ†G£`¬1ÁXë kVÂèØyÛÈÈªy¬¤”¹qÚ©§²ëÑİü÷ÿö^öî9T­¹Z-ÒŠõfºz8­t,–$±Å CšB·3Ã@#%¡¬gÆV}ÓÉbA(gÉb›†çd±f:mš£dÉ\0©¥4HHb -1¿œP’€‘cÖ%%’’’Hb=Dš@°@0cvv–¿ıÛ;8tèYÚàãŸø_ûÚ7øÔ§>ÁÎ;ùŞ÷îãá‡áßô\ZV$d>E3ts§Œö}&¤IÂèè(‰UÅ³Š¢ Ëz=ÅOã”eIJI°Ha)İ0DÌVÛ]Zt¼AÇ´cƒYo0ã\rfbÆtL™ò3¡E; ™J†™LGÙİæKßÛÇo½ï+üí7¦[¯Ák8„kó­ûçÿ|ğ8Øa2d¶1Ì	ÓIÆtÚd6¦Ó¡Ó¥İe:]ÉLñ_ÿøïøê]Ó\rM¢…£f^sH=Ğ	ƒƒD\"³e‡G:!¡“4˜\rMÚIƒišt²1f³’òå»vğûïÿ“İ’Ü«!Í‰—Õ(k2k©d©tˆÜ†ÀSRïj;rì€ˆH¿:şÍDDDN@ö,Cƒ‘wşäòóÿä-¼ûİoåĞxdçÎıxY`>Ş¥™¥LšfõÊµl>y#­„F#@ªŞ²|œ,NĞ`†´œf0‹Œ†\"ƒ‘$-‰1=5ÍÀÀ\0xÄ|+Ç±rœ$$!24HlĞÌ,qf:³$iF³Ñ\"¸“zN\ZÛ4(ôpVÿí J’”,Ë¸å–ë9÷Ü³)ò6±lcå‰Ï’X›,ädIABy¤Èsî¼óNfffq M[O=…íÛO%ÏÛäyÂ\'>q;‡:¼ô¦«h†YÎŞv:û÷W¡÷8joÿ-$$I=4<\ZY“¢ì{j‚­V5$ºã	Ó–±·l°»l²§l²7¶ØSöZ“=E“İEƒ]eÆ®2cg™²³ìè¦Ü}0áwMğ‡Ÿ¸‹ßzßgùÿóó|î«÷Ò)³j´Å¹~èÜœÉÒø³‘ó_?Ì}ôÛ|éŞY˜Jy´Ûà±î{hqÿTÆ7w\Zó÷ğÿğoù~ç/ùÌWîbÖ¡\Z†nx=4~ÑcÃI)if)+V®\0$iƒioqÀ†Øë\röÆ„]y`W‘ğàDÊ§o?ÀüãÛøõÿôAî|p…Ê²$8$^-©”{ÆxØÓ…}t’QroÖ=ËÕòªšˆHÿë}¯ÏÑœ^9‘iN¯ôTóAOÁKÖü?ïz÷ÉO²cààìÚ=Ná]’¬Í›ßô2nûÂì|t©—¼øÆsxã¯bb\n|Ìù¿÷gLNOsÁi£¼ìæù£?ù8Ä¼îÕ\\{İiX€™nÎÿƒÏpÿ}qååç²võŸøø—h5n~éÕìØ±›/ÿÃ÷¸ğâËø±·_Í,Âß|ì>şï\'?ÁŠ‘ÿñ_ı,¿ñ[Äã»°yó&n¸îr>ø±¿c÷T=ÓÕ›«®œÔõˆK^ğ‚ËÙ±ãyä>V\rÓÊŒ}{÷ËÈÕ×\\Ít»à+_»¬5Hcp·½íMüÑ~€éñ)Òàœ½í.:ÿşäO?¶š44lLóÃoy	œĞ\\Åßû™í\ZgŸ¶‚Ë/9?üË/Ôszªù‹Ÿ{¼&´¬Ë[_y5ÿôM\0şì·øÕÿúAŠæz\nZ¸Å%¶Ğüóa,µœÎ>şÍ?ıA^rÅFÈïÿø7ùïòQ¢\r€§Õ:µ¶RÕy®ÖêŠÓ022Âøø!ŠnN\'Oh6FH1:^ƒõf)¥å¸Õ0õÂI£1Ô\Z$dÕ‰§$M,Ei·;´g;4Òe&t£‘`^ÀpŒtv\'óH’Ïpòjã?ıÚ[9{İSÓşëŸ~Œ~íAÌÀZÄ˜Rä]’tÉé‚é¢\ri5‡<óªàW0#ñNÕã`Í@—Ğh2[dœJÉ£Q-+]|8l_JszEdyÓœ^é#–<p–şS½ºó¯uo@r^D¦ÛÎïãÎ»wğğãûÉİ)CB™ÓÅ0\Zxw’k¯8‹Zü«ßø0¿ñÛŸâ½ôq:]\'„&³a5“å,tíd„}ö«üúo˜ßü­ğïşÃg¹ÿ‘I¢e´§ÛeIäå í\"£h¬§LG¹ë¾üæo}Œ_ùÍğ+¿ù>÷¥ol27ÊBH(<a<O™ö6eÒœ<ÌÚ¬Y‘à^P\Z|î‹Ïƒ<†‘²iÃ(o{Ëõ¼òEçòC¯z·\\w&+G¡ÙhBÙ á³lŞ\0­¤Mğ„„”öT›F¶’¼ŒXÚ›¢èâĞ¾]œ{î™Üş;˜™éPxIYÆºg0­ç6[µ,Ñ‚SãoµçH(bÉÁÉIfbt.=ûT.Ş8Æp÷ ™OSšõâ^«34pª€İ*:œwêZ.>{=-wÊw?zˆ½í{»ì+šÌ8”Îµñ¼ÉD1‘gLu¦º™<aÇŞIf‹Œ\r¬Ñ °’”¡ìVÍÄv\'VÜ=#±$MÊ´ÁÁÙ6§ÛìŸ˜åàd—“]Lv˜œ¡(ic„˜\rÒe€²l‘åM²˜’x5|=s#Õ<ŞÌK²Øf€œí[ÆlÇœé\"òİ‡°k|€=“{§ŒıÓ‘³Æî‰Yf=bi³€YU<¦FnĞ	İĞ mMvÎ¶xä ³gª¤K¤eU‰û˜/Õ-mA•08Î\0\"\"Ï…^é¾`aÔ^SğícŠ7Qw2Œ²,˜™É\Z[IaORJ«!jçÎ¿ÿó<òØ\0Î8c+wŞù}d»víáàşÇé¶\'Á#<´‹ßÿß_àÀDÒÆ§sß};\'Ø¹{’vn6èv\n²$¥,!ıÌwùÊ7îÆC“ÙnÉÎİ‡Ø±÷ ï?ÈÄl‡\ZÄ˜É!k6iƒ]{\'ø³¿ú2\'ÛõŒÒ^‡-§làE×]Eâİªÿ2Mğâ$ìÙ³-›70¶r-»öà‘Çv‘¤‘ŒY²b’A›eIºØ,iœ‚8CHŒ`	³4Â8¯~ùõ¬[5Æş¯ğâ›.gÓÆUxYT}·V-YTYº‡w^ı™s#¸÷¡G™Ê%\'­âİ?ñz¶®\rû¬f¨Ò \'ó.™wix—¦çÆ#>C«»Í£Î¿áf6­H‰%LÏ\Zß¾û!b2Da-JkÖ­±¨eÄº¹¥”$XÒ ZŠ%\r	Ñœ²\Zç;¿ÿ¡*ÿÜ[¢É0ªUŸnĞh@’’¤MÒt€”H’Óèì¢ÕİÇ`9E£ìÒê ÚÁp¾‡Vœ¦AAÀ« ë™çdt°ü CÉ8·¾èB†Õ.<¼ë ì8HiC”6@á)4±¬‡ŞĞóêûÍÍ(ëe‰zïõÂ\rŠĞªŸ‹ŞKS¯\'}\\_ÇõK\"\"Ï9…^éUğÍó6¼ÃÀĞ \"Ñb]HÈ!¡ÓíÒÉ#¹\'´Kgã¦µ´J†\Z³¬_7^w!cCÕpTu©ê`ßB „„¨–¦q#NÚj’ÈË¢Zÿ7$¸W÷B¡Ú³„2:“…Ó‚z›y‘iÔ‘²\n¾fÆšÕkÙıøÒXU6œjÀmÊşƒmxd†¿şÔ×ùğçîäë÷ìfåê!V¬l³yÍ(#i‡ë.=‡õ#9kG¶±–<Ÿ$±’VèòÚ[¯â²ÏäÓŸøß½ónûÜmÜô¢+h¤ÕãŒVâ¡Ä­Z·øÉU †„‡vìå¾GÚäÑI,çüsÖñk¿øÃÜzÍ™lÌ&µ	†m’Ù,£Éƒ>Ápge¹“³CÜpÎ*~á·rİE›HrÃ\Z)wÜ½‹‡İ]½V0zkK;Jh¯Ãà¼ÅıØ‡3Œ-çÆKNáí/¿€W^~§´&éâú3GøÉ[ÏæM/ÚÌ)«\"‰O‘z—Ìgiù­òr‚ÓO\ZäŸüô+¹öÒÓHKò¾}Ïn¦»	!ÔË_¹Ö[juh™—\0ïYxEã’·/¼(\"r‚©–¡ìyN öy—>è[â*écEÑå´­g29ÙæÇö@È¨j\ZîK3gvvš+¯¼‚K.»˜sÏÛÆE—]Îlw–ûÜI^8¥Ç*hô6”fÄzˆoŒƒ¬Y»»ïy˜’€‡d®R¯3î°Ş5ˆlÛv>ü8ûL@H«û‰^W7¶ê½nÎ¹gŸÌîİ»Ù½œÜŒ2M(Í D2+¸ú’¹ó®{É1MÌ²ıÌ³¹úê²ı¼ó]Çß|äœwñ\\tù5\\|Ù•d­Aşîó·35Y°~õ^qóåÄ2å¬íçqé•W°á¤ÓÙ±ç ÷Ü÷ƒ#C®ä{î\"ÀªÂKó±«÷›¿&xup	´Û]ìçÊK¶ÑÊÁÛ¬àÊÎàòs¶pÕ9\'qÕöõ\\zú\n®Ú¾–kÏİÀ‹.:™—\\y:o|ÙüÀK¯äìSW`õ’N{fß{ÿg¹ÿñi˜%ó#m­ê•^\"åÑª¨ü}2£(#W·‰_øÉ[yÅ•grÕ…ÛiOL±g÷~~í]?È«o8k/ÚÆÈª•|÷ÛßcÛIë¹tË02ÀUç¬å–k¶ó£¯{1—s2Á»¡ÉãÎû>ğ<v° ókûÎ‡]FWwêV/©e	nMÊ¤I´tñEDNùíï«ÿU]@…¬DäDvôBVG¯gGï©‘şR½ÔN°‚¡F\n±d²ˆ¸e˜§7¢D+@(»´’H3‹ŒŒ’µšœè0>ÙÁ=Å,%R÷®Í½‡ŒhUÕ$ÃædIBäİ„FH)çNÃ,~÷€GFtÚ9yQrgn9Ÿª?5’ç–ëÏaâàA¾öµ»(’”ªÂM”V\r~öÇßÂï½ïLÌt @ê080@ĞÉav¦ÃàĞ\0!DÌ İ)Èc†F“œU3¦tò‚¼Ì 9ÆÁéœÙ¼C³X`ª]-ådxÕû=÷è½$Õ<äVèò“?p%o{åÅ‡’VÙ&ñ.NIôîu…g«+\n×½·I0ÒÚ1g6&t“¾í!şóÿş:\Z¸Y=¿x~ê±Xâ›â¸”?şêKø‰W_ÀZŸÅÉøôç¾ÁG?ÿ]~û=?BËB„o>>Á{~ë}¼áõoä•Wo áĞh\ZXu\"!zA×í,ã÷şìë¼ÿƒ_e&¶(ê0yX¯=w¡×©zşƒ–©•ˆ,*d%\"\"}Æˆ´˜j\'LwSÜª\n¾×½­óaÍI(-c&Oxl_‡ûwL³w2ÒaÒ¨ûjÌ¬Zï§jZe /#í2“¤ê\rí„aa×îÂû5 ejÆÉcIZÇµ¸(¶aÇ®C\\vÙ¥¬¤E—AŸa$N²6Ëyí-×°g÷Nf§fX52ÌÚ±A†‡È	œ*™ì\ZEc‰Üï¦™2¥í	íèÕğî-§óº7¿•‹.»šÉÎ\0;ÌÄŞb:o2[´ˆ4‰àKŞj_ç_õ|MºÖäÏ>üşúS÷0Sº4ªQ–“à¤Ø\\KÌ0wJ‡¼,ÉËœÆxñé/?ÆüÑÇ90YÔE®ªõ\rÃ¼×Â1µ§C\0=ûÑ¦¼Á”¥ì˜l³ãàvÍD&,£dì?4Åôô4­”Œ4éBœ„8^‚µ8ĞüéG¾ÃŸ|øLÇPŸ6‘§ƒ†7‹È2ó‡7/\nj}Ü»X…È^ÈíõR‡_P/e½Š^!d’ªkÑ‚Hf6W)×êíÍ½»êëªBGÕïRÏ/»FµVÌüNVÛ®¶³^`<Üäø,7sıu²õÔœ¾uç»™+®ºˆÁÑQşü¯¿ÀøT›½øÅ¬]·-[Nf``ï:€…¤š÷ê€!¤K!&dYB’¼àºKxğş{yè¾‡™™‰tË@´„2¸îÕã2óºÆ“ÕUëÀ‰aõÓOı	­®°¹GSÆwï}ŒGöæ%´ÆÖPX“2¤IRµP$)¤)1ÍØ=•qûı3üßOÜÅû?ø%öÌ@ÌZTK‡*èÎİoıº?i«÷qáÉ‰ºKŸ¨8¢Y]nÌãm¦c‹İİ”ÛîÜÍG¾ø\0÷ìd·ÁÎÙÀ×>Ào»‡wâÚË.ç”S(’”<kÒM\Zğ”xt’?ûøüÅG¾ÊLg\0,¨zô©ç\Z×ûUáşˆ}zºš-~öT#zÃ›MÊ¤E´ª·^DäD¤áÍ\"²ì<åáÍòüQ%»úBJªS\"ÕÁ¼y=Õ¼Z·ÕŸxnç|€]æç°ßöºêooW\0ë–Şß/©#yØOóÿ<[tF‡ë×¤l;ãtFFW219Áã»vòÀC»˜œ,Ic` ‰ÇîºeV{C³İ«ùÂFBY&¤	Şò¦Ù¶eŞs¿ùĞ—Ø}pŠ\"M(éRÕğJê¡µN¨OTOÍ‚ÇS?àÃŸ©*ÄÛÜ<ßH\Z\nVÀ™[Öqî¶-lÛº™µkV02b4›çpè³oÏ<ğwİÿ÷>zˆCÓİÒhãÕ:±¡^B	 «ÎG{Š™wÔ¼·˜9î‘²,È²÷ê–¦)1–ÄX’&4	$iÊìì,XğÏŞùc¼àò&í6LÏ8÷ß÷_ûÖ÷øê1=›ç)æ)‘Ñ\"¥…#Ş}Õ{yéıZö9ZÀ«¡ä1Äz½áÒ1ºÙ(¹ÍÏ=9ÑL¿÷Z…^Y^zå¨…ŞùŸ­~>¬µŸÈâà;ßøìéÍåtwÊ²¬æÖ&	83R3‘F’T…ºêu[KÄ¹\"\\^ÏÄ2%„PÍ¹MK²`d–ÑiC\':Ep¢u{‘un_>_KÄcyj‘Xt1/id¸“fIÕÓ²lRä‘è%I£”1‚aÄª—Õæ÷kşq›£íçRéhª{¬f_›bŒ$I‚Ç²ê	¶Şó5?×†Z‘n^â6D,ºİ³–Ô=è%Ø,\'ÖÃó§Ğ+\"òThN¯ˆˆ<o[àe>4Ó›Ïúìª†Vi4³ŒFš’†@š¤«–EŠ1!‚„<\Zyi”±ºí	î)PıŒW#zJ»h0İM™h;Œ2T¥¡Ì{=©óh©årŒy x xBğ÷€e-b:HÛ3ºÖb:Ï˜ì¦Lå)3eJÇÀ›	4Js\"‘$T}ÇÕ+ğì¿‹Uƒ¡SğÕIVÍ«§{uÙ,Ã=¥ğ”‰ÙŒÙn‹N(<Á\Z¤%:DëP„‚ÂBµÌÖâ;‘ã¢Ğ+\"\"²¤^ØíµÅ×/¶øöOoó^§U?;€Õ—­šİî^÷z:uèZĞXğÀ)±qsJs\n‹V)¬ÇÛ»ÿùğıT¹9Ñªù©Ñ¨öÕ\r,©†N×ó«Í’ª™ã`ÕşaUÕì…}ÕÏõs1÷<[{zTÏM5×;BZVÕ­½1B,ÁIª@l–d`à–Iˆ(½¤¤¬‡jW¯õ‰èÄÜ+‘\'f‹Ç°hx³ˆœÈlxs¯<<Õ…Šz?Ï½êàöT«öÎUm^4ÜÓrı‚€øŒ©çWıÕû½zÈ½kª°Z…Áúñ±K½}Âí‚Ç2÷ølƒEËäícvÄ}UÊ:˜R/g4w³#¶Sï‡yµo½a´VÏ#Æ«e©¨çe×:b3Ohñë¶ÀQ®>ÒR¯uïòÂçwáßÕsœ­w¯z„·rşq{uûùßXì™b?·E›¯\"Ş{W9ÔCªh½÷˜†7‹Èò 9½\"²ì-ôz4Ì#œ,TÇ½0PyúåD´THèé·÷Àáÿ„/~tOôLTr‹Ã®^ä¶Òc±p\'¼ßÅñrÙğ%Nm©Ç|´GxÔ7ƒú„BzHa	EHñĞ$–Õ¾ÄPP’âÙy:J¡Ğ+\"\'0…^YvzÍ!¥$£C(¦±XÖ†Ïê±ºˆÈ25ß³ì@$·„24)CƒN7#É(B\n½\"²Œ(ôŠÈ²³Tè5I„F(¹õ¥×²v,%‰]¯\nò\0˜/j(\"\"õçh9…Hšüõ‡>Îşñ€§C\n½\"²ì(ôŠÈ²³8ôf^’xR-õAdåŠÒ¤Ä½¯fÕùsRsWDdy	\0†Y¤¬‹m:4M,ªyÙ\n½\"²Ü(ôŠÈ²³8ô¦^êª¨ÕĞ¼<VA·^ã²\ZŞ¬Ø+\"òDªoÉªx™SÍİ­–]J	^]Û½‘¯Y)ôŠÈ‰L¡WD–#Bo¯z³÷*¹uA–° ‹ˆÈ±rs\"%„ŞZÃn@¤¬YEUo‘eB¡WD–£†^BıuV`q÷jˆ¦JV\"\"ÇÌêÊ÷%XUÇOHæzz«0ì^\roVè‘İô{¯[€ODd™ë­9ºğ<^¯Œ•ˆˆ¯N\ZõÚç^­ì6¿Foï‹U§Ed¹Pè‘>ÑëåUÌ9^6f«‘2õx™#N\"*ğŠÈr¢Ğ+\"\"\"\"\"\"}K¡WDDDDDDú–B¯ˆˆˆˆE5¨ù°ÕÎMIDdyQè‘>aª8ÌzM3ÏDú_UµıØšâÚqƒxD‹uÅ#Ö×|EdQè‘>5_EDúİS‰_Oå¶\"\"ÒzEDDDDD¤o)ôŠˆˆˆˆˆHßRè‘ÊüªÛ½5bŸ½)Ç¿E{F×?şı‘\'¦Ğ+\"\"\"\'4s¯gUŒÊŸm ºµá|®Àİñ‡^Ç17ÌC½õ*\0Ü0_|¿KëİóüíïÏü-DDäé£Ğ+\"\"\"\'”ùxZÅ[Ì1\n°.1äDË)Ê.îN°@ğ\01¡ˆÒS\nË(’İ˜àdsaô©ÆIÇ)-	ILÉ¢‘x$¸“Ä*ğš¥8	î	e4\"	%Â¡p(ÃHbÛK3JKªß!€÷Çz{×«4-\"\"O[üı?ô/,¼(\"rBqïàİqâ4)…Îß‰ôsªÃ“ËâN3í²v¬IVÎà³31>1I·›c!PF§S€{À“Œ®µ $)…Uz¾—öØãoÄI<­¿iº–\0	`$´±b’@NJAæEÕB›İ)=PÒ±„\"iRXó*,W{T‚õ‚®w¯ô3Æ«ç/†HppRHÇèf£äÖX|k‘Æô{¯Uè‘åE¡W¤ÿ…úÈÄëõa\rHİÙ²>ã\r·\\Éş¿E£ÛaÍš•œ~Ö™´Û3`FéN»S29sï}rÿîIî}ô\0ãyF7Æ-[4„øX‚¯[’-âDÌ4B“YÖ\ZçncÓÚ1Nİ°š•,Ki42bY2Ûî29[rÿãxhç.Ú3Ác‡r\"”´(-ÃÍë~í,ìö(ôŠÈ2¥Ğ+\"ËB¯HÿË¢á…E¬lÓJœ,ŸáœÍ\r~á§^ÏÌ®{ùî7¾Áßò&†G† 5ÌeI’ŒÄ:.ûgrî¸\'ıÜí|éÇi—Ã”Ö\"ZB«.å\'Q…^·’@IJIB—Ğ™dËÊ!^tõy¼èçrÖÉ+È€48I(ˆ±jišBºİ’C33ì˜èğ‘/İÁ§¾x*è†1‚5À²*LÌO\n½\"²LM¿÷Zà=¯l\\òö…EDN0QBÙ!óœ@<1{E¤¶ğ ]¯“›@$E4èÒ,\'¸şâ­ü‹Ÿ|ÛOYCŒÙväÜó/\"ÌĞ¤Mƒ\"4±$£(’4¥ÙJÙ´a×]u!+†yøû˜mÏÒ\rM\"vŒoÉªçÕÌI<Ò$2Pâêó7ñ/îÍÜtív6¬&I1i\'S±É´µ˜µ¦½Å´7ÈCƒ$k2Ğ\ZdõªQ.=ï.Ø~\Z»ö<Î£{÷àÌ\Zàu€<¦}{6U;äV\r‡\0¡E™4‰–,º­ˆÈ‰#¿ı}êé‘åE=½Ï…ÇàÇŞÿÔBz‚Ù”Rğ‚H5§wmcšW¿èb~ô5×²±VÂ£;wğ÷ßø.ÛÎ;ûgïLd|ª –	+G3NŞĞâ¬ÓNfõX s\'¤_ºı!şàO>Æ·wB‡&¥ËwGõŞ\rî4¼Ã`œäå×Á¿å&6®nÑ-#Ægî~`>vˆGvÏĞîvhw:„àä\r#œ~ò\n¶m^ËŠV$‰9Ÿêğßşò3|ú¶;™ÍGˆ¬¬†9Û±¿~–¨§WD–)\ro‘eG¡÷ÙVx‡à«ŸëÒœrÁĞĞ¥â¬Q…jdoé‘\')±b’›â§^o¾õ:†’·&1&|üãŸáK_û:«·ñ‰Ûî£l® ğd®<•gÃšQ^ú‚m¼ñÖóY3\0I^É¯ç~í¿}‚Çg3ÚÉ ¥WÅ£zµ™ó\'k²˜Ğèä/ØÈ?}ÇÍŒ\r±˜ö¾|Ç^ŞÿáÛyàá}LLwéÖçyÜ3Ã‚‘¥F’ä\\xÎI¼éå×rõöaË‘C³¿ûGÿ—O~éAÚåÉä¡ºÏ¥>WÏ…^Y¦4¼YD–!\ro~úÙ‹dn½Ò¹µº¸ÕÏ±nF¬««Üº²°Bn¬ÃDÀM½½rŒÒb–kÎßÊO¿å¥eNH2<˜óïşÓÿ ÍRÖmØÈç¿ò=ÆóQº–‘×Ë2Š801Íw?Ä½ìãìí§0<’cõê<¶gŠï>ø(e’AİÛknøQæø:Fê%§¬à]?ù*NZ=@ôÈ4M>ş¹ø/ïı(÷í˜¤SD<1TŸ©¦ã@#yÙ±s_û‡o±bx=§²#ĞJ+Wpû·îef6¯*:ŸX—jg4¼YD–›üö÷é´»ˆÈóUÕ+¶¨Íd×C+‚Wk‘FƒhN´	TÍ<êuK«ÆüÏ@ÒËÌnxìİ¯ÈğÀèğo~ıKmàYƒGöwùÿñ7|í{39Óáà¡C4\Z\r0§Œe}r¢GB\Z°4£“ñùoİÇüÙ—Ù7Ó¥S:-çÖ›/gtÀ1ï€×\'fxÁ	i ¡ÃuWÃ©›HÌ°´Éç¾r/ÿã?Îøl-\"{”ÕÉ¹º%Õ©\"#Òb|ÚøıÿõA>ÿµ‡±$aÀR¶o>™ë/½Ì;dÕßÅ;\"\"\"ÇI¡WDäy¨\n	‘”ÒR\nK)-¡¬{q1ê0V@#¤¼ )»4Ê²KR´Ib—PæXQı?9IQ’EHİ^\rŒ±·©ÈÑ•!0O~ù>7ö%ßû›¯pÿı¼ìå¯`bbœ}»vsõårõ¥gE}¢&%yÙ¡°m¦É›Æ¿}w>¸›lÀ0JÎŞ:ÊŠw&«!ø°äÈê±eÙa°Ñæ¢sVÑ²‚Ôœƒãï}ÿ§Ù;“1cƒt,¡87(ÂæGN ’P`8n\r¦c‹¿şô7Ø?Ù&tKV&	Wœs\ZCY^dyºhx³ˆ,3\ZŞ|üæê{Ææ\næTQ8XÅ6¡˜!+\'²)FÂ4«²)NËÙ²ÎXcœ±&pÁæ!Îß<Ê…§­æì“Ø²Â8i¤`ãpÎi•´i²Ø¥A$-K,I«Ê¹Kê\rdñ^ÊóF5ê\0àî{áÁã<º;ãƒŸø\nŞaÃÉ§S&#$#›™ôQö¶á‘{!!Ô3s½ºÎe·ÃH\n7\\q:K‚Á¾Éœ¯}ç~\nªùæ½!ü‹(9eUÆë_z9ë[XÂç¿v¼í»äa„‚P\rû5êC«<``$õ\\ø€ÕË¹ŠhÌÌÎré¹§sêš&FIcl5şÜW™è¦œ`jg4¼YD–Uo‘eG…¬—cÕèÏŞ¥ù>(sŒ‚@Qù,£\rçä\r«Ù²~§m\\Å†U£lŞ8Æª•c6›´\Z	Y\0JÊiF2:eY23;ËŞ}ûhwrvîàGòÀ#ûxè±=ì˜.˜±n	e…‰¤¸•ÕPR¯ç\0C=X_êÏ³1:æİ:46(Èi6©ƒG#¤³y‹³:·šG0\'bD7B9ËÏZÉùWo¡Yv‰Vò™;öğ+¿ûçL–+)ÉêÚ#{{ˆyÎE››üî?ÿ!¶uÈ½Åôø?ÿfÃ¹gêİ…#¥ô\"›W±·°’h†9Z‡ö¶yû-§QtÚì-›¼ãWßËİ;JJ\0[\\Xë9ÌÁ*d%\"ËÔô{¯Õ‘¢ˆH¿ëõz%@æF«‘xÀ:N«0šiš³;Ù22ÅO½â~çg^Ãı…·ğŸ¸•ŸxõeüÀÏäÊ³Ösúº6\Z+š%­Ó\n‘Ğ¥Å,8Í 3Œ¤]Ö$œ·u—½•[¯»€Ÿyóù·ïz5ïıâWü:^rŞ kyŒFg/-s’€ˆ[Ö\n*ÏOõĞ^¯FuXHëŞÛ’„@™\"Ğv·Ä¼*’Vµ0W>-Ö¤ª³ûÆÌlrh•	‰e¬Y½#­æ¬ÏtXZpH“”$Í0©©i¼\0Ã Õ=;æ«O UÃ®{m~^¯$F(;´§& ş„šÍæŞ{L‹wdÉX.\"\"OF¡WD¤¯‰ÒXõœ)BÄÜiz›Ué$§ŒÌpİö~éGoâ¿şÊ;øÉ7¿K/8•Ã	­´¤aÕ‚Cet¢ÇªXQ¶U¬¹ëğº ƒ;Á KŒfÊêUÃÜzıEü›w½•÷‹?Ì;_{9—n˜å¿—±¸Ÿ¦wH$PRU°=j}!écq>üöÌ\rî©‡0CİlD‡è{G½hG§íP„Ú³úwK˜«2>¿ÍsH-PEYP”‘\"bÌpOpïJÕ%Ú–xÃ\ZÕr_%Ô‡^²ŒÄ¢\ZİP)h4œê[Ó\ZÂ\"\"r,ô*\"ÒÇÌ«^ª«\nÌF$¥CË§òı\\ñ~é/ã×ŞıfŞxËÅœ¹®Í\"µYmÊjX£‡êàŞ“#K\\×[rezñ#Èg®Ü~\n?õ†ñ›?ÿ&şÙÛnàŠ3FM¦È˜­†ušUaÆ¬êM“ç[r«¡Ëu¨¬+ˆÏ·Ãƒno|Cï²y¤ÙHHN\nãàÁIÜ­îQ>2¨Î3’Ğnw™í,%$¡ª]-Ş…Q}¾–\nÍ½m¸±î½\r‰40ĞÌæFcLMEöïÛTá]DD\n½\"\"},T%zÀŒÄp†‹q®9{ÿş—ßÆ/ÿ“Wpõ…kkN‘Æi(»4¤^’yµlŠ“TC/IÑÏ¸.xZ÷¾Í3Œ„jh©y5¬´é]6¯ä•7^Î{ŞõƒüüÛofı`‡Ø™¬†¥.˜ß+RÊù¥€zÍ»Üë%®çùÆ.­$çÔM+h$à¡¤ŒpçĞíT§â\\omo®ûbÆÄD‡İ{à4HcÅŠ&Áòjş°‡úäO/ø.Ö{èTK9%œÁlX»‚¢,±¤Éî½ãš˜™Û÷zÄ„ˆˆ|_zEDúÈâ‘•(­Äl–AÛËicãü«wŞÂÿûî×qéi«­®1È ‰aŞÄhbTs\0½^¶clKü»;fa®Ï©z‘		ë[ÜrñY¼ï=?ÎÛo>ƒ­ChåH-_r[ò|vøûkáâ@Ñê`iÇ”$d4‰\\~Ş™dÑi”‡JîüîCx¬ŞïÖ\0O»‡…Êèt:G™ÄÃcÁ™gldd$’²Rx¶ </hæ¸õy‘³jlˆMÆpwbøú7î¡›·êø^-{¤bn\"\"ß7…^‘>a^}©\'^©J¼*•2Ã°ä¦+7óëï~/»æLV6J†BI3R\Z\ZÕR+s-©bÖŞÕÁw/lK[ZµÃ¬šÛˆUıÑ\rwV7³7´ø§?x¿úÓ¯â’Sš4:û«å©œÃ§«\"Eò|3\0çßeõ‚@^‡_¯–)#\ZÅ4—µ‘ËÏİBì:Ÿş‡{¸ç±xhà‹æÎ>··º‡èÆT‘ğÉ/ßÍã39İ¶lYË/ØNÚ=Hg1/ë!üó£#z­zWÕç¡$¡KšsÕ¥g°~í0ğøşnûû»È¨@W{³¸)‹ˆ<u\n½\"\"}ÂêÿF4še Qf„2gM£ÍO¾ò~éí¯à¼S×Òğó@´”ÒepJ+q‹‡õ,U£ŸşCìèFôPµzèç\\ñ+Œ<Œ¤Æ‹/ÚÂÿ÷Ï^Ëë®;›Áî8–Blâ´€¤G¹xëÒŸê0Ûû¹^ë¶ê\r$Äªjr4Oi¤-’ÒhÎN²e Ã?zÃµlZ‘CàÎmşô‹1VR8Dëù\\A+zU˜{…©\0H˜I[|ùá=üŸÛc<I±4ã\'^/:#ƒİ=¤qb›HIéUıq·¤ªC!„jÛ±Äfrå¶U¼ñÖiÑ>òÅ¹gWÒ!°07Oxq{&>“\"\"ı.Ş³ğŠÆ%o_xQDäSÕb¥ìT½õ Ïw6Q«¡Å	]šÉ4§®u~á§^Ãk_r1YÈñ|†4Xıõâ>oîNŒ‘‘‘a¶Ÿw\Z„„»ï¾·Ç	õš¾pB?yÚÔaÏ\0$æ$VZN°ªŞ7Ş%ã„|?kf¹şüÕü³w¾ígm ·”;à¿üÑùæ½W¡yÁ€|‰³(VÕZ¦Õ>Ü×¬[µ-GjpÁé[If2½÷¼˜€Ø%ñ„Ì»4B$)Û¤^@÷+fÙ0<Å­×Í?ş‰×³rl™Òøôß?ÈÿşËÏ±¿\r`…£ŒfxÎŞïõÉ0ë-í ´(“&Ñ´À˜ˆœ¸òÛßW}Ç/¼rè_XxQDä„â	ŞÁ»ãÄiR\n\rZ‚×¡7:‰uhú4çl^ÉÛßx#Wœ2\rïTC*\r‚îY=´øÄì9êïI’„N0&òÀŸä«üå§¾ÊîñHÁ yHçªáÊóAµnFÁh£¤Å¢^n(R–‘¡¡AV­l±å”5\\ué¹\\pÚI¬Y9J§€¿ı‡ÇøßõeØ5AN²äÛ>Ú¢e’æN(•”¤	Yáœ´2å­¯}7¿p++3£;5Ë½÷>ÂWïº»İÇÎ½SSSÄ1ŒÁ¡AÖ­ã¼óNáœ3Ösúi\'30Øbÿ4|ú¶»øó¿ù[v(‰Ar‡P/q´d\r«£Ì—Æ¹á81D‚ƒ“B:F7%·Æâ[‹ˆœ0¦ß{­B¯ˆ,/\n½KK¼Z7ÄHÂÎXŸòoñÇ9c]‹´lU1¨Ş<Úê`Ú0K±aÌO3£´œhNiŸûÆ÷øíßûKt70[vôâCÒoŒÒ2Ö¶føÿï±>™!‹e]Y|œ„¤hfD3¦»C|ı=|üswñåoîdÚ¡«\"óswç-z«Û”8)æÁÈâ,ƒY—ÏŞÀ½á&.9£ÅX€à9í™)ÚÃO&…HI3¥ëĞI¾|oÎÿú›ÛøûÛïÆ=¥LRÌ PÄ<¡×§z…^‘§dú½×jx³ˆ,7Ï÷áÍUYÚê[İS[	VùW_¸Ÿÿ‰×²}ó(IY‚S…]«–êŞªHÕ‰;Ì¹ªôlõÓ*ÔoÜ°†µkÖqÇw3‘bĞÁöó‰[ÉpÚá­¯¾‚õƒ)C­f“V³A«Ù¢Õ ³@Z:S&ø‹|Œ¿ùĞ§¸ë‡hG°j8DıŞZ°İ*Ó%L†zyuÂ()1¶	±ÃÎïç¾ïİÁ½û8{ÛV‚å„²¬A£‘Ñld4\ZY–’„\0…s`bšÿõşò§ù1z`\'‰µˆdÕ¾‘ƒ•„XÄXò“¹ä•Ï†ê5¼YD–›üö÷)ôŠÈr£ĞkÁëÀk†ÕC›ŞæÌ\r-şñ;^Áù[W‘º¢mÀ½êÕï¯g/ª\\{\"r«†{&œ­[N¢™6¹ã®èÆˆ¯‚×1áùôvx>1ÀK\Z‰óŠ—]†%FÛ³:$Ä4!É2’¬Éæ“OáÒ‹ÎaÓúµŒïerü\0eQà!›ÚïæuQ¬ºĞÕõ½CÕ°ê^Á,H=§¦YÑêrı%ÛxõË®åÒ·°rõešĞ±”6	O˜õ„¶:Š´Ú·2MY½v%\'oØÂ\0‘ñ}{ˆ¥×E´H^j;ì±÷Ú’ÁüÙ Ğ+\"Ë“æôŠÈ²£áÍ`H=¡¨×üI^ròHÎïüóbÛ©MšŞ¡áà‹†HšÙÜ|Ùİ\\Oo¨A ™»®İ-øÏ~ø‰/1İ\ZFñ<!¸Q„ç.È3ÌŒ$I8ù¤“ªJãH+tñÒfó)«8ë¬œwÆJÎ_e$İ)Òv*ø?ø;şâSß`ªµ’f}â\'âÖª–Â²n|çîp~ø¿¬ìÒÊ§8÷äÀÏ¼í^tÉV\n¯Ö>˜Ã¿9Å÷xœ;¿÷(‡¢(\nšÍ&ccclÜ´†/>“KÎlqò‹œoİõ(ÿá|ûö”Ì¦+h‡&NUÙüD\n“\ZŞ,\"Ë”æôŠÈ²ó|½½µxƒÑ¸‘ÄÈª)~î‡_Âë^t‰wHÊ‚Ô{‡ğÕst\"‡^«—‹éq¯‚V¯íë\n\\¥Ntù÷ı%ûÊw‰éJ¨™±ªà‘º|ûOï¤GQõ@`î$!#XŠ…’`mÖ®lqõ¹[yù\rçpÖæu¬lUŸ‚?üÀgøŸŸ¼ƒı³Äd„pïUn®æô.|ç„zABÁ ÍrÓe§ò7]ËÆuCt-åş‡øøßİÃ¿¹ƒÇwï£t#F#Æêıì^Ub¶\0œ­›ÖñÂ‹ÏæeWmâ¬“Fh¥°kï4ÿıO>Åg¾ú0ã¾‚\"xzO ï6…^Y¦4§WD–¡ç÷ğæz€!f‘`F\ZK²b–×¼ä~à%0:Pæ¤ fu/ÕÂIŒ\' Å¡·ºr~¿{··œÑ@«Áæ-›ùŞ]÷0>ÑÁ-£½m…Ş~Õ{O\'IBUo¬\'2JOˆ–2İÜÿğ^¾òµïÑ\Z\ZfûÖµ4pÎ<u‡¦g¹÷ŞÇˆQZ\n1\n8|Pquî´šå47¿à\\~îm×³qU†‡È¿³ŸÿæóßxˆS‚Œh	Ñ¤DXÚ ´@´&»Ü÷ÀcÜù‡Y½j”õkÇJÙvÆvìØÃİÈCJYíY´7Ï¥ús¨áÍ\"²Ìä·¿ïyÔ=\"\"Ò¼ªcE´HjM¦Ù¾y€·¾êJVeÓ4âiôjÎï\\€<‘œŸº…=Óó?;iÙåŒ\r+ø¥wşk4æX¬–zYîY–Ö;Ò±PµêT˜ã”ãÁ)I(­EÇFØ5Õâ~àËüı÷\'Ï­ÁÀ¼úÎ9eiìâVın ¬+:/ºO„¼Ëék‡ùÑW_Áú–Ñ´ßüöŞóï>À=tèø0‘j\ri§\0+À\"Pbõ4êÙÁ™-\"w=r€ÿô¿?Å÷ÇI9iõ0ïú©7°e]ŠÑ­CDD\n½\"\"ËNÀ¼A,ºŒ8?ñÃ7²iUFfÎ\0Õ·«zÁ—\\öd™éœÅÎ<e„›¯;‡!›¦éEİû?è=–>åsŒ‚@‘ƒåx\ZØ3ÑæOşêó˜xh²j¸Ék^~#Í4Ç<¯Ç,]É<X$Ä	^~ã…lİ4D£™²{r–?ıĞW™ê&¤¡A  YrÉ£ŞÉš€{J5!R43î90ÎûóO1éS2:yå-W’„²~ß.µ Ñ\"\"ÇK¡WDäYÕaG†±ª—È¸E¯óœ„œ”œ“¼äšs¸æ¢Í$e$x Ö+Æú\0yyÍm]|pÿäûÄÈPyÍK®fËÚMŸÁ¼XğÌöğ“oKN$‹ßıOŞªw{(mn-ÛˆX£ÉwîÛÅ]÷c¤„²äâsNæ´“F1ï€Ç£W·¸áçÒNéÎ]äÎûvâõ:Ñ	±¹3óïájmìùw yo´F L¹ı®‡ùêwwCiW]r\Z[Ö“Æ<,İô~yJ–ş†‘gÀ‘ê•ê\06…ASZ ÒœÒŒè%Ä”S4˜bÀÆ9scÂ«o:ŸV9MVF†[ÄCItÇiÎ}ÍÏíİç‰Çë¥azmñrJ½¹œ[æ	­nÆëWòª›®\"-a¡¬7hôJZÕ‹°Ê²²ø³òda3,hLçMnûÒ·	\0\'­L8ÿ´$´1J<.2=ÿ9	^rö©ë8y}JY´I’Àwîz˜™¼ êÀ\\İw5Tzñ‰›^‹9Ñæ{•š”E‹Û¾|\'E‘DØ06ÀYFhùìaÁyaÓûYDä©Qèy®yu`›Å”¡0@£Hhå%Cù«Ã!66pêØ!.ŞšrÃ+yıõ›ùÙº…3Ö¯$”ÕÜA§{TÅf\"eİ–rÙ¼~úbŒ¼øEW²íÔ“ÈÊ’ù²:”ÕË¥\neIñ¹¹³‹õÖŞ}ôÑÇ˜™­O ctl”$yò\"L[·nÅ¬\Z‡<úØ£äİ|~\\ÆQ†5İÂ0SSÓäõÇ7M26lXsØÉùş(ôŠˆ<Ç07’h8´¼KÒÙK£½ƒ3WvxåNå]?üşı¿ø~ëİ?Ä/¿óu¼ûÇ^Áu^Íaõ¤*Şd«´»ãVµ~ç8sÆŒ×ÜüBFÒ’,æ˜÷â~µ«<?-ìµ=pà\0e	‘H4chd„$s\'Oö6Ã°ºhLOOC½”–™-QóùXÌÿN»İ!VSğI†‡[sK2‰ˆÈ÷Oß¨\"\"Ï¡ŞÄÄœÌŒ´hÚ»¸tûÿäí×ñ~çgùÕŸ¾•xá6Îß4Ìé£-NjÂpœ¤U¶IcÄ=Å=˜WkŠ.t\"iş~ôgt\'XA(s®¹ø$Î<iŒ,Î<	@Bâªêü|—„@Y–ªêç%†¥)æk6›UË-î]MBBÜ)#Õvzï¦ºÃvñï<EQ½×p?rDDäø)ôŠˆ<‡\'¥Ãp¾›MÍ]¼ô²Qşí»_Á¿û¥·ñƒ·^ÃĞ@€\"BnX‘Btb„\"¶ˆ^-‘]°¼Z¿xñö½W\Z«ÿÌMkFbFæ‘•­A®¾ô,\ZÖ!	%f)î)FZ\0’åaé÷ìü€à…—¿v)àÎØØ(İ!8“S“ey”{›7=3MFF\Z Õjæ\nTõzzëõÄd_3 Õhæ4tºE™/(Îux{êÃ©EDßt \"ò¬éUr\rà¸ÓôY†â®ß¾’_xûKùåŸy7^v&‡ZeARF$f«·aX‚…jnb¯‡jî~<@¬Â«!Ïıiî¡E\'\rĞL#}2£-«—.ª˜÷ÃÂMÏiŒ4cÎ@ìĞŒ9‰Ç¹¥·ÔjFm/h.ìÉ¯FPbµfµ;œ²i5ƒÍjê¯]È#‰QÉ:T&09İ%1#µ@wY½z¬[\r7˜ûì-ü.RíèQ®ÊYµ\"¥ÕpÌ (É©¼êí]*ğ.Şˆˆ<)…^‘g…ÜN5÷6-Ve^wÃ9üÎ/½•—_y+§#YÉÜH=`ÁJ<”`Õq5—°Ú®“VÕë¯ô°àOB2×#ÕÏÌ÷ª ×¶Í›8÷ôS ,„˜Şs§a£\':s\'+»ŒÑá†óOeËŠI1K/SµpCyë“=XxKJbôêo}Šk¯¾€4D2R¦§#<6A£4÷ººò‘Ò-ğï=LŞµêœ.8“$ëVŸK\"Ñë};ò×¡Ş£¥æıF@›Ë/ÙJ#-0‹´»myl7IÒêÛ©	\"\"Ï¶ş?9!8n%…u	aŠ¦ígóŠYŞıc/çığ­diBQO\ZÈ¢Uuš#e]¯ùùQ¥ùÉTËU³vW¶Œ«.ØJ“	Œ.E(é&N<Z\"‘LäŒ¼û\'nâ×ŞõRŞöªsX×œd°ìÌUån$ÑÈ\"d1ÒŠ%­XĞŠ9Yt‚\'D\Zä¡AI	>ÍyÛ6rÑöME›2$ì9Tpÿ#û)Æibs\'ÿFß{è1¾óàŒ¢˜eû9óä•$qšÒgÈ­C—7¯Â­\'ØÂVEòªcØ3ÏE¤QÌ²}Ëz.9ÿ,Š²K×vìŸâ±])Ë@=.äˆ¶xŞ¾ˆˆ<1…^‘g‰É¬ éä†KOã7ñ­¼âÚ³k#!„\'\r½N]eÖªµGç~¾WÃKÍ \"×\\v>«!ñ‚ˆSô¦[Ê	«÷Ş!pÓ—ñ’ëÏa ”¼üúxÓÍ—±ÒÒŒ3¤ÔÁ²^ÏÙÕ|mÉÜüZ‘²ìÚ4#É$¯¿ù¬ÎHNb|úËßc÷¡¢%˜C8ÊI‘’ÀDn|âKßb<&”Iƒõ«FxåK®b0$ÄCàíú¤JYµàx¯™-V-8N$x—–O±n(çm¯1c	İ¢¤í	ŸûêİìÏq2‚×#¨4ˆå\"\"òdzED%	NÒà¦Ë¶óî·¿œ7¯¡Ò²;¿ô‰ÕË\riXãqqwÊ²ää\rƒ\\¸mI™cuyïïõÜ˜z¯Ktø»/=À}M=cĞJ~â/æçø&Ö•4â,™Q\räOS\nw\nK(,£°‘#ÒLJZI›a›à‡_u5/¹â,†¼¤‘¤|û¡	>ğñ¿£Ì2°’„‚àå’ã“İòtˆOıı]|ç¡ıÌ–\rpË/á§ŞöÆ\ZÓ4˜%¥$µ£K$ŸoÖk¥åf0ßÏHv€{Óõ¼ğ’ÍdE’Aîİ1ÅŸôKt½Eš\r,Ş9N	ğ…W4.yûÂ‹\"\"\'¯ª—2ÏëbE\'j¿Gï\0ÚH’„¦å¼üŠm¼ó‡^ÄÉ+Z¤^Ö•XßÿÅóN?¦‡x´yƒÏ7‘’˜f<°cßøî#x€‚àiİ¬y½\'ºSãìØ5Áöm[lâœuú\ZNÛººãÌØCŞ™¤,&6DbéX„¬˜¥Y³º5Ã¥[WğÎ7¿”W^!‰QXÊã»üÿşô‹Üûø4kb„ªæ†/ñ¾07²Ğ hÏ235Íùçnap¸IjpÑ›9cÓ:òCû˜ŸÀ;’FÃcİJÒ²$)§IãAV5Û\\rÆ\n~ê×sËÕgÓ\"§‘6y`÷ïû³ÏpÏ£³D\ZÄ^ßó¢}ªÖ®Fz<»ª;¬†pSõ›„eÒ$Zoà¹ˆÈ‰\'¿ı}ØâÓšCïøÂÂ‹\"\"\'÷HğŞg N“R<ÇƒVì2Œh7\'Dc ÌrÃ%§ñÏßq«Gš$ENj½µ>­ª0{Ç:W·šK¸øÚçŸ2–Ğhqû]ñŸÿç_óøş	&;f‹¥eXÒ$Ú ¥7)-£´ÃŸáê•°ú}¥\'ô¹à±K3\\µıLŞùæpÖ–!\Zi¤\0ò<ç‘Ç\'øú·îå‡aÿÁCìŸef¦`xp„«WpúÖ\r\\tŞVÎÚ²–ÑÁF †„YüÇ?ø<ıù»™*bÚ ‰VM .$Í„@»4m†\\²™ŸûéW³~óYbaLÍ<ğè4_úÆw¸óîûytÇãs¿B K6´–ígŸÊÅçÁ¹§¯gÅ@9Eš±o6ò»¿ÿqnûúı´mŒ«Ş—‹C/Nôç ôºU÷\"ÁÁI!£›’[cñ­EDNÓï½V¡WD–—/ôHƒYtC‰[¤‘;’ğ¯ßı:N_“8|ˆ­ZCöc$Ïsß½›o>ğ÷<ü8wÜõ {&ššiÒñAÚI¤LJ7<.è1÷¤D©àûlKÒ˜y`ëú~æí×ré9ëh¥±Fì`Än‰»Ñ‰%eŒ$!¦)Fƒ²,)ò6¹CšÜ··Íÿü³/ğ·ÿğ=f’”uY¬Ş©ªWõÈÏ³á˜;U—ãçw\noÃ5\\³yƒÁIR§›çÄX‚GfÛ³¤IBÖ0Ò$%\riHiBQÓeä[Mğşø|ûÎû!iáÖÀhKÕ’®÷õÙ¼(ôŠÈò¥Ğ+\"ËÎ‰z½×Gè(iĞamVòò\Z®¹p#iÙEsJ«^\r|æD,@9°kï~Ş9ÉwîŞÁçÿşÛ<¸¯Ë´·h[‹M‚‚y•wzŸuÁë*ÅnU!§|šU+š¼ğÚ¹ùª­œ¹u£-ÃŠˆ¹W£$êŞP¯¡IÓxp×·}ó^>ö¥;¹÷¡GIš”6Š/u¢i©Ğë‘„‚HVÏ\nË!N³ií×_z!W¿…óO_ÍÆaˆ±Ş•² KSÊ²¤,KÌ¼šƒœ¥§Lvá»ä¶¯ßÍg¿|»µ	–I(	¸EÜ¥¥‹wç¹£Ğ+\"Ë”B¯ˆ,;\'zè¨f¼¥4c‡á8Á?ÿñ×ğÊ·æSØsßÌ«õ?å™áD\"E5g³^ó¥ğŒh>zOİv;úìWØ3é¤«pk¥”vÄ?‘ò,0¯{WëORïäƒÇœ+Î=ëd.½èlNß²‰5«š@ª“M1B‘Ã¡qøÆ7ïá;w?Ä÷>ÆÎñYº–U‰4F°¾Twé’¡×	ska»;!”ce+åœÓ6rÑ¶“8ıÌ-œ¶eÍÄiµŒ$@Yzµ¯ÃıÎpûw¾Ë÷>ÊwïßÁtÉË¤Z“7VëHWA´Pßçûù\\Pè‘eJ¡WD–/ô.Õˆ2œóò+NçW~ú&F›qfÉ…ŞgV¤š[í¤Õr2V`\")–¤ìØ7Í_|èoùØïfÏ¡ˆ7Æè$Mâ…äÙĞû\\9â$8£\r–c¤!e°5ÄŠÑU4³&‰Úí6SÓÓLÏÌÒÉb0ÊPUï6‡Ä«ùó‹?±s–\n½sÃ›ëK°P@œ´î‘Îó¡h6X=4B«Õdph€É‰IÚ.3í6S³3t½$ZÄÌI‚§oV3x­$â”ğjEŞçøûm…^Y¦zEdÙ9ñB¯Õ½½ÕÚ¡Á\róªÂô)ƒ³¼çg_Ë\r¬£È»˜œªÀÕÂ¯^…Şg×Ï«`Q÷@´„#		nÎ?|ûaşğÿ~ŠoÜ·—ÉÆIÄĞ;˜?âŸKyÆ,x®½úd˜—u Lªuo½şÜ{Z­ÏkK,7d†[Àê]«—®Šõœá%-zOwïm»\nÏV•SÆqÊPİ¾éà”xtŸ«EñjIa³*0[½oàÄ¹¹¼½Şè¤‹B¯ˆ,SÓï½ö9=RYöÌmî ¸xS\n\Zù!^yã¥\\¸}#yÙ¡Œu0Ø‚vBØö©ŞbNÖ1^]Ü	”Ä¢C+q®»ôL~í]?Ì-/8‘0Næ3õú­½ŞÁ£¥%yz-Œ‚^÷ÔW×;†Y\n$˜’4%$)¥;¥;„P5«q¬ê×¯^»úçêMpd;ªùı©æçÎ7·*È³@!©&‡º%)RÌ’zšC¯;!ªvXïôH‹ˆÈS¢Ğ+\"ò}è\nª‚:#!v8mÃ0/}áÅ4nÕAøÜa»ı‘g“Íw/	!âXœaã˜ñÏòu¼æÆs	¤Ş©_5zŸc‹D‹”f”–¹Oœ™Uï]¢—$IB’ôFLô–ïªzZİªV½ò‡‡ÖÃÛÑÌ2©nWß*–ÆjØ<%ÁB,ª>]¯Úa#ä­\níÕ	°*àV-¡´*+ğŠˆ<ıt¤%\"rÜæ{\0ÌŒ,$ä¼øúË9ySb—ÔJ2‹/1–†)Ïš^Èè½nf¬h©‹F‡2~ò\r×ğ†›Îce˜¤‹ª\"·\'ÏÑz1Ï7CèáŸ³cSÓãùÍ¥Å¹iÕ°ê\'ŞjoI2[˜x½š¼®P]ñzØu¥\nÄ½Ÿø^DDäX)ôŠÈ2s\"ÆŞ¹Uóİ¼Äc‡±‘„«.ÙBË •:)¶ààW‡±Ï½\'~\rbŒ˜GÖğSo~)¯¾áb†ÃM:U/áÿºÈR˜yö)ôŠÈ2cUÆô^øxn«Ò3ÔËŸ8g¹à¼­œ¼v”Ô/q·ªÙü°Z9±™CV¦¬h¤üÈënàòíkHŠC$^€YìHDDDN\\\n½\"²üœ@½nõĞD3’$ÁÌ9ïœÓnewª\n7NZ^YÈ)éÓ¬+øá·ÜÈ–M#ïœ³xÒúG\"\"\"òœÓ˜ˆÈqê\rnö^ø-KÖpéöÓh\'x5§0ÖÅtÔÃ{â1¬®À}xEm’„Ì Q\\xÚZşÉ;^Ëh66[.ª\n’éuíoõŠDG|Ş{¾úv´Û?QÓÛGDä§Ğ+\"r|ÑÏÇcdå@ƒ\r£$^­ÛënezåDÔ« XBb	iH	$xé4¬Á@LhåWl[Á.8‰Ä\'Áò*2×KNéÕío^MÛŸk‹-§»øöOÔDDä™§Ğ+\"ò}ğºòªy>ÃÙgÊğ\0„XÑF}Í.;Õ2FÑq	†ÑH\ZÜrÃX?’’zW•¸EDD–	‰ˆ‡^Q/?B„²ËÅœIŒ[ô…·–åÃÁ#eŒ”æN+1.9û4N	ÄY\n°P\r‘>¢¯ODDDN\n½\"\"ÇÉê/Ñ\0w†RVf4\'X5cÏñ¹5;ey	8`Äz :İ«šğÖW¾ˆAŸ%ó¢®Ş]Ï&`_›UDDDs\n½\"\"Ç©êåµº9+Ç†Y»f”ÛÕš½î\ZıÚÜ«I,ÉbÎ5—Ë™[6bwñME©füWM_\"\"Ï…^‘ãT-Wc„zÙšá‘!ÆFxá¸GÜËºÄ‘†¾öÇ0wVµ^|ÕÅX§ªĞíP\rrV®©,zç{¿\Z)1ß_ÿt[|Ïô}ôè»ADäÙ Ğ+\"rÌçWÑIÒ„,#ÅÌ0ó:ôjY›~àf``İ^pñ6V´¡.U¶ğı ù÷Q¢xa@\\*0>İ‡ŞgâşmO%œED\n½\"\"ß\'sÇ<ÒjµhfÔ}~Uå_éCfŒ4Y·v5x±`Á¢g\"$-G<’ê4€õz|Ÿ*_ĞcüL^xÊâé¾ß\'ØÅïãù‘c¥Ğ+\"ò´p\ZYİ(ıÉ0<œ±qí\nï))­.Zö¼íöv1wi§º(#Ç(êí<“êqFù´İo¯°Yµ­.ôzgyæ)ôŠˆ<-Œ™™iò%ï¸B–1w\'„„SNZK#5°²Z«Yù¥œáA£‘+Á½7sn	¨èà%ÌÈÀ«ğY x†>S0w\ZY Ù€`;Z/í1rwN³‘0<ÀóúoBı¦ÑGDä™¦Ğ+\"rœz‡ÁnuT^ĞîBoÅšêÿ½¡’ÇĞ,\'\ZÃÜhµšXĞëº˜Ç‚²3É—ngãúQb,V¯g}ÍÜ	1`nx,9óôS9ïÜ³)ŠÜ|®æÙ’Û9ì&uá¹Ã//¼­aàì3Ï`ë–ÍPØÌS8Ú}-~<Dçäk¹ùÅWã±Mp\'x <©~ö^\r\0yº)ôŠˆ£4(bÌ¶s¦g\0Kç^İª€¤¾œ~â€14Ô$ÕZ½‹SÏóXš$$X51–´¼Cæ³¤Ì’ø	9‰wH™&ñ6‚Hé’ú,©Ï’ùYœ!+KVd¬ +\"-4Ë’fŒ4Ë‚f,h”™$^	‰G\ZtiÅ.EÎ@Y’ÆX÷8W¯•Q-7–x‡À,ÁgI¼Mâ9«ÆX»b”%	‘Ô\Zq–Fœ!õ6ãõ0e#ˆ¸G\ZÓŠ9‰ÇêñĞ&)Û„8ÉHË9eÍ	³‰“0A`Š@—€Wß\Zö,\"ò´Sè9f¸U¡·4 	äEÉätQ­ëÊ|÷ÏÜr6êÅéUïıÈpFwˆõ°[¡znê^Ó–GVdí[OáÜ3OalÈHâIl³j´Ép3gíªV’c¸8óÔ\r\\pöfÖ¯nÒ°!!‹Md± »œ²v%«ZdeÎHØ¶y#çœ±™C)!ÎÒ‘ÑÁÀÆÕCœ~Ò\Z.>ëTN\Z );˜x|-‚•kW\rqŞö­œ¾u­4¼KB$æ9#sBÎé\'¯æÜ36qÒÚQ‚wñØex¨ÅÚUcJŒÈh3aıØ\0!vI¼Íš±&ç½…­›×ĞJsÌI(Àg8õ”aÎ?÷$¶n^K#Ô¨‚/¨ÇWDäi¦Ğ+\"r\\ª¾Ş*ş@4gÏ¾ÇÙp/ne}`İ»]¬ãû¼F9Qy5üÖ Kê1»õ{A˜{.¦ÛÎ:‹7±uë)¼îµ/cdÒ0Ã5/8WŞú\"n~Éµ¬_;J™OsÃõ/dûömlÚ´†o¼M›N¦(hRuÒ¶9õÔ5¼ô¥×aæ\r7yíkoæÌmëØ¸¾É¾ùfNÚĞÄ‹}œ{öF^ıªk9é”¬İĞä•¯¾†õk˜wæ\nK%!ráùÛ¸õe7²~ı\nÎ?ÿl^vód)à‘`ÕëÁ,ãõ¯º‹Î;ƒ“Ö¯áU/{1çœ¶™¤hsÆÖ“xÁUàe<ç¤“×pîù§S¬Ë¸å–ëÙzê&Nİ¼‘sÎ>b—2osáyÛyÅË_Êúu«¸ìÒK¸æšÀ#»ºz?‰ˆ<ÍzEDÓÂ¨-P¸ëñ4ÅÂÂ¯WÀö‡`†Yõ\Z«€s\'w —jNv<º“Ïşím|èCŸæ‘G÷ò²—¿’¼([ÁäÔ,ÿçÿüwŞygœ¾`9ıègøä\'ÿo~óÛÜpı5$!\'M\"îmÖ­äú^Ág?ói&&&¹ü²‹Ù½k\'ÿø\'øä§>ÃW¾ò5n¸á&ÊƒCšhsÛ—¿ÃÇ>óE|ôA¶m;…Ä\n#\'ÆIÎ8}\r_üÂøèG?Ç_şßOsÿã^\rÑ6‹”1çŒmgĞ-¿şğgùôß}•ä#ÜøÂ+Y9Ğ²£­Œ`]b,H³”Ö yî\\pş…<øà#|ä#ŸásŸûv<¶‡,Ih¦—\\p_ûÊWøô\'>Á_ıå¸ıëOªµ¾«a!:™\"\"òtRè9Õ Äj¢[Õ·UZÆ÷î{„ÙB)¨ŸE8ÆÄT›JæUó[Í3§[Ÿ$M	6Äı÷?ÎÚuIBJQ:>¶‹VkIÒàÔS×sèĞ8ÑSB2ÆÎûX½fˆAp:lÜ¸’7¿å5<øà½ìÚµƒ,KX³ºÁà`Æ¥—^ÆÕW¿ÁÁ1FF†£›¦fr\n±l˜m’F3ªĞëĞl8Cƒ‡ÆghµVÂ(w~çºİˆ»á^„ÈÉ§¬á®{ï¥C²cçn¼,Y36@sRJ/±z»`„±rå}tY6Šû\0÷OA	Ñ¸û»wsù¥—ó¢^ÄYgn%ï¤,ºÄèD’:êê½%\"òtQè9.U/ŒQ<b°dˆ»ïÛÍÎ=“s½5N¬\né\0¶o±\Z¦w#Ñ­×·)s3×#¯æ½ª?–€Fƒ«¹ïŞÅé08”{Ÿ“PªüyˆeÎ–-[¹ã;Ù¼ùÒ´ Ø4Áf9xà1ÚÏÁƒìÙs}è3t;‘4mbŒ.NAJ8³„”!‚g¸CY:e4bLI’!Òd\0HH‚“&I(ÁÚä”iBi	ÿÿöî4X®ó¾óû÷yÎé¾6b%@‚ E\\DŠ«¸	’¨•’¥‘G²<{ÆY,O’JªfR©¤<5•x^$•IjR™S5“*ÊqdÕÌ8È±\'²Ë¢µĞe‰¢$nIq	€ØïÚİç<O^œî‹Æ@ÜÛü~Pïí¾§OŸ{î½ÍşçyşOU\'ŠPPæĞo‘\"Š~`®)Ê@JuÿÒX\nÆÇ&)Ë6ıƒGùã?şSºïï=ü­Ï~”V‘¤öP!+/ IÒù`è•¤7áÄ[Ñ=¾)ÁÁéÀÓ/£Ç½¨C\"…&ú63€µ²eÆÚPÕ‰—_9L¯×mRÿ2Pn“S(Zí@saší[×rüğ4½…š‚‚HS\0,¥’çŸ?ÄªU“¦Éé5V¯n33èv2!Nğğ#?áÁÿšW÷ãCù%z½ŠcÇ;¤?æi~şÜÓìß÷\"¹î@¥Œäæ¢dÍz¹ED2ELtº™…LM¶(Òa&â.YÓf¬”	ŠT’ÇN³mã6ÆÒegWµ™l33SÑ­JbQĞŠ5ãÌ1Vö—=Ê³ÇçØ¸ş\"”a±6ôº]ê:±jÕjØÇ~ˆ/şŞïsÙeÛY½úêšs—¯$Gğ»Ãw´oûÍá›’´Ìd5¹^ EH¾hoq7¹Y¶$„ëÖ®ã¶ë.¥,›¹ƒHˆ^k\\ñ2„óyŒ/ÿå“<·o†T´›¥©à¢ı.^l\'.ç”@$×7^Ö¯£=6Å®ë®äšWòå¯|›™™nxç\rì?ğ\n¯¼:M(Æ9rtšë®¿†íÛ·°eÓ%\\wİõüğÑŸ²÷•×Ø¶íJÚã«ÙóÌ‹<<Ç]wİAQLğôÏáŞ{w³yËz6_z»w¿pğĞk\\ºm+­±qö<û\"\0›7m¢(Ûì{õP’Rjæd¸íöY¿n’®»Š];¯çé\'bÃúK¸ş†«yuß1^}å\0·İzWmßÈ¥›.áî;ïäé=/ñÜû8td†wİr\r›·¬gÃ%ë¸úšt{‰={^ N™{î¹ƒ©U%›·lâªÛY½j5ß~äqŞuûíÜ}ïm¬_µw¾ó&ëğÓ\'Ÿ§J%™f>ñ ¬/ıü0˜Ü!Sc¤P,ÙV’–Ş£Ÿ\',s7õ¹ïß”¤e%çDÌRç(“ÌQæføàÅÕp-S‚TsÃ•›øg¿}?ÛÖOĞf–vúGØ¬Fª•+“H±ËKÇÚüÎ?ûCÛÛ¡KRh.~4¿‹œß^½úÍ(†æTÈÍÀâ\r“™’ŠÍ—^ÆÔš){á%ésfãÆµÌÍan® N¢HŒ.¿l+k¦VóÊËû8|ø8ã@äøô4˜œœ`íºÕìßÿ2““ã\\yåe›—_~™C‡‘Rfjj’ññ)šƒ\\±zM›”H¹EJ©_x«Ç–ÍkÙzé&:ó¼øâkÌÏÏ31>ÆÆë8ztš™™i&&¦Ø¶u=“ãìí‡ÏR§H]WlŞ´Š­—n$xõÕ#dJ^;x„V;°fÍÛ·oenn†#÷3Õjñì¾YÆWM±yó›¦ÖÒ™ïğÒËû˜ïDrhõ«ÁwÉ!÷‡E/946b³r¦„r-İÖ\Zz¡½tkIZ6fØmè•´²,ÛĞ›eÎj.™*ø§ÿèopÇµ[˜¬»L¦…ÅĞ›±Gd%K@U–üèù£üıÿá÷9”×Cs!#õ—Ây;†^úÁ7ĞÌo‡’˜{„T‘C¢Ê‰X´!´úsy+Ê\"hÂRN5ô×;ÈM1§¢(ûÛgêœ‰±	^u]bu bQ4Uµc¤×«(cA-rªˆ1÷—**È© Î™¢¤T‘s—\"@„’²(©S¢®kŠ‰16ó“S\rÔä~¡ªœ#)%RêRÄLU×”åD3Ó¿ªh•‘”krmà²( %ê8ÑşšP%\"‘Bh-ËLÕÍÍœñeÁĞ+i…š}`÷rº„(I+Yÿi^àÿÏ˜­!…²¿¦M\\á\\¿¨LAJ|èIf+¨ClF¡æ@ÎôÛÛ/ğ²8Ğ	B\"…u1N]´¡œ …’ºq ¦ ¦MM\"åª	z¡$‡6)´I±$Ç’*j\"uˆäX4«]‡eóõÛÄÖ8¡œ Ñ¢¦E•\nB1Ö<?™\")—Ô©éUÌ¯¯R\"É±EZäbŒº9P‡Ê6u,ééåHZTaœ:´¨rn=PSÇqBkŠ:¤‰­Vÿ˜K(Æ	å$u£.&È!cAÎ-R1F]´©BI¯_r«™‡ši®‡%Iç…¡W’Î‡@ÿ%5’BÉ#íáí\'ˆı!ŸË¦ÇFoJè÷º=Şãû?|ŒŠÁÅŒı¢LowÍH†@ ¡GM¥ë¡>ğ¡š@EAµdàÙ`¸ô`òàvóµ?Ñb^õbËƒÇëßû;ùEóØLÈÍòC\'Zÿ>Š@‡@wÉ6KÚ’ã[<NºıÇW„Åï¯îÿÁñ4½åÍ”ˆÁÙ“$½Y†^I:/)ô{±bA.Û|ñKß`ßLb®€^lzoq‡ßÊkùÉ@š>Á&ìôÈô¨©yğ»OğüŞã›¡¬ÍÿJ\r\'M$-úç&/—á³Ó5nBr¦¤¦ì?nøß‰Xºøw²VOÖ„Ç[‡¡mNŞgSIı¬\'Ø“D2MÁ©Åç\\Ü¶éå>Óq6\"añ÷åÄY\\8q”.w&Iç‹¡W’~aÍÛÕšF,H¡ÅÏ^<Ê—¿ù4´é¥HÊ™šÑÎ‹mé®´L4c•û?Y “Bàø\\Å7¾óUœ¢¦İôìSˆıaìßæïa0œ¸ø,†fŞsÎ¡9¡ ‡Ğÿ»ü4=Ÿù¤ğyæ¿˜á^äÅ Ú|áôû:m í[|®%¡¶ùbÿ\"G<r‡·]lgÒŒiÊ}-=CÃÇš†z~%I¿C¯$\'™@‘L$ãÌ-´øÆƒ?åÅ{”ÅØÒÍµŒ •¡Ì5‘´è¥q~ôä‹<ÿê!ªP.»šA¯:Ÿ–È7\n’§ózÛ¿Ş>Owÿ™¶_zûqºıK’ÎC¯$o!Ó«æe‹çöá_}ñÏ9\\%º­±şO­™L*,„qV5òÍŸp¸U(I!CSZ©yÀôDJ’¤‹ÃĞ+Io!Ç@UNğ½§÷ñ¯ÿèav“£_/º%C`ïÌ\"Ú2F*]\nºeàë¿ÈCïe>ŒÑ9pÊ\\RI’´üz%é¼@IM¤K1É¿ùú#ü»¯}Ÿnur5ÙAA]MØmÖ[]Zì(õW5·u*èR’ÇÚ<ú³ƒüË/üGª):±M\"™ĞLõd0¯S’$-G†^I:Ÿ2‹kk1½Şj¾ôgóĞsÇ8RŒ³Zıe]š5JR¨H¡ôš¥Qì8<¯NôÊdÂb\0n†)Ÿ¨í¨bÅ|Qò“—§ù¿ÿUöÚĞš$Ósz?ó¡İJ’¤eÅĞ+IçQüË˜›Ù3!Lrøx‹ÿù_“oıx/3!RÇV?8%bN§¹Õù4<yĞš…£25„DÌ™HósÈDê¢Åk³ğÅ?yˆŸ¾p„n1Nê*k~nM!+ûê%IZŞ½’ô8…úı†2{÷Ïò?ı‹/ñG_ŠÙbœÆhiç­)RòX³~©iê-prğÍdêØ|ŒÔ”9Qæ\Z€ùºÍç¿øu¾ñí\' \\M)VX,Ë#I’–;ÿ-I@t#éFş?ü\Z_ø?áµ…ŠùbŒùêXbØŞ¬ íÅ‹½óe›—wùWğm¾şİ=Ì3É|¯¢Ju¿g8“{‰‡YI’¤åÈĞ+IÀ PR3½¢ÍñjŒÏÿÑ7ù_ø~ğÌ1:­	ºqŒšL= ê÷(ê-ÕÏ«)Eª<NÕšä™ƒ™ş{_áOÿâ\',0E]Œ‘ŠæÂ¹©ı|âÁ’$i¹3ôJÒ0LB€\\Rç	¦ëµ|õ‘—ù§ÿòÿãß~ıE¦§Û@—@¯_déd!+>¿I§¶¦Ç¶ÈB§Çßøş<ÿøŸÿ	_ıÁ««ZÌe I±×ìƒ(çóÜ$IÒr–^ªúÜw†oJÒ²’s\"æ©s”Iæúó/—QàÈ\'æó\nZÑŞœIäW‰-„TSÖ]&bÅ{î¸‘O~è&n¾j=k¦1%Ú¹F[PS4;<\r\'ê>7šåsŞ¾šèÙœ‘Á9şâàüU)QÇ@\"b›Cu›—÷áÁo¿Ä¿ÿ³ï3_×ôB&åV³°QÈ!%!7…ÇN<_‚œÉ§&êwºïwpÆÏÔ~ºÇœÉ™öq:ÍÒQ§sñæÅŸí¿Ù¡ñg»ÿó(7%ŞRLÄ™Êµt[kè…öÒ­%iÙ˜}`·¡WÒÊ²ìCï°¡\0¼xWÿİy>ê”)S¦‘\r«\'¹û]Wpß{vrı;6°~<3VfŠ”)S\"Æ~5è¨cÕT&ÑĞÛ¯«Üôà6Ã›bSB ‡šº5äVÉtyá_ùŞşò¯öpôX¢—[ıe¤zÔ´OÏMÊ…<v~ÊÿBßFÂÉ‰2‡·Ó¹ÁÉ;[§ÛÇ™4•ÒO\']”‹KÎÍë	¹eøÜ-~qèóaçz.ÏC¯¤ÊĞ+iÅYQ¡÷låš@yŒ[¤ª&ÒeÇ¥«øôıwòî[¯bçe±iZZ	ZE\"†Nşo›œÂâŞœÏ–8—¡Ò97Ã³Ïvß\\€ıë÷İ.VW†HÍšº‰Ì4s„±IæêÀS/e¾úÍóÿ~ùAæëqÚã«¨Rê‡Š‰Ö©=Æ\0Á¹Ö§»‹\ZzyĞ{1fq½ÙĞ»ô{>Ó9;Óıo1C¯¤ÊĞ+iÅµĞÈ„şz¾ä’L åD39u©»³lX¿–w\\±­Öró\rÛØ¼~ŠÍë§˜ŒµÊ\"Bî¿¹?ÇÀx.¡”sÓ~*ç²ÿÌ’ÛçfğLº_t*R×‰…N—c3s<{¨Ãã{ğÌ³/ñüóû8rtñ©5ä¢¤Û«šùÒDB¿—8…æhN9\"Cï©Áî\"†Ş3±ÿ·Ôülrˆ‹Q²éí=—çşEıb¡wpñçÌçìL÷¿Å½’V(C¯¤gC/âba$H¹\Z\n‹‘šzÁ1\'ZEÉš©IÆÚ‘ñvb¬Y½z’‹f(uÙ³õV†^ÎqÿçºïS5¡!ĞÊDææºÌÎ-0ß©xmæ:=È™2\'~kB çæzAAA öCoİ_h	Cïb°k†ïçş°ı×½œÖspÏœ\rû~›2¸İ!SjşrªšVŒÄĞüÕRˆ¤~ş<İšÊÃÇp¦ÏGpÆÃ=ÉY„ŞÅIÈƒß¥ÁÇ&ğ†¨ªš\"1Äæ—³ÿ·Ô<ò\röÿV0ôJZ¡½’VœQ½,y$BîAˆıyºH!S…LÎ‘\nò HVÿÍu éñjæ›.pœŞ¹„R8÷`úVïÿdƒ 4ƒ³“#åLÎ519B‹œš°[1kò.aè…şï_™uÈ¤ÅËFÎ©Îg/÷K‹ş¦?”½ÉR§1èñülC¿eRÊÈó&ÛmêªG(\"u(¨C$ÅÜ¼Íœ÷áç‹¹™\\ÇLÌrèŞÆªcê§`¨‡†ŞÇp¢pÖéılCïàUÿ{ë{1FªªGËæBLjí‡Ø÷3Ÿ³·˜¡WÒ\n5ûÀn\nàw‡ïlßö›Ã7%i™ÉÍğÕz½~á¢‹ñğühúpÇß¿\n2Esÿıs C æş[ø\0‘L$C\"„DB&4u›Î²åsjœòø7j§îãõÚ¹ïés¸c\\ì5¡ºB †&ÜÒÊBóY)yqhs¿:Øb„¸·»¦G}j¢Ç-»6pÓUkØĞêqüØ1r. —\\¹n½f­z†ã3óäĞ\"PP„LH‰H$DÈ!P)rÕ„ÙšÍµŸ¦§¶éÑ-RÍªØáÆkùønc¼cÿ¾Wù÷¿›¢åÊ+6sÅ›Øûê>r(10YÔÜpÕV›¥Î¡új&[ó¼k×zn¾úVOÔLßO¨JZa­·ïÜÀx™™nVÍÎ™#eh‘sóKVÓŒÒˆDEs”¡hzhs3í ÅH»¬Ù²i-³sÇ14A>W1¹hF{¨S‡ì¾Ë7N0ç¹ë®›xá…I”\'NÿwúÂjs0ò\"ÄñfëP,ÙV’–Ş£Ÿ?ÍxIÒ3xëz\"úUîG°Åmûù+yP´©>©€ÓÒùF­ÙéÙ·¥£¶ôñoÔ–>şÜÚp\0>5äÜôÛæ<hah¹úÜ,\'R¿‡·	¾„A4AÓ“›ê>ü{ùµÏ¾—›w]Æû_ÿ×_µ²§•¦ù»¿òaşÁo}’{ßµªy &†š˜;ÄÜ¡E¦Ì‰2×¹C™f(êãPÏQÄĞÉ”)r¢Ì™‚ÌX+óñîæïı§c¢l±÷åW(Ê’«w¬cr¬bëæq6\\R4CÜC\"¥«\'\nşögîdr¼ „æï$W=î¼ı]üGŸ}?»®ÜÌşŸ}’Ûßµ“¢îĞbO}ìşÁo}’O|èN\n:äP6£èA=K‘{Äœ(È”iVš¦¦	©ÓŒ¸¨­#QTó¬)¸õº­”Õ1Z©ÃÍrdcÔ´S‡¢7M;ÍÒª;´2ì¸tŠ­ëZl\\Ù±m5EèôŠüU”¤sbè•¤‹j¸>ğ‰è{òíSœŞŒÓ‡×á³;1Ş5YœI‰±V‹Ãñ{ŸÿSşà‹ÿ²Uré†µ„Î1>²{\'—®kñêóûØ0µš˜2PS†7½óJŞ}û\r„Ô¥Ì¡Çê0Ã§>tÿè¿ú5vm¿„˜*J\"E•h÷*ÚuMQw‡;ï½šÿğµïğÀÿŒ}‡ §ŒENı¾ÖD \"SQ§e+31e¨t!T´¨™9Vñ_üÿçş¹ÙÀ[/%Ö\\¿sW\\¶…g~†5“-b]“§(\";ßq)ıĞm´ãE½Àxª˜ä8İ}\rÿäş\Z7¾ãRÆRÅX„Ø›§¬f¸bmä£w^Åå«:Ü}Óv¦ò<ãu—‰”˜¨¸¤İá3÷ßÊ\'>pSyš±^MQ5Á9PQäš\"\'âğT†¥?IÒë2ôJÒ\nrºLé‚%)—|÷¡Ğ[Í?üíßáÕWkİó$W]±_ıôùÆW¿ÌÂô!Š0MŒ5ä‚:O019ÁêUcÔÕk¦ tó¾;nä®w]Åì¡Y59Õ4W]6ÉıïÙÉTz…ë¶üêÇï¦>r¯ıûoğ©ßÃ{oİÎªú\0S(RİÌ%„ØŸ!Cƒ%Á:‹óËùÉ£?\"¤Ì?ùÌÚÉ‚\'ôW÷ø[ŸØÍÃşMzÇfÏĞN=bİ!W­µlİ´±Ö8ëVMĞJ·Üp÷Üv\r¯½ô8›VM2*6Oöøà]ÛYríöUüú/ïæú+6òŸ|ö—Ø¼\n.[—¹aÇ;6uøÜßù0·¾s\r÷İ»“Şscİƒ”©9‘rI¢€Átß¶IÒ›âœ^I+ÌhÍé}3–ß¥·õæy.Ï^2W\\¶™#¯ğ³\'ãï»“šI¶ïØÊÍ·l§3Sqİ®+Ù°i?Ü³ŸÃ3M5âûö±÷å—o¼çŞÛØûâ3Ü~ó\\¾e?üÑÓ<öÄãTU—«/ßÀßûõ÷ÃÂ7ßp5wßy-óÇg™9z”«vìàï»êÌÖMk¹îº]üõgãÆM„v›\'ŸÙGŠc¤œX7U°ûîëùÖCO1ßdJŠœyÇ[èÍäÑï}›kwíbÍš6kÖ]ÊG?r³%×ï¼’u&yâÙ×xùà<!—;2Í“ï¡İêq÷İ·ğógæº—såöm<÷ìÓ<ñÔ‹ÌÏ-0^ÔüÖoü2“­Š^oší[/§mª\n~•¾ÿnŞwïí\\¹ãöï{‰ï~÷1rŠ\\·s±®¸åxşÅƒÌ/d6o»Œ?şU.‡Š¨…‹PÌªyBçôJZiz~ŞĞ+i¥1ô.\rfKoëÍó\\¥\\S„ÿÅoı2wİvUç(wİ~-?İs„Ÿ=ˆÃÇ\nÚEÁÖ­ë(Ú“|ë‡ÏrdfR;nÛÉ;®ºŒ^ã®;ßÉSÿ”ı{_åê+wğáûï¢CÍÓO?MQwøÌÇßÇî;¯aÛÖ­ôz=>ñá¹ï¾›™™«xâ‰ƒ|öS7ó»wñóğ•¯=Ìå;®fz¡æç/¦fŒœ3k§Jvß}-ßúîSÌw#uhÓK=~å“÷ñÉŞ@µ0ÏÍ·ÜÊŞƒÇxòç³,¤õP±eË::$ztûV”E‹kw]Å}÷İÊáC/°kç6İó8ìç²m[¹ÿşİíÕ<şø“ä…ÌÇ>t+|ßNîº÷&Zã$&¸úêIî½÷F6lXÏÔT‹]»¶rí\r;ùÈî`ûËY¿~5÷èÎÃÿıÇßeÕª-´ÇWñä—H¡$„AÅçhè•¤³Ô{ôó„¥“–\\²HÒr6ŠKéÂz½e‘½g«)µı²-¼ÿ½×³nm›ı¯tùÆƒpüø,½ªËäxÁ}ï¿C‡fùş\"ã3·ßº“ñöÿÕcü÷¿ı+yi‡÷`õªqn¸õN¾òíG8tø\0÷½ÿİ=yè{@Ø°esÓ^7rğĞ1=Ìå—o¥=Şâ¥}‡8:=Ëšuëèu*f»=z	R‚›\"ÿİßÿ8ÿãÿò%Î&ºaRbãºU|ôƒ·±iC‹×Íñş˜×21$î{ï=äøËo?B&®¾êrŞyı6¾ûGøÜß½ŸÙ½?ãµı¯11^rÛ-7òè_æ™Ÿ¿ÊÍ·ìblbùĞHck8|té™i6o^ÃØX›#GĞíöØ¼y#­V‹”‡¥×é²iãF>ÊÁƒGŸ˜\"ÄÈôÌ!Íyï¯A|Á¹d‘¤Êuz%­8†^iùyÉš±u\"ö×“­ûkÇ ¥ş_i Ğ¬wKÎÜsËv~ù#÷rÙº	œá/¾û×<üã§ùãS´ÆÆø¿¾øeö=Æú-y÷·óàŸ?ÌÂ\\—²(	!P§f-å:ôËš÷×ßÍdr€”—ohñßü—÷ó¿ıïÂ¡Ù\"9E	bŒôz½Åã¬Ë»(CÈ‰\"&È‰ë®ŞÊßşÄûÙ¼qŠ™éYzèa~ø£gø›Ÿù›¶lã÷¿ğ%å Æ¨‰d„fY¦7Bs\\\'İ×ÿxò2g¡WÒ\neè•´âz¥åex-äTÕĞŠ©¿Ün#Eˆä”CdŒ‘#İº¢$1U¯¦GI·#V‰¢Ô±†2Ò­ª& (ˆ”EA\0RJÔuİ_²êÔ×œ3­Ôá’‰Ó³a¬d¾ª “R³îî`»¥!w°¿“Gdrn–	ëu{”E›‰ñ©¢Óí‘#-BÈbÙ\"Èyh¬ÓT_êtßË	†^I:³ì¶ $IzórÎ¤~ \r!PEQ‹âD¨LM¦A˜«S¢ÓëB3Tw6eºE$—™\"TÄ²M¦$æL¨z)Q›e2İ^N¯K¯®›…™Ï †L-ÏC/Sç’H$§“Cò`íæaÍ}ô«@M£h†‡­±IRŒÌ÷2¡lC+’b\"•ËLEE¦†›õµû–¶ÁE€ã^IÒ›aè•$I¿°Ah\\C!2ŞAĞ+˜@\nêI!\05‰šD\"Ñ,šs äfhôàã`¨ôë÷|R,I±M\nª ”§lşºA3=Gı·N‘L$ÆB‹D‹DIÎıîíLÿøXìÙ}½¾İÁ9[\Z¼%Iç‡¡W’$½åN\Z:<h9@Kr?Hf\"„9T¤ÈäP4=¢Ä&ôæ@HıÃ¡t‰LÑßg ‡Lunæò.nó†AsÉ×ó üÚ`İ&‡\\Pæ’²ß«|ú#“$]H†^I’t^œÔÑ9öïCj@ÈäĞô„·øø<9_\'œ›	C-.ÓB3úœÓgn‚tâYBÓBì.õ[s;‡LÕo‰ş÷Öo\'Ÿ™7Û$IçÊĞ+I’Î›ÅĞÓİMeåş¿Å¨ÚÏ¤ÃÁn8â5OÍƒP:üˆ¡Gî@ÎÙàùRÿ¹†£Y@¨³‡1t‡£î	Kõ\\›$é\\z%IÒEÕD¹¸d®î‰¯0:‡{__O†›Ù7ÚôÌ†Ÿwé}¯giX5´JÒÅ`è•$IËÚëš’$é\rz%I’tì¹–´rz%­8ƒé|1_Ä¤·©³ëı=ÍğãÅ9Àzó¼’Vß/JZQ\nZ¹¤È!ÇóT¬FÒJ±4ğhª;/iÍ¿´ØƒyÀ7^®èí\'dˆ§´şùs³4SÓÂëÕ–¤eÃĞ+ij\nİŠŞä`ƒôvB8%üj¸\0•éìÍi^_‡Ït³îñ`I(IZş½’V¤¥oc};+IJğ5WÒŠbè•´²„Ğ¬ï),Z”$I’NËĞ+iEÉ@‰~E+I’$é½’VœL† F²©W’.€Á€æĞÌé¥yıu˜³¤• ,\n7õ¹ïß”¤e&r\"¦Š¢¡¨ç(rg±Ø\nƒÿfˆ¯‘¤stúÂ€9Ô$29´éÅqR˜€bœ:¶È¡Xº¹$-³ì6ôJZY©écHP¤9b=G¬ç)È„şìŞ@&æf;«¶JÒ¹89ô^=SÔäĞ¦*&ÉÅ9´I¡èWĞ—¤åÉĞ+iÅ©Bó’Uæ@Ló„j˜:”©G¤‘DÌ5‘Ášœ†^I:;§†Ş 1F\nc¤Ø¢\nc¤8Fˆmr$C¯¤eÌĞ+iÅ©š½9r˜zÄTS—@¹&R{z`ğ•¤³sj¹—ä0A\n-RŒ¤Ğ&‡„’\r¼’–7C¯¤§rÎ\0©\"äš\"g5¤\Zr\r9õçóöW“ô=™$¥3Íé-šR.È!B!:¼YÒ²fè•´â$2äLÌ@®	¹&æL\n,e¹_Ó¹_äÙ^^I:[Mè=åU3ä¡jÍMØ\r!Ciè•´¬z%­@¹‰¾¹ns‚Ü°¢¿ˆ†$éÍ¼‚æ¥96÷\0GB,!°§WÒò6ûÀîÓLÜ¤a0|ùßvIÒ/nPát\r€Ï8Z’–#{z%­0\'Ş~5=½rÓóËĞà;IÒ›“_§§7„ĞôòöûMÁ^IËšÃ›%­8\'z2©YŸ7çÜ¾ƒ¡Î’¤ó\'B$ÆĞŸHÒİSÂ±$-3†^I+Îğ»Ä~O/@^œÛ+I:¿16½»Í˜\ZC¯¤•Á9½’V¼ƒšsÌl6›Ív>[è¿Î_x”¤•\",}í²§WÒŠ•Ó+Io…fŞnXz·$-{o–4b¼’ôÖ1ôJZy½’$I’¤‘åœ^I’$IÒH3ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+IKä%M’$I+—¡WÒÛT&ä¦\r§Û@\"ûw% jòâ¿fÛĞo¤Lì§ÿ5rhö5´]0=K’$]†^IoK1C$õhB0U?èfbèQ„.äRÈÔRÈäNêrªH)õ_V£!W’$i™0ôJz›ÉÄœıÜ@\r9Aîà)r ’HÕqî{ßM¬¨(ëL+•”)4½Á¡\"Ğ!æR=Ç;vlaÃ%“Ä˜$rÎMjÑ ,I’tÁz%½­„ÜPriª{Ò%=Š\\s „‚ †—o]G+ÌÓÊ=ZTTDºM].İ¼–µS%ë×¶Y5iõCo3ÀùäĞ;x~I’$]8†^Io3œÜaÃ%m>ø¾›Ù¶yŒ˜g¸æªË™œhCh¦å6Ss3™u}˜º>HÎÇÈi–@‡\"ô¨{Óäj*\n2!õšãƒ®$I’.C¯¤·•ªªd6o¼„{îºƒù¹ÄeÛ®¦ˆ-ÜG«w”\rí.Ça¢®«\"ãu›ÛoÜÅ{ï¸™k/ßÈeS‘5a‰4Çx¬[³–œdH)øÒ*I’´ŒøÎLÒÛBÌSÍºÕãL´aó†õì}a}ÿ1zì	r·ËÆõ“ÜyëÕ|òÃ7qíöM½Ú)1 V³{m/Û.™âcï¿ƒ_ÿôn6¬j15ÖæÚkvC9ĞÌäm^Z‡—=rT³$IÒÅaè•4²KÅLÈîy÷uLµ8üÚn¹~ŸùÈ¸qÇfV—5eLtë‚^:Äº5mVOlÜÔbİ%Ÿ=ı(Çíej|ŒÙ™yŠb5U5Ïúu«i—!ôçÇH\nNz‡V3’$IÒR\0¿;|Gû¶ß¾)I+ÖÒbREè²ëêËÙûòs?2Ã³{~Nª»ì¼ö\n~öÜ&W­£ÛéòÌsÏsõ®\\~ùÕ<úØs\\Ó­ì¼ş&¶n¿†½ûgxäÑ\'¨Ã7ßqkÖòĞ_=J«hÑét9:;GŠEóŒÃU¬†«YI’$é‚è=úyÂÒQwSŸûÎğMIZñšŠÍ™\"Msï]7R„úÉ¤^Í¥[¶°mÛ~úÓ§¹ùÖ;yæù½Ä²ÍÂB—£G§™_èQ”%!d°ví::LUWLLNĞ«ôf¹åÆ]:zŒç÷¡ËØÌ’$IÒE3ûÀn‡7K\Z}9Ğ9-úŞ£Züê§wóçc\\qõ•¼zp†¿ùéqüèûÏÑe‚ºœb!•ôb›ùT0W,ÔqlŠ0>EÇ™éÌW-Ú“«Ø¾c›6­&Õ]ÈÙÀ+I’´LØÓ+i¤\r¿ÀÔPw(cÅúÕ#ÆU„i…HââcrdB¾.ÔUrMŒBÙ,\"E¨X·f’º®8:=G\n-Ç2K’$-öôJz[‘Jä8Nh­¡\\µÉõï ·×Ña‚^œ¤Ãu(©r¤\"’B„ÉDê”	± ÆrIuæL7™çğtEM‹œ!4‹/=I’$]`†^Io+‰@·{÷åùöAUR	T¤PCh‚,@ˆC\"çj1À†!„¡ŠÌÍÖ9Rhî!sZòÌ’$Iº½’FŞpáä¹Nónßp r<ñ˜D õ‡@/îghÓÅÛÑ—WI’¤åÀwe’FÚùZ-(„\01’½¼¡Ùã gwx»~ŸğyxVI’$ı¢½’$I’¤‘eè•$I’$,C¯$\rÉCì~&ÃÃ§Ï×PjI’$?†^IZb0G7ç|ÚvÒ¶gh’$IZ½’4di¨•$IÒÊfè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²½’$I’¤‘eè•$I’$,C¯$I’$idz%I’$I#ËĞ+I’$I\ZY†^I’$IÒÈ2ôJ’$I’F–¡W’$I’4²şç â O¨²\0\0\0\0IEND®B`‚','image/png',0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'programming_academy'
--

--
-- Dumping routines for database 'programming_academy'
--

--
-- Current Database: `programming_academy`
--

USE `programming_academy`;

--
-- Final view structure for view `course_stats`
--

/*!50001 DROP VIEW IF EXISTS `course_stats`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `course_stats` AS select `c`.`id` AS `id`,`c`.`title` AS `title`,`c`.`category` AS `category`,`c`.`level` AS `level`,`c`.`is_active` AS `is_active`,`c`.`created_at` AS `created_at`,count(distinct `l`.`id`) AS `lesson_count`,count(distinct `ucp`.`user_id`) AS `enrolled_users`,count(distinct case when `ucp`.`percentage_completed` = 100 then `ucp`.`user_id` end) AS `completed_users`,round(avg(coalesce(`ucp`.`percentage_completed`,0)),2) AS `avg_completion_rate`,sum(coalesce(`l`.`views`,0)) AS `total_views`,count(distinct `a`.`id`) AS `assignment_count`,max(`ucp`.`last_accessed`) AS `last_activity` from (((`courses` `c` left join `lessons` `l` on(`c`.`id` = `l`.`course_id`)) left join `user_course_progress` `ucp` on(`c`.`id` = `ucp`.`course_id`)) left join `assignments` `a` on(`c`.`id` = `a`.`course_id`)) group by `c`.`id`,`c`.`title`,`c`.`category`,`c`.`level`,`c`.`is_active`,`c`.`created_at` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `platform_statistics`
--

/*!50001 DROP VIEW IF EXISTS `platform_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `platform_statistics` AS select `p`.`id` AS `id`,`p`.`name` AS `name`,`p`.`description` AS `description`,`p`.`url` AS `url`,`p`.`category` AS `category`,`p`.`level` AS `level`,`p`.`language` AS `language`,`p`.`logo_url` AS `logo_url`,`p`.`is_active` AS `is_active`,count(distinct `pb`.`user_id`) AS `bookmark_count`,count(distinct `pr`.`user_id`) AS `rating_count`,round(avg(`pr`.`rating`),2) AS `avg_rating`,`p`.`problem_count` AS `problem_count`,`p`.`user_count` AS `user_count`,`p`.`features` AS `features` from ((`platforms` `p` left join `platform_bookmarks` `pb` on(`p`.`id` = `pb`.`platform_id`)) left join `platform_ratings` `pr` on(`p`.`id` = `pr`.`platform_id`)) group by `p`.`id`,`p`.`name`,`p`.`description`,`p`.`url`,`p`.`category`,`p`.`level`,`p`.`language`,`p`.`logo_url`,`p`.`is_active`,`p`.`problem_count`,`p`.`user_count`,`p`.`features` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_challenge_summary`
--

/*!50001 DROP VIEW IF EXISTS `user_challenge_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_challenge_summary` AS select `u`.`id` AS `user_id`,`u`.`username` AS `username`,`u`.`firstName` AS `firstName`,`u`.`lastName` AS `lastName`,`c`.`category` AS `category`,count(distinct `ch`.`id`) AS `total_challenges_in_category`,count(distinct case when `uc`.`completed` = 1 then `ch`.`id` end) AS `completed_count`,count(distinct case when `uc`.`user_id` is not null then `ch`.`id` end) AS `attempted_count`,coalesce(sum(case when `uc`.`completed` = 1 then `uc`.`best_score` else 0 end),0) AS `total_points`,round(count(case when `uc`.`completed` = 1 then 1 end) * 100.0 / nullif(count(distinct case when `uc`.`user_id` is not null then `ch`.`id` end),0),1) AS `success_rate` from (((`users` `u` join (select distinct `challenges`.`category` AS `category` from `challenges` where `challenges`.`is_active` = 1) `c`) left join `challenges` `ch` on(`ch`.`category` = `c`.`category` and `ch`.`is_active` = 1)) left join `user_challenges` `uc` on(`ch`.`id` = `uc`.`challenge_id` and `uc`.`user_id` = `u`.`id`)) group by `u`.`id`,`u`.`username`,`u`.`firstName`,`u`.`lastName`,`c`.`category` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_course_overview`
--

/*!50001 DROP VIEW IF EXISTS `user_course_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_course_overview` AS select `c`.`id` AS `course_id`,`c`.`title` AS `title`,`c`.`description` AS `description`,`c`.`category` AS `category`,`c`.`level` AS `level`,`c`.`logo_path` AS `logo_path`,`c`.`main_points` AS `main_points`,`ucp`.`user_id` AS `user_id`,coalesce(`ucp`.`percentage_completed`,0) AS `percentage_completed`,`ucp`.`last_lesson_id` AS `last_lesson_id`,`ucp`.`started_at` AS `started_at`,`ucp`.`last_accessed` AS `last_accessed`,count(distinct `l`.`id`) AS `total_lessons`,count(distinct case when `ulp`.`completed_at` is not null then `ulp`.`lesson_id` end) AS `completed_lessons`,sum(coalesce(`l`.`views`,0)) AS `total_views` from (((`courses` `c` join `user_course_progress` `ucp` on(`c`.`id` = `ucp`.`course_id`)) left join `lessons` `l` on(`c`.`id` = `l`.`course_id`)) left join `user_lesson_progress` `ulp` on(`l`.`id` = `ulp`.`lesson_id` and `ulp`.`user_id` = `ucp`.`user_id`)) where `c`.`is_active` = 1 group by `c`.`id`,`c`.`title`,`c`.`description`,`c`.`category`,`c`.`level`,`c`.`logo_path`,`c`.`main_points`,`ucp`.`user_id`,`ucp`.`percentage_completed`,`ucp`.`last_lesson_id`,`ucp`.`started_at`,`ucp`.`last_accessed` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_learning_dashboard`
--

/*!50001 DROP VIEW IF EXISTS `user_learning_dashboard`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_learning_dashboard` AS select `u`.`id` AS `user_id`,`u`.`username` AS `username`,`u`.`firstName` AS `firstName`,`u`.`lastName` AS `lastName`,`u`.`email` AS `email`,`u`.`joinDate` AS `joinDate`,count(distinct `ucp`.`course_id`) AS `enrolled_courses`,count(distinct case when `ucp`.`percentage_completed` = 100 then `ucp`.`course_id` end) AS `completed_courses`,round(avg(coalesce(`ucp`.`percentage_completed`,0)),2) AS `avg_course_completion`,count(distinct `ulp`.`lesson_id`) AS `total_lessons_started`,count(distinct case when `ulp`.`completed_at` is not null then `ulp`.`lesson_id` end) AS `lessons_completed`,count(distinct `uc`.`challenge_id`) AS `challenges_attempted`,count(distinct case when `uc`.`completed` = 1 then `uc`.`challenge_id` end) AS `challenges_completed`,coalesce(sum(case when `uc`.`completed` = 1 then `uc`.`best_score` else 0 end),0) AS `total_challenge_points`,count(distinct `ua`.`assignment_id`) AS `assignments_attempted`,count(distinct case when `ua`.`is_completed` = 1 then `ua`.`assignment_id` end) AS `assignments_completed`,round(avg(case when `ua`.`score` is not null then `ua`.`score` else NULL end),2) AS `avg_assignment_score`,count(distinct `pb`.`platform_id`) AS `bookmarked_platforms`,max(`ucp`.`last_accessed`) AS `last_course_access`,max(`uc`.`last_attempted`) AS `last_challenge_attempt`,max(`ua`.`submitted_at`) AS `last_assignment_submission` from (((((`users` `u` left join `user_course_progress` `ucp` on(`u`.`id` = `ucp`.`user_id`)) left join `user_lesson_progress` `ulp` on(`u`.`id` = `ulp`.`user_id`)) left join `user_challenges` `uc` on(`u`.`id` = `uc`.`user_id`)) left join `user_assignments` `ua` on(`u`.`id` = `ua`.`user_id`)) left join `platform_bookmarks` `pb` on(`u`.`id` = `pb`.`user_id`)) group by `u`.`id`,`u`.`username`,`u`.`firstName`,`u`.`lastName`,`u`.`email`,`u`.`joinDate` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-23 20:43:16
