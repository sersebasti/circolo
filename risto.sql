-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Dec 13, 2025 at 05:15 PM
-- Server version: 11.8.5-MariaDB-ubu2404
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `risto`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add reparto', 7, 'add_reparto'),
(26, 'Can change reparto', 7, 'change_reparto'),
(27, 'Can delete reparto', 7, 'delete_reparto'),
(28, 'Can view reparto', 7, 'view_reparto'),
(29, 'Can add tavolo', 8, 'add_tavolo'),
(30, 'Can change tavolo', 8, 'change_tavolo'),
(31, 'Can delete tavolo', 8, 'delete_tavolo'),
(32, 'Can view tavolo', 8, 'view_tavolo'),
(33, 'Can add comanda', 9, 'add_comanda'),
(34, 'Can change comanda', 9, 'change_comanda'),
(35, 'Can delete comanda', 9, 'delete_comanda'),
(36, 'Can view comanda', 9, 'view_comanda'),
(37, 'Can add prodotto', 10, 'add_prodotto'),
(38, 'Can change prodotto', 10, 'change_prodotto'),
(39, 'Can delete prodotto', 10, 'delete_prodotto'),
(40, 'Can view prodotto', 10, 'view_prodotto'),
(41, 'Can add riga comanda', 11, 'add_rigacomanda'),
(42, 'Can change riga comanda', 11, 'change_rigacomanda'),
(43, 'Can delete riga comanda', 11, 'delete_rigacomanda'),
(44, 'Can view riga comanda', 11, 'view_rigacomanda'),
(45, 'Can add evento comanda', 12, 'add_eventocomanda'),
(46, 'Can change evento comanda', 12, 'change_eventocomanda'),
(47, 'Can delete evento comanda', 12, 'delete_eventocomanda'),
(48, 'Can view evento comanda', 12, 'view_eventocomanda');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$1000000$bboEYGYttP8albYPSHHQvD$90GsjiuW8NLapuZZ1laQDd4CulGtrV00wWGzOlY3QN8=', '2025-12-12 20:26:56.682710', 1, 'root', '', '', 'ser.sebastiani@gmail.com', 1, 1, '2025-12-12 20:15:56.768372');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comanda`
--

CREATE TABLE `comanda` (
  `id` bigint(20) NOT NULL,
  `creata_il` datetime(6) NOT NULL,
  `note` longtext NOT NULL,
  `creata_da_id` int(11) NOT NULL,
  `tavolo_id` bigint(20) NOT NULL,
  `coperti` smallint(5) UNSIGNED NOT NULL CHECK (`coperti` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `comanda`
--

INSERT INTO `comanda` (`id`, `creata_il`, `note`, `creata_da_id`, `tavolo_id`, `coperti`) VALUES
(1, '2025-12-13 16:05:51.447409', '', 1, 1, 3),
(2, '2025-12-13 16:06:31.145630', '', 1, 2, 6);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-12-12 20:44:55.369551', '1', 'margherita', 1, '[{\"added\": {}}]', 10, 1),
(2, '2025-12-12 20:45:30.655063', '2', 'salamino piccante', 1, '[{\"added\": {}}]', 10, 1),
(3, '2025-12-12 20:45:47.343149', '3', 'ragù', 1, '[{\"added\": {}}]', 10, 1),
(4, '2025-12-12 20:46:01.911063', '4', 'boscaiola', 1, '[{\"added\": {}}]', 10, 1),
(5, '2025-12-12 20:46:14.852918', '5', 'coca 1L', 1, '[{\"added\": {}}]', 10, 1),
(6, '2025-12-12 20:46:31.406924', '6', 'acqua 1L', 1, '[{\"added\": {}}]', 10, 1),
(7, '2025-12-12 20:56:05.027339', '3', 'Tavolo 3', 1, '[{\"added\": {}}]', 8, 1),
(8, '2025-12-12 20:56:10.119719', '4', 'Tavolo 4', 1, '[{\"added\": {}}]', 8, 1),
(9, '2025-12-12 20:56:14.792038', '5', 'Tavolo 5', 1, '[{\"added\": {}}]', 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(9, 'core', 'comanda'),
(12, 'core', 'eventocomanda'),
(10, 'core', 'prodotto'),
(7, 'core', 'reparto'),
(11, 'core', 'rigacomanda'),
(8, 'core', 'tavolo'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-12-12 20:14:12.218316'),
(2, 'auth', '0001_initial', '2025-12-12 20:14:13.503110'),
(3, 'admin', '0001_initial', '2025-12-12 20:14:13.784062'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-12-12 20:14:13.795705'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-12-12 20:14:13.811675'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-12-12 20:14:14.039977'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-12-12 20:14:14.147305'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-12-12 20:14:14.217819'),
(9, 'auth', '0004_alter_user_username_opts', '2025-12-12 20:14:14.232866'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-12-12 20:14:14.340954'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-12-12 20:14:14.346199'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-12-12 20:14:14.359251'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-12-12 20:14:14.437752'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-12-12 20:14:14.528437'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-12-12 20:14:14.599018'),
(16, 'auth', '0011_update_proxy_permissions', '2025-12-12 20:14:14.613124'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-12-12 20:14:14.688646'),
(18, 'sessions', '0001_initial', '2025-12-12 20:14:14.855031'),
(19, 'core', '0001_initial', '2025-12-12 20:36:31.549953'),
(20, 'core', '0002_comanda_coperti', '2025-12-12 21:37:33.023203'),
(21, 'core', '0003_delete_eventocomanda', '2025-12-12 22:00:38.991319'),
(22, 'core', '0004_alter_comanda_options_and_more', '2025-12-12 22:08:45.981108'),
(23, 'core', '0005_alter_comanda_tavolo', '2025-12-13 16:03:33.843090');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('1lw8qrj5wg20vj61oeg6pnl68gtcmyx8', '.eJxVjDEOwjAMRe-SGUVxLNKGkZ0zRG5skwJKpaadEHenlTrA-t77_20SrUtJa5M5jWwuBszplw2Un1J3wQ-q98nmqS7zONg9sYdt9jaxvK5H-3dQqJVtHYU7RSSCELI6iIQ5e88xnKMEFAjaC5FH0Oy6np0Kw4ZEoypGZz5f-5w40w:1vU9j6:vN5XjrNJRCgwOxHaiCTlo4sRrFSW_rxSkEg5pG9eETY', '2025-12-26 20:26:56.693411');

-- --------------------------------------------------------

--
-- Table structure for table `prodotto`
--

CREATE TABLE `prodotto` (
  `id` bigint(20) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `prezzo` decimal(10,2) NOT NULL,
  `attivo` tinyint(1) NOT NULL,
  `reparto_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `prodotto`
--

INSERT INTO `prodotto` (`id`, `nome`, `prezzo`, `attivo`, `reparto_id`) VALUES
(1, 'margherita', 6.00, 1, 2),
(2, 'salamino piccante', 7.00, 1, 2),
(3, 'ragù', 6.00, 1, 1),
(4, 'boscaiola', 7.00, 1, 1),
(5, 'coca 1L', 4.00, 1, 3),
(6, 'acqua 1L', 1.00, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `reparto`
--

CREATE TABLE `reparto` (
  `id` bigint(20) NOT NULL,
  `codice` varchar(20) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `auto_pronta` tinyint(1) NOT NULL,
  `attivo` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `reparto`
--

INSERT INTO `reparto` (`id`, `codice`, `nome`, `auto_pronta`, `attivo`) VALUES
(1, 'CUCINA', 'Cucina', 0, 1),
(2, 'PIZZERIA', 'Pizzeria', 0, 1),
(3, 'BAR', 'Bar', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `riga_comanda`
--

CREATE TABLE `riga_comanda` (
  `id` bigint(20) NOT NULL,
  `quantita` int(10) UNSIGNED NOT NULL CHECK (`quantita` >= 0),
  `prezzo_unitario` decimal(10,2) NOT NULL,
  `note` longtext NOT NULL,
  `stato` varchar(10) NOT NULL,
  `inviata_il` datetime(6) DEFAULT NULL,
  `pronta_il` datetime(6) DEFAULT NULL,
  `servita_il` datetime(6) DEFAULT NULL,
  `comanda_id` bigint(20) NOT NULL,
  `prodotto_id` bigint(20) NOT NULL,
  `reparto_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `riga_comanda`
--

INSERT INTO `riga_comanda` (`id`, `quantita`, `prezzo_unitario`, `note`, `stato`, `inviata_il`, `pronta_il`, `servita_il`, `comanda_id`, `prodotto_id`, `reparto_id`) VALUES
(1, 1, 7.00, 'no sale', 'INVIATA', '2025-12-13 17:05:26.219896', NULL, NULL, 2, 4, 1),
(2, 1, 1.00, 'gas', 'PRONTA', NULL, '2025-12-13 16:12:42.407390', NULL, 2, 6, 3),
(3, 3, 6.00, 'al dente', 'INVIATA', '2025-12-13 17:05:26.219896', NULL, NULL, 2, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tavolo`
--

CREATE TABLE `tavolo` (
  `id` bigint(20) NOT NULL,
  `numero` int(10) UNSIGNED NOT NULL CHECK (`numero` >= 0),
  `nome` varchar(100) NOT NULL,
  `attivo` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `tavolo`
--

INSERT INTO `tavolo` (`id`, `numero`, `nome`, `attivo`) VALUES
(1, 1, '', 1),
(2, 2, '', 1),
(3, 3, '', 1),
(4, 4, '', 1),
(5, 5, '', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `comanda`
--
ALTER TABLE `comanda`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `comanda_tavolo_id_8715e221_uniq` (`tavolo_id`),
  ADD KEY `comanda_creata_da_id_6728d3a5_fk_auth_user_id` (`creata_da_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `prodotto`
--
ALTER TABLE `prodotto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prodotto_reparto_id_d464835a_fk_reparto_id` (`reparto_id`);

--
-- Indexes for table `reparto`
--
ALTER TABLE `reparto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codice` (`codice`);

--
-- Indexes for table `riga_comanda`
--
ALTER TABLE `riga_comanda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_riga_rep_stato` (`reparto_id`,`stato`),
  ADD KEY `idx_riga_comanda` (`comanda_id`),
  ADD KEY `riga_comanda_prodotto_id_29c6dfe6_fk_prodotto_id` (`prodotto_id`);

--
-- Indexes for table `tavolo`
--
ALTER TABLE `tavolo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero` (`numero`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comanda`
--
ALTER TABLE `comanda`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `prodotto`
--
ALTER TABLE `prodotto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `reparto`
--
ALTER TABLE `reparto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `riga_comanda`
--
ALTER TABLE `riga_comanda`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tavolo`
--
ALTER TABLE `tavolo`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `comanda`
--
ALTER TABLE `comanda`
  ADD CONSTRAINT `comanda_creata_da_id_6728d3a5_fk_auth_user_id` FOREIGN KEY (`creata_da_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `comanda_tavolo_id_8715e221_fk_tavolo_id` FOREIGN KEY (`tavolo_id`) REFERENCES `tavolo` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `prodotto`
--
ALTER TABLE `prodotto`
  ADD CONSTRAINT `prodotto_reparto_id_d464835a_fk_reparto_id` FOREIGN KEY (`reparto_id`) REFERENCES `reparto` (`id`);

--
-- Constraints for table `riga_comanda`
--
ALTER TABLE `riga_comanda`
  ADD CONSTRAINT `riga_comanda_comanda_id_691394af_fk_comanda_id` FOREIGN KEY (`comanda_id`) REFERENCES `comanda` (`id`),
  ADD CONSTRAINT `riga_comanda_prodotto_id_29c6dfe6_fk_prodotto_id` FOREIGN KEY (`prodotto_id`) REFERENCES `prodotto` (`id`),
  ADD CONSTRAINT `riga_comanda_reparto_id_4217d54b_fk_reparto_id` FOREIGN KEY (`reparto_id`) REFERENCES `reparto` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
