-- phpMyAdmin SQL Dump
-- version 5.2.1deb1+deb12u1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 15, 2025 at 03:02 PM
-- Server version: 10.11.11-MariaDB-0+deb12u1
-- PHP Version: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pizza_orders`
--

DELIMITER $$
--
-- Procedures
--
$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `device` int(11) DEFAULT NULL,
  `user_info` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `archived_orders`
--

CREATE TABLE `archived_orders` (
  `id` int(11) NOT NULL,
  `original_order_id` int(11) NOT NULL,
  `device` int(11) NOT NULL,
  `order_type` enum('pizza','bar') NOT NULL,
  `items_json` text NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `order_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `completed_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bar_orders`
--

CREATE TABLE `bar_orders` (
  `id` int(11) NOT NULL,
  `device` int(11) NOT NULL,
  `table_number` int(11) DEFAULT NULL,
  `drink_type` varchar(50) DEFAULT NULL,
  `drink_name` varchar(100) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) DEFAULT 0.00,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('waiting','preparing','completed','served','paid','cancelled') DEFAULT 'waiting',
  `note` text DEFAULT NULL,
  `session_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bar_order_items`
--

CREATE TABLE `bar_order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `drink_type` varchar(50) NOT NULL,
  `drink_name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `status` enum('waiting','preparing','ready','delivered') DEFAULT 'waiting',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `burnt_pizzas_log`
--

CREATE TABLE `burnt_pizzas_log` (
  `id` int(11) NOT NULL,
  `pizza_id` int(11) DEFAULT NULL,
  `device` int(11) DEFAULT NULL,
  `pizza_name` varchar(100) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `burnt_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `burnt_pizzas_log`
--

INSERT INTO `burnt_pizzas_log` (`id`, `pizza_id`, `device`, `pizza_name`, `total`, `burnt_at`) VALUES
(89, 589, NULL, '01. Per bambini', 250.00, '2025-07-05 18:04:16'),
(90, 610, NULL, '01. Per bambini', 250.00, '2025-07-05 18:06:30'),
(91, 690, NULL, '01. Per bambini', 250.00, '2025-07-05 19:22:21'),
(92, 956, NULL, '01. Prosciutto cotto', 250.00, '2025-07-06 17:23:48'),
(93, 1393, NULL, 'Margherita', 230.00, '2025-07-11 13:11:49'),
(94, 1789, NULL, 'Per bambini', 250.00, '2025-07-12 02:56:59');

-- --------------------------------------------------------

--
-- Table structure for table `completed_payments`
--

CREATE TABLE `completed_payments` (
  `id` int(11) NOT NULL,
  `table_number` int(11) NOT NULL,
  `session_id` varchar(50) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `items_count` int(11) NOT NULL,
  `session_duration` int(11) DEFAULT NULL,
  `paid_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_method` enum('cash','card','other') DEFAULT 'cash'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `daily_stats`
--

CREATE TABLE `daily_stats` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `total_orders` int(11) DEFAULT 0,
  `total_pizzas` int(11) DEFAULT 0,
  `total_drinks` int(11) DEFAULT 0,
  `total_revenue` decimal(10,2) DEFAULT 0.00,
  `avg_preparation_time` int(11) DEFAULT 0,
  `burnt_items` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `avg_kitchen_time` int(11) DEFAULT 0,
  `avg_bar_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `daily_stats`
--

INSERT INTO `daily_stats` (`id`, `date`, `total_orders`, `total_pizzas`, `total_drinks`, `total_revenue`, `avg_preparation_time`, `burnt_items`, `created_at`, `updated_at`, `avg_kitchen_time`, `avg_bar_time`) VALUES
(23, '2025-07-05', 142, 138, 269, 49845.00, 0, 3, '2025-07-05 11:56:12', '2025-07-05 21:10:07', 19, 8),
(24, '2025-07-06', 74, 67, 102, 21615.00, 0, 1, '2025-07-05 22:41:36', '2025-07-06 18:21:13', 7, 2),
(29, '2025-07-10', 18, 1, 0, 695.00, 0, 0, '2025-07-10 08:29:11', '2025-07-10 12:39:49', 0, 0),
(30, '2025-07-11', 114, 96, 0, 50420.00, 0, 1, '2025-07-11 08:29:32', '2025-07-11 18:52:43', 0, 0),
(31, '2025-07-12', 186, 52, 0, 27530.00, 0, 1, '2025-07-12 07:23:36', '2025-07-12 11:44:03', 0, 0),
(32, '2025-07-13', 173, 0, 0, 0.00, 0, 0, '2025-07-13 10:59:00', '2025-07-13 19:29:41', 0, 0),
(33, '2025-07-14', 8, 0, 0, 0.00, 0, 0, '2025-07-14 10:32:45', '2025-07-14 21:57:07', 0, 0),
(34, '2025-07-15', 0, 0, 0, 0.00, 0, 0, '2025-07-15 00:59:52', '2025-07-15 00:59:52', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `drink_types`
--

CREATE TABLE `drink_types` (
  `id` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `category` varchar(50) NOT NULL DEFAULT '',
  `display_order` int(11) DEFAULT NULL,
  `cost_price` decimal(10,2) DEFAULT 0.00 COMMENT 'Nákladová cena nápoje'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `drink_types`
--

INSERT INTO `drink_types` (`id`, `type`, `name`, `price`, `description`, `is_active`, `created_at`, `updated_at`, `category`, `display_order`, `cost_price`) VALUES
(2, 'pivo_mazak', 'Mazák 0,3l', 40.00, '10 z chmele Saturn', 1, '2025-06-30 14:13:50', '2025-07-07 14:04:25', 'pivo', 10, 0.00),
(4, 'pivo_mazak_klasik', 'Mazák 0,5l', 50.00, 'Desítka z chmele saturn', 1, '2025-07-05 11:21:34', '2025-07-07 14:04:25', 'pivo', 10, 0.00),
(5, 'negroni_classic', 'Negroni Classico', 150.00, 'gin, vermut, Campari', 1, '2025-07-05 11:22:07', '2025-07-07 14:04:25', 'negroni', 5, 0.00),
(6, 'negroni_tartufo', 'Negroni Tartufo', 180.00, 'lanýžový gin, vermut, Campari', 1, '2025-07-05 11:22:31', '2025-07-07 14:04:25', 'negroni', 5, 0.00),
(7, 'negroni_sbagliato', 'Negroni Sbagliato', 150.00, 'prosecco, vermut, Campari', 1, '2025-07-05 11:22:52', '2025-07-07 14:04:25', 'negroni', 5, 0.00),
(8, 'spritz_limoncello', 'Spritz Limoncello', 130.00, '', 1, '2025-07-05 11:23:13', '2025-07-11 12:05:26', 'spritz', 6, 0.00),
(9, 'spritz_aperol', 'Spritz Aperol', 130.00, '', 1, '2025-07-05 11:23:26', '2025-07-11 12:05:12', 'spritz', 6, 0.00),
(10, 'spritz_sarti', 'Spritz Sarti', 130.00, '', 1, '2025-07-05 11:23:36', '2025-07-11 12:05:31', 'spritz', 6, 0.00),
(11, 'sprtiz_hugo', 'Spritz Hugo', 130.00, '', 1, '2025-07-05 11:23:45', '2025-07-11 12:05:22', 'spritz', 6, 0.00),
(12, 'spritz_campari', 'Spritz Campari', 130.00, '', 1, '2025-07-05 11:23:56', '2025-07-11 12:05:18', 'spritz', 6, 0.00),
(13, 'martini_fiero', 'Martini Fiero & tonic', 130.00, 'je směsí citrusů a hořkosladkého pomeranče se šťavnatými bílými víny', 1, '2025-07-05 11:24:13', '2025-07-11 12:04:49', 'koktejl', 7, 0.00),
(14, 'summer_gin', 'Summer gin Garage22 & tonic', 150.00, '', 1, '2025-07-05 11:24:27', '2025-07-11 12:04:59', 'koktejl', 7, 0.00),
(15, 'malfi_limone', 'Malfi limone & tonic', 130.00, 'italský prémiový gin, který se vyrábí z toskánského jalovce a kůry z citronů vypěstovaných na italském pobřeží Amalfi.', 0, '2025-07-05 11:24:38', '2025-07-11 12:04:44', 'koktejl', 7, 0.00),
(16, 'malfi_rosa', 'Fleurs de Prairie rosé gin & tonic', 130.00, 'květinovým charakterem a delikátní růžovou barvou, která v sobě odráží vůni levandulových polí, letních bylin a svěžího ovoce.', 0, '2025-07-05 11:24:58', '2025-07-11 12:04:42', 'koktejl', 7, 0.00),
(17, 'dige_limoncello', 'Limoncello', 90.00, 'digestiv - panák 0,4cl', 1, '2025-07-05 11:25:29', '2025-07-07 14:04:25', 'digestiv', 8, 0.00),
(18, 'dige_sambuca', 'Sambuca', 90.00, 'digestiv - panák 0,4cl\nklasický italský likér pro nejnáročnější labužníky. Hvězdicový anýz, jehož zralá semena se destilují a dále smíchají v harmonickém poměru s nejčistším alkoholem, je převažující složkou dávající likéru jeho charakteristické plné aróma.', 1, '2025-07-05 11:25:39', '2025-07-07 14:04:25', 'digestiv', 8, 0.00),
(19, 'dige_amaro', 'Amaro', 90.00, 'digestiv - panák 0,4cl', 1, '2025-07-05 11:25:46', '2025-07-11 12:04:35', 'digestiv', 8, 0.00),
(20, 'dige_grapa', 'Grapa di moscato', 120.00, 'digestiv - panák 0,4cl', 1, '2025-07-05 11:25:57', '2025-07-07 14:04:25', 'digestiv', 8, 0.00),
(23, 'vino_vlasak', 'Víno Ryzlink vlašský', 220.00, 'Láhev 0,7l', 1, '2025-07-05 11:27:09', '2025-07-07 16:26:01', 'vino', 9, 0.00),
(24, 'vino_rulanda', 'Víno Rulandské šedé', 220.00, 'Láhev 0,7l', 1, '2025-07-05 11:27:29', '2025-07-07 16:26:01', 'vino', 9, 0.00),
(25, 'vino_tramin', 'Víno Tramín', 220.00, 'Láhev 0,7l', 1, '2025-07-05 11:27:40', '2025-07-07 16:26:00', 'vino', 9, 0.00),
(26, 'vino_frankovka', 'Víno Frankovka', 220.00, 'Láhev 0,7l', 1, '2025-07-05 11:27:56', '2025-07-07 16:23:41', 'vino', 9, 0.00),
(27, 'vino_merlot', 'Víno Merlot', 240.00, 'Láhev 0,7l', 1, '2025-07-05 11:28:07', '2025-07-07 16:26:02', 'vino', 9, 0.00),
(28, 'hibernal', 'Víno Hibernal', 240.00, 'Láhev 0,7l', 1, '2025-07-05 11:26:38', '2025-07-07 16:26:03', 'vino', 9, 0.00),
(29, 'vino_frizz_ruz', 'Víno Frizzante růžové', 220.00, 'Láhev 0,7l', 1, '2025-07-05 11:28:36', '2025-07-07 16:26:03', 'vino', 9, 0.00),
(30, 'vino_frizzo_bile', 'Víno Frizzante bílé', 220.00, 'Láhev 0,7l', 1, '2025-07-05 11:28:23', '2025-07-07 16:26:04', 'vino', 9, 0.00),
(31, 'voda_perliva', 'Voda perlivá', 40.00, 'Láhev 0,7l', 1, '2025-07-05 11:28:50', '2025-07-07 14:11:59', 'nealko', 11, 0.00),
(32, 'voda_neperliva', 'Voda neperlivá', 40.00, 'Láhev 0,7l', 1, '2025-07-05 11:29:00', '2025-07-07 14:11:55', 'nealko', 11, 0.00),
(33, 'domaci_limo', 'Domácí limonáda', 50.00, '0,4l', 1, '2025-07-05 11:29:16', '2025-07-07 14:11:43', 'nealko', 11, 0.00),
(34, 'coca_cola', 'Coca-Cola', 50.00, '0,3l', 1, '2025-07-05 11:29:31', '2025-07-07 14:11:41', 'nealko', 11, 0.00),
(344, 'vino2dcl', 'Víno 2 dcl', 100.00, 'sklenka vina 2dcl', 1, '2025-07-05 11:26:16', '2025-07-07 16:24:22', 'vino', 9, 0.00),
(345, 'vino1dcl', 'Víno 1 dcl', 50.00, 'sklenka vina 1dcl', 1, '2025-07-05 11:26:16', '2025-07-07 16:24:22', 'vino', 9, 0.00),
(346, 'sektpastorek', 'Sekt Pastorek', 390.00, '18 měsíců zrál v lahvi', 1, '2025-07-11 12:06:00', '2025-07-11 12:06:00', 'vino', NULL, 0.00),
(347, 'redvelvet', 'Red Velvet gin Garage 22 a tonic', 170.00, '', 1, '2025-07-11 12:06:34', '2025-07-11 12:06:34', 'koktejl', NULL, 0.00),
(348, 'bluegin', 'Blue gin Garage22 a tonic', 150.00, '', 1, '2025-07-11 12:06:53', '2025-07-11 12:06:53', 'koktejl', NULL, 0.00),
(349, 'bellini', 'Bellini', 130.00, 'Prosseco a broskvove pyre', 1, '2025-07-11 12:11:37', '2025-07-11 12:11:37', 'koktejl', NULL, 0.00),
(350, 'rossini', 'Rossini', 130.00, 'Prosseco a jahodove pyre', 1, '2025-07-11 12:11:56', '2025-07-11 12:11:56', 'koktejl', NULL, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kitchen_orders`
--

CREATE TABLE `kitchen_orders` (
  `id` int(11) NOT NULL,
  `device` int(11) NOT NULL,
  `table_number` int(11) DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('waiting','preparing','completed','served','paid','cancelled') DEFAULT 'waiting',
  `is_remake` tinyint(1) DEFAULT 0,
  `original_order_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `pizza_name` varchar(100) DEFAULT NULL,
  `pizza_type` varchar(50) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `session_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kitchen_order_items`
--

CREATE TABLE `kitchen_order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `pizza_type` varchar(50) NOT NULL,
  `pizza_name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `status` enum('waiting','preparing','ready','delivered') DEFAULT 'waiting',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `table_session_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','preparing','ready','delivered','problem','cancelled','waiting_for_release','ready_for_pasta','dessert_time') DEFAULT 'pending',
  `order_type` enum('pizza','drink','other') NOT NULL,
  `printed_at` datetime DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `employee_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `table_session_id`, `created_at`, `status`, `order_type`, `printed_at`, `employee_id`, `payment_method`, `discount`, `customer_name`, `employee_name`) VALUES
(254, 242, '2025-07-05 14:16:08', 'pending', 'other', '2025-07-05 16:16:55', NULL, NULL, NULL, NULL, NULL),
(255, 243, '2025-07-05 14:18:56', 'pending', 'other', '2025-07-05 16:19:55', NULL, NULL, NULL, NULL, NULL),
(256, 244, '2025-07-05 14:20:13', 'pending', 'other', '2025-07-05 16:20:44', NULL, NULL, NULL, NULL, NULL),
(257, 245, '2025-07-05 14:20:32', 'pending', 'other', '2025-07-05 16:20:49', NULL, NULL, NULL, NULL, NULL),
(258, 246, '2025-07-05 14:22:30', 'pending', 'other', '2025-07-05 16:23:29', NULL, NULL, NULL, NULL, NULL),
(259, 247, '2025-07-05 14:23:25', 'pending', 'other', '2025-07-05 16:23:29', NULL, NULL, NULL, NULL, NULL),
(260, 248, '2025-07-05 14:29:08', 'pending', 'other', '2025-07-05 16:30:19', NULL, NULL, NULL, NULL, NULL),
(261, 249, '2025-07-05 14:37:19', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(262, 249, '2025-07-05 14:41:52', 'pending', 'other', '2025-07-05 16:44:57', NULL, NULL, NULL, NULL, NULL),
(263, 246, '2025-07-05 14:44:48', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(264, 250, '2025-07-05 14:54:17', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(265, 251, '2025-07-05 14:55:12', 'pending', 'other', '2025-07-05 16:57:35', NULL, NULL, NULL, NULL, NULL),
(266, 245, '2025-07-05 14:56:12', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(267, 247, '2025-07-05 14:59:12', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(268, 249, '2025-07-05 15:00:12', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(269, 252, '2025-07-05 15:02:57', 'pending', 'other', '2025-07-05 17:03:18', NULL, NULL, NULL, NULL, NULL),
(270, 246, '2025-07-05 15:03:39', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(271, 253, '2025-07-05 15:12:51', 'pending', 'other', '2025-07-05 17:14:22', NULL, NULL, NULL, NULL, NULL),
(272, 245, '2025-07-05 15:17:52', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(273, 254, '2025-07-05 15:19:20', 'pending', 'other', '2025-07-05 17:20:18', NULL, NULL, NULL, NULL, NULL),
(274, 255, '2025-07-05 15:20:39', 'pending', 'other', '2025-07-05 17:24:09', NULL, NULL, NULL, NULL, NULL),
(275, 245, '2025-07-05 15:33:56', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(276, 255, '2025-07-05 15:36:36', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(277, 256, '2025-07-05 15:40:29', 'pending', 'other', '2025-07-05 17:41:02', NULL, NULL, NULL, NULL, NULL),
(278, 257, '2025-07-05 15:40:56', 'pending', 'other', '2025-07-05 17:41:02', NULL, NULL, NULL, NULL, NULL),
(279, 257, '2025-07-05 15:45:55', 'pending', 'other', '2025-07-05 17:47:38', NULL, NULL, NULL, NULL, NULL),
(280, 255, '2025-07-05 15:46:10', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(281, 253, '2025-07-05 15:48:14', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(282, 258, '2025-07-05 15:51:13', 'pending', 'other', '2025-07-05 17:54:40', NULL, NULL, NULL, NULL, NULL),
(283, 245, '2025-07-05 15:52:49', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(284, 255, '2025-07-05 15:57:29', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(285, 253, '2025-07-05 16:00:05', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(286, 259, '2025-07-05 16:02:03', 'pending', 'other', '2025-07-05 18:04:18', NULL, NULL, NULL, NULL, NULL),
(287, 260, '2025-07-05 16:02:45', 'pending', 'other', '2025-07-05 18:04:18', NULL, NULL, NULL, NULL, NULL),
(288, 261, '2025-07-05 16:06:09', 'pending', 'other', '2025-07-05 18:07:39', NULL, NULL, NULL, NULL, NULL),
(289, 245, '2025-07-05 16:07:04', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(290, 260, '2025-07-05 16:08:10', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(291, 262, '2025-07-05 16:10:43', 'pending', 'other', '2025-07-05 18:11:41', NULL, NULL, NULL, NULL, NULL),
(292, 263, '2025-07-05 16:11:57', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(293, 255, '2025-07-05 16:12:06', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(294, 264, '2025-07-05 16:12:51', 'pending', 'other', '2025-07-05 18:16:34', NULL, NULL, NULL, NULL, NULL),
(295, 254, '2025-07-05 16:12:53', 'pending', 'other', '2025-07-05 18:16:34', NULL, NULL, NULL, NULL, NULL),
(296, 263, '2025-07-05 16:13:40', 'pending', 'other', '2025-07-05 18:16:34', NULL, NULL, NULL, NULL, NULL),
(297, 265, '2025-07-05 16:14:32', 'pending', 'other', '2025-07-05 18:16:34', NULL, NULL, NULL, NULL, NULL),
(298, 259, '2025-07-05 16:17:13', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(299, 264, '2025-07-05 16:18:16', 'pending', 'other', '2025-07-05 18:21:32', NULL, NULL, NULL, NULL, NULL),
(300, 257, '2025-07-05 16:18:35', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(301, 259, '2025-07-05 16:18:41', 'pending', 'other', '2025-07-05 18:21:32', NULL, NULL, NULL, NULL, NULL),
(302, 255, '2025-07-05 16:20:11', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(303, 266, '2025-07-05 16:21:04', 'pending', 'other', '2025-07-05 18:21:32', NULL, NULL, NULL, NULL, NULL),
(304, 245, '2025-07-05 16:22:22', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(305, 254, '2025-07-05 16:24:28', 'pending', 'other', '2025-07-05 18:28:26', NULL, NULL, NULL, NULL, NULL),
(306, 245, '2025-07-05 16:26:39', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(307, 267, '2025-07-05 16:28:49', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(308, 255, '2025-07-05 16:32:02', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(309, 245, '2025-07-05 16:33:09', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(310, 268, '2025-07-05 16:34:33', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(311, 245, '2025-07-05 16:35:16', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(312, 265, '2025-07-05 16:36:05', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(313, 255, '2025-07-05 16:43:15', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(314, 260, '2025-07-05 16:47:55', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(315, 245, '2025-07-05 16:50:12', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(316, 263, '2025-07-05 16:58:04', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(317, 250, '2025-07-05 16:58:16', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(318, 269, '2025-07-05 17:03:04', 'pending', 'other', '2025-07-05 19:05:19', NULL, NULL, NULL, NULL, NULL),
(319, 270, '2025-07-05 17:04:28', 'pending', 'other', '2025-07-05 19:05:19', NULL, NULL, NULL, NULL, NULL),
(320, 271, '2025-07-05 17:04:59', 'pending', 'other', '2025-07-05 19:05:19', NULL, NULL, NULL, NULL, NULL),
(321, 260, '2025-07-05 17:05:17', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(322, 245, '2025-07-05 17:07:05', 'pending', 'other', '2025-07-05 19:13:07', NULL, NULL, NULL, NULL, NULL),
(323, 272, '2025-07-05 17:08:09', 'pending', 'other', '2025-07-05 19:13:07', NULL, NULL, NULL, NULL, NULL),
(324, 273, '2025-07-05 17:10:02', 'pending', 'other', '2025-07-05 19:13:07', NULL, NULL, NULL, NULL, NULL),
(325, 274, '2025-07-05 17:11:54', 'pending', 'other', '2025-07-05 19:13:07', NULL, NULL, NULL, NULL, NULL),
(326, 260, '2025-07-05 17:17:01', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(327, 275, '2025-07-05 17:19:56', 'pending', 'other', '2025-07-05 19:22:05', NULL, NULL, NULL, NULL, NULL),
(328, 276, '2025-07-05 17:20:36', 'pending', 'other', '2025-07-05 19:22:04', NULL, NULL, NULL, NULL, NULL),
(329, 245, '2025-07-05 17:21:59', 'pending', 'other', '2025-07-05 19:22:04', NULL, NULL, NULL, NULL, NULL),
(330, 277, '2025-07-05 17:22:42', 'pending', 'other', '2025-07-05 19:25:02', NULL, NULL, NULL, NULL, NULL),
(331, 245, '2025-07-05 17:23:27', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(332, 264, '2025-07-05 17:23:42', 'pending', 'other', '2025-07-05 19:25:02', NULL, NULL, NULL, NULL, NULL),
(333, 278, '2025-07-05 17:24:01', 'pending', 'other', '2025-07-05 19:24:45', NULL, NULL, NULL, NULL, NULL),
(334, 245, '2025-07-05 17:24:13', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(335, 279, '2025-07-05 17:24:59', 'pending', 'other', '2025-07-05 19:25:02', NULL, NULL, NULL, NULL, NULL),
(336, 280, '2025-07-05 17:25:16', 'pending', 'other', '2025-07-05 19:33:07', NULL, NULL, NULL, NULL, NULL),
(337, 272, '2025-07-05 17:28:06', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(338, 257, '2025-07-05 17:28:31', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(339, 270, '2025-07-05 17:30:01', 'pending', 'other', '2025-07-05 19:33:07', NULL, NULL, NULL, NULL, NULL),
(340, 271, '2025-07-05 17:33:37', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(341, 281, '2025-07-05 17:33:48', 'pending', 'other', '2025-07-05 19:34:03', NULL, NULL, NULL, NULL, NULL),
(342, 280, '2025-07-05 17:36:05', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(343, 245, '2025-07-05 17:41:55', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(344, 282, '2025-07-05 17:43:49', 'pending', 'other', '2025-07-05 19:47:37', NULL, NULL, NULL, NULL, NULL),
(345, 283, '2025-07-05 17:51:48', 'pending', 'other', '2025-07-05 19:57:05', NULL, NULL, NULL, NULL, NULL),
(346, 279, '2025-07-05 17:52:36', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(347, 245, '2025-07-05 17:53:08', 'pending', 'other', '2025-07-05 19:57:05', NULL, NULL, NULL, NULL, NULL),
(348, 280, '2025-07-05 17:54:11', 'pending', 'other', '2025-07-05 19:57:05', NULL, NULL, NULL, NULL, NULL),
(349, 284, '2025-07-05 17:58:54', 'pending', 'other', '2025-07-05 20:09:44', NULL, NULL, NULL, NULL, NULL),
(350, 285, '2025-07-05 18:00:36', 'pending', 'other', '2025-07-05 20:09:44', NULL, NULL, NULL, NULL, NULL),
(351, 286, '2025-07-05 18:02:08', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(352, 245, '2025-07-05 18:05:25', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(353, 287, '2025-07-05 18:07:16', 'pending', 'other', '2025-07-05 20:09:44', NULL, NULL, NULL, NULL, NULL),
(354, 245, '2025-07-05 18:07:35', 'pending', 'other', '2025-07-05 20:09:44', NULL, NULL, NULL, NULL, NULL),
(355, 288, '2025-07-05 18:08:36', 'pending', 'other', '2025-07-05 20:09:44', NULL, NULL, NULL, NULL, NULL),
(356, 289, '2025-07-05 18:13:03', 'pending', 'other', '2025-07-05 20:17:08', NULL, NULL, NULL, NULL, NULL),
(357, 279, '2025-07-05 18:15:48', 'pending', 'other', '2025-07-05 20:17:08', NULL, NULL, NULL, NULL, NULL),
(358, 245, '2025-07-05 18:17:59', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(359, 285, '2025-07-05 18:19:39', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(360, 245, '2025-07-05 18:24:26', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(361, 280, '2025-07-05 18:25:26', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(362, 290, '2025-07-05 18:30:13', 'pending', 'other', '2025-07-05 20:32:30', NULL, NULL, NULL, NULL, NULL),
(363, 245, '2025-07-05 18:30:21', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(364, 285, '2025-07-05 18:36:55', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(365, 281, '2025-07-05 18:36:59', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(366, 291, '2025-07-05 18:47:00', 'pending', 'other', '2025-07-05 20:49:00', NULL, NULL, NULL, NULL, NULL),
(367, 291, '2025-07-05 18:49:12', 'pending', 'other', '2025-07-05 20:49:39', NULL, NULL, NULL, NULL, NULL),
(368, 250, '2025-07-05 18:53:09', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(369, 292, '2025-07-05 18:53:39', 'pending', 'other', '2025-07-05 20:56:29', NULL, NULL, NULL, NULL, NULL),
(370, 289, '2025-07-05 18:54:41', 'pending', 'other', '2025-07-05 20:56:29', NULL, NULL, NULL, NULL, NULL),
(371, 293, '2025-07-05 18:55:52', 'pending', 'other', '2025-07-05 20:56:29', NULL, NULL, NULL, NULL, NULL),
(372, 294, '2025-07-05 18:57:06', 'pending', 'other', '2025-07-05 20:59:37', NULL, NULL, NULL, NULL, NULL),
(373, 250, '2025-07-05 19:00:17', 'pending', 'other', '2025-07-05 21:00:24', NULL, NULL, NULL, NULL, NULL),
(374, 288, '2025-07-05 19:05:08', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(375, 295, '2025-07-05 19:14:19', 'pending', 'other', '2025-07-05 21:23:27', NULL, NULL, NULL, NULL, NULL),
(376, 296, '2025-07-05 19:17:41', 'pending', 'other', '2025-07-05 21:23:27', NULL, NULL, NULL, NULL, NULL),
(377, 281, '2025-07-05 19:18:22', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(378, 280, '2025-07-05 19:19:35', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(379, 291, '2025-07-05 19:22:25', 'pending', 'other', '2025-07-05 21:23:27', NULL, NULL, NULL, NULL, NULL),
(380, 297, '2025-07-05 19:25:24', 'pending', 'other', '2025-07-05 21:26:53', NULL, NULL, NULL, NULL, NULL),
(381, 296, '2025-07-05 19:28:01', 'pending', 'other', '2025-07-05 21:30:15', NULL, NULL, NULL, NULL, NULL),
(382, 280, '2025-07-05 19:40:42', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(383, 283, '2025-07-05 19:40:54', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(384, 294, '2025-07-05 19:41:35', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(385, 250, '2025-07-05 19:43:32', 'pending', 'other', '2025-07-05 21:44:15', NULL, NULL, NULL, NULL, NULL),
(386, 280, '2025-07-05 19:45:17', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(387, 297, '2025-07-05 19:54:30', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(388, 280, '2025-07-05 19:54:33', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(389, 297, '2025-07-05 19:57:24', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(390, 298, '2025-07-05 19:58:39', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(391, 299, '2025-07-05 19:59:20', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(392, 299, '2025-07-05 20:25:55', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(393, 300, '2025-07-05 20:34:21', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(394, 301, '2025-07-05 20:38:47', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(395, 299, '2025-07-05 20:46:58', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(416, 311, '2025-07-06 13:00:42', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(417, 312, '2025-07-06 13:15:45', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(418, 313, '2025-07-06 13:22:42', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(419, 313, '2025-07-06 13:38:15', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(420, 313, '2025-07-06 13:47:33', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(421, 314, '2025-07-06 14:00:09', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(422, 315, '2025-07-06 14:16:54', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(423, 312, '2025-07-06 14:19:22', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(424, 312, '2025-07-06 14:35:42', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(425, 316, '2025-07-06 14:38:57', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(426, 316, '2025-07-06 14:42:28', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(427, 315, '2025-07-06 14:42:49', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(428, 315, '2025-07-06 14:44:40', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(429, 317, '2025-07-06 14:47:37', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(430, 316, '2025-07-06 14:50:00', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(431, 318, '2025-07-06 14:56:09', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(432, 315, '2025-07-06 15:07:57', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(433, 316, '2025-07-06 15:10:52', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(434, 319, '2025-07-06 15:15:28', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(435, 316, '2025-07-06 15:17:18', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(436, 315, '2025-07-06 15:20:08', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(437, 318, '2025-07-06 15:25:17', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(438, 320, '2025-07-06 15:25:42', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(439, 321, '2025-07-06 15:28:26', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(440, 317, '2025-07-06 15:29:03', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(441, 322, '2025-07-06 15:32:02', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(442, 312, '2025-07-06 15:33:05', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(443, 323, '2025-07-06 15:34:30', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(444, 317, '2025-07-06 15:35:11', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(445, 316, '2025-07-06 15:37:30', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(446, 324, '2025-07-06 15:37:32', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(447, 318, '2025-07-06 15:39:39', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(448, 323, '2025-07-06 15:41:25', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(449, 325, '2025-07-06 15:41:45', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(450, 325, '2025-07-06 15:44:35', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(451, 321, '2025-07-06 15:46:14', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(452, 325, '2025-07-06 15:50:02', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(453, 321, '2025-07-06 15:50:49', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(454, 320, '2025-07-06 15:52:38', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(455, 321, '2025-07-06 15:58:01', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(456, 320, '2025-07-06 15:59:10', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(457, 321, '2025-07-06 16:02:18', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(458, 322, '2025-07-06 16:08:55', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(459, 323, '2025-07-06 16:09:34', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(460, 322, '2025-07-06 16:13:31', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(461, 326, '2025-07-06 16:14:16', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(462, 321, '2025-07-06 16:16:14', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(463, 323, '2025-07-06 16:20:02', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(464, 327, '2025-07-06 16:20:58', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(465, 321, '2025-07-06 16:26:26', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(466, 326, '2025-07-06 16:27:30', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(467, 328, '2025-07-06 16:27:54', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(468, 323, '2025-07-06 16:35:36', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(469, 329, '2025-07-06 16:36:07', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(470, 326, '2025-07-06 16:40:44', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(471, 321, '2025-07-06 16:47:50', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(472, 323, '2025-07-06 16:51:35', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(473, 330, '2025-07-06 16:52:05', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(474, 328, '2025-07-06 16:54:19', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(475, 327, '2025-07-06 16:55:49', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(476, 323, '2025-07-06 16:58:07', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(477, 331, '2025-07-06 17:00:28', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(478, 332, '2025-07-06 17:02:14', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(479, 333, '2025-07-06 17:08:34', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(480, 334, '2025-07-06 17:12:13', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(481, 323, '2025-07-06 17:16:04', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(482, 327, '2025-07-06 17:16:26', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(483, 335, '2025-07-06 17:17:00', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(484, 336, '2025-07-06 17:33:47', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(485, 337, '2025-07-06 17:36:21', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(486, 331, '2025-07-06 17:37:33', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(487, 337, '2025-07-06 17:53:16', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(488, 337, '2025-07-06 17:56:39', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(489, 338, '2025-07-06 17:59:00', 'pending', 'other', NULL, NULL, NULL, NULL, NULL, NULL),
(660, 495, '2025-07-11 12:55:41', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(661, 496, '2025-07-11 12:57:36', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(662, 497, '2025-07-11 12:58:30', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(664, 499, '2025-07-11 13:07:52', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(665, 500, '2025-07-11 13:12:31', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(666, 501, '2025-07-11 13:13:40', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(667, 502, '2025-07-11 13:22:27', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(668, 503, '2025-07-11 13:26:06', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(669, 496, '2025-07-11 13:26:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(671, 499, '2025-07-11 13:34:18', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(672, 499, '2025-07-11 13:37:36', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(673, 504, '2025-07-11 13:40:06', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(674, 505, '2025-07-11 13:42:41', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(675, 495, '2025-07-11 13:49:43', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(676, 501, '2025-07-11 13:52:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(677, 503, '2025-07-11 13:56:40', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(678, 503, '2025-07-11 14:02:06', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(679, 506, '2025-07-11 14:04:29', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(680, 500, '2025-07-11 14:05:06', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(681, 507, '2025-07-11 14:08:04', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(682, 506, '2025-07-11 14:09:31', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(683, 505, '2025-07-11 14:11:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(684, 508, '2025-07-11 14:21:23', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(685, 508, '2025-07-11 14:24:52', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(686, 509, '2025-07-11 14:29:27', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(687, 508, '2025-07-11 14:33:21', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(690, 511, '2025-07-11 14:41:22', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(691, 508, '2025-07-11 14:41:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(692, 512, '2025-07-11 14:42:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(693, 508, '2025-07-11 14:49:08', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(694, 508, '2025-07-11 14:49:23', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(695, 506, '2025-07-11 14:49:56', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(696, 513, '2025-07-11 14:53:56', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(697, 509, '2025-07-11 14:56:10', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(698, 511, '2025-07-11 14:56:50', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(699, 506, '2025-07-11 14:59:18', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(700, 506, '2025-07-11 15:01:52', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(701, 514, '2025-07-11 15:12:11', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Mirek'),
(702, 515, '2025-07-11 15:14:08', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(703, 514, '2025-07-11 15:15:39', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(704, 516, '2025-07-11 15:16:14', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(705, 516, '2025-07-11 15:16:36', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(706, 517, '2025-07-11 15:18:20', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(707, 515, '2025-07-11 15:18:33', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(708, 518, '2025-07-11 15:19:47', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(709, 514, '2025-07-11 15:25:29', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(710, 519, '2025-07-11 15:32:31', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(712, 520, '2025-07-11 15:35:28', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(713, 512, '2025-07-11 15:38:57', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(714, 512, '2025-07-11 15:51:04', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(715, 521, '2025-07-11 15:52:16', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(716, 522, '2025-07-11 15:52:48', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(717, 518, '2025-07-11 15:54:41', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(718, 523, '2025-07-11 16:02:28', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(719, 517, '2025-07-11 16:09:03', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(720, 518, '2025-07-11 16:23:58', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(721, 521, '2025-07-11 16:24:23', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(722, 518, '2025-07-11 16:26:39', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(723, 524, '2025-07-11 16:27:04', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(724, 525, '2025-07-11 16:30:09', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(725, 526, '2025-07-11 16:31:38', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(726, 526, '2025-07-11 16:41:12', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(727, 527, '2025-07-11 16:47:41', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(728, 526, '2025-07-11 16:47:55', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(729, 528, '2025-07-11 16:49:51', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(730, 518, '2025-07-11 16:56:36', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(731, 521, '2025-07-11 16:59:43', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(732, 521, '2025-07-11 17:00:23', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(733, 528, '2025-07-11 17:05:31', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(734, 525, '2025-07-11 17:07:09', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(735, 526, '2025-07-11 17:11:07', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(736, 529, '2025-07-11 17:16:11', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(737, 526, '2025-07-11 17:23:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(738, 527, '2025-07-11 17:23:55', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(739, 526, '2025-07-11 17:24:05', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(740, 530, '2025-07-11 17:26:19', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(741, 525, '2025-07-11 17:30:06', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(742, 527, '2025-07-11 17:33:16', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(743, 527, '2025-07-11 17:58:59', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(744, 531, '2025-07-11 18:03:34', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(745, 527, '2025-07-11 18:15:24', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vlaďka'),
(746, 531, '2025-07-11 18:18:20', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(747, 532, '2025-07-11 18:20:08', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(748, 529, '2025-07-11 18:42:05', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(779, 558, '2025-07-12 01:55:18', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(780, 544, '2025-07-12 02:00:20', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(784, 560, '2025-07-12 02:10:07', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(785, 561, '2025-07-12 02:14:16', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(786, 562, '2025-07-12 02:14:58', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(787, 544, '2025-07-12 02:21:48', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(788, 563, '2025-07-12 02:23:14', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(789, 548, '2025-07-12 02:24:44', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(790, 561, '2025-07-12 02:25:04', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(791, 564, '2025-07-12 02:25:47', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(792, 548, '2025-07-12 02:27:53', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(793, 562, '2025-07-12 02:30:29', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(794, 557, '2025-07-12 02:31:49', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(795, 565, '2025-07-12 02:35:13', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(796, 561, '2025-07-12 02:38:11', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(797, 560, '2025-07-12 02:42:31', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(798, 566, '2025-07-12 02:43:05', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(799, 544, '2025-07-12 02:48:41', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(800, 561, '2025-07-12 02:50:06', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(801, 565, '2025-07-12 02:52:52', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(802, 557, '2025-07-12 02:56:02', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(803, 567, '2025-07-12 02:56:32', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(804, 563, '2025-07-12 02:59:25', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(805, 551, '2025-07-12 03:05:24', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(806, 563, '2025-07-12 03:09:24', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(807, 544, '2025-07-12 03:10:09', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(808, 568, '2025-07-12 03:12:34', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(809, 569, '2025-07-12 03:13:08', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(811, 550, '2025-07-12 03:14:28', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(812, 568, '2025-07-12 03:15:29', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(813, 565, '2025-07-12 03:16:58', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(814, 557, '2025-07-12 03:17:54', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(815, 550, '2025-07-12 03:18:24', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(816, 566, '2025-07-12 03:19:37', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(817, 544, '2025-07-12 03:19:42', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(818, 587, '2025-07-12 03:23:34', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(819, 565, '2025-07-12 03:24:57', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(820, 561, '2025-07-12 03:29:39', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(821, 570, '2025-07-12 03:33:04', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(822, 567, '2025-07-12 03:33:49', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(823, 563, '2025-07-12 03:38:06', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(824, 567, '2025-07-12 03:39:06', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(825, 571, '2025-07-12 03:41:11', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(826, 563, '2025-07-12 03:42:41', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(827, 572, '2025-07-12 03:42:47', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(828, 573, '2025-07-12 03:44:18', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(829, 556, '2025-07-12 03:45:49', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(830, 548, '2025-07-12 03:49:42', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(831, 587, '2025-07-12 03:50:42', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(832, 546, '2025-07-12 03:51:30', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(833, 544, '2025-07-12 03:53:10', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(834, 568, '2025-07-12 03:57:28', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(835, 557, '2025-07-12 03:58:33', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(836, 568, '2025-07-12 04:00:55', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(837, 571, '2025-07-12 04:01:27', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(838, 557, '2025-07-12 04:01:32', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(839, 553, '2025-07-12 04:03:14', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(840, 570, '2025-07-12 04:05:13', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(841, 588, '2025-07-12 04:06:32', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(842, 571, '2025-07-12 04:08:20', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(843, 551, '2025-07-12 04:08:58', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(844, 551, '2025-07-12 04:10:00', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(845, 556, '2025-07-12 04:12:33', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(846, 574, '2025-07-12 04:16:04', 'pending', 'other', NULL, NULL, NULL, NULL, 'U sudu', 'Pavla'),
(847, 572, '2025-07-12 04:18:19', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(848, 546, '2025-07-12 04:21:09', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(849, 556, '2025-07-12 04:24:22', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(851, 575, '2025-07-12 04:25:51', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(852, 554, '2025-07-12 04:28:42', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(853, 576, '2025-07-12 04:29:27', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(854, 571, '2025-07-12 04:36:21', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(855, 577, '2025-07-12 04:39:51', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(856, 578, '2025-07-12 04:40:20', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(857, 579, '2025-07-12 04:48:33', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(858, 546, '2025-07-12 04:58:04', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(859, 553, '2025-07-12 04:58:53', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(860, 548, '2025-07-12 05:03:55', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(861, 571, '2025-07-12 05:08:40', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(862, 553, '2025-07-12 05:11:27', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(863, 588, '2025-07-12 05:16:55', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(864, 580, '2025-07-12 05:17:21', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(865, 571, '2025-07-12 05:19:57', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(867, 553, '2025-07-12 05:26:42', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(868, 551, '2025-07-12 05:28:24', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(869, 556, '2025-07-12 05:29:35', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(870, 553, '2025-07-12 05:30:02', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(871, 571, '2025-07-12 05:34:01', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(872, 556, '2025-07-12 05:35:28', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(873, 581, '2025-07-12 05:39:42', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(874, 546, '2025-07-12 05:40:25', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(875, 556, '2025-07-12 05:42:32', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(876, 548, '2025-07-12 05:45:05', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(877, 556, '2025-07-12 05:46:50', 'pending', 'other', NULL, NULL, NULL, NULL, 'Vse krabice', 'Pavla'),
(878, 571, '2025-07-12 05:48:29', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(879, 548, '2025-07-12 05:49:04', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(880, 553, '2025-07-12 05:49:17', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(881, 582, '2025-07-12 05:52:11', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(882, 588, '2025-07-12 05:53:41', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(883, 556, '2025-07-12 05:56:55', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(884, 571, '2025-07-12 06:08:39', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(885, 553, '2025-07-12 06:09:22', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(886, 556, '2025-07-12 06:09:52', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(887, 553, '2025-07-12 06:12:59', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(888, 549, '2025-07-12 06:13:15', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(889, 582, '2025-07-12 06:13:25', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(890, 579, '2025-07-12 06:16:46', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(891, 581, '2025-07-12 06:18:05', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(892, 581, '2025-07-12 06:20:33', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(893, 556, '2025-07-12 06:26:18', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(894, 551, '2025-07-12 06:26:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(895, 571, '2025-07-12 06:34:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(896, 579, '2025-07-12 06:35:40', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Vladka'),
(897, 571, '2025-07-12 06:48:20', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(898, 549, '2025-07-12 06:51:21', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(899, 583, '2025-07-12 07:03:31', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(900, 583, '2025-07-12 07:07:47', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(901, 549, '2025-07-12 07:27:54', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(902, 549, '2025-07-12 07:28:19', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(903, 549, '2025-07-12 07:32:26', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(904, 549, '2025-07-12 07:47:43', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(905, 583, '2025-07-12 07:48:28', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(906, 549, '2025-07-12 08:11:21', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(955, 613, '2025-07-13 13:21:20', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(957, 613, '2025-07-13 13:25:39', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(958, 615, '2025-07-13 13:27:17', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(959, 615, '2025-07-13 13:30:10', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(960, 613, '2025-07-13 13:30:26', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(961, 616, '2025-07-13 13:35:09', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(962, 617, '2025-07-13 13:35:43', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(963, 615, '2025-07-13 13:36:32', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(964, 618, '2025-07-13 13:37:47', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(965, 613, '2025-07-13 13:41:28', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(966, 617, '2025-07-13 13:43:00', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(967, 619, '2025-07-13 13:49:32', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(968, 619, '2025-07-13 13:52:46', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(969, 615, '2025-07-13 13:55:11', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(970, 617, '2025-07-13 13:56:22', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(971, 619, '2025-07-13 13:58:00', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(972, 620, '2025-07-13 14:00:09', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(973, 621, '2025-07-13 14:00:49', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(974, 622, '2025-07-13 14:04:25', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(975, 623, '2025-07-13 14:07:12', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(976, 624, '2025-07-13 14:09:40', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(977, 621, '2025-07-13 14:14:13', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(978, 617, '2025-07-13 14:18:12', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(979, 625, '2025-07-13 14:21:31', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(980, 626, '2025-07-13 14:22:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(981, 620, '2025-07-13 14:23:19', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(982, 619, '2025-07-13 14:26:36', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(983, 627, '2025-07-13 14:30:23', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(984, 623, '2025-07-13 14:31:44', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(985, 628, '2025-07-13 14:33:40', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(986, 629, '2025-07-13 14:34:18', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(987, 627, '2025-07-13 14:38:32', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(988, 625, '2025-07-13 14:38:58', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(989, 630, '2025-07-13 14:41:05', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(990, 630, '2025-07-13 14:47:59', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(991, 631, '2025-07-13 14:53:01', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(992, 630, '2025-07-13 14:58:31', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(993, 632, '2025-07-13 15:01:58', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(994, 633, '2025-07-13 15:02:57', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(995, 634, '2025-07-13 15:06:03', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(996, 635, '2025-07-13 15:09:01', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(997, 629, '2025-07-13 15:11:37', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(998, 636, '2025-07-13 15:13:24', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(999, 633, '2025-07-13 15:14:58', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1000, 619, '2025-07-13 15:15:37', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1001, 630, '2025-07-13 15:17:09', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1002, 630, '2025-07-13 15:20:12', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1003, 625, '2025-07-13 15:20:55', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1004, 664, '2025-07-13 15:21:17', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1005, 635, '2025-07-13 15:21:58', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1006, 634, '2025-07-13 15:22:53', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1007, 638, '2025-07-13 15:23:55', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1008, 639, '2025-07-13 15:25:22', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1009, 634, '2025-07-13 15:27:19', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1010, 632, '2025-07-13 15:27:58', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1011, 625, '2025-07-13 15:28:05', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1012, 640, '2025-07-13 15:30:17', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1013, 641, '2025-07-13 15:32:26', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1014, 642, '2025-07-13 15:33:04', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1015, 639, '2025-07-13 15:33:04', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1016, 639, '2025-07-13 15:40:51', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1017, 643, '2025-07-13 15:40:54', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1018, 632, '2025-07-13 15:41:24', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1019, 644, '2025-07-13 15:41:51', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1020, 632, '2025-07-13 15:41:57', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1021, 638, '2025-07-13 15:42:25', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1022, 625, '2025-07-13 15:45:25', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1023, 639, '2025-07-13 15:46:13', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1024, 645, '2025-07-13 15:47:30', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1025, 646, '2025-07-13 15:51:57', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1026, 638, '2025-07-13 15:52:46', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1027, 647, '2025-07-13 15:53:24', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1028, 632, '2025-07-13 15:54:35', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1029, 648, '2025-07-13 15:54:37', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1030, 649, '2025-07-13 15:55:28', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1031, 632, '2025-07-13 15:56:48', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1032, 646, '2025-07-13 15:57:39', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1033, 645, '2025-07-13 15:59:43', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1034, 650, '2025-07-13 16:00:22', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1035, 645, '2025-07-13 16:05:58', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1036, 651, '2025-07-13 16:06:43', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1037, 632, '2025-07-13 16:07:25', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1038, 645, '2025-07-13 16:08:36', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1039, 644, '2025-07-13 16:09:11', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1040, 639, '2025-07-13 16:10:20', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1041, 652, '2025-07-13 16:13:15', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1042, 653, '2025-07-13 16:15:01', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1043, 639, '2025-07-13 16:16:35', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1044, 646, '2025-07-13 16:16:49', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1045, 654, '2025-07-13 16:17:00', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1046, 643, '2025-07-13 16:17:47', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1047, 652, '2025-07-13 16:18:29', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1048, 655, '2025-07-13 16:18:58', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1049, 641, '2025-07-13 16:19:38', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1050, 643, '2025-07-13 16:23:53', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1051, 645, '2025-07-13 16:27:30', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1052, 644, '2025-07-13 16:30:16', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1053, 649, '2025-07-13 16:31:20', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1054, 664, '2025-07-13 16:31:49', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1055, 632, '2025-07-13 16:32:47', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1056, 655, '2025-07-13 16:33:28', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1057, 645, '2025-07-13 16:33:56', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1058, 639, '2025-07-13 16:34:19', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1059, 656, '2025-07-13 16:35:24', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1060, 648, '2025-07-13 16:35:48', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1061, 652, '2025-07-13 16:36:07', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1062, 647, '2025-07-13 16:37:43', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1063, 645, '2025-07-13 16:39:47', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1064, 645, '2025-07-13 16:41:07', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1065, 639, '2025-07-13 16:46:09', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1066, 646, '2025-07-13 16:46:27', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1067, 643, '2025-07-13 16:47:11', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1068, 657, '2025-07-13 16:47:49', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1069, 646, '2025-07-13 16:50:00', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1070, 652, '2025-07-13 16:50:18', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1071, 658, '2025-07-13 16:50:36', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla');
INSERT INTO `orders` (`id`, `table_session_id`, `created_at`, `status`, `order_type`, `printed_at`, `employee_id`, `payment_method`, `discount`, `customer_name`, `employee_name`) VALUES
(1072, 652, '2025-07-13 16:54:05', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1073, 657, '2025-07-13 16:56:34', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1074, 665, '2025-07-13 16:58:28', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1075, 660, '2025-07-13 16:58:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Mirek'),
(1076, 632, '2025-07-13 17:01:49', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1077, 664, '2025-07-13 17:01:57', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1078, 661, '2025-07-13 17:06:14', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1079, 657, '2025-07-13 17:08:28', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1080, 662, '2025-07-13 17:08:47', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1081, 648, '2025-07-13 17:08:50', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1082, 665, '2025-07-13 17:11:46', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1083, 632, '2025-07-13 17:14:18', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1084, 649, '2025-07-13 17:17:17', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1085, 648, '2025-07-13 17:19:37', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1086, 632, '2025-07-13 17:25:51', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1087, 665, '2025-07-13 17:26:31', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1088, 652, '2025-07-13 17:31:46', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1089, 665, '2025-07-13 17:34:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1090, 661, '2025-07-13 17:38:06', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1091, 648, '2025-07-13 17:39:36', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Pavla'),
(1092, 663, '2025-07-13 17:54:13', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1093, 649, '2025-07-13 18:00:13', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1094, 632, '2025-07-13 18:00:36', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1095, 632, '2025-07-13 18:00:56', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1096, 665, '2025-07-13 18:01:22', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1097, 664, '2025-07-13 18:01:50', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1098, 661, '2025-07-13 18:05:26', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1099, 661, '2025-07-13 18:15:09', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1100, 632, '2025-07-13 18:32:15', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1101, 665, '2025-07-13 18:32:45', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1103, 632, '2025-07-13 19:08:19', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1104, 665, '2025-07-13 19:08:36', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1105, 666, '2025-07-13 19:10:40', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1106, 664, '2025-07-13 19:12:44', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1107, 665, '2025-07-13 19:29:41', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'Dominika'),
(1108, 667, '2025-07-14 21:36:12', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'assa'),
(1109, 667, '2025-07-14 21:39:02', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'assa'),
(1110, 668, '2025-07-14 21:39:52', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'assa'),
(1111, 669, '2025-07-14 21:41:59', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'assa'),
(1112, 670, '2025-07-14 21:46:13', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'assa'),
(1113, 671, '2025-07-14 21:54:30', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'iPhone web'),
(1114, 672, '2025-07-14 21:54:54', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'assa'),
(1115, 673, '2025-07-14 21:57:07', 'pending', 'other', NULL, NULL, NULL, NULL, '', 'assa');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `item_type` enum('pizza','drink','other','predkrm','pasta','dezert','negroni','spritz','koktejl','digestiv','vino','pivo','nealko') DEFAULT NULL,
  `item_name` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unit_price` decimal(10,2) NOT NULL,
  `note` text DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `payment_method` varchar(10) DEFAULT 'cash',
  `paid_at` timestamp NULL DEFAULT NULL,
  `prepared_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `problem_note` text DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_name`, `quantity`, `unit_price`, `note`, `status`, `payment_method`, `paid_at`, `prepared_at`, `delivered_at`, `problem_note`, `parent_id`) VALUES
(326, 254, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 14:23:38', NULL, NULL, NULL),
(327, 254, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-05 14:23:39', NULL, NULL, NULL),
(328, 255, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 14:28:26', NULL, NULL, NULL),
(329, 255, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 14:28:31', NULL, NULL, NULL),
(330, 255, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 14:22:02', NULL, NULL, NULL),
(331, 255, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 14:22:04', NULL, NULL, NULL),
(332, 255, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 14:22:03', NULL, NULL, NULL),
(333, 256, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 14:30:41', NULL, NULL, NULL),
(334, 256, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:22:51', NULL, NULL, NULL),
(335, 257, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 14:34:51', NULL, NULL, NULL),
(336, 257, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 14:26:19', NULL, NULL, NULL),
(337, 257, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 14:26:20', NULL, NULL, NULL),
(338, 257, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:26:20', NULL, NULL, NULL),
(339, 257, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:26:21', NULL, NULL, NULL),
(340, 257, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:26:22', NULL, NULL, NULL),
(341, 257, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-05 14:34:53', NULL, NULL, NULL),
(342, 257, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 14:39:23', NULL, NULL, NULL),
(343, 257, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 14:38:08', NULL, NULL, NULL),
(344, 258, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 14:28:29', NULL, NULL, NULL),
(345, 258, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:28:30', NULL, NULL, NULL),
(346, 258, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 14:43:19', NULL, NULL, NULL),
(347, 258, 'koktejl', '02. Summer gin Garage22 & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-05 14:28:31', NULL, NULL, NULL),
(348, 259, 'spritz', '01. Spritz Hugo', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 14:29:35', NULL, NULL, NULL),
(349, 259, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 14:45:21', NULL, NULL, NULL),
(350, 260, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 14:52:47', NULL, NULL, NULL),
(351, 260, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 14:49:41', NULL, NULL, NULL),
(352, 260, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 14:49:42', NULL, NULL, NULL),
(353, 260, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:32:35', NULL, NULL, NULL),
(354, 260, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:32:36', NULL, NULL, NULL),
(355, 260, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 14:32:37', NULL, NULL, NULL),
(356, 260, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 14:32:38', NULL, NULL, NULL),
(357, 261, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:41:45', NULL, NULL, NULL),
(358, 261, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:41:46', NULL, NULL, NULL),
(359, 261, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 14:41:46', NULL, NULL, NULL),
(360, 261, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 14:41:47', NULL, NULL, NULL),
(361, 261, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 14:41:48', NULL, NULL, NULL),
(362, 262, 'pasta', '02. Gnocchi quattro formaggi', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 14:59:26', NULL, NULL, NULL),
(363, 262, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 14:56:14', NULL, NULL, NULL),
(364, 262, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 14:58:20', NULL, NULL, NULL),
(365, 262, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 14:56:16', NULL, NULL, NULL),
(366, 263, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 14:46:14', NULL, NULL, NULL),
(367, 264, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:56:44', NULL, NULL, NULL),
(368, 264, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:56:44', NULL, NULL, NULL),
(369, 264, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 14:56:45', NULL, NULL, NULL),
(370, 265, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 14:58:29', NULL, NULL, NULL),
(371, 265, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 14:58:30', NULL, NULL, NULL),
(372, 265, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 15:01:34', NULL, NULL, NULL),
(373, 266, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:01:01', NULL, NULL, NULL),
(374, 266, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:01:02', NULL, NULL, NULL),
(375, 267, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:01:49', NULL, NULL, NULL),
(376, 268, 'spritz', '01. Spritz Hugo', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 15:04:19', NULL, NULL, NULL),
(377, 268, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:04:20', NULL, NULL, NULL),
(378, 268, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:04:20', NULL, NULL, NULL),
(379, 269, 'nealko', '06. Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 15:06:53', NULL, NULL, NULL),
(380, 269, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 15:08:25', NULL, NULL, NULL),
(381, 269, 'koktejl', '02. Summer gin Garage22 & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-05 15:06:54', NULL, NULL, NULL),
(382, 270, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 15:09:36', NULL, NULL, NULL),
(383, 271, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:15:00', NULL, NULL, NULL),
(384, 271, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:15:01', NULL, NULL, NULL),
(385, 271, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 15:15:02', NULL, NULL, NULL),
(386, 271, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:15:07', NULL, NULL, NULL),
(387, 271, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 15:24:00', NULL, NULL, NULL),
(388, 271, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 15:24:01', NULL, NULL, NULL),
(389, 272, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:18:40', NULL, NULL, NULL),
(390, 273, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 15:27:56', NULL, NULL, NULL),
(391, 273, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 15:30:46', NULL, NULL, NULL),
(392, 273, 'spritz', '01. Spritz Limoncello', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 15:23:46', NULL, NULL, NULL),
(393, 273, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 15:40:05', NULL, NULL, NULL),
(394, 273, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:23:47', NULL, NULL, NULL),
(395, 273, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:23:48', NULL, NULL, NULL),
(396, 273, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 15:43:24', NULL, NULL, NULL),
(397, 273, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:23:49', NULL, NULL, NULL),
(398, 273, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:23:50', NULL, NULL, NULL),
(399, 273, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:23:51', NULL, NULL, NULL),
(400, 273, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 15:39:58', NULL, NULL, NULL),
(401, 274, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 15:47:15', NULL, NULL, NULL),
(402, 274, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 15:51:02', NULL, NULL, NULL),
(403, 274, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 15:56:06', NULL, NULL, NULL),
(404, 274, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:26:14', NULL, NULL, NULL),
(405, 274, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:26:15', NULL, NULL, NULL),
(406, 274, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:26:16', NULL, NULL, NULL),
(407, 274, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 15:26:17', NULL, NULL, NULL),
(408, 274, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 15:56:08', NULL, NULL, NULL),
(409, 275, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:35:22', NULL, NULL, NULL),
(410, 276, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:38:06', NULL, NULL, NULL),
(411, 276, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:38:06', NULL, NULL, NULL),
(412, 277, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:43:03', NULL, NULL, NULL),
(413, 277, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 15:43:04', NULL, NULL, NULL),
(414, 277, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:03:49', NULL, NULL, NULL),
(415, 277, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:03:47', NULL, NULL, NULL),
(416, 277, 'pasta', '02. Spaghetti pomodoro', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 16:03:51', NULL, NULL, NULL),
(417, 277, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:43:06', NULL, NULL, NULL),
(418, 278, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:44:48', NULL, NULL, NULL),
(419, 278, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:44:48', NULL, NULL, NULL),
(420, 278, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:10:03', NULL, NULL, NULL),
(421, 279, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:10:04', NULL, NULL, NULL),
(422, 279, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:48:44', NULL, NULL, NULL),
(423, 279, 'digestiv', '03. Limoncello', 1, 90.00, '', 'paid', 'cash', NULL, '2025-07-05 15:48:45', NULL, NULL, NULL),
(424, 280, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:49:59', NULL, NULL, NULL),
(425, 281, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 15:50:00', NULL, NULL, NULL),
(426, 282, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:17:04', NULL, NULL, NULL),
(427, 282, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 15:53:33', NULL, NULL, NULL),
(428, 282, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:17:04', NULL, NULL, NULL),
(429, 282, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:53:33', NULL, NULL, NULL),
(430, 283, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:54:48', NULL, NULL, NULL),
(431, 283, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 15:54:49', NULL, NULL, NULL),
(432, 284, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 15:58:41', NULL, NULL, NULL),
(433, 285, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:01:03', NULL, NULL, NULL),
(434, 285, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:01:04', NULL, NULL, NULL),
(435, 286, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:17:13', NULL, NULL, NULL),
(436, 286, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:03:27', NULL, NULL, NULL),
(437, 287, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 16:32:19', NULL, NULL, NULL),
(438, 287, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:32:21', NULL, NULL, NULL),
(439, 287, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-05 16:40:04', NULL, NULL, NULL),
(440, 287, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:39:25', NULL, NULL, NULL),
(441, 287, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:40:05', NULL, NULL, NULL),
(442, 287, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:40:15', NULL, NULL, NULL),
(443, 287, 'negroni', '00. Negroni Sbagliato', 1, 150.00, '', 'paid', 'cash', NULL, '2025-07-05 16:10:58', NULL, NULL, NULL),
(444, 287, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 16:10:59', NULL, NULL, NULL),
(445, 287, 'nealko', '06. Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 16:07:49', NULL, NULL, NULL),
(446, 287, 'spritz', '01. Spritz Limoncello', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 16:11:00', NULL, NULL, NULL),
(447, 287, 'spritz', '01. Spritz Campari', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 16:11:01', NULL, NULL, NULL),
(448, 288, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:13:37', NULL, NULL, NULL),
(449, 288, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:13:38', NULL, NULL, NULL),
(450, 288, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 16:13:39', NULL, NULL, NULL),
(451, 288, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:28:47', NULL, NULL, NULL),
(452, 289, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:15:16', NULL, NULL, NULL),
(453, 290, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:11:03', NULL, NULL, NULL),
(454, 290, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:11:04', NULL, NULL, NULL),
(455, 291, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:40:16', NULL, NULL, NULL),
(456, 291, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:15:17', NULL, NULL, NULL),
(457, 292, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:17:14', NULL, NULL, NULL),
(458, 292, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:17:15', NULL, NULL, NULL),
(459, 293, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:18:00', NULL, NULL, NULL),
(460, 294, 'spritz', '01. Spritz Hugo', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 16:20:09', NULL, NULL, NULL),
(461, 294, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 16:20:10', NULL, NULL, NULL),
(462, 294, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 16:45:56', NULL, NULL, NULL),
(463, 294, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:41:12', NULL, NULL, NULL),
(464, 295, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:40:45', NULL, NULL, NULL),
(465, 296, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:49:17', NULL, NULL, NULL),
(466, 297, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:25:34', NULL, NULL, NULL),
(467, 297, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:25:35', NULL, NULL, NULL),
(468, 297, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:25:36', NULL, NULL, NULL),
(469, 297, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:25:36', NULL, NULL, NULL),
(470, 297, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:57:37', NULL, NULL, NULL),
(471, 298, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:28:46', NULL, NULL, NULL),
(472, 299, 'predkrm', '00. Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-05 16:45:55', NULL, NULL, NULL),
(473, 299, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:20:11', NULL, NULL, NULL),
(474, 300, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:28:48', NULL, NULL, NULL),
(475, 301, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 16:52:15', NULL, NULL, NULL),
(476, 302, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 16:29:17', NULL, NULL, NULL),
(477, 303, 'predkrm', '00. Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-05 16:55:05', NULL, NULL, NULL),
(478, 303, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 16:29:40', NULL, NULL, NULL),
(479, 304, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:33:43', NULL, NULL, NULL),
(480, 305, 'pizza', 'Krabice', 1, 10.00, '', 'paid', 'cash', NULL, '2025-07-05 16:40:44', NULL, NULL, NULL),
(481, 306, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:33:44', NULL, NULL, NULL),
(482, 307, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:34:28', NULL, NULL, NULL),
(483, 307, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:34:29', NULL, NULL, NULL),
(484, 307, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:36:54', NULL, NULL, NULL),
(485, 308, 'negroni', '00. Negroni Classico', 1, 150.00, '', 'paid', 'cash', NULL, '2025-07-05 16:38:51', NULL, NULL, NULL),
(486, 309, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:33:45', NULL, NULL, NULL),
(487, 310, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:41:09', NULL, NULL, NULL),
(488, 310, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 16:41:12', NULL, NULL, NULL),
(489, 311, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:42:55', NULL, NULL, NULL),
(490, 312, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:42:57', NULL, NULL, NULL),
(491, 313, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 16:44:53', NULL, NULL, NULL),
(492, 314, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:48:56', NULL, NULL, NULL),
(493, 315, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:53:08', NULL, NULL, NULL),
(494, 315, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 16:53:12', NULL, NULL, NULL),
(495, 316, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:59:44', NULL, NULL, NULL),
(496, 317, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 16:59:45', NULL, NULL, NULL),
(497, 318, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:08:31', NULL, NULL, NULL),
(498, 318, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:06:34', NULL, NULL, NULL),
(499, 318, 'vino', '04. Víno Frizzante bílé', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-05 17:06:34', NULL, NULL, NULL),
(500, 318, 'predkrm', '00. Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-05 17:12:39', NULL, NULL, NULL),
(501, 318, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:12:44', NULL, NULL, NULL),
(502, 318, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 17:06:35', NULL, NULL, NULL),
(503, 318, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:06:36', NULL, NULL, NULL),
(504, 318, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:06:37', NULL, NULL, NULL),
(505, 319, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:09:59', NULL, NULL, NULL),
(506, 319, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:09:58', NULL, NULL, NULL),
(507, 319, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:10:00', NULL, NULL, NULL),
(508, 319, 'pasta', '02. Spaghetti pomodoro', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 17:28:00', NULL, NULL, NULL),
(509, 319, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:11:33', NULL, NULL, NULL),
(510, 320, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-05 17:15:25', NULL, NULL, NULL),
(511, 320, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:16:47', NULL, NULL, NULL),
(512, 320, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 17:12:11', NULL, NULL, NULL),
(513, 320, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 17:12:11', NULL, NULL, NULL),
(514, 320, 'koktejl', '02. Summer gin Garage22 & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-05 17:12:12', NULL, NULL, NULL),
(515, 321, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:16:19', NULL, NULL, NULL),
(516, 322, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:15:16', NULL, NULL, NULL),
(517, 322, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:15:17', NULL, NULL, NULL),
(518, 322, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:15:17', NULL, NULL, NULL),
(519, 322, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:15:18', NULL, NULL, NULL),
(520, 322, 'predkrm', '00. Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-05 17:27:55', NULL, NULL, NULL),
(521, 323, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-05 17:23:09', NULL, NULL, NULL),
(522, 323, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-05 17:23:11', NULL, NULL, NULL),
(523, 323, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:21:29', NULL, NULL, NULL),
(524, 323, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:21:31', NULL, NULL, NULL),
(525, 323, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:21:32', NULL, NULL, NULL),
(526, 323, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:21:33', NULL, NULL, NULL),
(527, 323, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:21:34', NULL, NULL, NULL),
(528, 323, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:21:35', NULL, NULL, NULL),
(529, 323, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 17:21:36', NULL, NULL, NULL),
(530, 323, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:21:42', NULL, NULL, NULL),
(531, 323, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:21:43', NULL, NULL, NULL),
(532, 323, 'nealko', '06. Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 17:23:14', NULL, NULL, NULL),
(533, 323, 'vino', '04. Víno 1 dcl', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:23:15', NULL, NULL, NULL),
(534, 323, 'pasta', '02. Gnocchi quattro formaggi', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 17:33:00', NULL, NULL, NULL),
(535, 323, 'pasta', '02. Gnocchi quattro formaggi', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 17:33:01', NULL, NULL, NULL),
(536, 323, 'pasta', '02. Gnocchi quattro formaggi', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 17:33:02', NULL, NULL, NULL),
(537, 323, 'pasta', '02. Gnocchi quattro formaggi', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 17:33:03', NULL, NULL, NULL),
(538, 323, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:26:07', NULL, NULL, NULL),
(539, 323, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:26:51', NULL, NULL, NULL),
(540, 323, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:29:05', NULL, NULL, NULL),
(541, 323, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:29:31', NULL, NULL, NULL),
(542, 324, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:18:14', NULL, NULL, NULL),
(543, 324, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 17:28:07', NULL, NULL, NULL),
(544, 324, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:28:08', NULL, NULL, NULL),
(545, 324, 'negroni', '00. Negroni Sbagliato', 1, 150.00, '', 'paid', 'cash', NULL, '2025-07-05 17:28:09', NULL, NULL, NULL),
(546, 325, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:30:04', NULL, NULL, NULL),
(547, 325, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 17:36:35', NULL, NULL, NULL),
(548, 325, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:36:42', NULL, NULL, NULL),
(549, 325, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:30:04', NULL, NULL, NULL),
(550, 326, 'spritz', '01. Spritz Sarti', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 17:27:20', NULL, NULL, NULL),
(551, 326, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:27:21', NULL, NULL, NULL),
(552, 327, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:50:37', NULL, NULL, NULL),
(553, 327, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:47:32', NULL, NULL, NULL),
(554, 327, 'spritz', '01. Spritz Sarti', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 17:33:53', NULL, NULL, NULL),
(555, 327, 'spritz', '01. Spritz Sarti', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 17:33:54', NULL, NULL, NULL),
(556, 327, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:33:55', NULL, NULL, NULL),
(557, 328, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:36:42', NULL, NULL, NULL),
(558, 328, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-05 17:49:05', NULL, NULL, NULL),
(559, 328, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:36:42', NULL, NULL, NULL),
(560, 328, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:45:43', NULL, NULL, NULL),
(561, 329, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 17:39:43', NULL, NULL, NULL),
(562, 329, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:39:43', NULL, NULL, NULL),
(563, 329, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:39:44', NULL, NULL, NULL),
(564, 329, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:39:25', NULL, NULL, NULL),
(565, 329, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:41:22', NULL, NULL, NULL),
(566, 329, 'pasta', '02. Spaghetti pomodoro', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 17:43:36', NULL, NULL, NULL),
(567, 330, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:43:15', NULL, NULL, NULL),
(568, 330, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:43:16', NULL, NULL, NULL),
(569, 330, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 17:43:16', NULL, NULL, NULL),
(570, 330, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:52:31', NULL, NULL, NULL),
(571, 331, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:39:44', NULL, NULL, NULL),
(572, 331, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:39:45', NULL, NULL, NULL),
(573, 332, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:45:16', NULL, NULL, NULL),
(574, 332, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 17:54:53', NULL, NULL, NULL),
(575, 333, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:56:15', NULL, NULL, NULL),
(576, 333, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 17:47:06', NULL, NULL, NULL),
(577, 333, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:47:07', NULL, NULL, NULL),
(578, 334, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 17:39:46', NULL, NULL, NULL),
(579, 335, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 17:50:55', NULL, NULL, NULL),
(580, 335, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:50:56', NULL, NULL, NULL),
(581, 335, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:50:57', NULL, NULL, NULL),
(582, 335, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:58:23', NULL, NULL, NULL),
(583, 335, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 17:59:53', NULL, NULL, NULL),
(584, 335, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:01:48', NULL, NULL, NULL),
(585, 336, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 18:01:02', NULL, NULL, NULL),
(586, 336, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:56:07', NULL, NULL, NULL),
(587, 336, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:56:09', NULL, NULL, NULL),
(588, 336, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 17:56:10', NULL, NULL, NULL),
(589, 336, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:05:48', NULL, NULL, NULL),
(590, 337, 'vino', '04. Víno 1 dcl', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:28:18', NULL, NULL, NULL),
(591, 338, 'spritz', '01. Spritz Sarti', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 17:57:49', NULL, NULL, NULL),
(592, 339, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:06:34', NULL, NULL, NULL),
(593, 340, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:01:39', NULL, NULL, NULL),
(594, 341, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:00:07', NULL, NULL, NULL),
(595, 341, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 18:00:08', NULL, NULL, NULL),
(596, 341, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:08:48', NULL, NULL, NULL),
(597, 341, 'koktejl', '02. Summer gin Garage22 & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-05 18:00:12', NULL, NULL, NULL),
(598, 341, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:00:13', NULL, NULL, NULL),
(599, 341, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 18:13:26', NULL, NULL, NULL),
(600, 342, 'koktejl', '02. Summer gin Garage22 & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-05 17:56:11', NULL, NULL, NULL),
(601, 342, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:56:12', NULL, NULL, NULL),
(602, 342, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 17:56:13', NULL, NULL, NULL),
(603, 343, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:04:30', NULL, NULL, NULL),
(604, 343, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:04:31', NULL, NULL, NULL),
(605, 343, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:04:32', NULL, NULL, NULL),
(606, 343, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:04:32', NULL, NULL, NULL),
(607, 344, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:07:33', NULL, NULL, NULL),
(608, 344, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 18:07:33', NULL, NULL, NULL),
(609, 344, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 18:07:34', NULL, NULL, NULL),
(610, 344, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:19:51', NULL, NULL, NULL),
(611, 345, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:09:09', NULL, NULL, NULL),
(612, 345, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 18:09:11', NULL, NULL, NULL),
(613, 345, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 18:27:32', NULL, NULL, NULL),
(614, 345, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:29:42', NULL, NULL, NULL),
(615, 346, 'digestiv', '03. Limoncello', 1, 90.00, '', 'paid', 'cash', NULL, '2025-07-05 18:13:26', NULL, NULL, NULL),
(616, 347, 'pasta', '02. Gnocchi quattro formaggi', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 18:40:47', NULL, NULL, NULL),
(617, 347, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:04:33', NULL, NULL, NULL),
(618, 348, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:10:00', NULL, NULL, NULL),
(619, 348, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:13:53', NULL, NULL, NULL),
(620, 348, 'pasta', '02. Spaghetti pomodoro', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 18:12:43', NULL, NULL, NULL),
(621, 349, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:15:51', NULL, NULL, NULL),
(622, 349, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:15:51', NULL, NULL, NULL),
(623, 349, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:15:52', NULL, NULL, NULL),
(624, 349, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:08:01', NULL, NULL, NULL),
(625, 349, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:16:02', NULL, NULL, NULL),
(626, 349, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:18:08', NULL, NULL, NULL),
(627, 349, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:15:53', NULL, NULL, NULL),
(628, 350, 'pasta', '02. Spaghetti pomodoro', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 18:33:13', NULL, NULL, NULL),
(629, 350, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 18:31:34', NULL, NULL, NULL),
(630, 350, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:32:28', NULL, NULL, NULL),
(631, 350, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:17:42', NULL, NULL, NULL),
(632, 350, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:17:43', NULL, NULL, NULL),
(633, 350, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:17:43', NULL, NULL, NULL),
(634, 351, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-05 18:02:49', NULL, NULL, NULL),
(635, 352, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:24:01', NULL, NULL, NULL),
(636, 352, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:24:02', NULL, NULL, NULL),
(637, 353, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:37:44', NULL, NULL, NULL),
(638, 353, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:22:28', NULL, NULL, NULL),
(639, 353, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 18:22:28', NULL, NULL, NULL),
(640, 354, 'pasta', '02. Gnocchi quattro formaggi', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 18:40:48', NULL, NULL, NULL),
(641, 355, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-05 18:39:03', NULL, NULL, NULL),
(642, 356, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:43:54', NULL, NULL, NULL),
(643, 356, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:47:00', NULL, NULL, NULL),
(644, 356, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:46:59', NULL, NULL, NULL),
(645, 356, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:47:47', NULL, NULL, NULL),
(646, 356, 'vino', '04. Víno Tramín', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-05 18:25:03', NULL, NULL, NULL),
(647, 356, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:27:08', NULL, NULL, NULL),
(648, 356, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:25:53', NULL, NULL, NULL),
(649, 356, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:25:54', NULL, NULL, NULL),
(650, 356, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:25:56', NULL, NULL, NULL),
(651, 356, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:26:19', NULL, NULL, NULL),
(652, 356, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:26:20', NULL, NULL, NULL),
(653, 357, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 18:17:08', NULL, NULL, NULL),
(654, 357, 'pizza', 'Krabice', 1, 10.00, '', 'paid', 'cash', NULL, '2025-07-05 18:17:04', NULL, NULL, NULL),
(655, 358, 'nealko', '06. Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 18:24:03', NULL, NULL, NULL),
(656, 358, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:24:03', NULL, NULL, NULL),
(657, 359, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:29:00', NULL, NULL, NULL),
(658, 360, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:29:03', NULL, NULL, NULL),
(659, 361, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:29:05', NULL, NULL, NULL),
(660, 362, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-05 18:52:27', NULL, NULL, NULL),
(661, 362, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:53:41', NULL, NULL, NULL),
(662, 362, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:43:50', NULL, NULL, NULL),
(663, 362, 'koktejl', '02. Summer gin Garage22 & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-05 18:34:33', NULL, NULL, NULL),
(664, 362, 'koktejl', '02. Malfi rosa & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-05 18:34:34', NULL, NULL, NULL),
(665, 362, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:34:34', NULL, NULL, NULL),
(666, 363, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:35:23', NULL, NULL, NULL),
(667, 364, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:41:33', NULL, NULL, NULL),
(668, 364, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:41:34', NULL, NULL, NULL),
(669, 365, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:42:22', NULL, NULL, NULL),
(670, 366, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 18:50:09', NULL, NULL, NULL),
(671, 366, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:50:09', NULL, NULL, NULL),
(672, 366, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:56:51', NULL, NULL, NULL),
(673, 367, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 18:58:24', NULL, NULL, NULL),
(674, 368, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:55:07', NULL, NULL, NULL),
(675, 368, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:55:08', NULL, NULL, NULL),
(676, 368, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 18:55:09', NULL, NULL, NULL),
(677, 369, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 19:00:04', NULL, NULL, NULL),
(678, 369, 'pizza', 'Krabice', 1, 10.00, '', 'paid', 'cash', NULL, '2025-07-05 18:59:58', NULL, NULL, NULL),
(679, 370, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 19:02:07', NULL, NULL, NULL),
(680, 370, 'pizza', 'Krabice', 1, 10.00, '', 'paid', 'cash', NULL, '2025-07-05 18:59:56', NULL, NULL, NULL),
(681, 370, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 18:56:44', NULL, NULL, NULL),
(682, 371, 'pivo', '05. Mazák 0,3l', 1, 45.00, '', 'paid', 'cash', NULL, '2025-07-05 18:58:32', NULL, NULL, NULL),
(683, 371, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 18:58:33', NULL, NULL, NULL),
(684, 371, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-05 19:10:12', NULL, NULL, NULL),
(685, 372, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:01:28', NULL, NULL, NULL),
(686, 372, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:01:28', NULL, NULL, NULL),
(687, 372, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 19:11:20', NULL, NULL, NULL),
(688, 373, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 19:12:43', NULL, NULL, NULL),
(689, 374, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:06:26', NULL, NULL, NULL),
(690, 375, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 19:26:11', NULL, NULL, NULL),
(691, 375, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:17:04', NULL, NULL, NULL),
(692, 375, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 19:17:05', NULL, NULL, NULL),
(693, 376, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:20:17', NULL, NULL, NULL),
(694, 376, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:20:18', NULL, NULL, NULL),
(695, 376, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 19:29:15', NULL, NULL, NULL),
(696, 376, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 19:31:09', NULL, NULL, NULL),
(697, 376, 'pasta', '02. Gnocchi quattro formaggi', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-05 19:38:18', NULL, NULL, NULL),
(698, 376, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 19:37:31', NULL, NULL, NULL),
(699, 377, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:21:05', NULL, NULL, NULL),
(700, 377, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 19:21:06', NULL, NULL, NULL),
(701, 378, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-05 19:21:02', NULL, NULL, NULL),
(702, 379, 'pizza', 'Krabice', 1, 10.00, '', 'paid', 'cash', NULL, '2025-07-05 19:23:41', NULL, NULL, NULL),
(703, 380, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-05 19:44:11', NULL, NULL, NULL),
(704, 380, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 19:31:58', NULL, NULL, NULL),
(705, 380, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 19:31:59', NULL, NULL, NULL),
(706, 380, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 19:31:59', NULL, NULL, NULL),
(707, 380, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:32:00', NULL, NULL, NULL),
(708, 380, 'vino', '04. Víno 1 dcl', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:33:29', NULL, NULL, NULL),
(709, 380, 'vino', '04. Víno 1 dcl', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:33:30', NULL, NULL, NULL),
(710, 381, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 19:35:01', NULL, NULL, NULL),
(711, 381, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:34:36', NULL, NULL, NULL),
(712, 381, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-05 19:32:08', NULL, NULL, NULL),
(713, 382, 'koktejl', '02. Martini Fiero & tonic', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 19:43:42', NULL, NULL, NULL),
(714, 382, 'koktejl', '02. Martini Fiero & tonic', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 19:43:43', NULL, NULL, NULL),
(715, 383, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:45:10', NULL, NULL, NULL),
(716, 384, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:45:11', NULL, NULL, NULL),
(717, 385, 'predkrm', '00. Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-05 19:43:42', NULL, NULL, NULL),
(718, 386, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-05 19:46:23', NULL, NULL, NULL),
(719, 387, 'koktejl', '02. Martini Fiero & tonic', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 19:56:04', NULL, NULL, NULL),
(720, 388, 'koktejl', '02. Martini Fiero & tonic', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 19:57:39', NULL, NULL, NULL),
(721, 388, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 19:57:40', NULL, NULL, NULL),
(722, 389, 'koktejl', '02. Martini Fiero & tonic', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 19:57:40', NULL, NULL, NULL),
(723, 389, 'koktejl', '02. Martini Fiero & tonic', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 19:57:42', NULL, NULL, NULL),
(724, 389, 'koktejl', '02. Martini Fiero & tonic', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 19:57:42', NULL, NULL, NULL),
(725, 390, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 20:03:19', NULL, NULL, NULL),
(726, 390, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 20:03:18', NULL, NULL, NULL),
(727, 391, 'spritz', '01. Spritz Hugo', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-05 20:02:19', NULL, NULL, NULL),
(728, 391, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 20:02:19', NULL, NULL, NULL),
(729, 392, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 20:26:00', NULL, NULL, NULL),
(730, 393, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 20:34:29', NULL, NULL, NULL),
(731, 394, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 21:09:06', NULL, NULL, NULL),
(732, 395, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-05 21:09:07', NULL, NULL, NULL),
(801, 416, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 13:04:56', NULL, NULL, NULL),
(802, 416, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 13:13:15', NULL, NULL, NULL),
(803, 416, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 13:05:01', NULL, NULL, NULL),
(804, 416, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-06 13:13:16', NULL, NULL, NULL),
(805, 417, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 13:20:00', NULL, NULL, NULL),
(806, 417, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 13:20:01', NULL, NULL, NULL),
(807, 417, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 13:20:02', NULL, NULL, NULL),
(808, 418, 'pivo', '05. Mazák 0,5l', 1, 60.00, '', 'paid', 'cash', NULL, '2025-07-06 13:25:00', NULL, NULL, NULL),
(809, 418, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 13:31:51', NULL, NULL, NULL),
(810, 418, 'spritz', '01. Spritz Limoncello', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 13:27:25', NULL, NULL, NULL),
(811, 418, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 13:24:52', NULL, NULL, NULL),
(812, 419, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 13:46:18', NULL, NULL, NULL),
(813, 420, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 13:48:51', NULL, NULL, NULL),
(814, 421, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:02:05', NULL, NULL, NULL),
(815, 421, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 14:10:12', NULL, NULL, NULL),
(816, 421, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 14:10:13', NULL, NULL, NULL),
(817, 421, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 14:03:15', NULL, NULL, NULL),
(818, 422, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 14:29:34', NULL, NULL, NULL);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_name`, `quantity`, `unit_price`, `note`, `status`, `payment_method`, `paid_at`, `prepared_at`, `delivered_at`, `problem_note`, `parent_id`) VALUES
(819, 422, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 14:29:35', NULL, NULL, NULL),
(820, 422, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:19:02', NULL, NULL, NULL),
(821, 422, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:19:01', NULL, NULL, NULL),
(822, 422, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:18:59', NULL, NULL, NULL),
(823, 422, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:19:00', NULL, NULL, NULL),
(824, 423, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:21:24', NULL, NULL, NULL),
(825, 424, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 14:36:29', NULL, NULL, NULL),
(826, 425, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:42:06', NULL, NULL, NULL),
(827, 425, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:42:07', NULL, NULL, NULL),
(828, 425, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:42:08', NULL, NULL, NULL),
(829, 425, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:40:48', NULL, NULL, NULL),
(830, 425, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 14:48:31', NULL, NULL, NULL),
(831, 425, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 14:48:33', NULL, NULL, NULL),
(832, 425, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 14:50:48', NULL, NULL, NULL),
(833, 426, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 14:53:19', NULL, NULL, NULL),
(834, 427, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:43:21', NULL, NULL, NULL),
(835, 428, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-06 14:56:22', NULL, NULL, NULL),
(836, 429, 'spritz', '01. Spritz Limoncello', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 14:51:50', NULL, NULL, NULL),
(837, 429, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 14:51:51', NULL, NULL, NULL),
(838, 430, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:54:07', NULL, NULL, NULL),
(839, 430, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 14:54:11', NULL, NULL, NULL),
(840, 431, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:01:17', NULL, NULL, NULL),
(841, 431, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:01:18', NULL, NULL, NULL),
(842, 431, 'spritz', '01. Spritz Hugo', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 15:01:19', NULL, NULL, NULL),
(843, 431, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:04:30', NULL, NULL, NULL),
(844, 431, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:04:32', NULL, NULL, NULL),
(845, 431, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:08:19', NULL, NULL, NULL),
(846, 431, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:11:30', NULL, NULL, NULL),
(847, 431, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:01:20', NULL, NULL, NULL),
(848, 432, 'pivo', '05. Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 15:11:16', NULL, NULL, NULL),
(849, 433, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 15:13:25', NULL, NULL, NULL),
(850, 433, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:13:26', NULL, NULL, NULL),
(851, 434, 'nealko', '06. Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 15:18:13', NULL, NULL, NULL),
(852, 434, 'vino', '04. Víno 1 dcl', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:18:14', NULL, NULL, NULL),
(853, 434, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 15:28:14', NULL, NULL, NULL),
(854, 434, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:28:16', NULL, NULL, NULL),
(855, 434, 'predkrm', '00. Focaccia e olio', 1, 75.00, '', 'paid', 'cash', NULL, '2025-07-06 15:18:12', NULL, NULL, NULL),
(856, 434, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:18:15', NULL, NULL, NULL),
(857, 435, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:18:02', NULL, NULL, NULL),
(858, 436, 'pivo', '05. Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 15:22:55', NULL, NULL, NULL),
(859, 437, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:26:38', NULL, NULL, NULL),
(860, 438, 'nealko', '06. Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 15:29:17', NULL, NULL, NULL),
(861, 438, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:29:17', NULL, NULL, NULL),
(862, 438, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:29:19', NULL, NULL, NULL),
(863, 438, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:29:20', NULL, NULL, NULL),
(864, 438, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:35:11', NULL, NULL, NULL),
(865, 438, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 15:35:13', NULL, NULL, NULL),
(866, 439, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:33:43', NULL, NULL, NULL),
(867, 439, 'koktejl', '02. Fleurs de Prairie rosé gin & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-06 15:33:44', NULL, NULL, NULL),
(868, 439, 'koktejl', '02. Malfi limone & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-06 15:33:44', NULL, NULL, NULL),
(869, 440, 'spritz', '01. Spritz Aperol', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 15:36:15', NULL, NULL, NULL),
(870, 441, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 15:37:19', NULL, NULL, NULL),
(871, 441, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:37:46', NULL, NULL, NULL),
(872, 441, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 15:37:47', NULL, NULL, NULL),
(873, 442, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:37:48', NULL, NULL, NULL),
(874, 442, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 15:35:49', NULL, NULL, NULL),
(875, 443, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:41:29', NULL, NULL, NULL),
(876, 443, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:41:30', NULL, NULL, NULL),
(877, 443, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-06 15:41:26', NULL, NULL, NULL),
(878, 443, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:43:20', NULL, NULL, NULL),
(879, 443, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:44:58', NULL, NULL, NULL),
(880, 443, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:41:31', NULL, NULL, NULL),
(881, 444, 'pivo', '05. Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 15:36:16', NULL, NULL, NULL),
(882, 445, 'spritz', '01. Spritz Limoncello', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 15:43:28', NULL, NULL, NULL),
(883, 446, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:44:50', NULL, NULL, NULL),
(884, 446, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:44:51', NULL, NULL, NULL),
(885, 446, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:50:06', NULL, NULL, NULL),
(886, 446, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:47:47', NULL, NULL, NULL),
(887, 446, 'pizza', 'Krabice', 1, 10.00, '', 'paid', 'cash', NULL, '2025-07-06 15:47:53', NULL, NULL, NULL),
(888, 446, 'pizza', 'Krabice', 1, 10.00, '', 'paid', 'cash', NULL, '2025-07-06 15:40:11', NULL, NULL, NULL),
(889, 447, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-06 15:51:36', NULL, NULL, NULL),
(890, 447, 'pizza', 'Krabice', 1, 10.00, '', 'paid', 'cash', NULL, '2025-07-06 15:51:37', NULL, NULL, NULL),
(891, 448, 'nealko', '06. Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 15:41:32', NULL, NULL, NULL),
(892, 449, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:48:04', NULL, NULL, NULL),
(893, 449, 'spritz', '01. Spritz Hugo', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 15:48:05', NULL, NULL, NULL),
(894, 449, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 15:55:17', NULL, NULL, NULL),
(895, 449, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 15:55:19', NULL, NULL, NULL),
(896, 449, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:57:49', NULL, NULL, NULL),
(897, 449, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:48:06', NULL, NULL, NULL),
(898, 450, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:45:42', NULL, NULL, NULL),
(899, 450, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 15:45:44', NULL, NULL, NULL),
(900, 451, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 16:00:55', NULL, NULL, NULL),
(901, 451, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 16:00:57', NULL, NULL, NULL),
(902, 452, 'nealko', '06. Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 15:54:04', NULL, NULL, NULL),
(903, 453, 'koktejl', '02. Fleurs de Prairie rosé gin & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-06 15:55:34', NULL, NULL, NULL),
(904, 453, 'vino', '04. Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', NULL, '2025-07-06 15:55:34', NULL, NULL, NULL),
(905, 453, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:55:35', NULL, NULL, NULL),
(906, 453, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-06 16:05:33', NULL, NULL, NULL),
(907, 454, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 15:55:38', NULL, NULL, NULL),
(908, 455, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:00:16', NULL, NULL, NULL),
(909, 455, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:00:16', NULL, NULL, NULL),
(910, 455, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:00:19', NULL, NULL, NULL),
(911, 456, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:03:31', NULL, NULL, NULL),
(912, 457, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:03:32', NULL, NULL, NULL),
(913, 458, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:11:30', NULL, NULL, NULL),
(914, 459, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:10:48', NULL, NULL, NULL),
(915, 460, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:14:42', NULL, NULL, NULL),
(916, 461, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:16:35', NULL, NULL, NULL),
(917, 461, 'pivo', '05. Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 16:16:36', NULL, NULL, NULL),
(918, 462, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:17:48', NULL, NULL, NULL),
(919, 463, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 16:33:21', NULL, NULL, NULL),
(920, 463, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 16:23:49', NULL, NULL, NULL),
(921, 463, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 16:29:27', NULL, NULL, NULL),
(922, 464, 'pivo', '05. Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 16:23:05', NULL, NULL, NULL),
(923, 464, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:23:05', NULL, NULL, NULL),
(924, 464, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:23:06', NULL, NULL, NULL),
(925, 464, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:23:07', NULL, NULL, NULL),
(926, 465, 'koktejl', '02. Fleurs de Prairie rosé gin & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-06 16:30:05', NULL, NULL, NULL),
(927, 466, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-06 16:35:18', NULL, NULL, NULL),
(928, 467, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 16:33:22', NULL, NULL, NULL),
(929, 467, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:29:39', NULL, NULL, NULL),
(930, 467, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:29:40', NULL, NULL, NULL),
(931, 468, 'predkrm', '00. Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-06 16:38:16', NULL, NULL, NULL),
(932, 468, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:35:46', NULL, NULL, NULL),
(933, 469, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 16:44:45', NULL, NULL, NULL),
(934, 469, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 16:44:46', NULL, NULL, NULL),
(935, 469, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:38:03', NULL, NULL, NULL),
(936, 469, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:38:03', NULL, NULL, NULL),
(937, 470, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:45:28', NULL, NULL, NULL),
(938, 470, 'spritz', '01. Spritz Limoncello', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 16:45:46', NULL, NULL, NULL),
(939, 471, 'predkrm', '00. Focaccia e olio', 1, 75.00, '', 'paid', 'cash', NULL, '2025-07-06 16:49:15', NULL, NULL, NULL),
(940, 471, 'predkrm', '00. Focaccia e olio', 1, 75.00, '', 'paid', 'cash', NULL, '2025-07-06 16:49:16', NULL, NULL, NULL),
(941, 471, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:48:44', NULL, NULL, NULL),
(942, 472, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:54:43', NULL, NULL, NULL),
(943, 473, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:32:58', '2025-07-06 16:57:32', NULL, NULL, NULL),
(944, 474, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 17:00:41', NULL, NULL, NULL),
(945, 475, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:58:10', NULL, NULL, NULL),
(946, 476, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 16:59:47', NULL, NULL, NULL),
(947, 477, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 17:04:48', NULL, NULL, NULL),
(948, 477, 'nealko', '06. Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 17:05:01', NULL, NULL, NULL),
(949, 477, 'spritz', '01. Spritz Limoncello', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 17:04:50', NULL, NULL, NULL),
(950, 477, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 17:14:09', NULL, NULL, NULL),
(951, 477, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 17:14:11', NULL, NULL, NULL),
(952, 478, 'pizza', '01. Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 17:14:12', NULL, NULL, NULL),
(953, 478, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 17:03:49', NULL, NULL, NULL),
(954, 479, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', '2025-07-12 11:32:58', '2025-07-06 17:23:39', NULL, NULL, NULL),
(955, 480, 'pizza', '01. Capocollo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-06 17:23:40', NULL, NULL, NULL),
(956, 480, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 17:27:53', NULL, NULL, NULL),
(957, 481, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 17:16:29', NULL, NULL, NULL),
(958, 482, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 17:19:00', NULL, NULL, NULL),
(959, 483, 'pizza', '01. Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-06 17:30:43', NULL, NULL, NULL),
(960, 483, 'pizza', '01. Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 17:34:00', NULL, NULL, NULL),
(961, 484, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 17:40:31', NULL, NULL, NULL),
(962, 484, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 17:41:48', NULL, NULL, NULL),
(963, 484, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 17:36:30', NULL, NULL, NULL),
(964, 484, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 17:36:30', NULL, NULL, NULL),
(965, 484, 'nealko', '06. Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 17:36:31', NULL, NULL, NULL),
(966, 484, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 17:43:39', NULL, NULL, NULL),
(967, 485, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 17:36:32', NULL, NULL, NULL),
(968, 486, 'pivo', '05. Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-06 17:39:24', NULL, NULL, NULL),
(969, 487, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 18:01:55', NULL, NULL, NULL),
(970, 488, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 18:01:45', NULL, NULL, NULL),
(971, 489, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 18:09:54', NULL, NULL, NULL),
(972, 489, 'pizza', '01. Diavola', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 18:04:25', NULL, NULL, NULL),
(973, 489, 'pizza', '01. Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-06 18:09:55', NULL, NULL, NULL),
(974, 489, 'pivo', '05. Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-06 18:05:24', NULL, NULL, NULL),
(975, 489, 'spritz', '01. Spritz Hugo', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 18:05:24', NULL, NULL, NULL),
(976, 489, 'spritz', '01. Spritz Hugo', 1, 120.00, '', 'paid', 'cash', NULL, '2025-07-06 18:05:25', NULL, NULL, NULL),
(1377, 660, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', NULL, '2025-07-11 13:16:15', NULL, NULL, NULL),
(1378, 660, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', NULL, '2025-07-11 13:16:16', NULL, NULL, NULL),
(1379, 660, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 13:16:17', NULL, NULL, NULL),
(1380, 660, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', NULL, '2025-07-11 13:03:18', NULL, NULL, NULL),
(1381, 661, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 13:06:27', NULL, NULL, NULL),
(1382, 661, 'vino', 'Víno Rulandské šedé', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-11 13:06:27', NULL, NULL, NULL),
(1383, 661, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 13:11:42', NULL, NULL, NULL),
(1384, 661, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', NULL, '2025-07-11 13:11:43', NULL, NULL, NULL),
(1385, 662, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:03:47', NULL, NULL, NULL),
(1386, 662, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:03:48', NULL, NULL, NULL),
(1387, 662, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:03:48', NULL, NULL, NULL),
(1388, 662, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:03:48', NULL, NULL, NULL),
(1389, 662, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:03:55', NULL, NULL, NULL),
(1390, 662, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-11 13:04:17', NULL, NULL, NULL),
(1391, 662, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 13:04:18', NULL, NULL, NULL),
(1393, 664, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-11 13:16:10', NULL, NULL, NULL),
(1394, 664, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 13:18:51', NULL, NULL, NULL),
(1395, 664, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:13:20', NULL, NULL, NULL),
(1396, 664, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:13:20', NULL, NULL, NULL),
(1397, 664, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:13:21', NULL, NULL, NULL),
(1398, 664, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:13:22', NULL, NULL, NULL),
(1399, 665, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-11 13:13:38', NULL, NULL, NULL),
(1400, 665, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 13:27:03', NULL, NULL, NULL),
(1401, 665, 'spritz', 'Spritz Sarti', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 13:18:12', NULL, NULL, NULL),
(1402, 666, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:32:58', '2025-07-11 13:22:33', NULL, NULL, NULL),
(1403, 666, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:32:58', '2025-07-11 13:22:34', NULL, NULL, NULL),
(1404, 666, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:32:58', '2025-07-11 13:22:32', NULL, NULL, NULL),
(1405, 666, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:32:58', '2025-07-11 13:48:43', NULL, NULL, NULL),
(1406, 666, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-12 11:32:58', '2025-07-11 13:46:16', NULL, NULL, NULL),
(1407, 667, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-11 13:31:25', NULL, NULL, NULL),
(1408, 667, 'vino', 'Sekt Pastorek', 1, 390.00, '', 'paid', 'cash', NULL, '2025-07-11 13:22:35', NULL, NULL, NULL),
(1409, 668, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:28:27', NULL, NULL, NULL),
(1410, 668, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:28:28', NULL, NULL, NULL),
(1411, 668, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:28:29', NULL, NULL, NULL),
(1412, 668, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 13:34:42', NULL, NULL, NULL),
(1413, 668, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', NULL, '2025-07-11 13:38:49', NULL, NULL, NULL),
(1414, 668, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 13:38:50', NULL, NULL, NULL),
(1415, 669, 'predkrm', 'Burrate e crudo', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-11 13:39:08', NULL, NULL, NULL),
(1417, 671, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 13:35:37', NULL, NULL, NULL),
(1418, 672, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 13:43:41', NULL, NULL, NULL),
(1419, 673, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 13:43:05', NULL, NULL, NULL),
(1420, 673, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-11 13:50:43', NULL, NULL, NULL),
(1421, 673, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 13:54:26', NULL, NULL, NULL),
(1422, 673, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:43:05', NULL, NULL, NULL),
(1423, 674, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 13:44:57', NULL, NULL, NULL),
(1424, 674, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:44:58', NULL, NULL, NULL),
(1425, 675, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', NULL, '2025-07-11 13:51:27', NULL, NULL, NULL),
(1426, 675, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', NULL, '2025-07-11 13:51:26', NULL, NULL, NULL),
(1427, 676, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:32:58', '2025-07-11 14:02:53', NULL, NULL, NULL),
(1428, 676, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:32:58', '2025-07-11 14:07:01', NULL, NULL, NULL),
(1429, 677, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:58:11', NULL, NULL, NULL),
(1430, 677, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 13:58:12', NULL, NULL, NULL),
(1431, 678, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:02:22', NULL, NULL, NULL),
(1432, 678, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:02:21', NULL, NULL, NULL),
(1433, 679, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 14:08:44', NULL, NULL, NULL),
(1434, 679, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 14:08:58', NULL, NULL, NULL),
(1435, 679, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 14:08:46', NULL, NULL, NULL),
(1436, 679, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:09:00', NULL, NULL, NULL),
(1437, 679, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:09:00', NULL, NULL, NULL),
(1438, 680, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 14:11:36', NULL, NULL, NULL),
(1439, 680, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 14:11:37', NULL, NULL, NULL),
(1440, 680, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:11:38', NULL, NULL, NULL),
(1441, 681, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 14:16:12', NULL, NULL, NULL),
(1442, 681, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 14:16:13', NULL, NULL, NULL),
(1443, 681, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', NULL, '2025-07-11 14:19:13', NULL, NULL, NULL),
(1444, 681, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 14:14:21', NULL, NULL, NULL),
(1445, 681, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', NULL, '2025-07-11 14:14:22', NULL, NULL, NULL),
(1446, 681, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:14:23', NULL, NULL, NULL),
(1447, 681, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:14:24', NULL, NULL, NULL),
(1448, 682, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', NULL, '2025-07-11 14:24:05', NULL, NULL, NULL),
(1449, 682, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 14:25:04', NULL, NULL, NULL),
(1450, 682, 'predkrm', 'Mozzarella e pomodorini', 1, 145.00, '', 'paid', 'cash', NULL, '2025-07-11 14:23:57', NULL, NULL, NULL),
(1451, 683, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 14:19:23', NULL, NULL, NULL),
(1452, 684, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 14:23:46', NULL, NULL, NULL),
(1453, 684, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:23:47', NULL, NULL, NULL),
(1454, 685, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 14:32:34', NULL, NULL, NULL),
(1455, 685, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 14:30:34', NULL, NULL, NULL),
(1456, 685, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 14:33:32', NULL, NULL, NULL),
(1457, 686, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:31:57', NULL, NULL, NULL),
(1458, 686, 'vino', 'Víno Rulandské šedé', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-11 14:31:58', NULL, NULL, NULL),
(1459, 686, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:31:59', NULL, NULL, NULL),
(1460, 686, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-11 14:46:47', NULL, NULL, NULL),
(1461, 686, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 14:45:35', NULL, NULL, NULL),
(1462, 686, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', NULL, '2025-07-11 14:45:36', NULL, NULL, NULL),
(1463, 686, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-11 14:36:31', NULL, NULL, NULL),
(1464, 687, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 14:35:29', NULL, NULL, NULL),
(1470, 690, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', NULL, '2025-07-11 14:52:06', NULL, NULL, NULL),
(1471, 690, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:42:51', NULL, NULL, NULL),
(1472, 691, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-11 14:47:29', NULL, NULL, NULL),
(1473, 691, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-11 14:47:30', NULL, NULL, NULL),
(1474, 691, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-11 14:47:31', NULL, NULL, NULL),
(1475, 692, 'vino', 'Víno Frizzante bílé', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-11 14:45:16', NULL, NULL, NULL),
(1476, 692, 'vino', 'Víno Rulandské šedé', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-11 14:45:16', NULL, NULL, NULL),
(1477, 692, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 14:45:17', NULL, NULL, NULL),
(1478, 693, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 14:54:55', NULL, NULL, NULL),
(1479, 693, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:54:56', NULL, NULL, NULL),
(1480, 694, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 14:54:55', NULL, NULL, NULL),
(1481, 695, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:56:32', NULL, NULL, NULL),
(1482, 696, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:58:46', NULL, NULL, NULL),
(1483, 696, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:58:47', NULL, NULL, NULL),
(1484, 696, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:58:48', NULL, NULL, NULL),
(1485, 696, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:58:49', NULL, NULL, NULL),
(1486, 696, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 15:27:17', NULL, NULL, NULL),
(1487, 696, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-11 15:27:18', NULL, NULL, NULL),
(1488, 696, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 15:27:19', NULL, NULL, NULL),
(1489, 696, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', NULL, '2025-07-11 15:03:42', NULL, NULL, NULL),
(1490, 697, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:00:50', NULL, NULL, NULL),
(1491, 698, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 14:56:58', NULL, NULL, NULL),
(1492, 699, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:00:52', NULL, NULL, NULL),
(1493, 700, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 15:02:28', NULL, NULL, NULL),
(1494, 701, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 15:22:42', NULL, NULL, NULL),
(1495, 702, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:16:11', NULL, NULL, NULL),
(1496, 702, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:16:10', NULL, NULL, NULL),
(1497, 702, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:16:09', NULL, NULL, NULL),
(1498, 702, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-11 15:20:58', NULL, NULL, NULL),
(1499, 703, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:19:33', NULL, NULL, NULL),
(1500, 703, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:19:32', NULL, NULL, NULL),
(1501, 703, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:19:34', NULL, NULL, NULL),
(1502, 703, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 15:25:36', NULL, NULL, NULL),
(1503, 703, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 15:23:38', NULL, NULL, NULL),
(1504, 703, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 15:19:35', NULL, NULL, NULL),
(1505, 704, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 15:30:51', NULL, NULL, NULL),
(1506, 704, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:21:33', NULL, NULL, NULL),
(1507, 704, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:21:34', NULL, NULL, NULL),
(1508, 704, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 15:30:52', NULL, NULL, NULL),
(1509, 704, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:21:35', NULL, NULL, NULL),
(1510, 705, 'predkrm', 'Foccacia, olio e olive', 1, 125.00, '', 'paid', 'cash', NULL, '2025-07-11 15:21:41', NULL, NULL, NULL),
(1511, 706, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 15:32:37', NULL, NULL, NULL),
(1512, 706, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:24:30', NULL, NULL, NULL),
(1513, 706, 'vino', 'Víno Frizzante růžové', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-11 15:24:29', NULL, NULL, NULL),
(1514, 706, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 15:24:28', NULL, NULL, NULL),
(1515, 706, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:24:26', NULL, NULL, NULL),
(1516, 706, 'predkrm', 'Mozzarella e pomodorini', 1, 145.00, '', 'paid', 'cash', NULL, '2025-07-11 15:25:54', NULL, NULL, NULL),
(1517, 706, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 15:33:31', NULL, NULL, NULL),
(1518, 707, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 15:37:20', NULL, NULL, NULL),
(1519, 707, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 15:37:21', NULL, NULL, NULL),
(1520, 708, 'predkrm', 'Burrate e crudo predkrm', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-11 15:30:25', NULL, NULL, NULL),
(1521, 708, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 15:27:57', NULL, NULL, NULL),
(1522, 708, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 15:48:39', NULL, NULL, NULL),
(1523, 708, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 15:27:58', NULL, NULL, NULL),
(1524, 709, 'predkrm', 'Foccacia, olio e olive', 1, 125.00, '', 'paid', 'cash', NULL, '2025-07-11 15:33:30', NULL, NULL, NULL),
(1525, 710, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:35:15', NULL, NULL, NULL),
(1526, 710, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:35:13', NULL, NULL, NULL),
(1527, 710, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-11 15:54:37', NULL, NULL, NULL),
(1528, 710, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 15:54:38', NULL, NULL, NULL),
(1529, 710, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', NULL, '2025-07-11 15:47:56', NULL, NULL, NULL),
(1531, 712, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:40:35', NULL, NULL, NULL),
(1532, 712, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:40:36', NULL, NULL, NULL),
(1533, 712, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:40:37', NULL, NULL, NULL),
(1534, 712, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:40:37', NULL, NULL, NULL),
(1535, 712, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:40:38', NULL, NULL, NULL),
(1536, 712, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 15:36:38', NULL, NULL, NULL),
(1537, 712, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 15:56:10', NULL, NULL, NULL),
(1538, 712, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 15:57:40', NULL, NULL, NULL),
(1539, 712, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 15:59:58', NULL, NULL, NULL),
(1540, 712, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', NULL, '2025-07-11 15:48:14', NULL, NULL, NULL),
(1541, 713, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 15:50:25', NULL, NULL, NULL),
(1542, 714, 'vino', 'Víno Frizzante bílé', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-11 15:52:39', NULL, NULL, NULL),
(1543, 715, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:55:46', NULL, NULL, NULL),
(1544, 715, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 15:55:46', NULL, NULL, NULL),
(1545, 715, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 16:04:25', NULL, NULL, NULL),
(1546, 715, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 16:02:03', NULL, NULL, NULL),
(1547, 716, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 16:06:07', NULL, NULL, NULL),
(1548, 716, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 15:56:50', NULL, NULL, NULL),
(1549, 717, 'koktejl', 'Rossini', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 15:59:11', NULL, NULL, NULL),
(1550, 717, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 15:59:12', NULL, NULL, NULL),
(1551, 717, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 16:09:33', NULL, NULL, NULL),
(1552, 718, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-11 16:10:52', NULL, NULL, NULL),
(1553, 718, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 16:12:32', NULL, NULL, NULL),
(1554, 719, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 16:15:08', NULL, NULL, NULL),
(1555, 719, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 16:15:09', NULL, NULL, NULL),
(1556, 719, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 16:15:10', NULL, NULL, NULL),
(1557, 720, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 16:24:44', NULL, NULL, NULL),
(1558, 721, 'vino', 'Víno Merlot', 1, 240.00, '', 'paid', 'cash', NULL, '2025-07-11 16:27:18', NULL, NULL, NULL),
(1559, 722, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 16:27:20', NULL, NULL, NULL),
(1560, 723, 'predkrm', 'Foccacia, olio e olive', 1, 125.00, '', 'paid', 'cash', NULL, '2025-07-11 16:37:59', NULL, NULL, NULL),
(1561, 723, 'predkrm', 'Foccacia, olio e olive', 1, 125.00, '', 'paid', 'cash', NULL, '2025-07-11 16:38:02', NULL, NULL, NULL),
(1562, 723, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'cash', NULL, '2025-07-11 16:38:03', NULL, NULL, NULL),
(1563, 723, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'cash', NULL, '2025-07-11 16:38:03', NULL, NULL, NULL),
(1564, 723, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 16:30:22', NULL, NULL, NULL),
(1565, 723, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 16:30:22', NULL, NULL, NULL),
(1566, 724, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 16:35:07', NULL, NULL, NULL),
(1567, 724, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 16:35:06', NULL, NULL, NULL),
(1568, 724, 'koktejl', 'Red Velvet gin Garage 22 a tonic', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-11 16:35:05', NULL, NULL, NULL),
(1569, 724, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 16:35:03', NULL, NULL, NULL),
(1570, 724, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 16:35:05', NULL, NULL, NULL),
(1571, 724, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 16:39:08', NULL, NULL, NULL),
(1572, 724, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 16:46:56', NULL, NULL, NULL),
(1573, 724, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-11 16:35:50', NULL, NULL, NULL),
(1574, 724, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 16:44:02', NULL, NULL, NULL),
(1575, 725, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 16:38:13', NULL, NULL, NULL),
(1576, 725, 'spritz', 'Spritz Sarti', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 16:38:14', NULL, NULL, NULL),
(1577, 726, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 16:54:23', NULL, NULL, NULL),
(1578, 727, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 17:04:02', NULL, NULL, NULL),
(1579, 727, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 17:04:03', NULL, NULL, NULL),
(1580, 727, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 16:51:00', NULL, NULL, NULL),
(1581, 727, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 16:51:01', NULL, NULL, NULL),
(1582, 728, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 16:52:18', NULL, NULL, NULL),
(1583, 729, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 17:05:07', NULL, NULL, NULL),
(1584, 729, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 17:05:08', NULL, NULL, NULL),
(1585, 729, 'vino', 'Víno Frizzante růžové', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-11 16:53:34', NULL, NULL, NULL),
(1586, 729, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 16:53:33', NULL, NULL, NULL),
(1587, 730, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 16:59:04', NULL, NULL, NULL),
(1588, 731, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 17:13:04', NULL, NULL, NULL),
(1589, 731, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 17:13:05', NULL, NULL, NULL),
(1590, 731, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 17:02:28', NULL, NULL, NULL),
(1591, 731, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 17:02:28', NULL, NULL, NULL),
(1592, 732, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 17:02:27', NULL, NULL, NULL),
(1593, 733, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 17:08:43', NULL, NULL, NULL),
(1594, 733, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 17:08:44', NULL, NULL, NULL),
(1595, 734, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 17:08:28', NULL, NULL, NULL),
(1596, 734, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 17:08:28', NULL, NULL, NULL),
(1597, 735, 'negroni', 'Negroni Sbagliato', 1, 150.00, '', 'paid', 'cash', NULL, '2025-07-11 17:13:52', NULL, NULL, NULL),
(1598, 736, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 17:23:17', NULL, NULL, NULL),
(1599, 736, 'negroni', 'Negroni Classico', 1, 150.00, '', 'paid', 'cash', NULL, '2025-07-11 17:20:40', NULL, NULL, NULL),
(1600, 736, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 17:20:40', NULL, NULL, NULL),
(1601, 737, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-11 17:35:58', NULL, NULL, NULL),
(1602, 738, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-11 17:36:02', NULL, NULL, NULL),
(1603, 739, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 17:25:32', NULL, NULL, NULL),
(1604, 740, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 17:36:02', NULL, NULL, NULL),
(1605, 740, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', NULL, '2025-07-11 17:28:00', NULL, NULL, NULL),
(1606, 740, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', NULL, '2025-07-11 17:28:00', NULL, NULL, NULL),
(1607, 741, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 17:30:14', NULL, NULL, NULL),
(1608, 742, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-11 17:36:06', NULL, NULL, NULL),
(1609, 743, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 18:04:13', NULL, NULL, NULL),
(1610, 744, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-11 18:26:34', NULL, NULL, NULL),
(1611, 744, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 18:21:10', NULL, NULL, NULL),
(1612, 744, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-11 18:21:11', NULL, NULL, NULL),
(1613, 744, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', NULL, '2025-07-11 18:26:34', NULL, NULL, NULL),
(1614, 744, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 18:06:58', NULL, NULL, NULL),
(1615, 744, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 18:06:58', NULL, NULL, NULL),
(1616, 744, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 18:06:57', NULL, NULL, NULL),
(1617, 744, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-11 18:06:56', NULL, NULL, NULL),
(1618, 745, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 18:15:31', NULL, NULL, NULL),
(1619, 745, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 18:15:32', NULL, NULL, NULL),
(1620, 746, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-11 18:18:32', NULL, NULL, NULL),
(1621, 747, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 18:20:19', NULL, NULL, NULL),
(1622, 747, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-11 18:20:19', NULL, NULL, NULL),
(1623, 748, 'negroni', 'Negroni Tartufo', 1, 180.00, '', 'paid', 'cash', NULL, '2025-07-11 18:42:10', NULL, NULL, NULL),
(1721, 779, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', NULL, '2025-07-12 01:55:24', NULL, NULL, NULL),
(1722, 779, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', NULL, '2025-07-12 01:55:24', NULL, NULL, NULL),
(1723, 779, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', NULL, '2025-07-12 01:55:25', NULL, NULL, NULL),
(1724, 779, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', NULL, '2025-07-12 01:55:25', NULL, NULL, NULL),
(1725, 780, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:00:26', NULL, NULL, NULL),
(1726, 780, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:00:27', NULL, NULL, NULL),
(1727, 780, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:00:27', NULL, NULL, NULL),
(1728, 780, 'negroni', 'Negroni Classico', 1, 150.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:00:28', NULL, NULL, NULL),
(1729, 780, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:42:34', NULL, NULL, NULL),
(1730, 780, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:42:34', NULL, NULL, NULL),
(1731, 780, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:42:35', NULL, NULL, NULL),
(1732, 780, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:10:08', NULL, NULL, NULL),
(1739, 784, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:13:50', NULL, NULL, NULL),
(1740, 784, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:13:51', NULL, NULL, NULL),
(1741, 784, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:13:51', NULL, NULL, NULL),
(1742, 784, 'negroni', 'Negroni Sbagliato', 1, 150.00, '', 'paid', 'cash', NULL, '2025-07-12 02:13:52', NULL, NULL, NULL),
(1743, 784, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 02:42:41', NULL, NULL, NULL),
(1744, 784, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', NULL, '2025-07-12 02:42:41', NULL, NULL, NULL),
(1745, 785, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:17:56', NULL, NULL, NULL),
(1746, 785, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:17:56', NULL, NULL, NULL),
(1747, 785, 'spritz', 'Spritz Sarti', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 02:17:55', NULL, NULL, NULL),
(1748, 785, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-12 02:43:00', NULL, NULL, NULL),
(1749, 785, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 02:17:54', NULL, NULL, NULL),
(1750, 785, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 03:11:47', NULL, NULL, NULL),
(1751, 785, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 03:17:15', NULL, NULL, NULL),
(1752, 785, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 03:14:38', NULL, NULL, NULL),
(1753, 786, 'spritz', 'Spritz Sarti', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 02:22:08', NULL, NULL, NULL),
(1754, 787, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:22:45', NULL, NULL, NULL),
(1755, 788, 'spritz', 'Spritz Campari', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 02:27:05', NULL, NULL, NULL);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_name`, `quantity`, `unit_price`, `note`, `status`, `payment_method`, `paid_at`, `prepared_at`, `delivered_at`, `problem_note`, `parent_id`) VALUES
(1756, 788, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 02:27:05', NULL, NULL, NULL),
(1757, 788, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 02:27:06', NULL, NULL, NULL),
(1758, 788, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:27:07', NULL, NULL, NULL),
(1759, 788, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 02:45:12', NULL, NULL, NULL),
(1760, 788, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 02:47:18', NULL, NULL, NULL),
(1761, 788, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:27:07', NULL, NULL, NULL),
(1762, 788, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-12 02:49:18', NULL, NULL, NULL),
(1763, 788, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-12 02:42:53', NULL, NULL, NULL),
(1764, 789, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 02:27:58', NULL, NULL, NULL),
(1765, 789, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 02:27:58', NULL, NULL, NULL),
(1766, 789, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 02:27:59', NULL, NULL, NULL),
(1767, 789, 'predkrm', 'Burrate e crudo predkrm', 1, 220.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 02:28:15', NULL, NULL, NULL),
(1768, 789, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 02:59:22', NULL, NULL, NULL),
(1769, 789, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 03:33:11', NULL, NULL, NULL),
(1770, 789, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 03:33:11', NULL, NULL, NULL),
(1771, 790, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:28:41', NULL, NULL, NULL),
(1772, 791, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 02:49:47', NULL, NULL, NULL),
(1773, 791, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 02:49:48', NULL, NULL, NULL),
(1774, 791, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:29:56', NULL, NULL, NULL),
(1775, 791, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:29:56', NULL, NULL, NULL),
(1776, 792, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 02:58:08', NULL, NULL, NULL),
(1777, 793, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-12 02:32:33', NULL, NULL, NULL),
(1778, 794, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 02:35:55', NULL, NULL, NULL),
(1779, 794, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 02:35:55', NULL, NULL, NULL),
(1780, 794, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 02:35:56', NULL, NULL, NULL),
(1781, 794, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 02:35:57', NULL, NULL, NULL),
(1782, 794, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 02:35:54', NULL, NULL, NULL),
(1783, 794, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 02:35:57', NULL, NULL, NULL),
(1784, 794, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 02:40:09', NULL, NULL, NULL),
(1785, 794, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 02:40:09', NULL, NULL, NULL),
(1786, 794, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 02:40:08', NULL, NULL, NULL),
(1787, 794, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 02:39:52', NULL, NULL, NULL),
(1788, 795, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 02:57:04', NULL, NULL, NULL),
(1789, 795, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 03:01:48', NULL, NULL, NULL),
(1790, 795, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 02:56:45', NULL, NULL, NULL),
(1791, 795, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 03:02:51', NULL, NULL, NULL),
(1792, 795, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:41:04', NULL, NULL, NULL),
(1793, 795, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:41:06', NULL, NULL, NULL),
(1794, 795, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:41:05', NULL, NULL, NULL),
(1795, 795, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:41:05', NULL, NULL, NULL),
(1796, 795, 'koktejl', 'Summer gin Garage22 & tonic', 1, 150.00, '', 'paid', 'cash', NULL, '2025-07-12 02:41:03', NULL, NULL, NULL),
(1797, 795, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:41:06', NULL, NULL, NULL),
(1798, 795, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', NULL, '2025-07-12 02:49:35', NULL, NULL, NULL),
(1799, 795, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 03:01:52', NULL, NULL, NULL),
(1800, 796, 'spritz', 'Spritz Sarti', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 02:41:02', NULL, NULL, NULL),
(1801, 797, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:43:47', NULL, NULL, NULL),
(1802, 797, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-12 02:47:36', NULL, NULL, NULL),
(1803, 797, 'koktejl', 'Summer gin Garage22 & tonic', 1, 150.00, '', 'paid', 'cash', NULL, '2025-07-12 02:43:46', NULL, NULL, NULL),
(1804, 798, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 02:45:04', NULL, NULL, NULL),
(1805, 798, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:45:05', NULL, NULL, NULL),
(1806, 798, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 03:18:42', NULL, NULL, NULL),
(1807, 799, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 03:20:59', NULL, NULL, NULL),
(1808, 799, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 03:23:27', NULL, NULL, NULL),
(1809, 799, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 03:25:01', NULL, NULL, NULL),
(1810, 799, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:50:55', NULL, NULL, NULL),
(1811, 799, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:50:54', NULL, NULL, NULL),
(1812, 799, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:50:53', NULL, NULL, NULL),
(1813, 799, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:50:56', NULL, NULL, NULL),
(1814, 799, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 02:50:52', NULL, NULL, NULL),
(1815, 800, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:52:18', NULL, NULL, NULL),
(1816, 801, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:54:26', NULL, NULL, NULL),
(1817, 801, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 02:54:27', NULL, NULL, NULL),
(1818, 802, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 03:00:55', NULL, NULL, NULL),
(1819, 802, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 03:00:53', NULL, NULL, NULL),
(1820, 803, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:00:20', NULL, NULL, NULL),
(1821, 803, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:00:18', NULL, NULL, NULL),
(1822, 803, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:00:16', NULL, NULL, NULL),
(1823, 803, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-12 03:35:38', NULL, NULL, NULL),
(1824, 804, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 03:02:20', NULL, NULL, NULL),
(1825, 805, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 03:09:53', NULL, NULL, NULL),
(1826, 805, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 03:09:54', NULL, NULL, NULL),
(1827, 805, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 03:09:55', NULL, NULL, NULL),
(1828, 805, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 03:08:20', NULL, NULL, NULL),
(1829, 805, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 03:08:21', NULL, NULL, NULL),
(1830, 806, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 03:36:56', NULL, NULL, NULL),
(1831, 807, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 03:11:18', NULL, NULL, NULL),
(1832, 808, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:14:22', NULL, NULL, NULL),
(1833, 808, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:14:27', NULL, NULL, NULL),
(1834, 808, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:14:28', NULL, NULL, NULL),
(1835, 809, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-12 03:39:52', NULL, NULL, NULL),
(1836, 809, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 03:14:24', NULL, NULL, NULL),
(1837, 809, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:16:16', NULL, NULL, NULL),
(1842, 811, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:28', '2025-07-12 03:25:54', NULL, NULL, NULL),
(1843, 811, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:28', '2025-07-12 03:25:54', NULL, NULL, NULL),
(1844, 811, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:28', '2025-07-12 03:25:55', NULL, NULL, NULL),
(1845, 812, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-12 03:43:59', NULL, NULL, NULL),
(1846, 812, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 03:44:00', NULL, NULL, NULL),
(1847, 812, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-12 03:46:04', NULL, NULL, NULL),
(1848, 813, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-12 03:23:07', NULL, NULL, NULL),
(1849, 813, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:20:20', NULL, NULL, NULL),
(1850, 813, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:20:21', NULL, NULL, NULL),
(1851, 813, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:20:22', NULL, NULL, NULL),
(1852, 813, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:20:24', NULL, NULL, NULL),
(1853, 814, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 03:23:31', NULL, NULL, NULL),
(1854, 814, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 03:23:29', NULL, NULL, NULL),
(1855, 815, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:28', '2025-07-12 03:25:52', NULL, NULL, NULL),
(1856, 815, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:28', '2025-07-12 03:25:53', NULL, NULL, NULL),
(1857, 815, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:28', '2025-07-12 03:25:53', NULL, NULL, NULL),
(1858, 815, 'predkrm', 'Focaccia e olio', 1, 75.00, '', 'paid', 'cash', '2025-07-12 11:22:28', '2025-07-12 03:27:26', NULL, NULL, NULL),
(1859, 816, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:27:45', NULL, NULL, NULL),
(1860, 817, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 03:29:38', NULL, NULL, NULL),
(1861, 818, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:06', '2025-07-12 03:31:17', NULL, NULL, NULL),
(1862, 818, 'predkrm', 'Focaccia e olio', 1, 75.00, '', 'paid', 'card', '2025-07-12 11:22:06', '2025-07-12 03:26:26', NULL, NULL, NULL),
(1863, 818, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-12 11:22:06', '2025-07-12 04:11:39', NULL, NULL, NULL),
(1864, 818, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-12 11:22:06', '2025-07-12 04:11:42', NULL, NULL, NULL),
(1865, 819, 'spritz', 'Spritz Sarti', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 03:31:20', NULL, NULL, NULL),
(1866, 820, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-12 03:35:23', NULL, NULL, NULL),
(1867, 820, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:33:26', NULL, NULL, NULL),
(1868, 821, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:35:20', NULL, NULL, NULL),
(1869, 821, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:35:19', NULL, NULL, NULL),
(1870, 821, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', NULL, '2025-07-12 04:18:25', NULL, NULL, NULL),
(1871, 821, 'predkrm', 'Foccacia, olio e olive', 1, 125.00, '', 'paid', 'cash', NULL, '2025-07-12 03:45:04', NULL, NULL, NULL),
(1872, 821, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-12 04:54:52', NULL, NULL, NULL),
(1873, 821, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'cash', NULL, '2025-07-12 03:45:05', NULL, NULL, NULL),
(1874, 822, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:36:09', NULL, NULL, NULL),
(1875, 822, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:36:09', NULL, NULL, NULL),
(1876, 823, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 03:40:53', NULL, NULL, NULL),
(1877, 823, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 03:40:54', NULL, NULL, NULL),
(1878, 824, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 04:05:22', NULL, NULL, NULL),
(1879, 825, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:45:23', NULL, NULL, NULL),
(1880, 825, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:45:24', NULL, NULL, NULL),
(1881, 825, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:45:25', NULL, NULL, NULL),
(1882, 825, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-12 04:11:46', NULL, NULL, NULL),
(1883, 825, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 03:45:26', NULL, NULL, NULL),
(1884, 825, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:45:26', NULL, NULL, NULL),
(1885, 825, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:45:27', NULL, NULL, NULL),
(1886, 825, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 03:45:28', NULL, NULL, NULL),
(1887, 825, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 04:11:47', NULL, NULL, NULL),
(1888, 825, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 04:11:48', NULL, NULL, NULL),
(1889, 825, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 04:13:07', NULL, NULL, NULL),
(1890, 826, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-12 03:47:37', NULL, NULL, NULL),
(1891, 826, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 03:48:52', NULL, NULL, NULL),
(1892, 827, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-12 04:00:37', NULL, NULL, NULL),
(1893, 827, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 04:00:38', NULL, NULL, NULL),
(1894, 827, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:48:53', NULL, NULL, NULL),
(1895, 827, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:48:55', NULL, NULL, NULL),
(1896, 828, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:51:25', NULL, NULL, NULL),
(1897, 828, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 03:51:24', NULL, NULL, NULL),
(1898, 828, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', NULL, '2025-07-12 03:51:26', NULL, NULL, NULL),
(1899, 829, 'negroni', 'Negroni Tartufo', 1, 180.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 03:56:03', NULL, NULL, NULL),
(1900, 829, 'negroni', 'Negroni Tartufo', 1, 180.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 03:56:02', NULL, NULL, NULL),
(1901, 829, 'nealko', 'Voda perlivá', 1, 40.00, '', 'cancelled', 'cash', NULL, '2025-07-12 03:56:00', NULL, NULL, NULL),
(1902, 829, 'vino', 'Víno Ryzlink vlašský', 1, 220.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 03:56:01', NULL, NULL, NULL),
(1903, 829, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', '2025-07-12 11:21:46', '2025-07-12 05:36:52', NULL, NULL, NULL),
(1904, 829, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 04:18:35', NULL, NULL, NULL),
(1905, 830, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 04:18:38', NULL, NULL, NULL),
(1906, 831, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:06', '2025-07-12 03:58:03', NULL, NULL, NULL),
(1907, 832, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 04:00:20', NULL, NULL, NULL),
(1908, 832, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 04:00:21', NULL, NULL, NULL),
(1909, 832, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 04:00:22', NULL, NULL, NULL),
(1910, 832, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 04:10:54', NULL, NULL, NULL),
(1911, 832, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 05:36:53', NULL, NULL, NULL),
(1912, 832, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 05:36:53', NULL, NULL, NULL),
(1913, 832, 'predkrm', 'Mozzarella e pomodorini', 1, 145.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 04:10:09', NULL, NULL, NULL),
(1914, 832, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 05:36:55', NULL, NULL, NULL),
(1915, 833, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:01', '2025-07-12 03:56:08', NULL, NULL, NULL),
(1916, 834, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-12 04:22:59', NULL, NULL, NULL),
(1917, 835, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 04:06:49', NULL, NULL, NULL),
(1918, 835, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 04:06:49', NULL, NULL, NULL),
(1919, 835, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 04:06:48', NULL, NULL, NULL),
(1920, 835, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 04:24:52', NULL, NULL, NULL),
(1921, 835, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 04:27:30', NULL, NULL, NULL),
(1922, 836, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:04:29', NULL, NULL, NULL),
(1923, 837, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 04:13:11', NULL, NULL, NULL),
(1924, 837, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 04:04:31', NULL, NULL, NULL),
(1925, 838, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 04:06:47', NULL, NULL, NULL),
(1926, 838, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 05:36:47', NULL, NULL, NULL),
(1927, 838, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 05:36:48', NULL, NULL, NULL),
(1928, 838, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:21', '2025-07-12 04:06:47', NULL, NULL, NULL),
(1929, 839, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 04:09:05', NULL, NULL, NULL),
(1930, 839, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 04:09:05', NULL, NULL, NULL),
(1931, 839, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:29:25', NULL, NULL, NULL),
(1932, 840, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:11:59', NULL, NULL, NULL),
(1933, 841, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:09', '2025-07-12 04:12:00', NULL, NULL, NULL),
(1934, 841, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:09', '2025-07-12 04:12:01', NULL, NULL, NULL),
(1935, 842, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 04:13:38', NULL, NULL, NULL),
(1936, 843, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 04:17:51', NULL, NULL, NULL),
(1937, 843, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 04:17:51', NULL, NULL, NULL),
(1938, 843, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 04:17:50', NULL, NULL, NULL),
(1939, 843, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 05:36:48', NULL, NULL, NULL),
(1940, 844, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 05:36:50', NULL, NULL, NULL),
(1941, 845, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:21:46', '2025-07-12 05:36:51', NULL, NULL, NULL),
(1942, 846, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:21:13', NULL, NULL, NULL),
(1943, 846, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:21:12', NULL, NULL, NULL),
(1944, 846, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 04:21:09', NULL, NULL, NULL),
(1945, 846, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:21:08', NULL, NULL, NULL),
(1946, 846, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-12 05:17:10', NULL, NULL, NULL),
(1947, 847, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 04:23:27', NULL, NULL, NULL),
(1948, 847, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:23:27', NULL, NULL, NULL),
(1949, 848, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 05:36:56', NULL, NULL, NULL),
(1950, 848, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 04:26:06', NULL, NULL, NULL),
(1951, 849, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-12 11:21:46', '2025-07-12 04:26:38', NULL, NULL, NULL),
(1954, 851, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-12 04:52:52', NULL, NULL, NULL),
(1955, 851, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:32:22', NULL, NULL, NULL),
(1956, 851, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'cash', NULL, '2025-07-12 04:31:46', NULL, NULL, NULL),
(1957, 851, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:32:21', NULL, NULL, NULL),
(1958, 851, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:32:16', NULL, NULL, NULL),
(1959, 851, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:32:20', NULL, NULL, NULL),
(1960, 851, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 04:52:52', NULL, NULL, NULL),
(1961, 851, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 04:52:53', NULL, NULL, NULL),
(1962, 851, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:32:21', NULL, NULL, NULL),
(1963, 851, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 04:56:35', NULL, NULL, NULL),
(1964, 852, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-12 11:22:04', '2025-07-12 05:34:43', NULL, NULL, NULL),
(1965, 852, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-12 11:22:04', '2025-07-12 05:34:42', NULL, NULL, NULL),
(1966, 852, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'card', '2025-07-12 11:22:04', '2025-07-12 04:32:56', NULL, NULL, NULL),
(1967, 853, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 04:40:13', NULL, NULL, NULL),
(1968, 853, 'vino', 'Víno Tramín', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-12 04:40:13', NULL, NULL, NULL),
(1969, 853, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 05:02:41', NULL, NULL, NULL),
(1970, 853, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 05:04:41', NULL, NULL, NULL),
(1971, 853, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-12 05:05:59', NULL, NULL, NULL),
(1972, 853, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:40:14', NULL, NULL, NULL),
(1973, 853, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 05:06:00', NULL, NULL, NULL),
(1974, 853, 'koktejl', 'Martini Fiero & tonic', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 04:40:12', NULL, NULL, NULL),
(1975, 854, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-12 05:07:45', NULL, NULL, NULL),
(1976, 854, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:41:35', NULL, NULL, NULL),
(1977, 854, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:41:35', NULL, NULL, NULL),
(1978, 855, 'vino', 'Víno Frizzante bílé', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-12 04:41:57', NULL, NULL, NULL),
(1979, 856, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:44:01', NULL, NULL, NULL),
(1980, 856, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:44:02', NULL, NULL, NULL),
(1981, 856, 'vino', 'Víno Ryzlink vlašský', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-12 04:44:00', NULL, NULL, NULL),
(1982, 856, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 05:31:38', NULL, NULL, NULL),
(1983, 856, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 05:31:40', NULL, NULL, NULL),
(1984, 857, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 05:17:13', NULL, NULL, NULL),
(1985, 857, 'vino', 'Víno Merlot', 1, 240.00, '', 'paid', 'cash', NULL, '2025-07-12 04:52:24', NULL, NULL, NULL),
(1986, 857, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:52:22', NULL, NULL, NULL),
(1987, 857, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 04:52:22', NULL, NULL, NULL),
(1988, 857, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 04:52:21', NULL, NULL, NULL),
(1989, 857, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', NULL, '2025-07-12 05:02:38', NULL, NULL, NULL),
(1990, 858, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 05:36:56', NULL, NULL, NULL),
(1991, 858, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 05:36:57', NULL, NULL, NULL),
(1992, 858, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 05:00:39', NULL, NULL, NULL),
(1993, 858, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 05:00:40', NULL, NULL, NULL),
(1994, 859, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:06:04', NULL, NULL, NULL),
(1995, 859, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:05:57', NULL, NULL, NULL),
(1996, 859, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:05:57', NULL, NULL, NULL),
(1997, 859, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:05:58', NULL, NULL, NULL),
(1998, 859, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:05:59', NULL, NULL, NULL),
(1999, 859, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:05:57', NULL, NULL, NULL),
(2000, 859, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:06:00', NULL, NULL, NULL),
(2001, 859, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:29:10', NULL, NULL, NULL),
(2002, 859, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:29:09', NULL, NULL, NULL),
(2003, 859, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:36:44', NULL, NULL, NULL),
(2004, 859, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:36:45', NULL, NULL, NULL),
(2005, 859, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:36:45', NULL, NULL, NULL),
(2006, 860, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 05:07:39', NULL, NULL, NULL),
(2007, 860, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 05:07:38', NULL, NULL, NULL),
(2008, 860, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 05:36:43', NULL, NULL, NULL),
(2009, 860, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 05:36:42', NULL, NULL, NULL),
(2010, 861, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 05:40:09', NULL, NULL, NULL),
(2011, 862, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:25:04', NULL, NULL, NULL),
(2012, 863, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:09', '2025-07-12 05:18:26', NULL, NULL, NULL),
(2013, 863, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:09', '2025-07-12 05:18:25', NULL, NULL, NULL),
(2014, 863, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-12 11:22:09', '2025-07-12 05:50:10', NULL, NULL, NULL),
(2015, 863, 'predkrm', 'Foccacia, olio e olive', 1, 125.00, '', 'paid', 'cash', '2025-07-12 11:22:09', '2025-07-12 05:36:31', NULL, NULL, NULL),
(2016, 864, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', NULL, '2025-07-12 05:48:27', NULL, NULL, NULL),
(2017, 864, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', NULL, '2025-07-12 05:20:14', NULL, NULL, NULL),
(2018, 864, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 05:20:15', NULL, NULL, NULL),
(2019, 865, 'vino', 'Víno Merlot', 1, 240.00, '', 'paid', 'cash', NULL, '2025-07-12 05:20:57', NULL, NULL, NULL),
(2023, 867, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:27:23', NULL, NULL, NULL),
(2024, 868, 'spritz', 'Spritz Sarti', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 05:29:33', NULL, NULL, NULL),
(2025, 869, 'vino', 'Víno Frizzante bílé', 1, 220.00, '', 'paid', 'cash', '2025-07-12 11:21:46', '2025-07-12 05:31:09', NULL, NULL, NULL),
(2026, 870, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:31:57', NULL, NULL, NULL),
(2027, 871, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 05:37:23', NULL, NULL, NULL),
(2028, 872, 'vino', 'Víno Ryzlink vlašský', 1, 220.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 05:38:02', NULL, NULL, NULL),
(2029, 872, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 05:47:10', NULL, NULL, NULL),
(2030, 873, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 05:43:09', NULL, NULL, NULL),
(2031, 873, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 05:57:35', NULL, NULL, NULL),
(2032, 873, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 05:57:36', NULL, NULL, NULL),
(2033, 873, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 05:43:11', NULL, NULL, NULL),
(2034, 873, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 05:43:10', NULL, NULL, NULL),
(2035, 873, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 06:01:40', NULL, NULL, NULL),
(2036, 873, 'negroni', 'Negroni Tartufo', 1, 180.00, '', 'paid', 'cash', NULL, '2025-07-12 05:43:10', NULL, NULL, NULL),
(2037, 873, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', NULL, '2025-07-12 05:58:25', NULL, NULL, NULL),
(2038, 873, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 05:43:11', NULL, NULL, NULL),
(2039, 874, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 05:44:38', NULL, NULL, NULL),
(2040, 874, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:22:14', '2025-07-12 05:44:37', NULL, NULL, NULL),
(2041, 875, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 05:47:11', NULL, NULL, NULL),
(2042, 876, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 05:48:02', NULL, NULL, NULL),
(2043, 876, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 05:48:02', NULL, NULL, NULL),
(2044, 877, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 06:05:27', NULL, NULL, NULL),
(2045, 877, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 06:14:29', NULL, NULL, NULL),
(2046, 877, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 06:06:58', NULL, NULL, NULL),
(2047, 877, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 06:09:42', NULL, NULL, NULL),
(2048, 878, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'cash', NULL, '2025-07-12 06:04:19', NULL, NULL, NULL),
(2049, 879, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-12 11:22:19', '2025-07-12 06:14:33', NULL, NULL, NULL),
(2050, 880, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 05:50:06', NULL, NULL, NULL),
(2051, 881, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 05:54:39', NULL, NULL, NULL),
(2052, 881, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 05:54:39', NULL, NULL, NULL),
(2053, 881, 'digestiv', 'Limoncello', 1, 90.00, '', 'paid', 'cash', NULL, '2025-07-12 05:54:40', NULL, NULL, NULL),
(2054, 881, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 06:18:18', NULL, NULL, NULL),
(2055, 881, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', NULL, '2025-07-12 06:18:19', NULL, NULL, NULL),
(2056, 882, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:09', '2025-07-12 05:55:23', NULL, NULL, NULL),
(2057, 883, 'vino', 'Víno Rulandské šedé', 1, 220.00, '', 'paid', 'cash', '2025-07-12 11:21:46', '2025-07-12 05:59:08', NULL, NULL, NULL),
(2058, 883, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 05:59:08', NULL, NULL, NULL),
(2059, 884, 'predkrm', 'Mozzarella e pomodorini', 1, 145.00, '', 'paid', 'cash', NULL, '2025-07-12 06:09:55', NULL, NULL, NULL),
(2060, 885, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 06:11:51', NULL, NULL, NULL),
(2061, 885, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 06:11:52', NULL, NULL, NULL),
(2062, 886, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', '2025-07-12 11:21:46', '2025-07-12 06:14:22', NULL, NULL, NULL),
(2063, 887, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-12 11:21:58', '2025-07-12 06:15:30', NULL, NULL, NULL),
(2064, 888, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 06:15:33', NULL, NULL, NULL),
(2065, 888, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 06:15:32', NULL, NULL, NULL),
(2066, 888, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 08:08:10', NULL, NULL, NULL),
(2067, 888, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 08:08:11', NULL, NULL, NULL),
(2068, 889, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 06:17:48', NULL, NULL, NULL),
(2069, 890, 'vino', 'Víno Merlot', 1, 240.00, '', 'paid', 'cash', NULL, '2025-07-12 06:22:49', NULL, NULL, NULL),
(2070, 890, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 06:22:48', NULL, NULL, NULL),
(2071, 890, 'koktejl', 'Red Velvet gin Garage 22 a tonic', 1, 170.00, '', 'paid', 'cash', NULL, '2025-07-12 06:22:47', NULL, NULL, NULL),
(2072, 891, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 06:18:53', NULL, NULL, NULL),
(2073, 892, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', NULL, '2025-07-12 06:24:11', NULL, NULL, NULL),
(2074, 893, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 06:29:39', NULL, NULL, NULL),
(2075, 893, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'card', '2025-07-12 11:21:50', '2025-07-12 06:29:39', NULL, NULL, NULL),
(2076, 894, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 06:32:31', NULL, NULL, NULL),
(2077, 894, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-12 11:22:26', '2025-07-12 06:32:32', NULL, NULL, NULL),
(2078, 895, 'digestiv', 'Limoncello', 1, 90.00, '', 'paid', 'cash', NULL, '2025-07-12 06:34:52', NULL, NULL, NULL),
(2079, 895, 'digestiv', 'Limoncello', 1, 90.00, '', 'paid', 'cash', NULL, '2025-07-12 06:34:51', NULL, NULL, NULL),
(2080, 896, 'vino', 'Sekt Pastorek', 1, 390.00, '', 'paid', 'cash', NULL, '2025-07-12 06:36:52', NULL, NULL, NULL),
(2081, 897, 'vino', 'Víno Merlot', 1, 240.00, '', 'paid', 'cash', NULL, '2025-07-12 06:48:24', NULL, NULL, NULL),
(2082, 898, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 06:53:36', NULL, NULL, NULL),
(2083, 898, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 06:53:37', NULL, NULL, NULL),
(2084, 899, 'vino', 'Víno Frizzante růžové', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-12 07:03:41', NULL, NULL, NULL),
(2085, 899, 'vino', 'Víno Frizzante bílé', 1, 220.00, '', 'paid', 'cash', NULL, '2025-07-12 07:05:45', NULL, NULL, NULL),
(2086, 899, 'vino', 'Víno Hibernal', 1, 240.00, '', 'paid', 'cash', NULL, '2025-07-12 07:05:44', NULL, NULL, NULL),
(2087, 899, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 07:05:44', NULL, NULL, NULL),
(2088, 899, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 07:05:34', NULL, NULL, NULL),
(2089, 900, 'digestiv', 'Amaro', 1, 90.00, '', 'paid', 'cash', NULL, '2025-07-12 07:10:07', NULL, NULL, NULL),
(2090, 900, 'digestiv', 'Amaro', 1, 90.00, '', 'paid', 'cash', NULL, '2025-07-12 07:10:06', NULL, NULL, NULL),
(2091, 900, 'digestiv', 'Amaro', 1, 90.00, '', 'paid', 'cash', NULL, '2025-07-12 07:10:06', NULL, NULL, NULL),
(2092, 900, 'digestiv', 'Amaro', 1, 90.00, '', 'paid', 'cash', NULL, '2025-07-12 07:10:05', NULL, NULL, NULL),
(2093, 900, 'digestiv', 'Amaro', 1, 90.00, '', 'paid', 'cash', NULL, '2025-07-12 07:10:04', NULL, NULL, NULL),
(2094, 901, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 07:33:12', NULL, NULL, NULL),
(2095, 902, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 07:33:11', NULL, NULL, NULL),
(2096, 902, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 07:33:12', NULL, NULL, NULL),
(2097, 903, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 08:08:11', NULL, NULL, NULL),
(2098, 904, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 07:53:49', NULL, NULL, NULL),
(2099, 905, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 07:55:04', NULL, NULL, NULL),
(2100, 905, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', NULL, '2025-07-12 07:55:05', NULL, NULL, NULL),
(2101, 906, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-12 11:22:30', '2025-07-12 08:16:26', NULL, NULL, NULL),
(2260, 955, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 13:54:04', '2025-07-13 13:21:40', NULL, NULL, NULL),
(2261, 955, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 13:54:04', '2025-07-13 13:21:40', NULL, NULL, NULL),
(2262, 955, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'card', '2025-07-13 13:54:04', '2025-07-13 13:21:41', NULL, NULL, NULL),
(2263, 955, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'card', '2025-07-13 13:54:04', '2025-07-13 13:21:34', NULL, NULL, NULL),
(2264, 955, 'predkrm', 'Mozzarella e pomodorini', 1, 145.00, '', 'paid', 'card', '2025-07-13 13:54:04', '2025-07-13 13:21:30', NULL, NULL, NULL),
(2269, 957, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 13:54:04', '2025-07-13 13:26:49', NULL, NULL, NULL),
(2270, 958, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:15:32', '2025-07-13 13:30:22', NULL, NULL, NULL),
(2271, 958, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:15:32', '2025-07-13 13:30:22', NULL, NULL, NULL),
(2272, 958, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:15:32', '2025-07-13 13:30:21', NULL, NULL, NULL),
(2273, 958, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 14:16:10', '2025-07-13 13:30:20', NULL, NULL, NULL),
(2274, 958, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:16:10', '2025-07-13 13:30:20', NULL, NULL, NULL),
(2275, 959, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', '2025-07-13 14:16:10', '2025-07-13 13:35:46', NULL, NULL, NULL),
(2276, 960, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 13:54:04', '2025-07-13 13:40:38', NULL, NULL, NULL),
(2277, 961, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'card', '2025-07-13 13:54:41', '2025-07-13 13:35:27', NULL, NULL, NULL),
(2278, 961, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'card', '2025-07-13 13:54:41', '2025-07-13 13:35:26', NULL, NULL, NULL),
(2279, 962, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:20:17', '2025-07-13 13:39:22', NULL, NULL, NULL),
(2280, 962, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'card', '2025-07-13 15:20:17', '2025-07-13 13:39:23', NULL, NULL, NULL),
(2281, 962, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'card', '2025-07-13 15:20:17', '2025-07-13 13:39:24', NULL, NULL, NULL),
(2282, 962, 'vino', 'Sekt Pastorek', 1, 390.00, '', 'paid', 'card', '2025-07-13 15:20:17', '2025-07-13 13:39:25', NULL, NULL, NULL),
(2283, 963, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 14:16:10', '2025-07-13 13:37:07', NULL, NULL, NULL),
(2284, 964, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:58:40', '2025-07-13 13:43:51', NULL, NULL, NULL),
(2285, 964, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:58:40', '2025-07-13 13:43:51', NULL, NULL, NULL),
(2286, 964, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-13 14:58:40', '2025-07-13 13:44:52', NULL, NULL, NULL),
(2287, 965, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 13:54:04', '2025-07-13 13:43:50', NULL, NULL, NULL),
(2288, 966, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'card', '2025-07-13 15:20:17', '2025-07-13 13:54:01', NULL, NULL, NULL),
(2289, 966, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'card', '2025-07-13 15:20:17', '2025-07-13 13:50:03', NULL, NULL, NULL),
(2290, 967, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', '2025-07-13 15:53:25', '2025-07-13 13:51:41', NULL, NULL, NULL),
(2291, 967, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', '2025-07-13 15:53:25', '2025-07-13 13:51:44', NULL, NULL, NULL),
(2292, 967, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 15:53:25', '2025-07-13 13:51:43', NULL, NULL, NULL),
(2293, 968, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-13 15:53:25', '2025-07-13 13:57:17', NULL, NULL, NULL),
(2294, 969, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:16:10', '2025-07-13 13:56:35', NULL, NULL, NULL),
(2295, 970, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'card', '2025-07-13 15:20:17', '2025-07-13 13:57:19', NULL, NULL, NULL),
(2296, 971, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 15:53:25', '2025-07-13 13:58:15', NULL, NULL, NULL),
(2297, 972, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 15:16:51', '2025-07-13 14:01:26', NULL, NULL, NULL),
(2298, 972, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 15:16:51', '2025-07-13 14:01:27', NULL, NULL, NULL),
(2299, 973, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-13 14:47:19', '2025-07-13 14:06:16', NULL, NULL, NULL),
(2300, 973, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:47:19', '2025-07-13 14:03:13', NULL, NULL, NULL),
(2301, 973, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 14:47:28', '2025-07-13 14:03:14', NULL, NULL, NULL),
(2302, 974, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-13 14:33:26', '2025-07-13 14:12:55', NULL, NULL, NULL),
(2303, 974, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:33:26', '2025-07-13 14:06:35', NULL, NULL, NULL),
(2304, 974, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:33:26', '2025-07-13 14:06:36', NULL, NULL, NULL),
(2305, 974, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:33:26', '2025-07-13 14:06:36', NULL, NULL, NULL),
(2306, 974, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'cash', '2025-07-13 14:33:26', '2025-07-13 14:12:57', NULL, NULL, NULL),
(2307, 974, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', '2025-07-13 14:33:26', '2025-07-13 14:15:07', NULL, NULL, NULL),
(2308, 975, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', '2025-07-13 14:47:59', '2025-07-13 14:19:03', NULL, NULL, NULL),
(2309, 975, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-13 14:47:59', '2025-07-13 14:17:12', NULL, NULL, NULL),
(2310, 975, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:47:59', '2025-07-13 14:09:01', NULL, NULL, NULL),
(2311, 975, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:47:59', '2025-07-13 14:09:01', NULL, NULL, NULL),
(2312, 976, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'cash', '2025-07-13 14:56:36', '2025-07-13 14:11:56', NULL, NULL, NULL),
(2313, 976, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-13 14:56:36', '2025-07-13 14:25:25', NULL, NULL, NULL),
(2314, 976, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'card', '2025-07-13 14:56:52', '2025-07-13 14:25:26', NULL, NULL, NULL),
(2315, 976, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-13 14:56:52', '2025-07-13 14:31:16', NULL, NULL, NULL),
(2316, 976, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 14:56:36', '2025-07-13 14:11:56', NULL, NULL, NULL),
(2317, 976, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 14:56:52', '2025-07-13 14:11:57', NULL, NULL, NULL),
(2318, 976, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 14:56:52', '2025-07-13 14:11:57', NULL, NULL, NULL),
(2319, 976, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-13 14:56:36', '2025-07-13 14:28:26', NULL, NULL, NULL),
(2320, 977, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 14:47:28', '2025-07-13 14:20:43', NULL, NULL, NULL),
(2321, 978, 'pizza', 'Burrata e crudo', 1, 350.00, '', 'paid', 'card', '2025-07-13 15:20:17', '2025-07-13 14:35:23', NULL, NULL, NULL),
(2322, 978, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'card', '2025-07-13 15:20:17', '2025-07-13 14:19:58', NULL, NULL, NULL),
(2323, 979, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-13 16:57:26', '2025-07-13 14:36:55', NULL, NULL, NULL),
(2324, 979, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:57:26', '2025-07-13 14:25:06', NULL, NULL, NULL),
(2325, 979, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-13 16:57:26', '2025-07-13 14:25:07', NULL, NULL, NULL),
(2326, 979, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:57:26', '2025-07-13 14:25:07', NULL, NULL, NULL),
(2327, 980, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-13 15:07:42', '2025-07-13 14:41:21', NULL, NULL, NULL);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_name`, `quantity`, `unit_price`, `note`, `status`, `payment_method`, `paid_at`, `prepared_at`, `delivered_at`, `problem_note`, `parent_id`) VALUES
(2328, 980, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 15:07:42', '2025-07-13 14:26:49', NULL, NULL, NULL),
(2329, 980, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'cash', '2025-07-13 15:07:42', '2025-07-13 14:26:50', NULL, NULL, NULL),
(2330, 980, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-13 15:07:42', '2025-07-13 14:41:22', NULL, NULL, NULL),
(2331, 981, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-13 15:16:51', '2025-07-13 14:28:38', NULL, NULL, NULL),
(2332, 981, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 15:16:51', '2025-07-13 14:28:39', NULL, NULL, NULL),
(2333, 982, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 15:53:25', '2025-07-13 14:30:11', NULL, NULL, NULL),
(2334, 982, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', '2025-07-13 15:53:25', '2025-07-13 14:30:13', NULL, NULL, NULL),
(2335, 982, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', '2025-07-13 15:53:25', '2025-07-13 14:30:14', NULL, NULL, NULL),
(2336, 983, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:14:22', '2025-07-13 14:32:11', NULL, NULL, NULL),
(2337, 983, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:14:22', '2025-07-13 14:32:10', NULL, NULL, NULL),
(2338, 983, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'card', '2025-07-13 15:14:22', '2025-07-13 14:32:10', NULL, NULL, NULL),
(2339, 983, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-13 15:14:22', '2025-07-13 14:48:20', NULL, NULL, NULL),
(2340, 984, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', '2025-07-13 14:47:59', '2025-07-13 14:35:42', NULL, NULL, NULL),
(2341, 985, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-13 15:10:31', '2025-07-13 14:45:54', NULL, NULL, NULL),
(2342, 985, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 15:10:31', '2025-07-13 14:45:55', NULL, NULL, NULL),
(2343, 985, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'card', '2025-07-13 15:10:31', '2025-07-13 14:35:13', NULL, NULL, NULL),
(2344, 985, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:10:31', '2025-07-13 14:35:16', NULL, NULL, NULL),
(2345, 985, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:10:31', '2025-07-13 14:35:19', NULL, NULL, NULL),
(2346, 986, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', '2025-07-13 15:34:09', '2025-07-13 14:53:21', NULL, NULL, NULL),
(2347, 986, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 15:34:09', '2025-07-13 14:37:28', NULL, NULL, NULL),
(2348, 986, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 15:34:09', '2025-07-13 14:37:29', NULL, NULL, NULL),
(2349, 986, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-13 15:34:09', '2025-07-13 14:53:21', NULL, NULL, NULL),
(2350, 987, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'card', '2025-07-13 15:14:22', '2025-07-13 14:40:19', NULL, NULL, NULL),
(2351, 988, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:57:26', '2025-07-13 14:40:18', NULL, NULL, NULL),
(2352, 989, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'card', '2025-07-13 15:56:31', '2025-07-13 14:51:22', NULL, NULL, NULL),
(2353, 990, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:56:31', '2025-07-13 14:49:20', NULL, NULL, NULL),
(2354, 991, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'paid', 'card', '2025-07-13 15:35:32', '2025-07-13 14:56:23', NULL, NULL, NULL),
(2355, 991, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-13 15:35:32', '2025-07-13 14:58:52', NULL, NULL, NULL),
(2356, 991, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:35:32', '2025-07-13 14:56:25', NULL, NULL, NULL),
(2357, 991, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:35:32', '2025-07-13 14:56:25', NULL, NULL, NULL),
(2358, 991, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:35:32', '2025-07-13 14:56:26', NULL, NULL, NULL),
(2359, 991, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'card', '2025-07-13 15:35:32', '2025-07-13 14:56:28', NULL, NULL, NULL),
(2360, 991, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:35:32', '2025-07-13 14:56:29', NULL, NULL, NULL),
(2361, 992, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'card', '2025-07-13 15:56:31', '2025-07-13 15:02:09', NULL, NULL, NULL),
(2362, 992, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'card', '2025-07-13 15:56:31', '2025-07-13 15:07:48', NULL, NULL, NULL),
(2363, 992, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 15:56:31', '2025-07-13 15:07:49', NULL, NULL, NULL),
(2364, 992, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'card', '2025-07-13 15:56:31', '2025-07-13 15:07:21', NULL, NULL, NULL),
(2365, 993, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 15:02:59', NULL, NULL, NULL),
(2366, 994, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:51:03', '2025-07-13 15:04:22', NULL, NULL, NULL),
(2367, 994, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:51:03', '2025-07-13 15:04:23', NULL, NULL, NULL),
(2368, 995, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-13 15:37:28', '2025-07-13 15:26:15', NULL, NULL, NULL),
(2369, 995, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 15:37:28', '2025-07-13 15:26:16', NULL, NULL, NULL),
(2370, 995, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'card', '2025-07-13 15:37:28', '2025-07-13 15:13:37', NULL, NULL, NULL),
(2371, 995, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:37:28', '2025-07-13 15:09:58', NULL, NULL, NULL),
(2372, 995, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'card', '2025-07-13 15:37:28', '2025-07-13 15:08:50', NULL, NULL, NULL),
(2373, 995, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:37:28', '2025-07-13 15:08:49', NULL, NULL, NULL),
(2374, 995, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:37:28', '2025-07-13 15:08:49', NULL, NULL, NULL),
(2375, 995, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'card', '2025-07-13 15:37:28', '2025-07-13 15:08:48', NULL, NULL, NULL),
(2376, 996, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', '2025-07-13 16:12:55', '2025-07-13 15:13:20', NULL, NULL, NULL),
(2377, 996, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:12:55', '2025-07-13 15:13:21', NULL, NULL, NULL),
(2378, 997, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 15:34:09', '2025-07-13 15:15:28', NULL, NULL, NULL),
(2379, 998, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:38:24', '2025-07-13 15:17:02', NULL, NULL, NULL),
(2380, 998, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:38:24', '2025-07-13 15:17:02', NULL, NULL, NULL),
(2381, 998, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:38:24', '2025-07-13 15:17:03', NULL, NULL, NULL),
(2382, 998, 'spritz', 'Spritz Sarti', 1, 130.00, '', 'paid', 'card', '2025-07-13 15:38:24', '2025-07-13 15:17:04', NULL, NULL, NULL),
(2383, 999, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-13 15:51:03', '2025-07-13 15:20:27', NULL, NULL, NULL),
(2384, 1000, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 15:53:25', '2025-07-13 15:18:00', NULL, NULL, NULL),
(2385, 1000, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', '2025-07-13 15:53:25', '2025-07-13 15:18:01', NULL, NULL, NULL),
(2386, 1000, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', '2025-07-13 15:53:25', '2025-07-13 15:18:01', NULL, NULL, NULL),
(2387, 1001, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:56:31', '2025-07-13 15:19:26', NULL, NULL, NULL),
(2388, 1002, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'card', '2025-07-13 15:56:31', '2025-07-13 15:20:44', NULL, NULL, NULL),
(2389, 1003, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', '2025-07-13 16:57:26', '2025-07-13 15:35:57', NULL, NULL, NULL),
(2390, 1004, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:50:39', '2025-07-13 15:26:24', NULL, NULL, NULL),
(2391, 1005, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:12:55', '2025-07-13 15:26:25', NULL, NULL, NULL),
(2392, 1006, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:37:28', '2025-07-13 15:26:26', NULL, NULL, NULL),
(2393, 1006, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:37:28', '2025-07-13 15:26:27', NULL, NULL, NULL),
(2394, 1007, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:25:13', '2025-07-13 15:28:56', NULL, NULL, NULL),
(2395, 1007, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:25:13', '2025-07-13 15:28:56', NULL, NULL, NULL),
(2396, 1007, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'card', '2025-07-13 16:25:13', '2025-07-13 15:30:36', NULL, NULL, NULL),
(2397, 1007, 'koktejl', 'Bellini', 1, 130.00, '', 'paid', 'card', '2025-07-13 16:25:13', '2025-07-13 15:28:57', NULL, NULL, NULL),
(2398, 1008, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:02:51', '2025-07-13 15:30:57', NULL, NULL, NULL),
(2399, 1008, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:02:51', '2025-07-13 15:30:57', NULL, NULL, NULL),
(2400, 1008, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:02:51', '2025-07-13 15:30:58', NULL, NULL, NULL),
(2401, 1008, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:02:51', '2025-07-13 15:30:58', NULL, NULL, NULL),
(2402, 1008, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'card', '2025-07-13 17:02:51', '2025-07-13 15:34:41', NULL, NULL, NULL),
(2403, 1008, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-13 17:49:27', '2025-07-13 15:37:54', NULL, NULL, NULL),
(2404, 1008, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-13 17:32:52', '2025-07-13 15:34:43', NULL, NULL, NULL),
(2405, 1008, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'card', '2025-07-13 17:02:51', '2025-07-13 15:39:57', NULL, NULL, NULL),
(2406, 1008, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 17:02:51', '2025-07-13 16:42:53', NULL, NULL, NULL),
(2407, 1009, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:37:28', '2025-07-13 15:32:09', NULL, NULL, NULL),
(2408, 1010, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 15:32:10', NULL, NULL, NULL),
(2409, 1011, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:57:26', '2025-07-13 15:34:10', NULL, NULL, NULL),
(2410, 1012, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:24:14', '2025-07-13 15:36:08', NULL, NULL, NULL),
(2411, 1012, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:24:14', '2025-07-13 15:36:08', NULL, NULL, NULL),
(2412, 1012, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'cash', '2025-07-13 16:24:14', '2025-07-13 15:42:40', NULL, NULL, NULL),
(2413, 1012, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-13 16:24:14', '2025-07-13 15:45:01', NULL, NULL, NULL),
(2414, 1012, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 16:24:14', '2025-07-13 15:36:09', NULL, NULL, NULL),
(2415, 1012, 'vino', 'Víno Frizzante růžové', 1, 220.00, '', 'paid', 'cash', '2025-07-13 16:24:14', '2025-07-13 15:36:09', NULL, NULL, NULL),
(2416, 1013, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:37:12', '2025-07-13 15:40:27', NULL, NULL, NULL),
(2417, 1013, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:37:12', '2025-07-13 15:40:28', NULL, NULL, NULL),
(2418, 1013, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:42:41', '2025-07-13 15:40:29', NULL, NULL, NULL),
(2419, 1013, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:42:41', '2025-07-13 15:40:29', NULL, NULL, NULL),
(2420, 1013, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 16:37:12', '2025-07-13 15:47:08', NULL, NULL, NULL),
(2421, 1013, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 16:42:41', '2025-07-13 15:49:55', NULL, NULL, NULL),
(2422, 1013, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-13 16:37:12', '2025-07-13 15:52:06', NULL, NULL, NULL),
(2423, 1013, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'card', '2025-07-13 16:42:41', '2025-07-13 15:52:06', NULL, NULL, NULL),
(2424, 1014, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-13 15:56:48', '2025-07-13 15:55:59', NULL, NULL, NULL),
(2425, 1014, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:56:48', '2025-07-13 15:41:29', NULL, NULL, NULL),
(2426, 1014, 'nealko', 'Coca-Cola', 1, 50.00, '', 'paid', 'card', '2025-07-13 15:56:48', '2025-07-13 15:41:28', NULL, NULL, NULL),
(2427, 1015, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:32:52', '2025-07-13 15:44:27', NULL, NULL, NULL),
(2428, 1015, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:32:52', '2025-07-13 15:44:28', NULL, NULL, NULL),
(2429, 1015, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-13 17:32:52', '2025-07-13 15:59:09', NULL, NULL, NULL),
(2430, 1015, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-13 17:49:27', '2025-07-13 15:59:10', NULL, NULL, NULL),
(2431, 1015, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', '2025-07-13 17:32:52', '2025-07-13 15:44:27', NULL, NULL, NULL),
(2432, 1016, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-13 17:33:20', '2025-07-13 16:02:19', NULL, NULL, NULL),
(2433, 1016, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:32:52', '2025-07-13 15:44:26', NULL, NULL, NULL),
(2434, 1016, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'cash', '2025-07-13 17:32:52', '2025-07-13 15:49:11', NULL, NULL, NULL),
(2435, 1017, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 15:47:07', NULL, NULL, NULL),
(2436, 1017, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 15:47:07', NULL, NULL, NULL),
(2437, 1017, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 15:47:08', NULL, NULL, NULL),
(2438, 1017, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 15:47:06', NULL, NULL, NULL),
(2439, 1017, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 15:47:06', NULL, NULL, NULL),
(2440, 1017, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 16:06:38', NULL, NULL, NULL),
(2441, 1017, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 16:06:39', NULL, NULL, NULL),
(2442, 1018, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:09:49', NULL, NULL, NULL),
(2443, 1019, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', '2025-07-13 16:41:44', '2025-07-13 15:50:19', NULL, NULL, NULL),
(2444, 1019, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', '2025-07-13 16:41:44', '2025-07-13 15:50:20', NULL, NULL, NULL),
(2445, 1019, 'predkrm', 'Foccacia, olio e olive', 1, 125.00, '', 'paid', 'cash', '2025-07-13 16:41:44', '2025-07-13 15:45:58', NULL, NULL, NULL),
(2446, 1019, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', '2025-07-13 16:41:44', '2025-07-13 16:08:17', NULL, NULL, NULL),
(2447, 1019, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-13 16:41:44', '2025-07-13 16:14:51', NULL, NULL, NULL),
(2448, 1020, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 15:50:22', NULL, NULL, NULL),
(2449, 1021, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:25:13', '2025-07-13 15:50:26', NULL, NULL, NULL),
(2450, 1021, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:25:13', '2025-07-13 15:50:26', NULL, NULL, NULL),
(2451, 1022, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-13 16:57:26', '2025-07-13 15:52:40', NULL, NULL, NULL),
(2452, 1023, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:32:52', '2025-07-13 15:54:08', NULL, NULL, NULL),
(2453, 1023, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:33:20', '2025-07-13 15:54:09', NULL, NULL, NULL),
(2454, 1023, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:02:51', '2025-07-13 15:54:07', NULL, NULL, NULL),
(2455, 1023, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:49:27', '2025-07-13 15:54:08', NULL, NULL, NULL),
(2456, 1024, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-13 16:53:08', '2025-07-13 16:17:32', NULL, NULL, NULL),
(2457, 1024, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'cash', '2025-07-13 16:53:08', '2025-07-13 15:55:41', NULL, NULL, NULL),
(2458, 1024, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:53:08', '2025-07-13 15:55:41', NULL, NULL, NULL),
(2459, 1025, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:17:02', '2025-07-13 15:57:55', NULL, NULL, NULL),
(2460, 1025, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:16:40', '2025-07-13 15:57:56', NULL, NULL, NULL),
(2461, 1025, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-13 17:16:40', '2025-07-13 15:57:55', NULL, NULL, NULL),
(2462, 1026, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'card', '2025-07-13 16:25:13', '2025-07-13 15:58:58', NULL, NULL, NULL),
(2463, 1027, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'cash', '2025-07-13 16:48:10', '2025-07-13 16:25:36', NULL, NULL, NULL),
(2464, 1027, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', '2025-07-13 16:48:10', '2025-07-13 16:01:19', NULL, NULL, NULL),
(2465, 1027, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', '2025-07-13 16:48:10', '2025-07-13 16:01:19', NULL, NULL, NULL),
(2466, 1027, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-13 16:48:10', '2025-07-13 16:25:37', NULL, NULL, NULL),
(2467, 1027, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:48:10', '2025-07-13 16:01:20', NULL, NULL, NULL),
(2468, 1028, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:04:36', NULL, NULL, NULL),
(2469, 1028, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:04:34', NULL, NULL, NULL),
(2470, 1028, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:30:59', NULL, NULL, NULL),
(2471, 1029, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 18:24:14', '2025-07-13 16:07:45', NULL, NULL, NULL),
(2472, 1030, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-13 18:30:42', '2025-07-13 16:27:21', NULL, NULL, NULL),
(2473, 1030, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:30:42', '2025-07-13 16:09:44', NULL, NULL, NULL),
(2474, 1030, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'card', '2025-07-13 18:30:42', '2025-07-13 16:09:42', NULL, NULL, NULL),
(2475, 1030, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:30:42', '2025-07-13 16:09:43', NULL, NULL, NULL),
(2476, 1031, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:04:32', NULL, NULL, NULL),
(2477, 1031, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:04:33', NULL, NULL, NULL),
(2478, 1032, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'card', '2025-07-13 17:17:02', '2025-07-13 16:03:19', NULL, NULL, NULL),
(2479, 1032, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-13 17:17:02', '2025-07-13 16:29:17', NULL, NULL, NULL),
(2480, 1033, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-13 16:57:11', '2025-07-13 16:13:42', NULL, NULL, NULL),
(2481, 1033, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:57:11', '2025-07-13 16:13:43', NULL, NULL, NULL),
(2482, 1033, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:58:25', '2025-07-13 16:13:43', NULL, NULL, NULL),
(2483, 1033, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:58:25', '2025-07-13 16:13:44', NULL, NULL, NULL),
(2484, 1033, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:53:08', '2025-07-13 16:13:44', NULL, NULL, NULL),
(2485, 1034, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-13 17:01:07', '2025-07-13 16:15:34', NULL, NULL, NULL),
(2486, 1034, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 17:01:07', '2025-07-13 16:35:07', NULL, NULL, NULL),
(2487, 1034, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 17:01:07', '2025-07-13 16:35:08', NULL, NULL, NULL),
(2488, 1034, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:01:07', '2025-07-13 16:15:34', NULL, NULL, NULL),
(2489, 1035, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-13 16:59:19', '2025-07-13 16:18:36', NULL, NULL, NULL),
(2490, 1035, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', '2025-07-13 16:53:08', '2025-07-13 16:13:08', NULL, NULL, NULL),
(2491, 1036, 'predkrm', 'Focaccia e olio', 1, 75.00, '', 'paid', 'cash', '2025-07-13 17:21:47', '2025-07-13 16:15:35', NULL, NULL, NULL),
(2492, 1036, 'predkrm', 'Mozzarella e pomodorini', 1, 145.00, '', 'paid', 'cash', '2025-07-13 17:21:47', '2025-07-13 16:15:37', NULL, NULL, NULL),
(2493, 1036, 'vino', 'Víno Frizzante bílé', 1, 220.00, '', 'paid', 'cash', '2025-07-13 17:21:47', '2025-07-13 16:15:57', NULL, NULL, NULL),
(2494, 1036, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 17:21:47', '2025-07-13 16:15:58', NULL, NULL, NULL),
(2495, 1037, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:07:36', NULL, NULL, NULL),
(2496, 1038, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:53:08', '2025-07-13 16:13:42', NULL, NULL, NULL),
(2497, 1039, 'vino', 'Víno 2 dcl', 1, 100.00, '', 'paid', 'cash', '2025-07-13 16:41:44', '2025-07-13 16:17:52', NULL, NULL, NULL),
(2498, 1039, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:41:44', '2025-07-13 16:17:53', NULL, NULL, NULL),
(2499, 1040, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:33:20', '2025-07-13 16:19:16', NULL, NULL, NULL),
(2500, 1040, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:33:20', '2025-07-13 16:19:17', NULL, NULL, NULL),
(2501, 1041, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:05:07', '2025-07-13 16:23:19', NULL, NULL, NULL),
(2502, 1041, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:05:07', '2025-07-13 16:23:20', NULL, NULL, NULL),
(2503, 1041, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:05:07', '2025-07-13 16:23:23', NULL, NULL, NULL),
(2504, 1042, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:13:07', '2025-07-13 16:26:14', NULL, NULL, NULL),
(2505, 1042, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:13:41', '2025-07-13 16:26:14', NULL, NULL, NULL),
(2506, 1042, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-13 17:13:07', '2025-07-13 16:26:13', NULL, NULL, NULL),
(2507, 1042, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'cash', '2025-07-13 17:13:41', '2025-07-13 16:26:13', NULL, NULL, NULL),
(2508, 1042, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 17:13:07', '2025-07-13 16:26:14', NULL, NULL, NULL),
(2509, 1042, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-13 17:13:07', '2025-07-13 16:42:31', NULL, NULL, NULL),
(2510, 1042, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'cash', '2025-07-13 17:13:41', '2025-07-13 16:42:31', NULL, NULL, NULL),
(2511, 1043, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:49:27', '2025-07-13 16:19:15', NULL, NULL, NULL),
(2512, 1044, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'card', '2025-07-13 17:16:40', '2025-07-13 16:46:36', NULL, NULL, NULL),
(2513, 1044, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 17:16:40', '2025-07-13 16:48:50', NULL, NULL, NULL),
(2514, 1044, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:17:02', '2025-07-13 16:28:51', NULL, NULL, NULL),
(2515, 1044, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:17:02', '2025-07-13 16:28:30', NULL, NULL, NULL),
(2516, 1044, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-13 17:17:02', '2025-07-13 16:28:30', NULL, NULL, NULL),
(2517, 1045, 'pizza', 'Margherita', 1, 230.00, '', 'paid', 'card', '2025-07-13 17:23:28', '2025-07-13 16:53:39', NULL, NULL, NULL),
(2518, 1045, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-13 17:23:28', '2025-07-13 16:54:12', NULL, NULL, NULL),
(2519, 1045, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'card', '2025-07-13 17:23:28', '2025-07-13 16:54:13', NULL, NULL, NULL),
(2520, 1046, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'cancelled', 'cash', NULL, '2025-07-13 16:19:50', NULL, NULL, NULL),
(2521, 1046, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 16:31:36', NULL, NULL, NULL),
(2522, 1047, 'pizza', 'Per bambini', 1, 250.00, '', 'paid', 'card', '2025-07-13 18:05:07', '2025-07-13 17:04:27', NULL, NULL, NULL),
(2523, 1047, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-13 18:05:07', '2025-07-13 17:04:28', NULL, NULL, NULL),
(2524, 1048, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'card', '2025-07-13 17:35:39', '2025-07-13 17:05:29', NULL, NULL, NULL),
(2525, 1048, 'pizza', 'Prosicutto crudo', 1, 270.00, '', 'paid', 'card', '2025-07-13 17:35:39', '2025-07-13 17:07:31', NULL, NULL, NULL),
(2526, 1048, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-13 17:35:39', '2025-07-13 16:32:46', NULL, NULL, NULL),
(2527, 1048, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:35:39', '2025-07-13 16:32:50', NULL, NULL, NULL),
(2528, 1049, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:42:41', '2025-07-13 16:21:06', NULL, NULL, NULL),
(2529, 1050, 'nealko', 'Voda perlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 16:31:34', NULL, NULL, NULL),
(2530, 1050, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 17:14:53', NULL, NULL, NULL),
(2531, 1050, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 17:14:54', NULL, NULL, NULL),
(2532, 1050, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 16:31:33', NULL, NULL, NULL),
(2533, 1050, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 16:31:34', NULL, NULL, NULL),
(2534, 1050, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 16:31:35', NULL, NULL, NULL),
(2535, 1051, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'paid', 'card', '2025-07-13 16:58:25', '2025-07-13 16:28:51', NULL, NULL, NULL),
(2536, 1052, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:41:44', '2025-07-13 16:38:31', NULL, NULL, NULL),
(2537, 1052, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 16:41:44', '2025-07-13 16:38:32', NULL, NULL, NULL),
(2538, 1052, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', '2025-07-13 16:41:44', '2025-07-13 16:32:32', NULL, NULL, NULL),
(2539, 1053, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-13 18:30:42', '2025-07-13 16:34:31', NULL, NULL, NULL),
(2540, 1053, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:30:42', '2025-07-13 16:34:31', NULL, NULL, NULL),
(2541, 1054, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:50:39', '2025-07-13 16:35:01', NULL, NULL, NULL),
(2542, 1055, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:38:44', NULL, NULL, NULL),
(2543, 1055, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:38:45', NULL, NULL, NULL),
(2544, 1055, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:38:47', NULL, NULL, NULL),
(2545, 1055, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:38:44', NULL, NULL, NULL),
(2546, 1055, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 16:37:37', NULL, NULL, NULL),
(2547, 1056, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:35:39', '2025-07-13 16:40:06', NULL, NULL, NULL),
(2548, 1057, 'vino', 'Víno 1 dcl', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:57:11', '2025-07-13 16:42:27', NULL, NULL, NULL),
(2549, 1058, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:49:27', '2025-07-13 16:45:02', NULL, NULL, NULL),
(2550, 1058, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:49:27', '2025-07-13 16:45:03', NULL, NULL, NULL),
(2551, 1058, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:49:27', '2025-07-13 16:45:04', NULL, NULL, NULL),
(2552, 1059, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:14:26', '2025-07-13 16:47:17', NULL, NULL, NULL),
(2553, 1059, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 17:14:26', '2025-07-13 16:47:18', NULL, NULL, NULL),
(2554, 1059, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'card', '2025-07-13 17:14:26', '2025-07-13 16:47:20', NULL, NULL, NULL),
(2555, 1059, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'card', '2025-07-13 17:14:26', '2025-07-13 16:47:21', NULL, NULL, NULL),
(2556, 1059, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'card', '2025-07-13 17:14:26', '2025-07-13 17:04:06', NULL, NULL, NULL),
(2557, 1059, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'card', '2025-07-13 17:14:26', '2025-07-13 17:04:07', NULL, NULL, NULL),
(2558, 1059, 'predkrm', 'Focaccia e olio', 1, 75.00, '', 'paid', 'card', '2025-07-13 17:14:26', '2025-07-13 16:45:50', NULL, NULL, NULL),
(2559, 1059, 'predkrm', 'Foccacia, olio e olive', 1, 125.00, '', 'paid', 'card', '2025-07-13 17:14:26', '2025-07-13 16:45:51', NULL, NULL, NULL),
(2560, 1060, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 18:24:14', '2025-07-13 16:49:08', NULL, NULL, NULL),
(2561, 1061, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:05:07', '2025-07-13 16:52:09', NULL, NULL, NULL),
(2562, 1062, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', '2025-07-13 16:48:10', '2025-07-13 16:40:14', NULL, NULL, NULL),
(2563, 1063, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'cancelled', 'cash', NULL, NULL, NULL, NULL, NULL),
(2564, 1063, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:59:19', '2025-07-13 16:42:25', NULL, NULL, NULL),
(2565, 1063, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:59:19', '2025-07-13 16:42:26', NULL, NULL, NULL),
(2566, 1064, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 16:58:25', '2025-07-13 16:42:24', NULL, NULL, NULL),
(2567, 1065, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:49:27', '2025-07-13 16:52:13', NULL, NULL, NULL),
(2568, 1066, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'card', '2025-07-13 17:17:02', '2025-07-13 16:49:21', NULL, NULL, NULL),
(2569, 1067, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 16:57:33', NULL, NULL, NULL),
(2570, 1067, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:26:07', '2025-07-13 16:57:33', NULL, NULL, NULL),
(2571, 1068, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'cash', '2025-07-13 17:38:23', '2025-07-13 17:08:20', NULL, NULL, NULL),
(2572, 1068, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:38:23', '2025-07-13 16:52:53', NULL, NULL, NULL),
(2573, 1068, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'cash', '2025-07-13 17:38:23', '2025-07-13 16:52:50', NULL, NULL, NULL),
(2574, 1069, 'koktejl', 'Red Velvet gin Garage 22 a tonic', 1, 170.00, '', 'paid', 'card', '2025-07-13 17:16:40', '2025-07-13 16:58:29', NULL, NULL, NULL),
(2575, 1069, 'koktejl', 'Red Velvet gin Garage 22 a tonic', 1, 170.00, '', 'paid', 'card', '2025-07-13 17:17:02', '2025-07-13 16:58:43', NULL, NULL, NULL),
(2576, 1070, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:05:07', '2025-07-13 16:52:07', NULL, NULL, NULL),
(2577, 1071, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', '2025-07-13 17:34:19', '2025-07-13 17:07:07', NULL, NULL, NULL),
(2578, 1071, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', '2025-07-13 17:34:19', '2025-07-13 17:07:07', NULL, NULL, NULL),
(2579, 1071, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:34:19', '2025-07-13 16:58:44', NULL, NULL, NULL),
(2580, 1071, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 17:34:19', '2025-07-13 16:58:46', NULL, NULL, NULL),
(2581, 1072, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-13 18:05:07', '2025-07-13 16:59:45', NULL, NULL, NULL),
(2582, 1073, 'nealko', 'Voda neperlivá', 1, 40.00, '', 'paid', 'cash', '2025-07-13 17:38:23', '2025-07-13 16:59:44', NULL, NULL, NULL),
(2583, 1074, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'card', '2025-07-13 19:47:39', '2025-07-13 17:02:37', NULL, NULL, NULL),
(2584, 1074, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:51:37', '2025-07-13 17:02:30', NULL, NULL, NULL),
(2585, 1074, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:47:39', '2025-07-13 17:02:38', NULL, NULL, NULL),
(2586, 1074, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'card', '2025-07-13 19:51:37', '2025-07-13 17:17:27', NULL, NULL, NULL),
(2587, 1075, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-13 17:23:43', '2025-07-13 17:20:35', NULL, NULL, NULL),
(2588, 1075, 'spritz', 'Spritz Hugo', 1, 130.00, '', 'paid', 'card', '2025-07-13 17:23:43', '2025-07-13 17:04:32', NULL, NULL, NULL),
(2589, 1076, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 17:04:37', NULL, NULL, NULL),
(2590, 1077, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:50:39', '2025-07-13 17:05:41', NULL, NULL, NULL),
(2591, 1078, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-13 18:47:09', '2025-07-13 17:50:42', NULL, NULL, NULL),
(2592, 1078, 'pizza', 'Salame', 1, 250.00, '', 'paid', 'card', '2025-07-13 18:47:09', '2025-07-13 17:50:42', NULL, NULL, NULL),
(2593, 1078, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:47:09', '2025-07-13 17:09:40', NULL, NULL, NULL),
(2594, 1078, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:47:09', '2025-07-13 17:09:41', NULL, NULL, NULL),
(2595, 1079, 'predkrm', 'Tagliere di salumi', 1, 220.00, '', 'paid', 'cash', '2025-07-13 17:38:23', '2025-07-13 17:14:30', NULL, NULL, NULL),
(2596, 1080, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-13 18:31:29', '2025-07-13 17:23:47', NULL, NULL, NULL),
(2597, 1080, 'predkrm', 'Foccacia, olio e olive', 1, 125.00, '', 'paid', 'card', '2025-07-13 18:31:29', '2025-07-13 17:14:26', NULL, NULL, NULL),
(2598, 1080, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:31:29', '2025-07-13 17:11:47', NULL, NULL, NULL),
(2599, 1080, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:31:29', '2025-07-13 17:12:01', NULL, NULL, NULL),
(2600, 1081, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'cash', '2025-07-13 18:24:14', '2025-07-13 17:12:56', NULL, NULL, NULL),
(2601, 1082, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:51:37', '2025-07-13 17:12:57', NULL, NULL, NULL),
(2602, 1083, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 17:18:14', NULL, NULL, NULL),
(2603, 1083, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 17:16:39', NULL, NULL, NULL),
(2604, 1084, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-13 18:30:42', '2025-07-13 17:19:30', NULL, NULL, NULL),
(2605, 1085, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', '2025-07-13 18:24:14', '2025-07-13 17:31:41', NULL, NULL, NULL),
(2606, 1086, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 17:27:52', NULL, NULL, NULL),
(2607, 1086, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 17:27:51', NULL, NULL, NULL),
(2608, 1087, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'card', '2025-07-13 19:47:39', '2025-07-13 17:30:06', NULL, NULL, NULL),
(2609, 1087, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:51:37', '2025-07-13 17:30:06', NULL, NULL, NULL),
(2610, 1088, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-13 18:05:07', '2025-07-13 17:39:04', NULL, NULL, NULL),
(2611, 1088, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:05:07', '2025-07-13 17:39:05', NULL, NULL, NULL),
(2612, 1088, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:05:07', '2025-07-13 17:39:05', NULL, NULL, NULL),
(2613, 1089, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'card', '2025-07-13 19:47:39', '2025-07-13 17:41:01', NULL, NULL, NULL),
(2614, 1090, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:47:09', '2025-07-13 17:38:12', NULL, NULL, NULL),
(2615, 1091, 'pasta', 'Ragú alla Bolognese', 1, 210.00, '', 'paid', 'cash', '2025-07-13 18:24:14', '2025-07-13 17:47:12', NULL, NULL, NULL),
(2616, 1092, 'spritz', 'Spritz Sarti', 1, 130.00, '', 'paid', 'cash', '2025-07-13 18:30:50', '2025-07-13 17:56:38', NULL, NULL, NULL),
(2617, 1092, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'cash', '2025-07-13 18:30:50', '2025-07-13 17:56:37', NULL, NULL, NULL),
(2618, 1093, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-13 18:30:42', '2025-07-13 18:06:30', NULL, NULL, NULL),
(2619, 1093, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:30:42', '2025-07-13 18:06:31', NULL, NULL, NULL),
(2620, 1094, 'spritz', 'Spritz Aperol', 1, 130.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 18:06:33', NULL, NULL, NULL),
(2621, 1094, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 18:06:32', NULL, NULL, NULL),
(2622, 1095, 'negroni', 'Negroni Classico', 1, 150.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 18:06:32', NULL, NULL, NULL),
(2623, 1096, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:51:37', '2025-07-13 18:07:32', NULL, NULL, NULL),
(2624, 1097, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:50:39', '2025-07-13 18:07:34', NULL, NULL, NULL),
(2625, 1098, 'pivo', 'Mazák 0,3l', 1, 40.00, '', 'paid', 'card', '2025-07-13 18:47:09', '2025-07-13 18:09:00', NULL, NULL, NULL),
(2626, 1099, 'nealko', 'Domácí limonáda', 1, 50.00, '', 'paid', 'card', '2025-07-13 18:47:09', '2025-07-13 18:16:24', NULL, NULL, NULL),
(2627, 1100, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 18:50:49', NULL, NULL, NULL),
(2628, 1101, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:51:37', '2025-07-13 18:50:47', NULL, NULL, NULL),
(2629, 1101, 'spritz', 'Spritz Limoncello', 1, 130.00, '', 'paid', 'card', '2025-07-13 19:47:39', '2025-07-13 18:50:46', NULL, NULL, NULL),
(2631, 1103, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:49:41', '2025-07-13 19:08:29', NULL, NULL, NULL),
(2632, 1104, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:51:37', '2025-07-13 19:09:13', NULL, NULL, NULL),
(2633, 1105, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:52:20', '2025-07-13 19:11:57', NULL, NULL, NULL),
(2634, 1105, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:52:20', '2025-07-13 19:11:58', NULL, NULL, NULL),
(2635, 1106, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:50:39', '2025-07-13 19:29:54', NULL, NULL, NULL),
(2636, 1107, 'pivo', 'Mazák 0,5l', 1, 50.00, '', 'paid', 'card', '2025-07-13 19:51:37', '2025-07-13 19:29:55', NULL, NULL, NULL),
(2637, 1108, 'pizza', 'Prosciutto cotto', 1, 250.00, '', 'paid', 'card', '2025-07-14 22:00:09', '2025-07-14 21:59:32', NULL, NULL, NULL),
(2638, 1109, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'card', '2025-07-14 22:00:09', '2025-07-14 21:59:37', NULL, NULL, NULL),
(2639, 1110, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'cash', '2025-07-14 22:00:06', '2025-07-14 21:59:37', NULL, NULL, NULL),
(2640, 1111, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'card', '2025-07-14 21:59:58', '2025-07-14 21:59:40', NULL, NULL, NULL),
(2641, 1112, 'pizza', 'Daviola bianca', 1, 250.00, '', 'paid', 'cash', '2025-07-14 22:00:13', '2025-07-14 21:59:33', NULL, NULL, NULL),
(2642, 1113, 'predkrm', 'Bruschetta pomodoro', 1, 145.00, '', 'paid', 'cash', '2025-07-14 22:00:00', '2025-07-14 21:59:35', NULL, NULL, NULL),
(2643, 1114, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'card', '2025-07-14 22:00:03', '2025-07-14 21:59:41', NULL, NULL, NULL),
(2644, 1115, 'dezert', 'Tiramisu', 1, 95.00, '', 'paid', 'card', '2025-07-14 22:00:15', '2025-07-14 21:59:41', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_tables`
--

CREATE TABLE `order_tables` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `table_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `table_session_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `paid_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_method` enum('cash','card','other','hotovost','karta','stravenky') DEFAULT 'cash',
  `items_json` text DEFAULT NULL,
  `split_info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `table_session_id`, `amount`, `paid_at`, `payment_method`, `items_json`, `split_info`) VALUES
(156, 497, 730.00, '2025-07-11 13:04:35', 'hotovost', NULL, NULL),
(157, 499, 970.00, '2025-07-11 13:45:03', 'hotovost', NULL, NULL),
(158, 496, 1080.00, '2025-07-11 13:47:19', 'hotovost', NULL, NULL),
(159, 504, 660.00, '2025-07-11 14:11:25', 'hotovost', NULL, NULL),
(160, 502, 620.00, '2025-07-11 14:17:14', 'hotovost', NULL, NULL),
(161, 500, 870.00, '2025-07-11 14:19:28', 'hotovost', NULL, NULL),
(162, 505, 430.00, '2025-07-11 14:21:48', 'hotovost', NULL, NULL),
(163, 495, 790.00, '2025-07-11 14:26:07', 'hotovost', NULL, NULL),
(164, 501, 1250.00, '2025-07-11 14:28:04', 'hotovost', NULL, NULL),
(165, 503, 1200.00, '2025-07-11 14:29:27', 'hotovost', NULL, NULL),
(166, 508, 1675.00, '2025-07-11 15:02:25', 'hotovost', NULL, NULL),
(167, 511, 450.00, '2025-07-11 15:12:04', 'hotovost', NULL, NULL),
(168, 507, 1090.00, '2025-07-11 15:26:56', 'hotovost', NULL, NULL),
(169, 513, 280.00, '2025-07-11 15:33:22', 'hotovost', NULL, NULL),
(170, 513, 320.00, '2025-07-11 15:33:50', 'hotovost', NULL, NULL),
(171, 513, 300.00, '2025-07-11 15:34:22', 'hotovost', NULL, NULL),
(172, 513, 260.00, '2025-07-11 15:34:47', 'hotovost', NULL, NULL),
(174, 515, 950.00, '2025-07-11 15:43:42', 'hotovost', NULL, NULL),
(175, 509, 1420.00, '2025-07-11 15:59:46', 'hotovost', NULL, NULL),
(176, 516, 795.00, '2025-07-11 16:11:44', 'hotovost', NULL, NULL),
(177, 523, 230.00, '2025-07-11 16:14:07', 'hotovost', NULL, NULL),
(178, 523, 250.00, '2025-07-11 16:14:11', 'hotovost', NULL, NULL),
(179, 522, 300.00, '2025-07-11 16:16:36', 'hotovost', NULL, NULL),
(180, 519, 790.00, '2025-07-11 16:17:15', 'hotovost', NULL, NULL),
(181, 520, 800.00, '2025-07-11 16:22:02', 'hotovost', NULL, NULL),
(182, 520, 560.00, '2025-07-11 16:22:20', 'hotovost', NULL, NULL),
(183, 514, 1175.00, '2025-07-11 16:23:00', 'hotovost', NULL, NULL),
(184, 506, 1075.00, '2025-07-11 16:31:56', 'hotovost', NULL, NULL),
(185, 517, 1155.00, '2025-07-11 16:32:47', 'hotovost', NULL, NULL),
(186, 512, 970.00, '2025-07-11 16:39:49', 'hotovost', NULL, NULL),
(187, 524, 630.00, '2025-07-11 17:12:22', 'hotovost', NULL, NULL),
(188, 518, 360.00, '2025-07-11 17:19:24', 'hotovost', NULL, NULL),
(189, 518, 290.00, '2025-07-11 17:20:37', 'hotovost', NULL, NULL),
(190, 518, 350.00, '2025-07-11 17:20:50', 'hotovost', NULL, NULL),
(191, 518, 40.00, '2025-07-11 17:21:58', 'hotovost', NULL, NULL),
(192, 518, 80.00, '2025-07-11 17:22:16', 'hotovost', NULL, NULL),
(193, 521, 1630.00, '2025-07-11 17:27:01', 'hotovost', NULL, NULL),
(194, 525, 1540.00, '2025-07-11 17:47:55', 'hotovost', NULL, NULL),
(195, 530, 450.00, '2025-07-11 17:51:25', 'hotovost', NULL, NULL),
(196, 526, 865.00, '2025-07-11 17:53:32', 'hotovost', NULL, NULL),
(197, 528, 910.00, '2025-07-11 18:04:13', 'hotovost', NULL, NULL),
(198, 527, 350.00, '2025-07-11 18:16:12', 'hotovost', NULL, NULL),
(199, 532, 80.00, '2025-07-11 18:20:45', 'hotovost', NULL, NULL),
(200, 527, 520.00, '2025-07-11 18:27:11', 'hotovost', NULL, NULL),
(201, 527, 450.00, '2025-07-11 18:28:13', 'hotovost', NULL, NULL),
(202, 529, 630.00, '2025-07-11 18:44:08', 'hotovost', NULL, NULL),
(203, 531, 1450.00, '2025-07-11 18:51:56', 'hotovost', NULL, NULL),
(207, 558, 1060.00, '2025-07-12 01:55:35', 'hotovost', NULL, NULL),
(208, 559, 150.00, '2025-07-12 02:06:35', 'hotovost', NULL, NULL),
(209, 560, 1195.00, '2025-07-12 03:05:04', 'hotovost', NULL, NULL),
(210, 562, 225.00, '2025-07-12 03:11:43', 'hotovost', NULL, NULL),
(211, 564, 600.00, '2025-07-12 03:20:35', 'hotovost', NULL, NULL),
(212, 566, 480.00, '2025-07-12 03:41:46', 'hotovost', NULL, NULL),
(213, 565, 780.00, '2025-07-12 03:46:59', 'hotovost', NULL, NULL),
(214, 565, 805.00, '2025-07-12 03:48:02', 'hotovost', NULL, NULL),
(215, 565, 800.00, '2025-07-12 03:48:43', 'hotovost', NULL, NULL),
(216, 563, 940.00, '2025-07-12 04:22:38', 'hotovost', NULL, NULL),
(217, 563, 1225.00, '2025-07-12 04:23:31', 'hotovost', NULL, NULL),
(218, 568, 1045.00, '2025-07-12 04:32:19', 'hotovost', NULL, NULL),
(219, 567, 730.00, '2025-07-12 04:36:02', 'hotovost', NULL, NULL),
(220, 572, 710.00, '2025-07-12 04:44:08', 'hotovost', NULL, NULL),
(221, 570, 900.00, '2025-07-12 04:55:11', 'hotovost', NULL, NULL),
(222, 577, 220.00, '2025-07-12 05:30:45', 'hotovost', NULL, NULL),
(223, 561, 1615.00, '2025-07-12 05:36:58', 'hotovost', NULL, NULL),
(224, 575, 1415.00, '2025-07-12 05:43:05', 'hotovost', NULL, NULL),
(225, 576, 680.00, '2025-07-12 05:51:13', 'hotovost', NULL, NULL),
(226, 576, 780.00, '2025-07-12 05:52:32', 'hotovost', NULL, NULL),
(227, 571, 290.00, '2025-07-12 06:05:27', 'hotovost', NULL, NULL),
(228, 582, 740.00, '2025-07-12 06:38:27', 'hotovost', NULL, NULL),
(229, 571, 320.00, '2025-07-12 06:45:06', 'hotovost', NULL, NULL),
(230, 571, 1190.00, '2025-07-12 06:45:50', 'hotovost', NULL, NULL),
(231, 571, 50.00, '2025-07-12 06:46:26', 'hotovost', NULL, NULL),
(232, 571, 1190.00, '2025-07-12 06:48:40', 'hotovost', NULL, NULL),
(233, 571, 260.00, '2025-07-12 06:48:42', 'hotovost', NULL, NULL),
(234, 569, 450.00, '2025-07-12 07:23:57', 'hotovost', NULL, NULL),
(235, 578, 820.00, '2025-07-12 07:39:37', 'hotovost', NULL, NULL),
(236, 573, 200.00, '2025-07-12 07:39:47', 'hotovost', NULL, NULL),
(237, 581, 1480.00, '2025-07-12 07:40:07', 'hotovost', NULL, NULL),
(238, 579, 1575.00, '2025-07-12 07:52:29', 'hotovost', NULL, NULL),
(239, 583, 1290.00, '2025-07-12 08:06:53', 'hotovost', NULL, NULL),
(240, 574, 460.00, '2025-07-12 08:17:33', 'hotovost', NULL, NULL),
(241, 580, 410.00, '2025-07-12 08:33:59', 'hotovost', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pickup_items`
--

CREATE TABLE `pickup_items` (
  `id` int(11) NOT NULL,
  `device` int(11) NOT NULL,
  `item_type` enum('pizza','drink') NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `status` enum('ready','picked_up') DEFAULT 'ready',
  `ready_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `pickup_time` timestamp NULL DEFAULT NULL,
  `from_table` enum('kitchen','bar') NOT NULL,
  `original_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pizza_types`
--

CREATE TABLE `pizza_types` (
  `id` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `category` varchar(50) NOT NULL DEFAULT 'pizza',
  `display_order` int(11) DEFAULT NULL,
  `cost_price` decimal(10,2) DEFAULT 0.00 COMMENT 'Nákladová cena položky'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pizza_types`
--

INSERT INTO `pizza_types` (`id`, `type`, `name`, `price`, `description`, `is_active`, `created_at`, `updated_at`, `category`, `display_order`, `cost_price`) VALUES
(1, 'margherita', 'Margherita', 230.00, 'italská bio rajčata, mozzarella fior di latte, bazalka, \nolivový olej extra vergine', 1, '2025-06-30 14:13:50', '2025-07-07 14:04:25', 'pizza', 2, 0.00),
(2, 'diavola', 'Diavola', 250.00, 'italská bio rajčata, pikantní salám Ventricina, \nmozzarella fior di latte, bazalka', 0, '2025-06-30 14:13:50', '2025-07-11 12:04:11', 'pizza', 2, 0.00),
(3, 'prosciutto', 'Prosciutto cotto', 250.00, 'italská bio rajčata, mozzarella fior di latte, \nitalská dušená šunka', 1, '2025-06-30 14:13:50', '2025-07-07 14:04:25', 'pizza', 2, 0.00),
(6, 'bambiny', 'Per bambini', 250.00, 'italská bio rajčata, mozzarella fior di latte, \nitalská dušená šunka, kukuřice', 1, '2025-07-05 11:19:13', '2025-07-07 14:04:25', 'pizza', 2, 0.00),
(7, 'salame', 'Salame', 250.00, 'italská bio rajčata, salám Milano, mozzarella fior di latte, \nbazalka, červená cibule', 1, '2025-07-05 11:19:28', '2025-07-07 14:04:25', 'pizza', 2, 0.00),
(8, 'capocollo', 'Capocollo', 270.00, 'mozzarela fior di latte, cherry rajčata, \nitalská sušená krkovice, Grana Padano', 1, '2025-07-05 11:19:42', '2025-07-07 14:04:25', 'pizza', 2, 0.00),
(9, 'foccacia', 'Focaccia e olio', 75.00, 'domácí rozmarýnová focaccia, olivový olej extra vergine', 1, '2025-07-05 11:19:58', '2025-07-14 11:40:41', 'predkrm', 1, 0.00),
(10, 'salamtalir', 'Tagliere di salumi', 220.00, 'Italské uzeniny, domácí rozmarýnová foccacia, olivový olej \nextra vergine', 1, '2025-07-05 11:20:13', '2025-07-07 14:04:25', 'predkrm', 1, 0.00),
(11, 'pomodorspag', 'Spaghetti pomodoro', 170.00, 'omáčka z rajčat, bazalky a oregána, Grana Padano', 0, '2025-07-05 11:20:28', '2025-07-11 12:09:52', 'pasta', 3, 0.00),
(12, 'gnocchiquatro', 'Gnocchi quattro formaggi', 170.00, 'omáčka ze čtyř italských sýrů', 0, '2025-07-05 11:20:43', '2025-07-11 12:09:54', 'pasta', 3, 0.00),
(15, 'baba', 'Baba a rum', 90.00, 'rum', 0, '2025-07-07 14:15:11', '2025-07-11 11:58:02', 'dezert', 4, 30.00),
(16, 'tiramisu', 'Tiramisu', 95.00, '', 1, '2025-07-11 11:58:20', '2025-07-11 11:58:20', 'dezert', NULL, 0.00),
(17, 'bolognese', 'Ragú alla Bolognese', 210.00, 'Tagliatelle, hovezi ragu, zelenina, rajcata, garana padano', 1, '2025-07-11 11:59:16', '2025-07-11 11:59:16', 'pasta', NULL, 0.00),
(18, 'foccolivy', 'Foccacia, olio e olive', 125.00, 'domaci rozmarynova foccacia, olivy, olivovy olej extra vergine', 1, '2025-07-11 12:00:08', '2025-07-11 12:00:08', 'predkrm', NULL, 0.00),
(19, 'bruschettapomodoro', 'Bruschetta pomodoro', 145.00, 'domaci opeceny chleb, cherry racjata, bazalka, olivovy extra vergine olej', 1, '2025-07-11 12:00:45', '2025-07-11 12:00:45', 'predkrm', NULL, 0.00),
(20, 'burrataecrudo', 'Burrate e crudo predkrm', 220.00, 'Italska susesna sunka, burrata, domaci rozamrynova foccacia, olivovy extra olej vergine', 0, '2025-07-11 12:01:28', '2025-07-13 14:49:52', 'predkrm', NULL, 0.00),
(21, 'crudopizza', 'Prosicutto crudo', 270.00, 'italska bio rajcata, mozzarella fior di latte, rukola, italska susena sunka, grana padano', 0, '2025-07-11 12:02:20', '2025-07-13 16:18:05', 'pizza', NULL, 0.00),
(22, 'diavolabianca', 'Daviola bianca', 250.00, 'mozzarella fior di latte, pikantni italsky salam ventricina, bazalka', 1, '2025-07-11 12:03:11', '2025-07-11 12:03:11', 'pizza', NULL, 0.00),
(23, 'burrataecrudopizza', 'Burrata e crudo', 350.00, 'italska bio rajcata, mozzarella fior di latte, cherry rajcata, italska susena sunka, syr burrata, bazalkove pesto', 0, '2025-07-11 12:04:06', '2025-07-13 14:49:44', 'pizza', NULL, 0.00),
(24, 'mozzpomodoro', 'Mozzarella e pomodorini', 145.00, 'cherry rajcata, mozzarella, bazalka, olivo olej extra vergine, domaci opeceny chleb', 1, '2025-07-11 12:09:15', '2025-07-11 12:09:15', 'predkrm', NULL, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `restaurant_tables`
--

CREATE TABLE `restaurant_tables` (
  `id` int(11) NOT NULL,
  `table_number` int(11) NOT NULL,
  `status` enum('free','occupied','to_clean') DEFAULT 'free',
  `session_start` timestamp NULL DEFAULT NULL,
  `last_order_at` timestamp NULL DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT 0.00,
  `notes` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `category_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `table_code` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `restaurant_tables`
--

INSERT INTO `restaurant_tables` (`id`, `table_number`, `status`, `session_start`, `last_order_at`, `total_amount`, `notes`, `updated_at`, `category_id`, `location_id`, `table_code`) VALUES
(1, 1, 'free', NULL, NULL, 0.00, NULL, '2025-07-14 21:59:58', 1, 1, 'P11'),
(2, 2, 'free', NULL, NULL, 0.00, NULL, '2025-07-14 22:00:13', 1, 1, 'P12'),
(3, 3, 'free', NULL, NULL, 0.00, NULL, '2025-07-14 22:00:00', 1, 1, 'P13'),
(4, 4, 'free', NULL, NULL, 0.00, NULL, '2025-07-14 22:00:06', 1, 1, 'P14'),
(5, 5, 'free', NULL, NULL, 0.00, NULL, '2025-07-14 22:00:03', 2, 2, 'P21'),
(6, 6, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 14:56:52', 2, 2, 'P22'),
(7, 7, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 18:47:09', 2, 2, 'P23'),
(8, 8, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 18:05:07', 2, 2, 'P24'),
(9, 9, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 16:59:19', 2, 2, 'P25'),
(10, 10, 'free', NULL, NULL, 0.00, NULL, '2025-07-14 22:00:15', 3, 3, 'P31'),
(11, 11, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 17:38:23', 3, 3, 'P32'),
(12, 12, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 15:07:42', 3, 3, 'P33'),
(13, 13, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 17:17:02', 3, 3, 'P34'),
(14, 14, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 17:26:07', 3, 3, 'P35'),
(15, 15, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 17:14:26', 4, 4, 'P41'),
(16, 16, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 13:20:04', 5, 5, 'O1'),
(17, 17, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 18:30:43', 5, 5, 'O2'),
(18, 18, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 19:49:41', 5, 5, 'O3'),
(19, 19, 'free', '2025-07-13 16:58:28', NULL, 0.00, NULL, '2025-07-13 18:40:15', 5, 5, 'O4'),
(20, 20, 'free', '2025-07-13 15:21:17', NULL, 0.00, NULL, '2025-07-13 18:39:32', 5, 5, 'O5'),
(5881, 21, 'free', '2025-07-12 03:41:11', NULL, 0.00, NULL, '2025-07-12 07:24:35', 5, 5, 'O6'),
(5882, 22, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 18:31:29', 5, 5, 'O7'),
(5883, 23, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 17:34:19', 5, 5, 'O8'),
(5887, 31, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 16:25:13', 4, 4, 'P42'),
(5888, 32, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 17:13:41', 4, 4, 'P43'),
(5889, 100, 'free', NULL, NULL, 0.00, NULL, '2025-07-12 11:40:50', 6, NULL, 'A1'),
(5890, 101, 'free', NULL, NULL, 0.00, NULL, '2025-07-13 17:23:43', 6, NULL, 'A2'),
(5893, 999, 'free', NULL, NULL, 0.00, NULL, '2025-07-14 22:00:09', 8, 6, 'XX');

-- --------------------------------------------------------

--
-- Table structure for table `serving_history`
--

CREATE TABLE `serving_history` (
  `id` int(11) NOT NULL,
  `table_number` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `item_type` enum('pizza','drink','other') NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `served_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('served','problem') DEFAULT 'served',
  `reason` text DEFAULT NULL,
  `server_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `serving_history`
--

INSERT INTO `serving_history` (`id`, `table_number`, `item_name`, `item_type`, `price`, `served_at`, `status`, `reason`, `server_name`) VALUES
(26, 1, 'Spaghetti Carbonara', 'pizza', 180.00, '2025-06-30 14:09:31', 'served', NULL, NULL),
(27, 19, 'Margherita', 'pizza', 1000.00, '2025-07-03 07:31:07', 'served', NULL, NULL),
(28, 21, 'Cola', 'drink', 100.00, '2025-07-03 07:31:08', 'served', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `table_bills`
--

CREATE TABLE `table_bills` (
  `id` int(11) NOT NULL,
  `table_number` int(11) NOT NULL,
  `session_id` varchar(50) NOT NULL,
  `item_type` enum('pizza','drink','other') NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `note` text DEFAULT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `table_categories`
--

CREATE TABLE `table_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `display_order` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `table_categories`
--

INSERT INTO `table_categories` (`id`, `name`, `display_order`, `created_at`) VALUES
(1, 'Pergola 1', 1, '2025-07-01 12:06:46'),
(2, 'Pergola 2', 2, '2025-07-01 12:06:46'),
(3, 'Pergola 3', 3, '2025-07-01 12:06:46'),
(4, 'Pergola 4', 4, '2025-07-01 12:06:46'),
(5, 'Olivy', 5, '2025-07-01 12:06:46'),
(6, 'Auto', 6, '2025-07-05 11:45:38'),
(7, 'Auto', 6, '2025-07-05 11:47:01'),
(8, 'PIAGGIO', 999, '2025-07-06 08:14:57'),
(9, 'PIAGGIO', 999, '2025-07-06 08:18:24');

-- --------------------------------------------------------

--
-- Table structure for table `table_locations`
--

CREATE TABLE `table_locations` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `display_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `table_locations`
--

INSERT INTO `table_locations` (`id`, `name`, `display_order`) VALUES
(1, 'Pergola 1', 1),
(2, 'Pergola 2', 2),
(3, 'Pergola 3', 3),
(4, 'Pergola 4', 4),
(5, 'Olivy', 5),
(6, 'PIAGGIO', 999),
(7, 'PIAGGIO', 999);

-- --------------------------------------------------------

--
-- Table structure for table `table_sessions`
--

CREATE TABLE `table_sessions` (
  `id` int(11) NOT NULL,
  `table_number` int(11) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_time` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `table_sessions`
--

INSERT INTO `table_sessions` (`id`, `table_number`, `start_time`, `end_time`, `is_active`) VALUES
(242, 23, '2025-07-05 14:16:07', '2025-07-05 14:45:35', 0),
(243, 6, '2025-07-05 14:18:56', '2025-07-05 14:56:21', 0),
(244, 16, '2025-07-05 14:20:13', '2025-07-05 14:47:21', 0),
(245, 2, '2025-07-05 14:20:31', '2025-07-05 19:19:37', 0),
(246, 9, '2025-07-05 14:22:30', '2025-07-05 15:22:13', 0),
(247, 19, '2025-07-05 14:23:25', '2025-07-05 15:20:24', 0),
(248, 11, '2025-07-05 14:29:08', '2025-07-05 15:19:43', 0),
(249, 13, '2025-07-05 14:37:19', '2025-07-05 15:24:49', 0),
(250, 100, '2025-07-05 14:54:17', '2025-07-05 21:09:54', 0),
(251, 7, '2025-07-05 14:55:12', '2025-07-05 15:28:04', 0),
(252, 23, '2025-07-05 15:02:56', '2025-07-05 15:34:19', 0),
(253, 14, '2025-07-05 15:12:51', '2025-07-05 16:04:34', 0),
(254, 15, '2025-07-05 15:19:20', '2025-07-05 16:52:46', 0),
(255, 8, '2025-07-05 15:20:39', '2025-07-05 17:10:09', 0),
(256, 13, '2025-07-05 15:40:29', '2025-07-05 16:33:47', 0),
(257, 11, '2025-07-05 15:40:56', '2025-07-05 17:58:01', 0),
(258, 19, '2025-07-05 15:51:13', '2025-07-05 17:49:17', 0),
(259, 16, '2025-07-05 16:02:03', '2025-07-05 17:40:31', 0),
(260, 21, '2025-07-05 16:02:45', '2025-07-05 17:33:04', 0),
(261, 7, '2025-07-05 16:06:09', '2025-07-05 17:12:43', 0),
(262, 10, '2025-07-05 16:10:43', '2025-07-05 16:59:05', 0),
(263, 18, '2025-07-05 16:11:57', '2025-07-05 17:19:22', 0),
(264, 32, '2025-07-05 16:12:51', '2025-07-05 18:34:36', 0),
(265, 4, '2025-07-05 16:14:32', '2025-07-05 17:10:57', 0),
(266, 5, '2025-07-05 16:21:04', '2025-07-05 17:03:00', 0),
(267, 14, '2025-07-05 16:28:49', '2025-07-05 16:56:51', 0),
(268, 101, '2025-07-05 16:34:33', '2025-07-05 17:40:06', 0),
(269, 31, '2025-07-05 17:03:04', '2025-07-05 18:33:01', 0),
(270, 15, '2025-07-05 17:04:28', '2025-07-05 18:26:10', 0),
(271, 13, '2025-07-05 17:04:59', '2025-07-05 18:34:06', 0),
(272, 9, '2025-07-05 17:08:09', '2025-07-05 18:04:37', 0),
(273, 12, '2025-07-05 17:10:02', '2025-07-05 18:30:42', 0),
(274, 5, '2025-07-05 17:11:54', '2025-07-05 18:10:25', 0),
(275, 6, '2025-07-05 17:19:56', '2025-07-05 18:22:44', 0),
(276, 10, '2025-07-05 17:20:36', '2025-07-05 18:06:14', 0),
(277, 4, '2025-07-05 17:22:42', '2025-07-05 18:28:56', 0),
(278, 17, '2025-07-05 17:24:01', '2025-07-05 18:34:53', 0),
(279, 7, '2025-07-05 17:24:59', '2025-07-05 18:47:54', 0),
(280, 14, '2025-07-05 17:25:15', '2025-07-05 21:10:07', 0),
(281, 18, '2025-07-05 17:33:47', '2025-07-05 19:54:56', 0),
(282, 22, '2025-07-05 17:43:49', '2025-07-05 19:02:03', 0),
(283, 19, '2025-07-05 17:51:48', '2025-07-05 19:56:39', 0),
(284, 11, '2025-07-05 17:58:54', '2025-07-05 18:48:18', 0),
(285, 8, '2025-07-05 18:00:36', '2025-07-05 19:36:15', 0),
(286, 16, '2025-07-05 18:02:07', '2025-07-05 18:03:01', 0),
(287, 16, '2025-07-05 18:07:16', '2025-07-05 21:09:12', 0),
(288, 10, '2025-07-05 18:08:35', '2025-07-05 19:16:00', 0),
(289, 23, '2025-07-05 18:13:03', '2025-07-05 19:52:11', 0),
(290, 4, '2025-07-05 18:30:13', '2025-07-05 19:32:44', 0),
(291, 5, '2025-07-05 18:47:00', '2025-07-05 19:34:08', 0),
(292, 101, '2025-07-05 18:53:39', '2025-07-05 20:46:55', 0),
(293, 17, '2025-07-05 18:55:52', '2025-07-05 19:37:51', 0),
(294, 12, '2025-07-05 18:57:06', '2025-07-05 21:09:16', 0),
(295, 32, '2025-07-05 19:14:19', '2025-07-05 20:06:18', 0),
(296, 9, '2025-07-05 19:17:41', '2025-07-05 19:58:09', 0),
(297, 2, '2025-07-05 19:25:24', '2025-07-05 20:25:22', 0),
(298, 9, '2025-07-05 19:58:38', '2025-07-05 20:20:50', 0),
(299, 6, '2025-07-05 19:59:20', '2025-07-05 21:09:20', 0),
(300, 17, '2025-07-05 20:34:21', '2025-07-05 20:34:46', 0),
(301, 17, '2025-07-05 20:38:47', '2025-07-05 21:09:22', 0),
(311, 7, '2025-07-06 13:00:42', '2025-07-06 13:37:59', 0),
(312, 999, '2025-07-06 13:15:45', '2025-07-07 07:19:30', 0),
(313, 23, '2025-07-06 13:22:42', '2025-07-06 14:33:21', 0),
(314, 5, '2025-07-06 14:00:09', '2025-07-06 14:49:45', 0),
(315, 11, '2025-07-06 14:16:54', '2025-07-06 15:59:53', 0),
(316, 8, '2025-07-06 14:38:57', '2025-07-06 15:59:41', 0),
(317, 19, '2025-07-06 14:47:37', '2025-07-06 16:31:52', 0),
(318, 6, '2025-07-06 14:56:09', '2025-07-06 15:59:34', 0),
(319, 4, '2025-07-06 15:15:28', '2025-07-06 15:56:06', 0),
(320, 13, '2025-07-06 15:25:42', '2025-07-06 16:23:30', 0),
(321, 9, '2025-07-06 15:28:26', '2025-07-06 17:13:48', 0),
(322, 2, '2025-07-06 15:32:02', '2025-07-06 16:53:09', 0),
(323, 15, '2025-07-06 15:34:30', '2025-07-06 17:22:04', 0),
(324, 10, '2025-07-06 15:37:31', '2025-07-06 15:59:49', 0),
(325, 14, '2025-07-06 15:41:45', '2025-07-06 16:32:12', 0),
(326, 101, '2025-07-06 16:14:16', '2025-07-06 17:11:30', 0),
(327, 31, '2025-07-06 16:20:58', '2025-07-06 17:22:07', 0),
(328, 7, '2025-07-06 16:27:54', '2025-07-06 17:18:56', 0),
(329, 20, '2025-07-06 16:36:07', '2025-07-06 17:05:24', 0),
(330, 1, '2025-07-06 16:52:04', '2025-07-12 11:32:58', 0),
(331, 11, '2025-07-06 17:00:28', '2025-07-06 18:03:32', 0),
(332, 3, '2025-07-06 17:02:14', '2025-07-06 17:17:25', 0),
(333, 1, '2025-07-06 17:08:34', '2025-07-12 11:32:58', 0),
(334, 2, '2025-07-06 17:12:13', '2025-07-06 17:30:36', 0),
(335, 4, '2025-07-06 17:17:00', '2025-07-06 17:39:00', 0),
(336, 2, '2025-07-06 17:33:47', '2025-07-06 18:02:15', 0),
(337, 15, '2025-07-06 17:36:21', '2025-07-06 18:03:03', 0),
(338, 6, '2025-07-06 17:59:00', '2025-07-06 18:21:13', 0),
(495, 19, '2025-07-11 12:55:41', '2025-07-11 14:26:07', 0),
(496, 6, '2025-07-11 12:57:36', '2025-07-11 13:47:19', 0),
(497, 11, '2025-07-11 12:58:30', '2025-07-11 13:04:35', 0),
(499, 11, '2025-07-11 13:07:52', '2025-07-11 13:45:03', 0),
(500, 3, '2025-07-11 13:12:31', '2025-07-11 14:19:28', 0),
(501, 1, '2025-07-11 13:13:40', '2025-07-12 11:32:58', 0),
(502, 23, '2025-07-11 13:22:27', '2025-07-11 14:17:14', 0),
(503, 7, '2025-07-11 13:26:06', '2025-07-11 14:29:27', 0),
(504, 21, '2025-07-11 13:40:06', '2025-07-11 14:11:25', 0),
(505, 101, '2025-07-11 13:42:41', '2025-07-11 14:21:48', 0),
(506, 11, '2025-07-11 14:04:29', '2025-07-11 16:31:56', 0),
(507, 6, '2025-07-11 14:08:04', '2025-07-11 15:26:56', 0),
(508, 13, '2025-07-11 14:21:23', '2025-07-11 15:02:25', 0),
(509, 2, '2025-07-11 14:29:27', '2025-07-11 15:59:46', 0),
(511, 16, '2025-07-11 14:41:22', '2025-07-11 15:12:04', 0),
(512, 31, '2025-07-11 14:42:45', '2025-07-11 16:39:49', 0),
(513, 32, '2025-07-11 14:53:56', '2025-07-11 15:34:47', 0),
(514, 9, '2025-07-11 15:12:11', '2025-07-11 16:23:00', 0),
(515, 3, '2025-07-11 15:14:08', '2025-07-11 15:43:42', 0),
(516, 14, '2025-07-11 15:16:14', '2025-07-11 16:11:44', 0),
(517, 8, '2025-07-11 15:18:20', '2025-07-11 16:32:47', 0),
(518, 5, '2025-07-11 15:19:47', '2025-07-11 17:22:16', 0),
(519, 101, '2025-07-11 15:32:31', '2025-07-11 16:17:15', 0),
(520, 20, '2025-07-11 15:35:28', '2025-07-11 16:22:20', 0),
(521, 19, '2025-07-11 15:52:16', '2025-07-11 17:27:01', 0),
(522, 6, '2025-07-11 15:52:48', '2025-07-11 16:16:36', 0),
(523, 16, '2025-07-11 16:02:28', '2025-07-11 16:14:11', 0),
(524, 16, '2025-07-11 16:27:04', '2025-07-11 17:12:22', 0),
(525, 2, '2025-07-11 16:30:09', '2025-07-11 17:47:55', 0),
(526, 13, '2025-07-11 16:31:38', '2025-07-11 17:53:32', 0),
(527, 32, '2025-07-11 16:47:41', '2025-07-11 18:28:13', 0),
(528, 3, '2025-07-11 16:49:51', '2025-07-11 18:04:13', 0),
(529, 6, '2025-07-11 17:16:11', '2025-07-11 18:44:09', 0),
(530, 7, '2025-07-11 17:26:19', '2025-07-11 17:51:26', 0),
(531, 2, '2025-07-11 18:03:34', '2025-07-11 18:51:56', 0),
(532, 100, '2025-07-11 18:20:08', '2025-07-11 18:20:45', 0),
(544, 4, '2025-07-12 11:50:34', '2025-07-12 11:40:50', 0),
(546, 12, '2025-07-12 11:56:14', '2025-07-12 11:40:50', 0),
(548, 11, '2025-07-12 12:00:24', '2025-07-12 11:40:50', 0),
(549, 20, '2025-07-12 12:01:16', '2025-07-12 11:40:50', 0),
(550, 17, '2025-07-12 12:01:39', '2025-07-12 11:40:50', 0),
(551, 16, '2025-07-12 12:14:31', '2025-07-12 11:40:50', 0),
(553, 2, '2025-07-12 12:42:23', '2025-07-12 11:40:50', 0),
(554, 3, '2025-07-12 12:51:43', '2025-07-12 11:40:50', 0),
(556, 100, '2025-07-12 12:59:13', '2025-07-12 11:40:50', 0),
(557, 14, '2025-07-12 13:07:05', '2025-07-12 11:40:50', 0),
(558, 999, '2025-07-12 01:37:33', '2025-07-12 01:55:35', 0),
(559, 999, '2025-07-12 02:04:51', '2025-07-12 02:06:35', 0),
(560, 6, '2025-07-12 02:10:07', '2025-07-12 03:05:04', 0),
(561, 13, '2025-07-12 02:14:16', '2025-07-12 05:36:58', 0),
(562, 32, '2025-07-12 02:14:58', '2025-07-12 03:11:43', 0),
(563, 9, '2025-07-12 02:23:14', '2025-07-12 04:23:31', 0),
(564, 21, '2025-07-12 02:25:47', '2025-07-12 03:20:35', 0),
(565, 15, '2025-07-12 02:35:13', '2025-07-12 03:48:43', 0),
(566, 19, '2025-07-12 02:43:05', '2025-07-12 03:41:46', 0),
(567, 101, '2025-07-12 02:56:32', '2025-07-12 04:36:02', 0),
(568, 32, '2025-07-12 03:12:34', '2025-07-12 04:32:19', 0),
(569, 6, '2025-07-12 03:13:08', '2025-07-12 07:23:57', 0),
(570, 7, '2025-07-12 03:33:04', '2025-07-12 04:55:11', 0),
(571, 21, '2025-07-12 03:41:11', '2025-07-12 06:48:42', 0),
(572, 19, '2025-07-12 03:42:47', '2025-07-12 04:44:08', 0),
(573, 8, '2025-07-12 03:44:18', '2025-07-12 07:39:47', 0),
(574, 999, '2025-07-12 04:16:04', '2025-07-12 08:17:33', 0),
(575, 15, '2025-07-12 04:25:51', '2025-07-12 05:43:05', 0),
(576, 31, '2025-07-12 04:29:27', '2025-07-12 05:52:32', 0),
(577, 101, '2025-07-12 04:39:51', '2025-07-12 05:30:45', 0),
(578, 9, '2025-07-12 04:40:20', '2025-07-12 07:39:37', 0),
(579, 32, '2025-07-12 04:48:33', '2025-07-12 07:52:29', 0),
(580, 18, '2025-07-12 05:17:21', '2025-07-12 08:33:59', 0),
(581, 13, '2025-07-12 05:39:42', '2025-07-12 07:40:07', 0),
(582, 19, '2025-07-12 05:52:11', '2025-07-12 06:38:27', 0),
(583, 15, '2025-07-12 07:03:31', '2025-07-12 08:06:53', 0),
(584, 19, '2025-07-12 11:02:50', '2025-07-12 11:40:50', 0),
(585, 9, '2025-07-12 11:18:19', '2025-07-12 11:40:50', 0),
(586, 8, '2025-07-12 11:19:25', '2025-07-12 11:40:50', 0),
(587, 7, '2025-07-12 11:21:07', '2025-07-12 11:40:50', 0),
(588, 6, '2025-07-12 11:21:21', '2025-07-12 11:40:50', 0),
(589, 101, '2025-07-12 11:28:27', '2025-07-12 11:47:32', 0),
(590, 1, '2025-07-12 11:33:40', '2025-07-12 11:40:50', 0),
(591, 31, '2025-07-12 11:39:09', '2025-07-12 11:39:34', 0),
(592, 2, '2025-07-12 11:41:21', '2025-07-12 11:42:41', 0),
(593, 1, '2025-07-12 11:44:03', '2025-07-12 11:47:30', 0),
(611, 999, '2025-07-13 13:14:54', '2025-07-13 13:15:50', 0),
(612, 16, '2025-07-13 13:15:50', '2025-07-13 13:20:04', 0),
(613, 2, '2025-07-13 13:21:20', '2025-07-13 13:54:04', 0),
(614, 999, '2025-07-13 13:21:33', '2025-07-13 13:23:06', 0),
(615, 9, '2025-07-13 13:27:17', '2025-07-13 14:16:10', 0),
(616, 5, '2025-07-13 13:35:09', '2025-07-13 13:54:41', 0),
(617, 11, '2025-07-13 13:35:43', '2025-07-13 15:20:17', 0),
(618, 1, '2025-07-13 13:37:47', '2025-07-13 14:58:40', 0),
(619, 32, '2025-07-13 13:49:32', '2025-07-13 15:53:25', 0),
(620, 22, '2025-07-13 14:00:09', '2025-07-13 15:16:51', 0),
(621, 20, '2025-07-13 14:00:49', '2025-07-13 14:47:28', 0),
(622, 2, '2025-07-13 14:04:25', '2025-07-13 14:33:26', 0),
(623, 3, '2025-07-13 14:07:12', '2025-07-13 14:47:59', 0),
(624, 6, '2025-07-13 14:09:40', '2025-07-13 14:56:52', 0),
(625, 19, '2025-07-13 14:21:31', '2025-07-13 16:57:26', 0),
(626, 12, '2025-07-13 14:22:45', '2025-07-13 15:07:42', 0),
(627, 15, '2025-07-13 14:30:23', '2025-07-13 15:14:22', 0),
(628, 9, '2025-07-13 14:33:40', '2025-07-13 15:10:31', 0),
(629, 7, '2025-07-13 14:34:18', '2025-07-13 15:34:09', 0),
(630, 2, '2025-07-13 14:41:05', '2025-07-13 15:56:31', 0),
(631, 14, '2025-07-13 14:53:01', '2025-07-13 15:35:32', 0),
(632, 18, '2025-07-13 15:01:58', '2025-07-13 19:49:41', 0),
(633, 17, '2025-07-13 15:02:57', '2025-07-13 15:51:03', 0),
(634, 13, '2025-07-13 15:06:03', '2025-07-13 15:37:28', 0),
(635, 8, '2025-07-13 15:09:01', '2025-07-13 16:12:55', 0),
(636, 4, '2025-07-13 15:13:24', '2025-07-13 15:38:24', 0),
(637, 20, '2025-07-13 15:21:17', '2025-07-13 18:39:32', 0),
(638, 31, '2025-07-13 15:23:55', '2025-07-13 16:25:13', 0),
(639, 5, '2025-07-13 15:25:22', '2025-07-13 17:49:27', 0),
(640, 11, '2025-07-13 15:30:17', '2025-07-13 16:24:14', 0),
(641, 22, '2025-07-13 15:32:26', '2025-07-13 16:42:41', 0),
(642, 1, '2025-07-13 15:33:04', '2025-07-13 15:56:48', 0),
(643, 14, '2025-07-13 15:40:54', '2025-07-13 17:26:07', 0),
(644, 23, '2025-07-13 15:41:51', '2025-07-13 16:41:44', 0),
(645, 9, '2025-07-13 15:47:30', '2025-07-13 16:59:19', 0),
(646, 13, '2025-07-13 15:51:57', '2025-07-13 17:17:02', 0),
(647, 101, '2025-07-13 15:53:24', '2025-07-13 16:48:10', 0),
(648, 999, '2025-07-13 15:54:37', '2025-07-13 18:24:14', 0),
(649, 17, '2025-07-13 15:55:28', '2025-07-13 18:30:42', 0),
(650, 7, '2025-07-13 16:00:22', '2025-07-13 17:01:07', 0),
(651, 4, '2025-07-13 16:06:43', '2025-07-13 17:21:47', 0),
(652, 8, '2025-07-13 16:13:15', '2025-07-13 18:05:07', 0),
(653, 32, '2025-07-13 16:15:01', '2025-07-13 17:13:41', 0),
(654, 2, '2025-07-13 16:17:00', '2025-07-13 17:23:28', 0),
(655, 1, '2025-07-13 16:18:58', '2025-07-13 17:35:39', 0),
(656, 15, '2025-07-13 16:35:24', '2025-07-13 17:14:26', 0),
(657, 11, '2025-07-13 16:47:49', '2025-07-13 17:38:23', 0),
(658, 23, '2025-07-13 16:50:36', '2025-07-13 17:34:19', 0),
(659, 19, '2025-07-13 16:58:28', '2025-07-13 18:40:15', 0),
(660, 101, '2025-07-13 16:58:45', '2025-07-13 17:23:43', 0),
(661, 7, '2025-07-13 17:06:14', '2025-07-13 18:47:09', 0),
(662, 22, '2025-07-13 17:08:47', '2025-07-13 18:31:29', 0),
(663, 4, '2025-07-13 17:54:13', '2025-07-13 18:30:50', 0),
(664, 1, '2025-07-13 18:39:32', '2025-07-13 19:50:39', 0),
(665, 2, '2025-07-13 18:40:15', '2025-07-13 19:51:37', 0),
(666, 3, '2025-07-13 19:10:40', '2025-07-13 19:52:20', 0),
(667, 999, '2025-07-14 21:36:12', '2025-07-14 22:00:09', 0),
(668, 4, '2025-07-14 21:39:52', '2025-07-14 22:00:06', 0),
(669, 1, '2025-07-14 21:41:59', '2025-07-14 21:59:58', 0),
(670, 2, '2025-07-14 21:46:13', '2025-07-14 22:00:13', 0),
(671, 3, '2025-07-14 21:54:30', '2025-07-14 22:00:00', 0),
(672, 5, '2025-07-14 21:54:54', '2025-07-14 22:00:03', 0),
(673, 10, '2025-07-14 21:57:07', '2025-07-14 22:00:15', 0);

-- --------------------------------------------------------

--
-- Table structure for table `total_statistics`
--

CREATE TABLE `total_statistics` (
  `id` int(11) NOT NULL,
  `total_pizzas_ever` int(11) DEFAULT 0,
  `total_drinks_ever` int(11) DEFAULT 0,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `archived_orders`
--
ALTER TABLE `archived_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_archived_device` (`device`),
  ADD KEY `idx_archived_date` (`completed_timestamp`),
  ADD KEY `idx_archived_type` (`order_type`);

--
-- Indexes for table `bar_orders`
--
ALTER TABLE `bar_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bar_order_items`
--
ALTER TABLE `bar_order_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `burnt_pizzas_log`
--
ALTER TABLE `burnt_pizzas_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `completed_payments`
--
ALTER TABLE `completed_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_paid_date` (`paid_at`),
  ADD KEY `idx_table_payment` (`table_number`,`paid_at`);

--
-- Indexes for table `daily_stats`
--
ALTER TABLE `daily_stats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `date` (`date`);

--
-- Indexes for table `drink_types`
--
ALTER TABLE `drink_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type` (`type`),
  ADD KEY `idx_cost_price` (`cost_price`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kitchen_orders`
--
ALTER TABLE `kitchen_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_kitchen_original_order` (`original_order_id`),
  ADD KEY `idx_device` (`device`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_timestamp` (`timestamp`);

--
-- Indexes for table `kitchen_order_items`
--
ALTER TABLE `kitchen_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_id` (`order_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `table_session_id` (`table_session_id`),
  ADD KEY `idx_order_status` (`status`),
  ADD KEY `idx_order_type` (`order_type`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `idx_item_status` (`status`),
  ADD KEY `idx_prepared_at` (`prepared_at`),
  ADD KEY `idx_item_type_status` (`item_type`,`status`);

--
-- Indexes for table `order_tables`
--
ALTER TABLE `order_tables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `table_session_id` (`table_session_id`);

--
-- Indexes for table `pickup_items`
--
ALTER TABLE `pickup_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pizza_types`
--
ALTER TABLE `pizza_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type` (`type`),
  ADD KEY `idx_cost_price` (`cost_price`);

--
-- Indexes for table `restaurant_tables`
--
ALTER TABLE `restaurant_tables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `table_number` (`table_number`),
  ADD KEY `idx_table_status` (`status`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `restaurant_tables_ibfk_2` (`location_id`);

--
-- Indexes for table `serving_history`
--
ALTER TABLE `serving_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_served_date` (`served_at`),
  ADD KEY `idx_table_served` (`table_number`,`served_at`);

--
-- Indexes for table `table_bills`
--
ALTER TABLE `table_bills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_table_session` (`table_number`,`session_id`),
  ADD KEY `idx_table_date` (`table_number`,`added_at`);

--
-- Indexes for table `table_categories`
--
ALTER TABLE `table_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `table_locations`
--
ALTER TABLE `table_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `table_sessions`
--
ALTER TABLE `table_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `table_number` (`table_number`),
  ADD KEY `idx_session_active` (`is_active`);

--
-- Indexes for table `total_statistics`
--
ALTER TABLE `total_statistics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_stats` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `archived_orders`
--
ALTER TABLE `archived_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bar_orders`
--
ALTER TABLE `bar_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `bar_order_items`
--
ALTER TABLE `bar_order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `burnt_pizzas_log`
--
ALTER TABLE `burnt_pizzas_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `completed_payments`
--
ALTER TABLE `completed_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `daily_stats`
--
ALTER TABLE `daily_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `drink_types`
--
ALTER TABLE `drink_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=351;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kitchen_orders`
--
ALTER TABLE `kitchen_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=214;

--
-- AUTO_INCREMENT for table `kitchen_order_items`
--
ALTER TABLE `kitchen_order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1116;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2645;

--
-- AUTO_INCREMENT for table `order_tables`
--
ALTER TABLE `order_tables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=242;

--
-- AUTO_INCREMENT for table `pickup_items`
--
ALTER TABLE `pickup_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pizza_types`
--
ALTER TABLE `pizza_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `restaurant_tables`
--
ALTER TABLE `restaurant_tables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5895;

--
-- AUTO_INCREMENT for table `serving_history`
--
ALTER TABLE `serving_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `table_bills`
--
ALTER TABLE `table_bills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `table_categories`
--
ALTER TABLE `table_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `table_locations`
--
ALTER TABLE `table_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `table_sessions`
--
ALTER TABLE `table_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=674;

--
-- AUTO_INCREMENT for table `total_statistics`
--
ALTER TABLE `total_statistics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kitchen_orders`
--
ALTER TABLE `kitchen_orders`
  ADD CONSTRAINT `fk_kitchen_original_order` FOREIGN KEY (`original_order_id`) REFERENCES `kitchen_orders` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `kitchen_order_items`
--
ALTER TABLE `kitchen_order_items`
  ADD CONSTRAINT `fk_kitchen_items_order` FOREIGN KEY (`order_id`) REFERENCES `kitchen_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`table_session_id`) REFERENCES `table_sessions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_tables`
--
ALTER TABLE `order_tables`
  ADD CONSTRAINT `order_tables_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`table_session_id`) REFERENCES `table_sessions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `restaurant_tables`
--
ALTER TABLE `restaurant_tables`
  ADD CONSTRAINT `restaurant_tables_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `table_categories` (`id`),
  ADD CONSTRAINT `restaurant_tables_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `table_locations` (`id`);

--
-- Constraints for table `table_sessions`
--
ALTER TABLE `table_sessions`
  ADD CONSTRAINT `table_sessions_ibfk_1` FOREIGN KEY (`table_number`) REFERENCES `restaurant_tables` (`table_number`) ON DELETE CASCADE;
--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `party_size` int(11) NOT NULL,
  `reservation_date` date NOT NULL,
  `reservation_time` time NOT NULL,
  `notes` text DEFAULT NULL,
  `table_number` int(11) DEFAULT NULL,
  `status` enum('pending','confirmed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_reservation_date_time` (`reservation_date`, `reservation_time`),
  KEY `idx_table_number` (`table_number`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_reservations_table` FOREIGN KEY (`table_number`) REFERENCES `restaurant_tables` (`table_number`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
