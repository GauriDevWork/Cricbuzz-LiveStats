-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2025 at 12:30 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cricketdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `bowling_records`
--

CREATE TABLE `bowling_records` (
  `id` int(11) NOT NULL,
  `match_id` varchar(64) DEFAULT NULL,
  `player_id` varchar(64) DEFAULT NULL,
  `player_name` varchar(128) DEFAULT NULL,
  `overs` decimal(5,2) DEFAULT NULL,
  `runs_conceded` int(11) DEFAULT NULL,
  `wickets` int(11) DEFAULT NULL,
  `economy` decimal(6,2) DEFAULT NULL,
  `raw_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_json`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bowling_records`
--

INSERT INTO `bowling_records` (`id`, `match_id`, `player_id`, `player_name`, `overs`, `runs_conceded`, `wickets`, `economy`, `raw_json`, `created_at`) VALUES
(1, '130168', '9311', 'Jasprit Bumrah', 4.00, 32, 2, 8.00, '{\"matchId\":130168,\"playerId\":9311,\"playerName\":\"Jasprit Bumrah\",\"overs\":4,\"runs\":32,\"wickets\":2,\"economy\":8.0}', '2025-09-28 09:52:27'),
(2, '130168', '13217', 'Arshdeep Singh', 4.00, 28, 1, 7.00, '{\"matchId\":130168,\"playerId\":13217,\"playerName\":\"Arshdeep Singh\",\"overs\":4,\"runs\":28,\"wickets\":1,\"economy\":7.0}', '2025-09-28 09:52:27'),
(3, '130168', '10808', 'Mohammed Siraj', 4.00, 36, 0, 9.00, '{\"matchId\":130168,\"playerId\":10808,\"playerName\":\"Mohammed Siraj\",\"overs\":4,\"runs\":36,\"wickets\":0,\"economy\":9.0}', '2025-09-28 09:52:27'),
(4, '130140', '9311', 'Jasprit Bumrah', 3.00, 22, 1, 7.33, '{\"matchId\":130140,\"playerId\":9311,\"playerName\":\"Jasprit Bumrah\",\"overs\":3,\"runs\":22,\"wickets\":1,\"economy\":7.33}', '2025-09-28 09:52:27'),
(5, '130140', '13217', 'Arshdeep Singh', 4.00, 35, 2, 8.75, '{\"matchId\":130140,\"playerId\":13217,\"playerName\":\"Arshdeep Singh\",\"overs\":4,\"runs\":35,\"wickets\":2,\"economy\":8.75}', '2025-09-28 09:52:27'),
(6, '130140', '10808', 'Mohammed Siraj', 4.00, 41, 1, 10.25, '{\"matchId\":130140,\"playerId\":10808,\"playerName\":\"Mohammed Siraj\",\"overs\":4,\"runs\":41,\"wickets\":1,\"economy\":10.25}', '2025-09-28 09:52:27');

-- --------------------------------------------------------

--
-- Table structure for table `innings`
--

CREATE TABLE `innings` (
  `id` int(11) NOT NULL,
  `match_id` varchar(64) DEFAULT NULL,
  `innings_number` int(11) DEFAULT NULL,
  `batting_team_id` varchar(64) DEFAULT NULL,
  `batting_team_name` varchar(128) DEFAULT NULL,
  `runs` int(11) DEFAULT NULL,
  `wickets` int(11) DEFAULT NULL,
  `overs` decimal(5,2) DEFAULT NULL,
  `raw_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_json`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `innings`
--

INSERT INTO `innings` (`id`, `match_id`, `innings_number`, `batting_team_id`, `batting_team_name`, `runs`, `wickets`, `overs`, `raw_json`, `created_at`) VALUES
(1, '130168', 1, '2', 'India', 202, 5, 19.60, '{\"matchId\":130168,\"team\":\"team1\",\"batting_team_id\":2,\"batting_team_name\":\"India\",\"inningsId\":1,\"runs\":202,\"wickets\":5,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(2, '130168', 2, '5', 'Sri Lanka', 202, 5, 19.60, '{\"matchId\":130168,\"team\":\"team2\",\"batting_team_id\":5,\"batting_team_name\":\"Sri Lanka\",\"inningsId\":2,\"runs\":202,\"wickets\":5,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(3, '130140', 1, '5', 'Sri Lanka', 133, 8, 19.60, '{\"matchId\":130140,\"team\":\"team1\",\"batting_team_id\":5,\"batting_team_name\":\"Sri Lanka\",\"inningsId\":1,\"runs\":133,\"wickets\":8,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(4, '130140', 2, '3', 'Pakistan', 138, 5, 17.60, '{\"matchId\":130140,\"team\":\"team2\",\"batting_team_id\":3,\"batting_team_name\":\"Pakistan\",\"inningsId\":2,\"runs\":138,\"wickets\":5,\"overs\":\"17.6\"}', '2025-09-28 10:04:24'),
(5, '130157', 1, '3', 'Pakistan', 135, 8, 19.60, '{\"matchId\":130157,\"team\":\"team1\",\"batting_team_id\":3,\"batting_team_name\":\"Pakistan\",\"inningsId\":1,\"runs\":135,\"wickets\":8,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(6, '130157', 2, '6', 'Bangladesh', 124, 9, 19.60, '{\"matchId\":130157,\"team\":\"team2\",\"batting_team_id\":6,\"batting_team_name\":\"Bangladesh\",\"inningsId\":2,\"runs\":124,\"wickets\":9,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(7, '130129', 1, '3', 'Pakistan', 171, 5, 19.60, '{\"matchId\":130129,\"team\":\"team1\",\"batting_team_id\":3,\"batting_team_name\":\"Pakistan\",\"inningsId\":1,\"runs\":171,\"wickets\":5,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(8, '130129', 2, '2', 'India', 174, 4, 18.50, '{\"matchId\":130129,\"team\":\"team2\",\"batting_team_id\":2,\"batting_team_name\":\"India\",\"inningsId\":2,\"runs\":174,\"wickets\":4,\"overs\":\"18.5\"}', '2025-09-28 10:04:24'),
(9, '130146', 1, '2', 'India', 168, 6, 19.60, '{\"matchId\":130146,\"team\":\"team1\",\"batting_team_id\":2,\"batting_team_name\":\"India\",\"inningsId\":1,\"runs\":168,\"wickets\":6,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(10, '130146', 2, '6', 'Bangladesh', 127, 10, 19.30, '{\"matchId\":130146,\"team\":\"team2\",\"batting_team_id\":6,\"batting_team_name\":\"Bangladesh\",\"inningsId\":2,\"runs\":127,\"wickets\":10,\"overs\":\"19.3\"}', '2025-09-28 10:04:24'),
(11, '121345', 1, '72', 'Nepal', 148, 8, 19.60, '{\"matchId\":121345,\"team\":\"team1\",\"batting_team_id\":72,\"batting_team_name\":\"Nepal\",\"inningsId\":1,\"runs\":148,\"wickets\":8,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(12, '121345', 2, '10', 'West Indies', 129, 9, 19.60, '{\"matchId\":121345,\"team\":\"team2\",\"batting_team_id\":10,\"batting_team_name\":\"West Indies\",\"inningsId\":2,\"runs\":129,\"wickets\":9,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(13, '134782', 1, '529', 'Botswana', 122, 6, 19.60, '{\"matchId\":134782,\"team\":\"team1\",\"batting_team_id\":529,\"batting_team_name\":\"Botswana\",\"inningsId\":1,\"runs\":122,\"wickets\":6,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(14, '134782', 2, '535', 'Tanzania', 124, 3, 13.50, '{\"matchId\":134782,\"team\":\"team2\",\"batting_team_id\":535,\"batting_team_name\":\"Tanzania\",\"inningsId\":2,\"runs\":124,\"wickets\":3,\"overs\":\"13.5\"}', '2025-09-28 10:04:24'),
(15, '134760', 1, '161', 'Namibia', 241, 5, 19.60, '{\"matchId\":134760,\"team\":\"team1\",\"batting_team_id\":161,\"batting_team_name\":\"Namibia\",\"inningsId\":1,\"runs\":241,\"wickets\":5,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(16, '134760', 2, '14', 'Kenya', 105, 7, 19.60, '{\"matchId\":134760,\"team\":\"team2\",\"batting_team_id\":14,\"batting_team_name\":\"Kenya\",\"inningsId\":2,\"runs\":105,\"wickets\":7,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(17, '116828', 1, '159', 'Guyana Amazon Warriors', 130, 8, 19.60, '{\"matchId\":116828,\"team\":\"team1\",\"batting_team_id\":159,\"batting_team_name\":\"Guyana Amazon Warriors\",\"inningsId\":1,\"runs\":130,\"wickets\":8,\"overs\":\"19.6\"}', '2025-09-28 10:04:24'),
(18, '116828', 2, '271', 'Trinbago Knight Riders', 133, 7, 17.60, '{\"matchId\":116828,\"team\":\"team2\",\"batting_team_id\":271,\"batting_team_name\":\"Trinbago Knight Riders\",\"inningsId\":2,\"runs\":133,\"wickets\":7,\"overs\":\"17.6\"}', '2025-09-28 10:04:24'),
(19, '131009', 1, '54', 'India U19', 280, 9, 49.60, '{\"matchId\":131009,\"team\":\"team1\",\"batting_team_id\":54,\"batting_team_name\":\"India U19\",\"inningsId\":1,\"runs\":280,\"wickets\":9,\"overs\":\"49.6\"}', '2025-09-28 10:04:24'),
(20, '130998', 1, '54', 'India U19', 300, 10, 49.40, '{\"matchId\":130998,\"team\":\"team1\",\"batting_team_id\":54,\"batting_team_name\":\"India U19\",\"inningsId\":1,\"runs\":300,\"wickets\":10,\"overs\":\"49.4\"}', '2025-09-28 10:04:24');

-- --------------------------------------------------------

--
-- Table structure for table `matches`
--

CREATE TABLE `matches` (
  `id` int(11) NOT NULL,
  `match_id` varchar(64) DEFAULT NULL,
  `match_desc` varchar(512) DEFAULT NULL,
  `team1_id` varchar(64) DEFAULT NULL,
  `team1_name` varchar(128) DEFAULT NULL,
  `team2_id` varchar(64) DEFAULT NULL,
  `team2_name` varchar(128) DEFAULT NULL,
  `venue_id` varchar(64) DEFAULT NULL,
  `venue_name` varchar(255) DEFAULT NULL,
  `venue_city` varchar(128) DEFAULT NULL,
  `match_start` datetime DEFAULT NULL,
  `status` varchar(128) DEFAULT NULL,
  `toss_winner` varchar(128) DEFAULT NULL,
  `toss_decision` varchar(16) DEFAULT NULL,
  `winner` varchar(128) DEFAULT NULL,
  `victory_margin` varchar(64) DEFAULT NULL,
  `victory_type` varchar(32) DEFAULT NULL,
  `format` varchar(16) DEFAULT NULL,
  `raw_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_json`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `matches`
--

INSERT INTO `matches` (`id`, `match_id`, `match_desc`, `team1_id`, `team1_name`, `team2_id`, `team2_name`, `venue_id`, `venue_name`, `venue_city`, `match_start`, `status`, `toss_winner`, `toss_decision`, `winner`, `victory_margin`, `victory_type`, `format`, `raw_json`, `created_at`) VALUES
(105858, '105858', '3rd T20I', '27', 'Ireland', '9', 'England', '370', 'The Village', 'Dublin', '2025-09-21 18:00:00', 'England won by 6 wkts', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":105858,\"seriesId\":8802,\"seriesName\":\"England tour of Ireland, 2025\",\"matchDesc\":\"3rd T20I\",\"matchFormat\":\"T20\",\"startDate\":\"1758457800000\",\"endDate\":\"1758470400000\",\"state\":\"Complete\",\"status\":\"England won by 6 wkts\",\"team1\":{\"teamId\":27,\"teamName\":\"Ireland\",\"teamSName\":\"IRE\",\"imageId\":495001},\"team2\":{\"teamId\":9,\"teamName\":\"England\",\"teamSName\":\"ENG\",\"imageId\":172123},\"venueInfo\":{\"id\":370,\"ground\":\"The Village\",\"city\":\"Dublin\",\"timezone\":\"+01:00\",\"latitude\":\"53.32568\",\"longitude\":\"-6.261829\"},\"currBatTeamId\":9,\"seriesStartDt\":\"1758067200000\",\"seriesEndDt\":\"1758585600000\",\"isTimeAnnounced\":true,\"stateTitle\":\"ENG Won\"}', '2025-09-28 09:39:18'),
(113262, '113262', '66th Match', '119', 'Somerset', '152', 'Essex', '118', 'County Ground', 'Chelmsford', '2025-09-24 15:00:00', 'Essex won by 7 wkts', NULL, NULL, NULL, NULL, NULL, 'TEST', '{\"matchId\":113262,\"seriesId\":9360,\"seriesName\":\"County Championship Division One 2025\",\"matchDesc\":\"66th Match\",\"matchFormat\":\"TEST\",\"startDate\":\"1758706200000\",\"endDate\":\"1758990600000\",\"state\":\"Complete\",\"status\":\"Essex won by 7 wkts\",\"team1\":{\"teamId\":119,\"teamName\":\"Somerset\",\"teamSName\":\"SOM\",\"imageId\":172199},\"team2\":{\"teamId\":152,\"teamName\":\"Essex\",\"teamSName\":\"ESS\",\"imageId\":172219},\"venueInfo\":{\"id\":118,\"ground\":\"County Ground\",\"city\":\"Chelmsford\",\"timezone\":\"+01:00\",\"latitude\":\"51.731580\",\"longitude\":\"0.469004\"},\"currBatTeamId\":152,\"seriesStartDt\":\"1743724800000\",\"seriesEndDt\":\"1759104000000\",\"isTimeAnnounced\":true,\"stateTitle\":\"Complete\"}', '2025-09-28 09:39:18'),
(113271, '113271', '67th Match', '140', 'Warwickshire', '139', 'Nottinghamshire', '18', 'Trent Bridge', 'Nottingham', '2025-09-24 15:00:00', 'Nottinghamshire won by 10 wkts', NULL, NULL, NULL, NULL, NULL, 'TEST', '{\"matchId\":113271,\"seriesId\":9360,\"seriesName\":\"County Championship Division One 2025\",\"matchDesc\":\"67th Match\",\"matchFormat\":\"TEST\",\"startDate\":\"1758706200000\",\"endDate\":\"1758990600000\",\"state\":\"Complete\",\"status\":\"Nottinghamshire won by 10 wkts\",\"team1\":{\"teamId\":140,\"teamName\":\"Warwickshire\",\"teamSName\":\"WARKS\",\"imageId\":172207},\"team2\":{\"teamId\":139,\"teamName\":\"Nottinghamshire\",\"teamSName\":\"NOTTS\",\"imageId\":172206},\"venueInfo\":{\"id\":18,\"ground\":\"Trent Bridge\",\"city\":\"Nottingham\",\"timezone\":\"+01:00\",\"latitude\":\"52.936884\",\"longitude\":\"-1.132230\"},\"currBatTeamId\":139,\"seriesStartDt\":\"1743724800000\",\"seriesEndDt\":\"1759104000000\",\"isTimeAnnounced\":true,\"stateTitle\":\"NOTTS Won\"}', '2025-09-28 09:39:18'),
(116828, '116828', 'Final', '159', 'Guyana Amazon Warriors', '271', 'Trinbago Knight Riders', '110', 'Providence Stadium', 'Guyana', '2025-09-22 05:30:00', 'Trinbago Knight Riders won by 3 wkts', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":116828,\"seriesId\":9575,\"seriesName\":\"Caribbean Premier League 2025\",\"matchDesc\":\"Final\",\"matchFormat\":\"T20\",\"startDate\":\"1758499200000\",\"endDate\":\"1758511800000\",\"state\":\"Complete\",\"status\":\"Trinbago Knight Riders won by 3 wkts\",\"team1\":{\"teamId\":159,\"teamName\":\"Guyana Amazon Warriors\",\"teamSName\":\"GAW\",\"imageId\":172227},\"team2\":{\"teamId\":271,\"teamName\":\"Trinbago Knight Riders\",\"teamSName\":\"TKR\",\"imageId\":172325},\"venueInfo\":{\"id\":110,\"ground\":\"Providence Stadium\",\"city\":\"Guyana\",\"timezone\":\"-04:00\",\"latitude\":\"41.823872\",\"longitude\":\"-71.411987\"},\"currBatTeamId\":271,\"seriesStartDt\":\"1755129600000\",\"seriesEndDt\":\"1758585600000\",\"isTimeAnnounced\":true,\"stateTitle\":\"TKR Won\"}', '2025-09-28 09:39:18'),
(119852, '119852', '2nd Unofficial Test', '79', 'Australia A', '78', 'India A', '485', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Cricket Stadium', 'Lucknow', '2025-09-23 09:30:00', 'India A won by 5 wkts', NULL, NULL, NULL, NULL, NULL, 'TEST', '{\"matchId\":119852,\"seriesId\":9935,\"seriesName\":\"Australia A tour of India, 2025\",\"matchDesc\":\"2nd Unofficial Test\",\"matchFormat\":\"TEST\",\"startDate\":\"1758600000000\",\"endDate\":\"1758884400000\",\"state\":\"Complete\",\"status\":\"India A won by 5 wkts\",\"team1\":{\"teamId\":79,\"teamName\":\"Australia A\",\"teamSName\":\"AUSA\",\"imageId\":172173},\"team2\":{\"teamId\":78,\"teamName\":\"India A\",\"teamSName\":\"INDA\",\"imageId\":693099},\"venueInfo\":{\"id\":485,\"ground\":\"Bharat Ratna Shri Atal Bihari Vajpayee Ekana Cricket Stadium\",\"city\":\"Lucknow\",\"timezone\":\"+05:30\",\"latitude\":\"26.846694\",\"longitude\":\"80.946166\"},\"currBatTeamId\":78,\"seriesStartDt\":\"1757980800000\",\"seriesEndDt\":\"1759795200000\",\"isTimeAnnounced\":true,\"stateTitle\":\"INDA Won\"}', '2025-09-28 09:39:18'),
(121345, '121345', '1st T20I', '72', 'Nepal', '10', 'West Indies', '140', 'Sharjah Cricket Stadium', 'Sharjah', '2025-09-27 20:00:00', 'Nepal won by 19 runs', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":121345,\"seriesId\":10091,\"seriesName\":\"West Indies vs Nepal in UAE, 2025\",\"matchDesc\":\"1st T20I\",\"matchFormat\":\"T20\",\"startDate\":\"1758983400000\",\"endDate\":\"1758996000000\",\"state\":\"Complete\",\"status\":\"Nepal won by 19 runs\",\"team1\":{\"teamId\":72,\"teamName\":\"Nepal\",\"teamSName\":\"NEP\",\"imageId\":172169},\"team2\":{\"teamId\":10,\"teamName\":\"West Indies\",\"teamSName\":\"WI\",\"imageId\":172124},\"venueInfo\":{\"id\":140,\"ground\":\"Sharjah Cricket Stadium\",\"city\":\"Sharjah\",\"timezone\":\"+04:00\",\"latitude\":\"25.33095\",\"longitude\":\"55.420902\"},\"currBatTeamId\":72,\"seriesStartDt\":\"1758931200000\",\"seriesEndDt\":\"1759363200000\",\"isTimeAnnounced\":true,\"stateTitle\":\"NEP Won\"}', '2025-09-28 09:39:18'),
(130129, '130129', 'Super Fours, 14th Match (A1 v A2)', '3', 'Pakistan', '2', 'India', '153', 'Dubai International Cricket Stadium', 'Dubai', '2025-09-21 20:00:00', 'India won by 6 wkts', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":130129,\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\",\"matchDesc\":\"Super Fours, 14th Match (A1 v A2)\",\"matchFormat\":\"T20\",\"startDate\":\"1758465000000\",\"endDate\":\"1758477600000\",\"state\":\"Complete\",\"status\":\"India won by 6 wkts\",\"team1\":{\"teamId\":3,\"teamName\":\"Pakistan\",\"teamSName\":\"PAK\",\"imageId\":591986},\"team2\":{\"teamId\":2,\"teamName\":\"India\",\"teamSName\":\"IND\",\"imageId\":719031},\"venueInfo\":{\"id\":153,\"ground\":\"Dubai International Cricket Stadium\",\"city\":\"Dubai\",\"timezone\":\"+04:00\",\"latitude\":\"25.046842\",\"longitude\":\"55.218969\"},\"currBatTeamId\":2,\"seriesStartDt\":\"1757376000000\",\"seriesEndDt\":\"1759190400000\",\"isTimeAnnounced\":true,\"stateTitle\":\"IND Won\"}', '2025-09-28 09:39:18'),
(130140, '130140', 'Super Fours, 15th Match (A2 v B1)', '5', 'Sri Lanka', '3', 'Pakistan', '94', 'Sheikh Zayed Stadium', 'Abu Dhabi', '2025-09-23 20:00:00', 'Pakistan won by 5 wkts', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":130140,\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\",\"matchDesc\":\"Super Fours, 15th Match (A2 v B1)\",\"matchFormat\":\"T20\",\"startDate\":\"1758637800000\",\"endDate\":\"1758650400000\",\"state\":\"Complete\",\"status\":\"Pakistan won by 5 wkts\",\"team1\":{\"teamId\":5,\"teamName\":\"Sri Lanka\",\"teamSName\":\"SL\",\"imageId\":172119},\"team2\":{\"teamId\":3,\"teamName\":\"Pakistan\",\"teamSName\":\"PAK\",\"imageId\":591986},\"venueInfo\":{\"id\":94,\"ground\":\"Sheikh Zayed Stadium\",\"city\":\"Abu Dhabi\",\"timezone\":\"+04:00\",\"latitude\":\"24.416138\",\"longitude\":\"54.453566\"},\"currBatTeamId\":3,\"seriesStartDt\":\"1757376000000\",\"seriesEndDt\":\"1759190400000\",\"isTimeAnnounced\":true,\"stateTitle\":\"PAK Won\"}', '2025-09-28 09:39:18'),
(130146, '130146', 'Super Fours, 16th Match (A1 v B2)', '2', 'India', '6', 'Bangladesh', '153', 'Dubai International Cricket Stadium', 'Dubai', '2025-09-24 20:00:00', 'India won by 41 runs', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":130146,\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\",\"matchDesc\":\"Super Fours, 16th Match (A1 v B2)\",\"matchFormat\":\"T20\",\"startDate\":\"1758724200000\",\"endDate\":\"1758736800000\",\"state\":\"Complete\",\"status\":\"India won by 41 runs\",\"team1\":{\"teamId\":2,\"teamName\":\"India\",\"teamSName\":\"IND\",\"imageId\":719031},\"team2\":{\"teamId\":6,\"teamName\":\"Bangladesh\",\"teamSName\":\"BAN\",\"imageId\":172120},\"venueInfo\":{\"id\":153,\"ground\":\"Dubai International Cricket Stadium\",\"city\":\"Dubai\",\"timezone\":\"+04:00\",\"latitude\":\"25.046842\",\"longitude\":\"55.218969\"},\"currBatTeamId\":2,\"seriesStartDt\":\"1757376000000\",\"seriesEndDt\":\"1759190400000\",\"isTimeAnnounced\":true,\"stateTitle\":\"IND Won\"}', '2025-09-28 09:39:18'),
(130157, '130157', 'Super Fours, 17th Match (A2 v B2)', '3', 'Pakistan', '6', 'Bangladesh', '153', 'Dubai International Cricket Stadium', 'Dubai', '2025-09-25 20:00:00', 'Pakistan won by 11 runs', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":130157,\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\",\"matchDesc\":\"Super Fours, 17th Match (A2 v B2)\",\"matchFormat\":\"T20\",\"startDate\":\"1758810600000\",\"endDate\":\"1758823200000\",\"state\":\"Complete\",\"status\":\"Pakistan won by 11 runs\",\"team1\":{\"teamId\":3,\"teamName\":\"Pakistan\",\"teamSName\":\"PAK\",\"imageId\":591986},\"team2\":{\"teamId\":6,\"teamName\":\"Bangladesh\",\"teamSName\":\"BAN\",\"imageId\":172120},\"venueInfo\":{\"id\":153,\"ground\":\"Dubai International Cricket Stadium\",\"city\":\"Dubai\",\"timezone\":\"+04:00\",\"latitude\":\"25.046842\",\"longitude\":\"55.218969\"},\"currBatTeamId\":3,\"seriesStartDt\":\"1757376000000\",\"seriesEndDt\":\"1759190400000\",\"isTimeAnnounced\":true,\"stateTitle\":\"PAK Won\"}', '2025-09-28 09:39:18'),
(130168, '130168', 'Super Fours, 18th Match (A1 v B1)', '2', 'India', '5', 'Sri Lanka', '153', 'Dubai International Cricket Stadium', 'Dubai', '2025-09-26 20:00:00', 'Match tied (India Won the Super Over)', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":130168,\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\",\"matchDesc\":\"Super Fours, 18th Match (A1 v B1)\",\"matchFormat\":\"T20\",\"startDate\":\"1758897000000\",\"endDate\":\"1758909600000\",\"state\":\"Complete\",\"status\":\"Match tied (India Won the Super Over)\",\"team1\":{\"teamId\":2,\"teamName\":\"India\",\"teamSName\":\"IND\",\"imageId\":719031},\"team2\":{\"teamId\":5,\"teamName\":\"Sri Lanka\",\"teamSName\":\"SL\",\"imageId\":172119},\"venueInfo\":{\"id\":153,\"ground\":\"Dubai International Cricket Stadium\",\"city\":\"Dubai\",\"timezone\":\"+04:00\",\"latitude\":\"25.046842\",\"longitude\":\"55.218969\"},\"seriesStartDt\":\"1757376000000\",\"seriesEndDt\":\"1759190400000\",\"isTimeAnnounced\":true,\"stateTitle\":\"Complete\"}', '2025-09-28 09:39:18'),
(130993, '130993', '1st Youth ODI', '129', 'Australia U19', '54', 'India U19', '732', 'Ian Healy Oval', 'Brisbane', '2025-09-21 09:30:00', 'India U19 won by 7 wkts', NULL, NULL, NULL, NULL, NULL, 'ODI', '{\"matchId\":130993,\"seriesId\":10636,\"seriesName\":\"India Under 19 tour of Australia, 2025\",\"matchDesc\":\"1st Youth ODI\",\"matchFormat\":\"ODI\",\"startDate\":\"1758427200000\",\"endDate\":\"1758456000000\",\"state\":\"Complete\",\"status\":\"India U19 won by 7 wkts\",\"team1\":{\"teamId\":129,\"teamName\":\"Australia U19\",\"teamSName\":\"AUSU19\",\"imageId\":172204},\"team2\":{\"teamId\":54,\"teamName\":\"India U19\",\"teamSName\":\"INDU19\",\"imageId\":172155},\"venueInfo\":{\"id\":732,\"ground\":\"Ian Healy Oval\",\"city\":\"Brisbane\",\"timezone\":\"+10:00\",\"latitude\":\"-27.40523\",\"longitude\":\"153.04421\"},\"currBatTeamId\":54,\"seriesStartDt\":\"1758412800000\",\"seriesEndDt\":\"1760227200000\",\"isTimeAnnounced\":true,\"stateTitle\":\"INDU19 Won\"}', '2025-09-28 09:39:18'),
(130998, '130998', '2nd Youth ODI', '54', 'India U19', '129', 'Australia U19', '732', 'Ian Healy Oval', 'Brisbane', '2025-09-24 09:30:00', 'India U19 won by 51 runs', NULL, NULL, NULL, NULL, NULL, 'ODI', '{\"matchId\":130998,\"seriesId\":10636,\"seriesName\":\"India Under 19 tour of Australia, 2025\",\"matchDesc\":\"2nd Youth ODI\",\"matchFormat\":\"ODI\",\"startDate\":\"1758686400000\",\"endDate\":\"1758715200000\",\"state\":\"Complete\",\"status\":\"India U19 won by 51 runs\",\"team1\":{\"teamId\":54,\"teamName\":\"India U19\",\"teamSName\":\"INDU19\",\"imageId\":172155},\"team2\":{\"teamId\":129,\"teamName\":\"Australia U19\",\"teamSName\":\"AUSU19\",\"imageId\":172204},\"venueInfo\":{\"id\":732,\"ground\":\"Ian Healy Oval\",\"city\":\"Brisbane\",\"timezone\":\"+10:00\",\"latitude\":\"-27.40523\",\"longitude\":\"153.04421\"},\"currBatTeamId\":54,\"seriesStartDt\":\"1758412800000\",\"seriesEndDt\":\"1760227200000\",\"isTimeAnnounced\":true,\"stateTitle\":\"INDU19 Won\"}', '2025-09-28 09:39:18'),
(131009, '131009', '3rd Youth ODI', '54', 'India U19', '129', 'Australia U19', '732', 'Ian Healy Oval', 'Brisbane', '2025-09-26 09:30:00', 'India U19 won by 167 runs', NULL, NULL, NULL, NULL, NULL, 'ODI', '{\"matchId\":131009,\"seriesId\":10636,\"seriesName\":\"India Under 19 tour of Australia, 2025\",\"matchDesc\":\"3rd Youth ODI\",\"matchFormat\":\"ODI\",\"startDate\":\"1758859200000\",\"endDate\":\"1758888000000\",\"state\":\"Complete\",\"status\":\"India U19 won by 167 runs\",\"team1\":{\"teamId\":54,\"teamName\":\"India U19\",\"teamSName\":\"INDU19\",\"imageId\":172155},\"team2\":{\"teamId\":129,\"teamName\":\"Australia U19\",\"teamSName\":\"AUSU19\",\"imageId\":172204},\"venueInfo\":{\"id\":732,\"ground\":\"Ian Healy Oval\",\"city\":\"Brisbane\",\"timezone\":\"+10:00\",\"latitude\":\"-27.40523\",\"longitude\":\"153.04421\"},\"currBatTeamId\":54,\"seriesStartDt\":\"1758412800000\",\"seriesEndDt\":\"1760227200000\",\"isTimeAnnounced\":true,\"stateTitle\":\"INDU19 Won\"}', '2025-09-28 09:39:18'),
(133484, '133484', '5th Match', '87', 'Western Australia', '164', 'Queensland', '300', 'Allan Border Field', 'Brisbane', '2025-09-21 09:30:00', 'Queensland won by 2 wkts', NULL, NULL, NULL, NULL, NULL, 'ODI', '{\"matchId\":133484,\"seriesId\":10829,\"seriesName\":\"Australia Domestic One-Day Cup 2025-26\",\"matchDesc\":\"5th Match\",\"matchFormat\":\"ODI\",\"startDate\":\"1758427200000\",\"endDate\":\"1758456000000\",\"state\":\"Complete\",\"status\":\"Queensland won by 2 wkts\",\"team1\":{\"teamId\":87,\"teamName\":\"Western Australia\",\"teamSName\":\"WA\",\"imageId\":172180},\"team2\":{\"teamId\":164,\"teamName\":\"Queensland\",\"teamSName\":\"QL\",\"imageId\":172233},\"venueInfo\":{\"id\":300,\"ground\":\"Allan Border Field\",\"city\":\"Brisbane\",\"timezone\":\"+10:00\",\"latitude\":\"-27.435145\",\"longitude\":\"153.046143\"},\"currBatTeamId\":164,\"seriesStartDt\":\"1757980800000\",\"seriesEndDt\":\"1772409600000\",\"isTimeAnnounced\":true,\"stateTitle\":\"QL Won\"}', '2025-09-28 09:39:18'),
(133495, '133495', '6th Match', '87', 'Western Australia', '158', 'South Australia', '527', 'Karen Rolton Oval', 'Adelaide, South Australia', '2025-09-24 06:00:00', 'Western Australia won by 66 runs', NULL, NULL, NULL, NULL, NULL, 'ODI', '{\"matchId\":133495,\"seriesId\":10829,\"seriesName\":\"Australia Domestic One-Day Cup 2025-26\",\"matchDesc\":\"6th Match\",\"matchFormat\":\"ODI\",\"startDate\":\"1758673800000\",\"endDate\":\"1758702600000\",\"state\":\"Complete\",\"status\":\"Western Australia won by 66 runs\",\"team1\":{\"teamId\":87,\"teamName\":\"Western Australia\",\"teamSName\":\"WA\",\"imageId\":172180},\"team2\":{\"teamId\":158,\"teamName\":\"South Australia\",\"teamSName\":\"SAUS\",\"imageId\":172225},\"venueInfo\":{\"id\":527,\"ground\":\"Karen Rolton Oval\",\"city\":\"Adelaide, South Australia\",\"timezone\":\"+10:30\",\"latitude\":\"-34.9191215\",\"longitude\":\"138.5815232\"},\"currBatTeamId\":87,\"seriesStartDt\":\"1757980800000\",\"seriesEndDt\":\"1772409600000\",\"isTimeAnnounced\":true,\"stateTitle\":\"WA Won\"}', '2025-09-28 09:39:18'),
(134760, '134760', '1st Match, Group A', '161', 'Namibia', '14', 'Kenya', '69', 'Harare Sports Club', 'Harare', '2025-09-26 13:00:00', 'Namibia won by 136 runs', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":134760,\"seriesId\":10944,\"seriesName\":\"ICC Mens T20 World Cup Africa Regional Final 2025\",\"matchDesc\":\"1st Match, Group A\",\"matchFormat\":\"T20\",\"startDate\":\"1758871800000\",\"endDate\":\"1758884400000\",\"state\":\"Complete\",\"status\":\"Namibia won by 136 runs\",\"team1\":{\"teamId\":161,\"teamName\":\"Namibia\",\"teamSName\":\"NAM\",\"imageId\":172229},\"team2\":{\"teamId\":14,\"teamName\":\"Kenya\",\"teamSName\":\"KEN\",\"imageId\":172129},\"venueInfo\":{\"id\":69,\"ground\":\"Harare Sports Club\",\"city\":\"Harare\",\"timezone\":\"+02:00\",\"latitude\":\"-17.814114\",\"longitude\":\"31.050962\"},\"currBatTeamId\":161,\"seriesStartDt\":\"1758844800000\",\"seriesEndDt\":\"1759708800000\",\"isTimeAnnounced\":true,\"stateTitle\":\"NAM Won\"}', '2025-09-28 09:39:18'),
(134771, '134771', '2nd Match, Group A', '553', 'Malawi', '536', 'Nigeria', '762', 'Takashinga Sports Club', 'Harare', '2025-09-26 13:00:00', 'Nigeria won by 9 wkts', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":134771,\"seriesId\":10944,\"seriesName\":\"ICC Mens T20 World Cup Africa Regional Final 2025\",\"matchDesc\":\"2nd Match, Group A\",\"matchFormat\":\"T20\",\"startDate\":\"1758871800000\",\"endDate\":\"1758884400000\",\"state\":\"Complete\",\"status\":\"Nigeria won by 9 wkts\",\"team1\":{\"teamId\":553,\"teamName\":\"Malawi\",\"teamSName\":\"MWI\",\"imageId\":172605},\"team2\":{\"teamId\":536,\"teamName\":\"Nigeria\",\"teamSName\":\"NGA\",\"imageId\":248436},\"venueInfo\":{\"id\":762,\"ground\":\"Takashinga Sports Club\",\"city\":\"Harare\",\"timezone\":\"+02:00\",\"latitude\":\"-17.88849\",\"longitude\":\"30.99021\"},\"currBatTeamId\":536,\"seriesStartDt\":\"1758844800000\",\"seriesEndDt\":\"1759708800000\",\"isTimeAnnounced\":true,\"stateTitle\":\"NGA Won\"}', '2025-09-28 09:39:18'),
(134777, '134777', '3rd Match, Group B', '44', 'Uganda', '12', 'Zimbabwe', '69', 'Harare Sports Club', 'Harare', '2025-09-26 17:20:00', 'Zimbabwe won by 5 wkts', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":134777,\"seriesId\":10944,\"seriesName\":\"ICC Mens T20 World Cup Africa Regional Final 2025\",\"matchDesc\":\"3rd Match, Group B\",\"matchFormat\":\"T20\",\"startDate\":\"1758887400000\",\"endDate\":\"1758900000000\",\"state\":\"Complete\",\"status\":\"Zimbabwe won by 5 wkts\",\"team1\":{\"teamId\":44,\"teamName\":\"Uganda\",\"teamSName\":\"UGA\",\"imageId\":495000},\"team2\":{\"teamId\":12,\"teamName\":\"Zimbabwe\",\"teamSName\":\"ZIM\",\"imageId\":172127},\"venueInfo\":{\"id\":69,\"ground\":\"Harare Sports Club\",\"city\":\"Harare\",\"timezone\":\"+02:00\",\"latitude\":\"-17.814114\",\"longitude\":\"31.050962\"},\"currBatTeamId\":12,\"seriesStartDt\":\"1758844800000\",\"seriesEndDt\":\"1759708800000\",\"isTimeAnnounced\":true,\"stateTitle\":\"ZIM Won\"}', '2025-09-28 09:39:18'),
(134782, '134782', '4th Match, Group B', '529', 'Botswana', '535', 'Tanzania', '762', 'Takashinga Sports Club', 'Harare', '2025-09-26 17:20:00', 'Tanzania won by 7 wkts', NULL, NULL, NULL, NULL, NULL, 'T20', '{\"matchId\":134782,\"seriesId\":10944,\"seriesName\":\"ICC Mens T20 World Cup Africa Regional Final 2025\",\"matchDesc\":\"4th Match, Group B\",\"matchFormat\":\"T20\",\"startDate\":\"1758887400000\",\"endDate\":\"1758900000000\",\"state\":\"Complete\",\"status\":\"Tanzania won by 7 wkts\",\"team1\":{\"teamId\":529,\"teamName\":\"Botswana\",\"teamSName\":\"BW\",\"imageId\":172579},\"team2\":{\"teamId\":535,\"teamName\":\"Tanzania\",\"teamSName\":\"TAN\",\"imageId\":172586},\"venueInfo\":{\"id\":762,\"ground\":\"Takashinga Sports Club\",\"city\":\"Harare\",\"timezone\":\"+02:00\",\"latitude\":\"-17.88849\",\"longitude\":\"30.99021\"},\"currBatTeamId\":535,\"seriesStartDt\":\"1758844800000\",\"seriesEndDt\":\"1759708800000\",\"isTimeAnnounced\":true,\"stateTitle\":\"TAN Won\"}', '2025-09-28 09:39:18');

-- --------------------------------------------------------

--
-- Table structure for table `partnerships`
--

CREATE TABLE `partnerships` (
  `id` int(11) NOT NULL,
  `match_id` varchar(64) DEFAULT NULL,
  `innings_number` int(11) DEFAULT NULL,
  `batsman1_id` varchar(64) DEFAULT NULL,
  `batsman2_id` varchar(64) DEFAULT NULL,
  `batsman1_name` varchar(128) DEFAULT NULL,
  `batsman2_name` varchar(128) DEFAULT NULL,
  `partnership_runs` int(11) DEFAULT NULL,
  `raw_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_json`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `partnerships`
--

INSERT INTO `partnerships` (`id`, `match_id`, `innings_number`, `batsman1_id`, `batsman2_id`, `batsman1_name`, `batsman2_name`, `partnership_runs`, `raw_json`, `created_at`) VALUES
(1, '130168', 1, '11808', '1413', 'Shubman Gill', 'Virat Kohli', 85, '{\"matchId\":130168,\"innings\":1,\"batsman1Id\":\"11808\",\"batsman2Id\":\"1413\",\"batsman1Name\":\"Shubman Gill\",\"batsman2Name\":\"Virat Kohli\",\"runs\":85}', '2025-09-28 10:04:46'),
(2, '130168', 1, '1413', '576', 'Virat Kohli', 'Rohit Sharma', 42, '{\"matchId\":130168,\"innings\":1,\"batsman1Id\":\"1413\",\"batsman2Id\":\"576\",\"batsman1Name\":\"Virat Kohli\",\"batsman2Name\":\"Rohit Sharma\",\"runs\":42}', '2025-09-28 10:04:46'),
(3, '130168', 2, '10896', '14504', 'Rinku Singh', 'Tilak Varma', 60, '{\"matchId\":130168,\"innings\":2,\"batsman1Id\":\"10896\",\"batsman2Id\":\"14504\",\"runs\":60}', '2025-09-28 10:04:46'),
(4, '130140', 1, '9429', '9716', 'Sarfaraz Khan', 'Abhimanyu Easwaran', 48, '{\"matchId\":130140,\"innings\":1,\"batsman1Id\":\"9429\",\"batsman2Id\":\"9716\",\"runs\":48}', '2025-09-28 10:04:46'),
(5, '130140', 2, '8292', '13217', 'Kuldeep Yadav', 'Arshdeep Singh', 55, '{\"matchId\":130140,\"innings\":2,\"batsman1Id\":\"8292\",\"batsman2Id\":\"13217\",\"runs\":55}', '2025-09-28 10:04:46'),
(6, '130157', 1, '9311', '10808', 'Jasprit Bumrah', 'Mohammed Siraj', 30, '{\"matchId\":130157,\"innings\":1,\"batsman1Id\":\"9311\",\"batsman2Id\":\"10808\",\"runs\":30}', '2025-09-28 10:04:46'),
(7, '130157', 2, '14659', '10754', 'Ravi Bishnoi', 'Mukesh Kumar', 22, '{\"matchId\":130157,\"innings\":2,\"batsman1Id\":\"14659\",\"batsman2Id\":\"10754\",\"runs\":22}', '2025-09-28 10:04:46'),
(8, '130129', 1, '8799', '9428', 'FictionalA', 'Shreyas Iyer', 70, '{\"matchId\":130129,\"innings\":1,\"batsman1Id\":\"8799\",\"batsman2Id\":\"9428\",\"batsman1Name\":\"FictionalA\",\"batsman2Name\":\"Shreyas Iyer\",\"runs\":70}', '2025-09-28 10:04:46'),
(9, '130129', 2, '8733', '11813', 'KL Rahul', 'Ruturaj Gaikwad', 95, '{\"matchId\":130129,\"innings\":2,\"batsman1Id\":\"8733\",\"batsman2Id\":\"11813\",\"batsman1Name\":\"KL Rahul\",\"batsman2Name\":\"Ruturaj Gaikwad\",\"runs\":95}', '2025-09-28 10:04:46'),
(10, '130146', 1, '576', '1413', 'Rohit Sharma', 'Virat Kohli', 101, '{\"matchId\":130146,\"innings\":1,\"batsman1Id\":\"576\",\"batsman2Id\":\"1413\",\"runs\":101}', '2025-09-28 10:04:46'),
(11, '121345', 1, '72A', '72B', 'NEP_Player1', 'NEP_Player2', 74, '{\"matchId\":121345,\"innings\":1,\"batsman1Id\":\"72A\",\"batsman2Id\":\"72B\",\"batsman1Name\":\"NEP_Player1\",\"batsman2Name\":\"NEP_Player2\",\"runs\":74}', '2025-09-28 10:04:46'),
(12, '121345', 2, '10A', '10B', 'WI_Player1', 'WI_Player2', 50, '{\"matchId\":121345,\"innings\":2,\"batsman1Id\":\"10A\",\"batsman2Id\":\"10B\",\"runs\":50}', '2025-09-28 10:04:46'),
(13, '134782', 1, '529A', '529B', 'BotswanaPlayer1', 'BotswanaPlayer2', 45, '{\"matchId\":134782,\"innings\":1,\"batsman1Id\":\"529A\",\"batsman2Id\":\"529B\",\"runs\":45}', '2025-09-28 10:04:46'),
(14, '134782', 2, '535A', '535B', 'TanzaniaPlayer1', 'TanzaniaPlayer2', 68, '{\"matchId\":134782,\"innings\":2,\"batsman1Id\":\"535A\",\"batsman2Id\":\"535B\",\"runs\":68}', '2025-09-28 10:04:46'),
(15, '134760', 1, '161A', '161B', 'NamibiaPlayer1', 'NamibiaPlayer2', 120, '{\"matchId\":134760,\"innings\":1,\"batsman1Id\":\"161A\",\"batsman2Id\":\"161B\",\"runs\":120}', '2025-09-28 10:04:46'),
(16, '134760', 2, '14A', '14B', 'KenyaPlayer1', 'KenyaPlayer2', 35, '{\"matchId\":134760,\"innings\":2,\"batsman1Id\":\"14A\",\"batsman2Id\":\"14B\",\"runs\":35}', '2025-09-28 10:04:46'),
(17, '116828', 1, '159A', '159B', 'GuyanaBats1', 'GuyanaBats2', 54, '{\"matchId\":116828,\"innings\":1,\"batsman1Id\":\"159A\",\"batsman2Id\":\"159B\",\"runs\":54}', '2025-09-28 10:04:46'),
(18, '116828', 2, '271A', '271B', 'TrinbagoB1', 'TrinbagoB2', 66, '{\"matchId\":116828,\"innings\":2,\"batsman1Id\":\"271A\",\"batsman2Id\":\"271B\",\"runs\":66}', '2025-09-28 10:04:46'),
(19, '131009', 1, '54A', '54B', 'IndiaU19_B1', 'IndiaU19_B2', 136, '{\"matchId\":131009,\"innings\":1,\"batsman1Id\":\"54A\",\"batsman2Id\":\"54B\",\"runs\":136}', '2025-09-28 10:04:46'),
(20, '130998', 1, '129A', '54C', 'AUSU19_B1', 'IndiaU19_B1', 142, '{\"matchId\":130998,\"innings\":1,\"batsman1Id\":\"129A\",\"batsman2Id\":\"54C\",\"runs\":142}', '2025-09-28 10:04:46');

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `player_id` varchar(64) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `country` varchar(128) DEFAULT NULL,
  `team_id` varchar(64) DEFAULT NULL,
  `playing_role` varchar(64) DEFAULT NULL,
  `batting_style` varchar(64) DEFAULT NULL,
  `bowling_style` varchar(64) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `image_url` varchar(512) DEFAULT NULL,
  `raw_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_json`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`id`, `player_id`, `name`, `full_name`, `country`, `team_id`, `playing_role`, `batting_style`, `bowling_style`, `dob`, `image_url`, `raw_json`, `created_at`) VALUES
(1, '11808', 'Shubman Gill', 'Shubman Gill', 'India', '2', 'Batsman', 'Right-hand bat', 'Right-arm offbreak', NULL, 'https://www.cricbuzz.com/static/img/players/616515.jpg', '{\"id\":\"11808\",\"name\":\"Shubman Gill\",\"imageId\":616515,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm offbreak\"}', '2025-09-28 09:21:12'),
(2, '13940', 'Yashasvi Jaiswal', 'Yashasvi Jaiswal', 'India', '2', 'Batsman', 'Left-hand bat', 'Right-arm legbreak', NULL, 'https://www.cricbuzz.com/static/img/players/591942.jpg', '{\"id\":\"13940\",\"name\":\"Yashasvi Jaiswal\",\"imageId\":591942,\"battingStyle\":\"Left-hand bat\",\"bowlingStyle\":\"Right-arm legbreak\"}', '2025-09-28 09:21:12'),
(3, '13866', 'Sai Sudharsan', 'Sai Sudharsan', 'India', '2', 'Batsman', 'Left-hand bat', 'Right-arm legbreak', NULL, 'https://www.cricbuzz.com/static/img/players/717782.jpg', '{\"id\":\"13866\",\"name\":\"Sai Sudharsan\",\"imageId\":717782,\"battingStyle\":\"Left-hand bat\",\"bowlingStyle\":\"Right-arm legbreak\"}', '2025-09-28 09:21:12'),
(4, '576', 'Rohit Sharma', 'Rohit Sharma', 'India', '2', 'Batsman', 'Right-hand bat', 'Right-arm offbreak', NULL, 'https://www.cricbuzz.com/static/img/players/616514.jpg', '{\"id\":\"576\",\"name\":\"Rohit Sharma\",\"imageId\":616514,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm offbreak\"}', '2025-09-28 09:21:12'),
(5, '1413', 'Virat Kohli', 'Virat Kohli', 'India', '2', 'Batsman', 'Right-hand bat', 'Right-arm medium', NULL, 'https://www.cricbuzz.com/static/img/players/616517.jpg', '{\"id\":\"1413\",\"name\":\"Virat Kohli\",\"imageId\":616517,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm medium\"}', '2025-09-28 09:21:12'),
(6, '7915', 'Suryakumar Yadav', 'Suryakumar Yadav', 'India', '2', 'Batsman', 'Right-hand bat', 'Right-arm offbreak', NULL, 'https://www.cricbuzz.com/static/img/players/352481.jpg', '{\"id\":\"7915\",\"name\":\"Suryakumar Yadav\",\"imageId\":352481,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm offbreak\"}', '2025-09-28 09:21:12'),
(7, '9428', 'Shreyas Iyer', 'Shreyas Iyer', 'India', '2', 'Batsman', 'Right-hand bat', 'Right-arm legbreak', NULL, 'https://www.cricbuzz.com/static/img/players/616518.jpg', '{\"id\":\"9428\",\"name\":\"Shreyas Iyer\",\"imageId\":616518,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm legbreak\"}', '2025-09-28 09:21:12'),
(8, '10896', 'Rinku Singh', 'Rinku Singh', 'India', '2', 'Batsman', 'Left-hand bat', 'Right-arm offbreak', NULL, 'https://www.cricbuzz.com/static/img/players/279125.jpg', '{\"id\":\"10896\",\"name\":\"Rinku Singh\",\"imageId\":279125,\"battingStyle\":\"Left-hand bat\",\"bowlingStyle\":\"Right-arm offbreak\"}', '2025-09-28 09:21:12'),
(9, '14504', 'Tilak Varma', 'Tilak Varma', 'India', '2', 'Batsman', 'Left-hand bat', 'Right-arm offbreak', NULL, 'https://www.cricbuzz.com/static/img/players/226525.jpg', '{\"id\":\"14504\",\"name\":\"Tilak Varma\",\"imageId\":226525,\"battingStyle\":\"Left-hand bat\",\"bowlingStyle\":\"Right-arm offbreak\"}', '2025-09-28 09:21:12'),
(10, '11813', 'Ruturaj Gaikwad', 'Ruturaj Gaikwad', 'India', '2', 'Batsman', 'Right-hand bat', 'Right-arm offbreak', NULL, 'https://www.cricbuzz.com/static/img/players/333874.jpg', '{\"id\":\"11813\",\"name\":\"Ruturaj Gaikwad\",\"imageId\":333874,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm offbreak\"}', '2025-09-28 09:21:12'),
(11, '10636', 'Rajat Patidar', 'Rajat Patidar', 'India', '2', 'Batsman', 'Right-hand bat', 'Right-arm offbreak', NULL, 'https://www.cricbuzz.com/static/img/players/760758.jpg', '{\"id\":\"10636\",\"name\":\"Rajat Patidar\",\"imageId\":760758,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm offbreak\"}', '2025-09-28 09:21:12'),
(12, '9429', 'Sarfaraz Khan', 'Sarfaraz Khan', 'India', '2', 'Batsman', 'Right-hand bat', 'Right-arm legbreak', NULL, 'https://www.cricbuzz.com/static/img/players/591955.jpg', '{\"id\":\"9429\",\"name\":\"Sarfaraz Khan\",\"imageId\":591955,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm legbreak\"}', '2025-09-28 09:21:12'),
(13, '9716', 'Abhimanyu Easwaran', 'Abhimanyu Easwaran', 'India', '2', 'Batsman', 'Right-hand bat', 'Right-arm legbreak', NULL, 'https://www.cricbuzz.com/static/img/players/591956.jpg', '{\"id\":\"9716\",\"name\":\"Abhimanyu Easwaran\",\"imageId\":591956,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm legbreak\"}', '2025-09-28 09:21:12'),
(14, '8257', 'Karun Nair', 'Karun Nair', 'India', '2', 'Batsman', 'Right-hand bat', 'Right-arm offbreak', NULL, 'https://www.cricbuzz.com/static/img/players/717781.jpg', '{\"id\":\"8257\",\"name\":\"Karun Nair\",\"imageId\":717781,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm offbreak\"}', '2025-09-28 09:21:12'),
(15, '14701', 'Nitish Kumar Reddy', 'Nitish Kumar Reddy', 'India', '2', 'All-rounder', 'Right-hand bat', 'Right-arm fast-medium', NULL, 'https://www.cricbuzz.com/static/img/players/591947.jpg', '{\"id\":\"14701\",\"name\":\"Nitish Kumar Reddy\",\"imageId\":591947,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm fast-medium\"}', '2025-09-28 09:21:12'),
(16, '9647', 'Hardik Pandya', 'Hardik Pandya', 'India', '2', 'All-rounder', 'Right-hand bat', 'Right-arm fast-medium', NULL, 'https://www.cricbuzz.com/static/img/players/616519.jpg', '{\"id\":\"9647\",\"name\":\"Hardik Pandya\",\"imageId\":616519,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm fast-medium\"}', '2025-09-28 09:21:12'),
(17, '11195', 'Shivam Dube', 'Shivam Dube', 'India', '2', 'All-rounder', 'Left-hand bat', 'Right-arm medium', NULL, 'https://www.cricbuzz.com/static/img/players/593805.jpg', '{\"id\":\"11195\",\"name\":\"Shivam Dube\",\"imageId\":593805,\"battingStyle\":\"Left-hand bat\",\"bowlingStyle\":\"Right-arm medium\"}', '2025-09-28 09:21:12'),
(18, '12086', 'Abhishek Sharma', 'Abhishek Sharma', 'India', '2', 'All-rounder', 'Left-hand bat', 'Left-arm orthodox', NULL, 'https://www.cricbuzz.com/static/img/players/153963.jpg', '{\"id\":\"12086\",\"name\":\"Abhishek Sharma\",\"imageId\":153963,\"battingStyle\":\"Left-hand bat\",\"bowlingStyle\":\"Left-arm orthodox\"}', '2025-09-28 09:21:12'),
(19, '587', 'Ravindra Jadeja', 'Ravindra Jadeja', 'India', '2', 'All-rounder', 'Left-hand bat', 'Left-arm orthodox', NULL, 'https://www.cricbuzz.com/static/img/players/616520.jpg', '{\"id\":\"587\",\"name\":\"Ravindra Jadeja\",\"imageId\":616520,\"battingStyle\":\"Left-hand bat\",\"bowlingStyle\":\"Left-arm orthodox\"}', '2025-09-28 09:21:12'),
(20, '8683', 'Shardul Thakur', 'Shardul Thakur', 'India', '2', 'All-rounder', 'Right-hand bat', 'Right-arm fast-medium', NULL, 'https://www.cricbuzz.com/static/img/players/352487.jpg', '{\"id\":\"8683\",\"name\":\"Shardul Thakur\",\"imageId\":352487,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm fast-medium\"}', '2025-09-28 09:21:12'),
(21, '10945', 'Washington Sundar', 'Washington Sundar', 'India', '2', 'All-rounder', 'Left-hand bat', 'Right-arm offbreak', NULL, 'https://www.cricbuzz.com/static/img/players/616522.jpg', '{\"id\":\"10945\",\"name\":\"Washington Sundar\",\"imageId\":616522,\"battingStyle\":\"Left-hand bat\",\"bowlingStyle\":\"Right-arm offbreak\"}', '2025-09-28 09:21:12'),
(22, '8808', 'Axar Patel', 'Axar Patel', 'India', '2', 'All-rounder', 'Left-hand bat', 'Left-arm orthodox', NULL, 'https://www.cricbuzz.com/static/img/players/616521.jpg', '{\"id\":\"8808\",\"name\":\"Axar Patel\",\"imageId\":616521,\"battingStyle\":\"Left-hand bat\",\"bowlingStyle\":\"Left-arm orthodox\"}', '2025-09-28 09:21:12'),
(23, '10744', 'Rishabh Pant', 'Rishabh Pant', 'India', '2', 'Wicket-keeper', 'Left-hand bat', NULL, NULL, 'https://www.cricbuzz.com/static/img/players/616524.jpg', '{\"id\":\"10744\",\"name\":\"Rishabh Pant\",\"imageId\":616524,\"battingStyle\":\"Left-hand bat\"}', '2025-09-28 09:21:12'),
(24, '8733', 'KL Rahul', 'KL Rahul', 'India', '2', 'Wicket-keeper', 'Right-hand bat', NULL, NULL, 'https://www.cricbuzz.com/static/img/players/616523.jpg', '{\"id\":\"8733\",\"name\":\"KL Rahul\",\"imageId\":616523,\"battingStyle\":\"Right-hand bat\"}', '2025-09-28 09:21:12'),
(25, '14691', 'Dhruv Jurel', 'Dhruv Jurel', 'India', '2', 'Wicket-keeper', 'Right-hand bat', NULL, NULL, 'https://www.cricbuzz.com/static/img/players/591954.jpg', '{\"id\":\"14691\",\"name\":\"Dhruv Jurel\",\"imageId\":591954,\"battingStyle\":\"Right-hand bat\"}', '2025-09-28 09:21:12'),
(26, '8271', 'Sanju Samson', 'Sanju Samson', 'India', '2', 'Wicket-keeper', 'Right-hand bat', NULL, NULL, 'https://www.cricbuzz.com/static/img/players/226289.jpg', '{\"id\":\"8271\",\"name\":\"Sanju Samson\",\"imageId\":226289,\"battingStyle\":\"Right-hand bat\"}', '2025-09-28 09:21:12'),
(27, '10276', 'Ishan Kishan', 'Ishan Kishan', 'India', '2', 'Wicket-keeper', 'Left-hand bat', NULL, NULL, 'https://www.cricbuzz.com/static/img/players/352492.jpg', '{\"id\":\"10276\",\"name\":\"Ishan Kishan\",\"imageId\":352492,\"battingStyle\":\"Left-hand bat\"}', '2025-09-28 09:21:12'),
(28, '10808', 'Mohammed Siraj', 'Mohammed Siraj', 'India', '2', 'Bowler', 'Right-hand bat', 'Right-arm fast', NULL, 'https://www.cricbuzz.com/static/img/players/591952.jpg', '{\"id\":\"10808\",\"name\":\"Mohammed Siraj\",\"imageId\":591952,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm fast\"}', '2025-09-28 09:21:12'),
(29, '9311', 'Jasprit Bumrah', 'Jasprit Bumrah', 'India', '2', 'Bowler', 'Right-hand bat', 'Right-arm fast', NULL, 'https://www.cricbuzz.com/static/img/players/591949.jpg', '{\"id\":\"9311\",\"name\":\"Jasprit Bumrah\",\"imageId\":591949,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm fast\"}', '2025-09-28 09:21:12'),
(30, '10551', 'Prasidh Krishna', 'Prasidh Krishna', 'India', '2', 'Bowler', 'Right-hand bat', 'Right-arm fast', NULL, 'https://www.cricbuzz.com/static/img/players/591958.jpg', '{\"id\":\"10551\",\"name\":\"Prasidh Krishna\",\"imageId\":591958,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm fast\"}', '2025-09-28 09:21:12'),
(31, '14726', 'Akash Deep', 'Akash Deep', 'India', '2', 'Bowler', 'Right-hand bat', 'Right-arm fast-medium', NULL, 'https://www.cricbuzz.com/static/img/players/591951.jpg', '{\"id\":\"14726\",\"name\":\"Akash Deep\",\"imageId\":591951,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm fast-medium\"}', '2025-09-28 09:21:12'),
(32, '8292', 'Kuldeep Yadav', 'Kuldeep Yadav', 'India', '2', 'Bowler', 'Left-hand bat', 'Left-arm wrist-spin', NULL, 'https://www.cricbuzz.com/static/img/players/616525.jpg', '{\"id\":\"8292\",\"name\":\"Kuldeep Yadav\",\"imageId\":616525,\"battingStyle\":\"Left-hand bat\",\"bowlingStyle\":\"Left-arm wrist-spin\"}', '2025-09-28 09:21:12'),
(33, '13217', 'Arshdeep Singh', 'Arshdeep Singh', 'India', '2', 'Bowler', 'Left-hand bat', 'Left-arm fast-medium', NULL, 'https://www.cricbuzz.com/static/img/players/616527.jpg', '{\"id\":\"13217\",\"name\":\"Arshdeep Singh\",\"imageId\":616527,\"battingStyle\":\"Left-hand bat\",\"bowlingStyle\":\"Left-arm fast-medium\"}', '2025-09-28 09:21:12'),
(34, '24729', 'Harshit Rana', 'Harshit Rana', 'India', '2', 'Bowler', 'Right-hand bat', 'Right-arm fast-medium', NULL, 'https://www.cricbuzz.com/static/img/players/616529.jpg', '{\"id\":\"24729\",\"name\":\"Harshit Rana\",\"imageId\":616529,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm fast-medium\"}', '2025-09-28 09:21:12'),
(35, '14659', 'Ravi Bishnoi', 'Ravi Bishnoi', 'India', '2', 'Bowler', 'Right-hand bat', 'Right-arm legbreak', NULL, 'https://www.cricbuzz.com/static/img/players/226280.jpg', '{\"id\":\"14659\",\"name\":\"Ravi Bishnoi\",\"imageId\":226280,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm legbreak\"}', '2025-09-28 09:21:12'),
(36, '10754', 'Mukesh Kumar', 'Mukesh Kumar', 'India', '2', 'Bowler', 'Right-hand bat', 'Right-arm fast-medium', NULL, 'https://www.cricbuzz.com/static/img/players/333872.jpg', '{\"id\":\"10754\",\"name\":\"Mukesh Kumar\",\"imageId\":333872,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm fast-medium\"}', '2025-09-28 09:21:12'),
(37, '12926', 'Varun Chakaravarthy', NULL, 'India', NULL, 'Bowler', 'Right-hand bat', 'Right-arm legbreak', NULL, NULL, '{\"id\":\"12926\",\"name\":\"Varun Chakaravarthy\",\"imageId\":616528,\"battingStyle\":\"Right-hand bat\",\"bowlingStyle\":\"Right-arm legbreak\"}', '2025-09-28 10:13:58');

-- --------------------------------------------------------

--
-- Table structure for table `player_stats`
--

CREATE TABLE `player_stats` (
  `id` int(11) NOT NULL,
  `player_id` varchar(64) DEFAULT NULL,
  `format` varchar(16) DEFAULT NULL,
  `matches` int(11) DEFAULT NULL,
  `innings` int(11) DEFAULT NULL,
  `runs` int(11) DEFAULT NULL,
  `highest` int(11) DEFAULT NULL,
  `batting_avg` decimal(7,2) DEFAULT NULL,
  `strike_rate` decimal(7,2) DEFAULT NULL,
  `centuries` int(11) DEFAULT NULL,
  `fifties` int(11) DEFAULT NULL,
  `balls_faced` int(11) DEFAULT NULL,
  `wickets` int(11) DEFAULT NULL,
  `bowling_avg` decimal(7,2) DEFAULT NULL,
  `economy` decimal(7,2) DEFAULT NULL,
  `catches` int(11) DEFAULT NULL,
  `stumpings` int(11) DEFAULT NULL,
  `raw_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_json`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_stats`
--

INSERT INTO `player_stats` (`id`, `player_id`, `format`, `matches`, `innings`, `runs`, `highest`, `batting_avg`, `strike_rate`, `centuries`, `fifties`, `balls_faced`, `wickets`, `bowling_avg`, `economy`, `catches`, `stumpings`, `raw_json`, `created_at`) VALUES
(1, '12926', 'Test', 0, 0, 0, 0, 0.00, 0.00, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"0\",\"4\",\"23\",\"83\"]},{\"values\":[\"Innings\",\"0\",\"0\",\"3\",\"13\"]},{\"values\":[\"Runs\",\"0\",\"0\",\"1\",\"26\"]},{\"values\":[\"Balls\",\"0\",\"0\",\"6\",\"47\"]},{\"values\":[\"Highest\",\"0\",\"0\",\"1\",\"10\"]},{\"values\":[\"Average\",\"0\",\"0\",\"0.5\",\"6.5\"]},{\"values\":[\"SR\",\"0\",\"0\",\"16.67\",\"55.32\"]},{\"values\":[\"Not Out\",\"0\",\"0\",\"1\",\"9\"]},{\"values\":[\"Fours\",\"0\",\"0\",\"0\",\"2\"]},{\"values\":[\"Sixes\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"Ducks\",\"0\",\"0\",\"2\",\"1\"]},{\"values\":[\"50s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"100s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"200s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Varun Chakaravarthy Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/12926/varun-chakaravarthy\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20'),
(2, '12926', 'ODI', 4, 0, 0, 0, 0.00, 0.00, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"0\",\"4\",\"23\",\"83\"]},{\"values\":[\"Innings\",\"0\",\"0\",\"3\",\"13\"]},{\"values\":[\"Runs\",\"0\",\"0\",\"1\",\"26\"]},{\"values\":[\"Balls\",\"0\",\"0\",\"6\",\"47\"]},{\"values\":[\"Highest\",\"0\",\"0\",\"1\",\"10\"]},{\"values\":[\"Average\",\"0\",\"0\",\"0.5\",\"6.5\"]},{\"values\":[\"SR\",\"0\",\"0\",\"16.67\",\"55.32\"]},{\"values\":[\"Not Out\",\"0\",\"0\",\"1\",\"9\"]},{\"values\":[\"Fours\",\"0\",\"0\",\"0\",\"2\"]},{\"values\":[\"Sixes\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"Ducks\",\"0\",\"0\",\"2\",\"1\"]},{\"values\":[\"50s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"100s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"200s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Varun Chakaravarthy Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/12926/varun-chakaravarthy\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20'),
(3, '12926', 'T20', 23, 3, 1, 1, 0.50, 16.67, 0, 0, 6, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"0\",\"4\",\"23\",\"83\"]},{\"values\":[\"Innings\",\"0\",\"0\",\"3\",\"13\"]},{\"values\":[\"Runs\",\"0\",\"0\",\"1\",\"26\"]},{\"values\":[\"Balls\",\"0\",\"0\",\"6\",\"47\"]},{\"values\":[\"Highest\",\"0\",\"0\",\"1\",\"10\"]},{\"values\":[\"Average\",\"0\",\"0\",\"0.5\",\"6.5\"]},{\"values\":[\"SR\",\"0\",\"0\",\"16.67\",\"55.32\"]},{\"values\":[\"Not Out\",\"0\",\"0\",\"1\",\"9\"]},{\"values\":[\"Fours\",\"0\",\"0\",\"0\",\"2\"]},{\"values\":[\"Sixes\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"Ducks\",\"0\",\"0\",\"2\",\"1\"]},{\"values\":[\"50s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"100s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"200s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Varun Chakaravarthy Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/12926/varun-chakaravarthy\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20'),
(4, '12926', 'IPL', 83, 13, 26, 10, 6.50, 55.32, 0, 0, 47, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"0\",\"4\",\"23\",\"83\"]},{\"values\":[\"Innings\",\"0\",\"0\",\"3\",\"13\"]},{\"values\":[\"Runs\",\"0\",\"0\",\"1\",\"26\"]},{\"values\":[\"Balls\",\"0\",\"0\",\"6\",\"47\"]},{\"values\":[\"Highest\",\"0\",\"0\",\"1\",\"10\"]},{\"values\":[\"Average\",\"0\",\"0\",\"0.5\",\"6.5\"]},{\"values\":[\"SR\",\"0\",\"0\",\"16.67\",\"55.32\"]},{\"values\":[\"Not Out\",\"0\",\"0\",\"1\",\"9\"]},{\"values\":[\"Fours\",\"0\",\"0\",\"0\",\"2\"]},{\"values\":[\"Sixes\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"Ducks\",\"0\",\"0\",\"2\",\"1\"]},{\"values\":[\"50s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"100s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"200s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Varun Chakaravarthy Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/12926/varun-chakaravarthy\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20'),
(5, '11808', 'Test', 37, 69, 2647, 269, 41.36, 61.43, 9, 7, 4309, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"37\",\"55\",\"27\",\"118\"]},{\"values\":[\"Innings\",\"69\",\"55\",\"27\",\"115\"]},{\"values\":[\"Runs\",\"2647\",\"2775\",\"693\",\"3866\"]},{\"values\":[\"Balls\",\"4309\",\"2787\",\"489\",\"2787\"]},{\"values\":[\"Highest\",\"269\",\"208\",\"126\",\"129\"]},{\"values\":[\"Average\",\"41.36\",\"59.04\",\"28.88\",\"39.45\"]},{\"values\":[\"SR\",\"61.43\",\"99.57\",\"141.72\",\"138.72\"]},{\"values\":[\"Not Out\",\"5\",\"8\",\"3\",\"17\"]},{\"values\":[\"Fours\",\"295\",\"314\",\"76\",\"372\"]},{\"values\":[\"Sixes\",\"43\",\"59\",\"24\",\"119\"]},{\"values\":[\"Ducks\",\"5\",\"1\",\"1\",\"4\"]},{\"values\":[\"50s\",\"7\",\"15\",\"3\",\"26\"]},{\"values\":[\"100s\",\"9\",\"8\",\"1\",\"4\"]},{\"values\":[\"200s\",\"1\",\"1\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Shubman Gill Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/11808/shubman-gill\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20'),
(6, '11808', 'ODI', 55, 55, 2775, 208, 59.04, 99.57, 8, 15, 2787, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"37\",\"55\",\"27\",\"118\"]},{\"values\":[\"Innings\",\"69\",\"55\",\"27\",\"115\"]},{\"values\":[\"Runs\",\"2647\",\"2775\",\"693\",\"3866\"]},{\"values\":[\"Balls\",\"4309\",\"2787\",\"489\",\"2787\"]},{\"values\":[\"Highest\",\"269\",\"208\",\"126\",\"129\"]},{\"values\":[\"Average\",\"41.36\",\"59.04\",\"28.88\",\"39.45\"]},{\"values\":[\"SR\",\"61.43\",\"99.57\",\"141.72\",\"138.72\"]},{\"values\":[\"Not Out\",\"5\",\"8\",\"3\",\"17\"]},{\"values\":[\"Fours\",\"295\",\"314\",\"76\",\"372\"]},{\"values\":[\"Sixes\",\"43\",\"59\",\"24\",\"119\"]},{\"values\":[\"Ducks\",\"5\",\"1\",\"1\",\"4\"]},{\"values\":[\"50s\",\"7\",\"15\",\"3\",\"26\"]},{\"values\":[\"100s\",\"9\",\"8\",\"1\",\"4\"]},{\"values\":[\"200s\",\"1\",\"1\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Shubman Gill Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/11808/shubman-gill\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20'),
(7, '11808', 'T20', 27, 27, 693, 126, 28.88, 141.72, 1, 3, 489, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"37\",\"55\",\"27\",\"118\"]},{\"values\":[\"Innings\",\"69\",\"55\",\"27\",\"115\"]},{\"values\":[\"Runs\",\"2647\",\"2775\",\"693\",\"3866\"]},{\"values\":[\"Balls\",\"4309\",\"2787\",\"489\",\"2787\"]},{\"values\":[\"Highest\",\"269\",\"208\",\"126\",\"129\"]},{\"values\":[\"Average\",\"41.36\",\"59.04\",\"28.88\",\"39.45\"]},{\"values\":[\"SR\",\"61.43\",\"99.57\",\"141.72\",\"138.72\"]},{\"values\":[\"Not Out\",\"5\",\"8\",\"3\",\"17\"]},{\"values\":[\"Fours\",\"295\",\"314\",\"76\",\"372\"]},{\"values\":[\"Sixes\",\"43\",\"59\",\"24\",\"119\"]},{\"values\":[\"Ducks\",\"5\",\"1\",\"1\",\"4\"]},{\"values\":[\"50s\",\"7\",\"15\",\"3\",\"26\"]},{\"values\":[\"100s\",\"9\",\"8\",\"1\",\"4\"]},{\"values\":[\"200s\",\"1\",\"1\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Shubman Gill Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/11808/shubman-gill\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20'),
(8, '11808', 'IPL', 118, 115, 3866, 129, 39.45, 138.72, 4, 26, 2787, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"37\",\"55\",\"27\",\"118\"]},{\"values\":[\"Innings\",\"69\",\"55\",\"27\",\"115\"]},{\"values\":[\"Runs\",\"2647\",\"2775\",\"693\",\"3866\"]},{\"values\":[\"Balls\",\"4309\",\"2787\",\"489\",\"2787\"]},{\"values\":[\"Highest\",\"269\",\"208\",\"126\",\"129\"]},{\"values\":[\"Average\",\"41.36\",\"59.04\",\"28.88\",\"39.45\"]},{\"values\":[\"SR\",\"61.43\",\"99.57\",\"141.72\",\"138.72\"]},{\"values\":[\"Not Out\",\"5\",\"8\",\"3\",\"17\"]},{\"values\":[\"Fours\",\"295\",\"314\",\"76\",\"372\"]},{\"values\":[\"Sixes\",\"43\",\"59\",\"24\",\"119\"]},{\"values\":[\"Ducks\",\"5\",\"1\",\"1\",\"4\"]},{\"values\":[\"50s\",\"7\",\"15\",\"3\",\"26\"]},{\"values\":[\"100s\",\"9\",\"8\",\"1\",\"4\"]},{\"values\":[\"200s\",\"1\",\"1\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Shubman Gill Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/11808/shubman-gill\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20'),
(9, '13940', 'Test', 24, 46, 2209, 214, 50.20, 66.22, 6, 12, 3336, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"24\",\"1\",\"23\",\"66\"]},{\"values\":[\"Innings\",\"46\",\"1\",\"22\",\"66\"]},{\"values\":[\"Runs\",\"2209\",\"15\",\"723\",\"2166\"]},{\"values\":[\"Balls\",\"3336\",\"22\",\"440\",\"1417\"]},{\"values\":[\"Highest\",\"214\",\"15\",\"100\",\"124\"]},{\"values\":[\"Average\",\"50.2\",\"15\",\"36.15\",\"34.38\"]},{\"values\":[\"SR\",\"66.22\",\"68.19\",\"164.32\",\"152.86\"]},{\"values\":[\"Not Out\",\"2\",\"0\",\"2\",\"3\"]},{\"values\":[\"Fours\",\"270\",\"3\",\"82\",\"258\"]},{\"values\":[\"Sixes\",\"43\",\"0\",\"38\",\"92\"]},{\"values\":[\"Ducks\",\"5\",\"0\",\"2\",\"4\"]},{\"values\":[\"50s\",\"12\",\"0\",\"5\",\"15\"]},{\"values\":[\"100s\",\"6\",\"0\",\"1\",\"2\"]},{\"values\":[\"200s\",\"2\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Yashasvi Jaiswal Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/13940/yashasvi-jaiswal\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(10, '13940', 'ODI', 1, 1, 15, 15, 15.00, 68.19, 0, 0, 22, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"24\",\"1\",\"23\",\"66\"]},{\"values\":[\"Innings\",\"46\",\"1\",\"22\",\"66\"]},{\"values\":[\"Runs\",\"2209\",\"15\",\"723\",\"2166\"]},{\"values\":[\"Balls\",\"3336\",\"22\",\"440\",\"1417\"]},{\"values\":[\"Highest\",\"214\",\"15\",\"100\",\"124\"]},{\"values\":[\"Average\",\"50.2\",\"15\",\"36.15\",\"34.38\"]},{\"values\":[\"SR\",\"66.22\",\"68.19\",\"164.32\",\"152.86\"]},{\"values\":[\"Not Out\",\"2\",\"0\",\"2\",\"3\"]},{\"values\":[\"Fours\",\"270\",\"3\",\"82\",\"258\"]},{\"values\":[\"Sixes\",\"43\",\"0\",\"38\",\"92\"]},{\"values\":[\"Ducks\",\"5\",\"0\",\"2\",\"4\"]},{\"values\":[\"50s\",\"12\",\"0\",\"5\",\"15\"]},{\"values\":[\"100s\",\"6\",\"0\",\"1\",\"2\"]},{\"values\":[\"200s\",\"2\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Yashasvi Jaiswal Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/13940/yashasvi-jaiswal\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(11, '13940', 'T20', 23, 22, 723, 100, 36.15, 164.32, 1, 5, 440, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"24\",\"1\",\"23\",\"66\"]},{\"values\":[\"Innings\",\"46\",\"1\",\"22\",\"66\"]},{\"values\":[\"Runs\",\"2209\",\"15\",\"723\",\"2166\"]},{\"values\":[\"Balls\",\"3336\",\"22\",\"440\",\"1417\"]},{\"values\":[\"Highest\",\"214\",\"15\",\"100\",\"124\"]},{\"values\":[\"Average\",\"50.2\",\"15\",\"36.15\",\"34.38\"]},{\"values\":[\"SR\",\"66.22\",\"68.19\",\"164.32\",\"152.86\"]},{\"values\":[\"Not Out\",\"2\",\"0\",\"2\",\"3\"]},{\"values\":[\"Fours\",\"270\",\"3\",\"82\",\"258\"]},{\"values\":[\"Sixes\",\"43\",\"0\",\"38\",\"92\"]},{\"values\":[\"Ducks\",\"5\",\"0\",\"2\",\"4\"]},{\"values\":[\"50s\",\"12\",\"0\",\"5\",\"15\"]},{\"values\":[\"100s\",\"6\",\"0\",\"1\",\"2\"]},{\"values\":[\"200s\",\"2\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Yashasvi Jaiswal Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/13940/yashasvi-jaiswal\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(12, '13940', 'IPL', 66, 66, 2166, 124, 34.38, 152.86, 2, 15, 1417, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"24\",\"1\",\"23\",\"66\"]},{\"values\":[\"Innings\",\"46\",\"1\",\"22\",\"66\"]},{\"values\":[\"Runs\",\"2209\",\"15\",\"723\",\"2166\"]},{\"values\":[\"Balls\",\"3336\",\"22\",\"440\",\"1417\"]},{\"values\":[\"Highest\",\"214\",\"15\",\"100\",\"124\"]},{\"values\":[\"Average\",\"50.2\",\"15\",\"36.15\",\"34.38\"]},{\"values\":[\"SR\",\"66.22\",\"68.19\",\"164.32\",\"152.86\"]},{\"values\":[\"Not Out\",\"2\",\"0\",\"2\",\"3\"]},{\"values\":[\"Fours\",\"270\",\"3\",\"82\",\"258\"]},{\"values\":[\"Sixes\",\"43\",\"0\",\"38\",\"92\"]},{\"values\":[\"Ducks\",\"5\",\"0\",\"2\",\"4\"]},{\"values\":[\"50s\",\"12\",\"0\",\"5\",\"15\"]},{\"values\":[\"100s\",\"6\",\"0\",\"1\",\"2\"]},{\"values\":[\"200s\",\"2\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Yashasvi Jaiswal Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/13940/yashasvi-jaiswal\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(13, '576', 'Test', 67, 116, 4301, 212, 40.58, 57.06, 12, 18, 7538, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"67\",\"273\",\"159\",\"272\"]},{\"values\":[\"Innings\",\"116\",\"265\",\"151\",\"267\"]},{\"values\":[\"Runs\",\"4301\",\"11168\",\"4231\",\"7046\"]},{\"values\":[\"Balls\",\"7538\",\"12034\",\"3003\",\"5334\"]},{\"values\":[\"Highest\",\"212\",\"264\",\"121\",\"109\"]},{\"values\":[\"Average\",\"40.58\",\"48.77\",\"31.34\",\"29.73\"]},{\"values\":[\"SR\",\"57.06\",\"92.81\",\"140.90\",\"132.10\"]},{\"values\":[\"Not Out\",\"10\",\"36\",\"16\",\"30\"]},{\"values\":[\"Fours\",\"473\",\"1044\",\"383\",\"640\"]},{\"values\":[\"Sixes\",\"88\",\"344\",\"205\",\"302\"]},{\"values\":[\"Ducks\",\"6\",\"16\",\"12\",\"18\"]},{\"values\":[\"50s\",\"18\",\"58\",\"32\",\"47\"]},{\"values\":[\"100s\",\"12\",\"32\",\"5\",\"2\"]},{\"values\":[\"200s\",\"1\",\"3\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Rohit Sharma Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/576/rohit-sharma\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(14, '576', 'ODI', 273, 265, 11168, 264, 48.77, 92.81, 32, 58, 12034, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"67\",\"273\",\"159\",\"272\"]},{\"values\":[\"Innings\",\"116\",\"265\",\"151\",\"267\"]},{\"values\":[\"Runs\",\"4301\",\"11168\",\"4231\",\"7046\"]},{\"values\":[\"Balls\",\"7538\",\"12034\",\"3003\",\"5334\"]},{\"values\":[\"Highest\",\"212\",\"264\",\"121\",\"109\"]},{\"values\":[\"Average\",\"40.58\",\"48.77\",\"31.34\",\"29.73\"]},{\"values\":[\"SR\",\"57.06\",\"92.81\",\"140.90\",\"132.10\"]},{\"values\":[\"Not Out\",\"10\",\"36\",\"16\",\"30\"]},{\"values\":[\"Fours\",\"473\",\"1044\",\"383\",\"640\"]},{\"values\":[\"Sixes\",\"88\",\"344\",\"205\",\"302\"]},{\"values\":[\"Ducks\",\"6\",\"16\",\"12\",\"18\"]},{\"values\":[\"50s\",\"18\",\"58\",\"32\",\"47\"]},{\"values\":[\"100s\",\"12\",\"32\",\"5\",\"2\"]},{\"values\":[\"200s\",\"1\",\"3\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Rohit Sharma Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/576/rohit-sharma\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(15, '576', 'T20', 159, 151, 4231, 121, 31.34, 140.90, 5, 32, 3003, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"67\",\"273\",\"159\",\"272\"]},{\"values\":[\"Innings\",\"116\",\"265\",\"151\",\"267\"]},{\"values\":[\"Runs\",\"4301\",\"11168\",\"4231\",\"7046\"]},{\"values\":[\"Balls\",\"7538\",\"12034\",\"3003\",\"5334\"]},{\"values\":[\"Highest\",\"212\",\"264\",\"121\",\"109\"]},{\"values\":[\"Average\",\"40.58\",\"48.77\",\"31.34\",\"29.73\"]},{\"values\":[\"SR\",\"57.06\",\"92.81\",\"140.90\",\"132.10\"]},{\"values\":[\"Not Out\",\"10\",\"36\",\"16\",\"30\"]},{\"values\":[\"Fours\",\"473\",\"1044\",\"383\",\"640\"]},{\"values\":[\"Sixes\",\"88\",\"344\",\"205\",\"302\"]},{\"values\":[\"Ducks\",\"6\",\"16\",\"12\",\"18\"]},{\"values\":[\"50s\",\"18\",\"58\",\"32\",\"47\"]},{\"values\":[\"100s\",\"12\",\"32\",\"5\",\"2\"]},{\"values\":[\"200s\",\"1\",\"3\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Rohit Sharma Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/576/rohit-sharma\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(16, '576', 'IPL', 272, 267, 7046, 109, 29.73, 132.10, 2, 47, 5334, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"67\",\"273\",\"159\",\"272\"]},{\"values\":[\"Innings\",\"116\",\"265\",\"151\",\"267\"]},{\"values\":[\"Runs\",\"4301\",\"11168\",\"4231\",\"7046\"]},{\"values\":[\"Balls\",\"7538\",\"12034\",\"3003\",\"5334\"]},{\"values\":[\"Highest\",\"212\",\"264\",\"121\",\"109\"]},{\"values\":[\"Average\",\"40.58\",\"48.77\",\"31.34\",\"29.73\"]},{\"values\":[\"SR\",\"57.06\",\"92.81\",\"140.90\",\"132.10\"]},{\"values\":[\"Not Out\",\"10\",\"36\",\"16\",\"30\"]},{\"values\":[\"Fours\",\"473\",\"1044\",\"383\",\"640\"]},{\"values\":[\"Sixes\",\"88\",\"344\",\"205\",\"302\"]},{\"values\":[\"Ducks\",\"6\",\"16\",\"12\",\"18\"]},{\"values\":[\"50s\",\"18\",\"58\",\"32\",\"47\"]},{\"values\":[\"100s\",\"12\",\"32\",\"5\",\"2\"]},{\"values\":[\"200s\",\"1\",\"3\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Rohit Sharma Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/576/rohit-sharma\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(17, '1413', 'Test', 123, 210, 9230, 254, 46.85, 55.58, 30, 31, 16608, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"123\",\"302\",\"125\",\"267\"]},{\"values\":[\"Innings\",\"210\",\"290\",\"117\",\"259\"]},{\"values\":[\"Runs\",\"9230\",\"14181\",\"4188\",\"8661\"]},{\"values\":[\"Balls\",\"16608\",\"15192\",\"3056\",\"6519\"]},{\"values\":[\"Highest\",\"254\",\"183\",\"122\",\"113\"]},{\"values\":[\"Average\",\"46.85\",\"57.88\",\"48.7\",\"39.55\"]},{\"values\":[\"SR\",\"55.58\",\"93.35\",\"137.05\",\"132.86\"]},{\"values\":[\"Not Out\",\"13\",\"45\",\"31\",\"40\"]},{\"values\":[\"Fours\",\"1027\",\"1325\",\"369\",\"771\"]},{\"values\":[\"Sixes\",\"30\",\"153\",\"124\",\"291\"]},{\"values\":[\"Ducks\",\"15\",\"16\",\"7\",\"10\"]},{\"values\":[\"50s\",\"31\",\"74\",\"38\",\"63\"]},{\"values\":[\"100s\",\"30\",\"51\",\"1\",\"8\"]},{\"values\":[\"200s\",\"7\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Virat Kohli Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/1413/virat-kohli\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(18, '1413', 'ODI', 302, 290, 14181, 183, 57.88, 93.35, 51, 74, 15192, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"123\",\"302\",\"125\",\"267\"]},{\"values\":[\"Innings\",\"210\",\"290\",\"117\",\"259\"]},{\"values\":[\"Runs\",\"9230\",\"14181\",\"4188\",\"8661\"]},{\"values\":[\"Balls\",\"16608\",\"15192\",\"3056\",\"6519\"]},{\"values\":[\"Highest\",\"254\",\"183\",\"122\",\"113\"]},{\"values\":[\"Average\",\"46.85\",\"57.88\",\"48.7\",\"39.55\"]},{\"values\":[\"SR\",\"55.58\",\"93.35\",\"137.05\",\"132.86\"]},{\"values\":[\"Not Out\",\"13\",\"45\",\"31\",\"40\"]},{\"values\":[\"Fours\",\"1027\",\"1325\",\"369\",\"771\"]},{\"values\":[\"Sixes\",\"30\",\"153\",\"124\",\"291\"]},{\"values\":[\"Ducks\",\"15\",\"16\",\"7\",\"10\"]},{\"values\":[\"50s\",\"31\",\"74\",\"38\",\"63\"]},{\"values\":[\"100s\",\"30\",\"51\",\"1\",\"8\"]},{\"values\":[\"200s\",\"7\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Virat Kohli Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/1413/virat-kohli\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(19, '1413', 'T20', 125, 117, 4188, 122, 48.70, 137.05, 1, 38, 3056, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"123\",\"302\",\"125\",\"267\"]},{\"values\":[\"Innings\",\"210\",\"290\",\"117\",\"259\"]},{\"values\":[\"Runs\",\"9230\",\"14181\",\"4188\",\"8661\"]},{\"values\":[\"Balls\",\"16608\",\"15192\",\"3056\",\"6519\"]},{\"values\":[\"Highest\",\"254\",\"183\",\"122\",\"113\"]},{\"values\":[\"Average\",\"46.85\",\"57.88\",\"48.7\",\"39.55\"]},{\"values\":[\"SR\",\"55.58\",\"93.35\",\"137.05\",\"132.86\"]},{\"values\":[\"Not Out\",\"13\",\"45\",\"31\",\"40\"]},{\"values\":[\"Fours\",\"1027\",\"1325\",\"369\",\"771\"]},{\"values\":[\"Sixes\",\"30\",\"153\",\"124\",\"291\"]},{\"values\":[\"Ducks\",\"15\",\"16\",\"7\",\"10\"]},{\"values\":[\"50s\",\"31\",\"74\",\"38\",\"63\"]},{\"values\":[\"100s\",\"30\",\"51\",\"1\",\"8\"]},{\"values\":[\"200s\",\"7\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Virat Kohli Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/1413/virat-kohli\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(20, '1413', 'IPL', 267, 259, 8661, 113, 39.55, 132.86, 8, 63, 6519, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"123\",\"302\",\"125\",\"267\"]},{\"values\":[\"Innings\",\"210\",\"290\",\"117\",\"259\"]},{\"values\":[\"Runs\",\"9230\",\"14181\",\"4188\",\"8661\"]},{\"values\":[\"Balls\",\"16608\",\"15192\",\"3056\",\"6519\"]},{\"values\":[\"Highest\",\"254\",\"183\",\"122\",\"113\"]},{\"values\":[\"Average\",\"46.85\",\"57.88\",\"48.7\",\"39.55\"]},{\"values\":[\"SR\",\"55.58\",\"93.35\",\"137.05\",\"132.86\"]},{\"values\":[\"Not Out\",\"13\",\"45\",\"31\",\"40\"]},{\"values\":[\"Fours\",\"1027\",\"1325\",\"369\",\"771\"]},{\"values\":[\"Sixes\",\"30\",\"153\",\"124\",\"291\"]},{\"values\":[\"Ducks\",\"15\",\"16\",\"7\",\"10\"]},{\"values\":[\"50s\",\"31\",\"74\",\"38\",\"63\"]},{\"values\":[\"100s\",\"30\",\"51\",\"1\",\"8\"]},{\"values\":[\"200s\",\"7\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Virat Kohli Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/1413/virat-kohli\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"}]}', '2025-09-28 09:48:20'),
(21, '7915', 'Test', 1, 1, 8, 8, 8.00, 40.00, 0, 0, 20, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"1\",\"37\",\"89\",\"166\"]},{\"values\":[\"Innings\",\"1\",\"35\",\"84\",\"151\"]},{\"values\":[\"Runs\",\"8\",\"773\",\"2669\",\"4311\"]},{\"values\":[\"Balls\",\"20\",\"736\",\"1621\",\"2900\"]},{\"values\":[\"Highest\",\"8\",\"72\",\"117\",\"103\"]},{\"values\":[\"Average\",\"8\",\"25.77\",\"37.59\",\"35.05\"]},{\"values\":[\"SR\",\"40.00\",\"105.03\",\"164.66\",\"148.66\"]},{\"values\":[\"Not Out\",\"0\",\"5\",\"13\",\"28\"]},{\"values\":[\"Fours\",\"1\",\"80\",\"243\",\"454\"]},{\"values\":[\"Sixes\",\"0\",\"19\",\"148\",\"168\"]},{\"values\":[\"Ducks\",\"0\",\"3\",\"6\",\"10\"]},{\"values\":[\"50s\",\"0\",\"4\",\"21\",\"29\"]},{\"values\":[\"100s\",\"0\",\"0\",\"4\",\"2\"]},{\"values\":[\"200s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Suryakumar Yadav Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/7915/suryakumar-yadav\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20'),
(22, '7915', 'ODI', 37, 35, 773, 72, 25.77, 105.03, 0, 4, 736, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"1\",\"37\",\"89\",\"166\"]},{\"values\":[\"Innings\",\"1\",\"35\",\"84\",\"151\"]},{\"values\":[\"Runs\",\"8\",\"773\",\"2669\",\"4311\"]},{\"values\":[\"Balls\",\"20\",\"736\",\"1621\",\"2900\"]},{\"values\":[\"Highest\",\"8\",\"72\",\"117\",\"103\"]},{\"values\":[\"Average\",\"8\",\"25.77\",\"37.59\",\"35.05\"]},{\"values\":[\"SR\",\"40.00\",\"105.03\",\"164.66\",\"148.66\"]},{\"values\":[\"Not Out\",\"0\",\"5\",\"13\",\"28\"]},{\"values\":[\"Fours\",\"1\",\"80\",\"243\",\"454\"]},{\"values\":[\"Sixes\",\"0\",\"19\",\"148\",\"168\"]},{\"values\":[\"Ducks\",\"0\",\"3\",\"6\",\"10\"]},{\"values\":[\"50s\",\"0\",\"4\",\"21\",\"29\"]},{\"values\":[\"100s\",\"0\",\"0\",\"4\",\"2\"]},{\"values\":[\"200s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Suryakumar Yadav Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/7915/suryakumar-yadav\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20'),
(23, '7915', 'T20', 89, 84, 2669, 117, 37.59, 164.66, 4, 21, 1621, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"1\",\"37\",\"89\",\"166\"]},{\"values\":[\"Innings\",\"1\",\"35\",\"84\",\"151\"]},{\"values\":[\"Runs\",\"8\",\"773\",\"2669\",\"4311\"]},{\"values\":[\"Balls\",\"20\",\"736\",\"1621\",\"2900\"]},{\"values\":[\"Highest\",\"8\",\"72\",\"117\",\"103\"]},{\"values\":[\"Average\",\"8\",\"25.77\",\"37.59\",\"35.05\"]},{\"values\":[\"SR\",\"40.00\",\"105.03\",\"164.66\",\"148.66\"]},{\"values\":[\"Not Out\",\"0\",\"5\",\"13\",\"28\"]},{\"values\":[\"Fours\",\"1\",\"80\",\"243\",\"454\"]},{\"values\":[\"Sixes\",\"0\",\"19\",\"148\",\"168\"]},{\"values\":[\"Ducks\",\"0\",\"3\",\"6\",\"10\"]},{\"values\":[\"50s\",\"0\",\"4\",\"21\",\"29\"]},{\"values\":[\"100s\",\"0\",\"0\",\"4\",\"2\"]},{\"values\":[\"200s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Suryakumar Yadav Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/7915/suryakumar-yadav\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20'),
(24, '7915', 'IPL', 166, 151, 4311, 103, 35.05, 148.66, 2, 29, 2900, NULL, NULL, NULL, NULL, NULL, '{\"headers\":[\"ROWHEADER\",\"Test\",\"ODI\",\"T20\",\"IPL\"],\"values\":[{\"values\":[\"Matches\",\"1\",\"37\",\"89\",\"166\"]},{\"values\":[\"Innings\",\"1\",\"35\",\"84\",\"151\"]},{\"values\":[\"Runs\",\"8\",\"773\",\"2669\",\"4311\"]},{\"values\":[\"Balls\",\"20\",\"736\",\"1621\",\"2900\"]},{\"values\":[\"Highest\",\"8\",\"72\",\"117\",\"103\"]},{\"values\":[\"Average\",\"8\",\"25.77\",\"37.59\",\"35.05\"]},{\"values\":[\"SR\",\"40.00\",\"105.03\",\"164.66\",\"148.66\"]},{\"values\":[\"Not Out\",\"0\",\"5\",\"13\",\"28\"]},{\"values\":[\"Fours\",\"1\",\"80\",\"243\",\"454\"]},{\"values\":[\"Sixes\",\"0\",\"19\",\"148\",\"168\"]},{\"values\":[\"Ducks\",\"0\",\"3\",\"6\",\"10\"]},{\"values\":[\"50s\",\"0\",\"4\",\"21\",\"29\"]},{\"values\":[\"100s\",\"0\",\"0\",\"4\",\"2\"]},{\"values\":[\"200s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"300s\",\"0\",\"0\",\"0\",\"0\"]},{\"values\":[\"400s\",\"0\",\"0\",\"0\",\"0\"]}],\"appIndex\":{\"seoTitle\":\"Suryakumar Yadav Profile - Cricbuzz | Cricbuzz.com\",\"webURL\":\"http://www.cricbuzz.com/profiles/7915/suryakumar-yadav\"},\"seriesSpinner\":[{\"seriesName\":\"Career\"},{\"seriesId\":10587,\"seriesName\":\"Asia Cup 2025\"}]}', '2025-09-28 09:48:20');

-- --------------------------------------------------------

--
-- Table structure for table `series`
--

CREATE TABLE `series` (
  `id` int(11) NOT NULL,
  `series_id` varchar(64) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `host_country` varchar(128) DEFAULT NULL,
  `match_type` varchar(32) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date NOT NULL,
  `planned_matches` int(11) DEFAULT NULL,
  `raw_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_json`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `series`
--

INSERT INTO `series` (`id`, `series_id`, `name`, `host_country`, `match_type`, `start_date`, `end_date`, `planned_matches`, `raw_json`, `created_at`) VALUES
(7572, '7572', 'ICC Cricket World Cup League Two 2023-27', NULL, NULL, '2024-02-15', '2027-03-27', NULL, '{\"id\":7572,\"name\":\"ICC Cricket World Cup League Two 2023-27\",\"startDt\":\"1707955200000\",\"endDt\":\"1806364800000\"}', '2025-09-28 09:29:48'),
(9107, '9107', 'The Ashes, 2025-26', NULL, NULL, '2025-11-21', '2026-01-08', NULL, '{\"id\":9107,\"name\":\"The Ashes, 2025-26\",\"startDt\":\"1763683200000\",\"endDt\":\"1767830400000\"}', '2025-09-28 09:29:48'),
(9551, '9551', 'West Indies tour of South Africa, 2026', NULL, NULL, '2026-01-27', '2026-02-05', NULL, '{\"id\":9551,\"name\":\"West Indies tour of South Africa, 2026\",\"startDt\":\"1769472000000\",\"endDt\":\"1770336000000\"}', '2025-09-28 09:29:48'),
(9596, '9596', 'India tour of Australia, 2025', NULL, NULL, '2025-10-19', '2025-11-08', NULL, '{\"id\":9596,\"name\":\"India tour of Australia, 2025\",\"startDt\":\"1760832000000\",\"endDt\":\"1762560000000\"}', '2025-09-28 09:29:48'),
(9629, '9629', 'West Indies tour of India, 2025', NULL, NULL, '2025-10-02', '2025-10-14', NULL, '{\"id\":9629,\"name\":\"West Indies tour of India, 2025\",\"startDt\":\"1759363200000\",\"endDt\":\"1760400000000\"}', '2025-09-28 09:29:48'),
(9638, '9638', 'South Africa tour of India, 2025', NULL, NULL, '2025-11-14', '2025-12-19', NULL, '{\"id\":9638,\"name\":\"South Africa tour of India, 2025\",\"startDt\":\"1763078400000\",\"endDt\":\"1766102400000\"}', '2025-09-28 09:29:48'),
(10091, '10091', 'West Indies vs Nepal in UAE, 2025', NULL, NULL, '2025-09-27', '2025-09-30', NULL, '{\"id\":10091,\"name\":\"West Indies vs Nepal in UAE, 2025\",\"startDt\":\"1758931200000\",\"endDt\":\"1759190400000\"}', '2025-09-28 09:29:48'),
(10102, '10102', 'New Zealand tour of India, 2026', NULL, NULL, '2026-01-11', '2026-01-31', NULL, '{\"id\":10102,\"name\":\"New Zealand tour of India, 2026\",\"startDt\":\"1768089600000\",\"endDt\":\"1769817600000\"}', '2025-09-28 09:29:48'),
(10201, '10201', 'Australia tour of New Zealand, 2025', NULL, NULL, '2025-10-01', '2025-10-04', NULL, '{\"id\":10201,\"name\":\"Australia tour of New Zealand, 2025\",\"startDt\":\"1759276800000\",\"endDt\":\"1759536000000\"}', '2025-09-28 09:29:48'),
(10212, '10212', 'England tour of New Zealand, 2025', NULL, NULL, '2025-10-18', '2025-11-01', NULL, '{\"id\":10212,\"name\":\"England tour of New Zealand, 2025\",\"startDt\":\"1760745600000\",\"endDt\":\"1761955200000\"}', '2025-09-28 09:29:48'),
(10223, '10223', 'West Indies tour of New Zealand, 2025', NULL, NULL, '2025-11-05', '2025-12-21', NULL, '{\"id\":10223,\"name\":\"West Indies tour of New Zealand, 2025\",\"startDt\":\"1762300800000\",\"endDt\":\"1766361600000\"}', '2025-09-28 09:29:48'),
(10234, '10234', 'South Africa tour of New Zealand, 2026', NULL, NULL, '2026-03-15', '2026-03-24', NULL, '{\"id\":10234,\"name\":\"South Africa tour of New Zealand, 2026\",\"startDt\":\"1773532800000\",\"endDt\":\"1774396800000\"}', '2025-09-28 09:29:48'),
(10504, '10504', 'South Africa tour of Namibia 2025', NULL, NULL, '2025-10-11', '2025-10-11', NULL, '{\"id\":10504,\"name\":\"South Africa tour of Namibia 2025\",\"startDt\":\"1760140800000\",\"endDt\":\"1760140800000\"}', '2025-09-28 09:29:48'),
(10532, '10532', 'India tour of England, 2026', NULL, NULL, '2026-07-01', '2026-07-18', NULL, '{\"id\":10532,\"name\":\"India tour of England, 2026\",\"startDt\":\"1782864000000\",\"endDt\":\"1784419200000\"}', '2025-09-28 09:29:48'),
(10559, '10559', 'New Zealand tour of England, 2026', NULL, NULL, '2026-06-04', '2026-06-28', NULL, '{\"id\":10559,\"name\":\"New Zealand tour of England, 2026\",\"startDt\":\"1780531200000\",\"endDt\":\"1782691200000\"}', '2025-09-28 09:29:48'),
(10565, '10565', 'Pakistan tour of England 2026', NULL, NULL, '2026-08-18', '2026-09-07', NULL, '{\"id\":10565,\"name\":\"Pakistan tour of England 2026\",\"startDt\":\"1787097600000\",\"endDt\":\"1788912000000\"}', '2025-09-28 09:29:48'),
(10576, '10576', 'Sri Lanka tour of England, 2026', NULL, NULL, '2026-09-14', '2026-09-25', NULL, '{\"id\":10576,\"name\":\"Sri Lanka tour of England, 2026\",\"startDt\":\"1789430400000\",\"endDt\":\"1790467200000\"}', '2025-09-28 09:29:48'),
(10587, '10587', 'Asia Cup 2025', NULL, NULL, '2025-09-09', '2025-09-28', NULL, '{\"id\":10587,\"name\":\"Asia Cup 2025\",\"startDt\":\"1757376000000\",\"endDt\":\"1759017600000\"}', '2025-09-28 09:29:48'),
(10625, '10625', 'ICC Mens T20 World Cup East Asia Pacific Qualifier 2025', NULL, NULL, '2025-10-08', '2025-10-17', NULL, '{\"id\":10625,\"name\":\"ICC Mens T20 World Cup East Asia Pacific Qualifier 2025\",\"startDt\":\"1759881600000\",\"endDt\":\"1760659200000\"}', '2025-09-28 09:29:48'),
(10774, '10774', 'England tour of Sri Lanka 2026', NULL, NULL, '2026-01-22', '2026-02-02', NULL, '{\"id\":10774,\"name\":\"England tour of Sri Lanka 2026\",\"startDt\":\"1769040000000\",\"endDt\":\"1770076800000\"}', '2025-09-28 09:29:48'),
(10840, '10840', 'Afghanistan vs Bangladesh in UAE 2025', NULL, NULL, '2025-10-02', '2025-10-14', NULL, '{\"id\":10840,\"name\":\"Afghanistan vs Bangladesh in UAE 2025\",\"startDt\":\"1759363200000\",\"endDt\":\"1760400000000\"}', '2025-09-28 09:29:48'),
(10895, '10895', 'South Africa tour of Pakistan, 2025', NULL, NULL, '2025-10-12', '2025-11-08', NULL, '{\"id\":10895,\"name\":\"South Africa tour of Pakistan, 2025\",\"startDt\":\"1760227200000\",\"endDt\":\"1762560000000\"}', '2025-09-28 09:29:48'),
(10906, '10906', 'Pakistan T20I Tri-Series 2025', NULL, NULL, '2025-11-17', '2025-11-29', NULL, '{\"id\":10906,\"name\":\"Pakistan T20I Tri-Series 2025\",\"startDt\":\"1763337600000\",\"endDt\":\"1764374400000\"}', '2025-09-28 09:29:48'),
(10933, '10933', 'Sri Lanka tour of Pakistan 2025', NULL, NULL, '2025-11-11', '2025-11-15', NULL, '{\"id\":10933,\"name\":\"Sri Lanka tour of Pakistan 2025\",\"startDt\":\"1762819200000\",\"endDt\":\"1763164800000\"}', '2025-09-28 09:29:48'),
(10944, '10944', 'ICC Mens T20 World Cup Africa Regional Final 2025', NULL, NULL, '2025-09-26', '2025-10-04', NULL, '{\"id\":10944,\"name\":\"ICC Mens T20 World Cup Africa Regional Final 2025\",\"startDt\":\"1758844800000\",\"endDt\":\"1759536000000\"}', '2025-09-28 09:29:48'),
(10955, '10955', 'West Indies tour of Bangladesh, 2025', NULL, NULL, '2025-10-18', '2025-11-01', NULL, '{\"id\":10955,\"name\":\"West Indies tour of Bangladesh, 2025\",\"startDt\":\"1760745600000\",\"endDt\":\"1761955200000\"}', '2025-09-28 09:29:48'),
(10972, '10972', 'Ireland tour of Bangladesh, 2025', NULL, NULL, '2025-11-10', '2025-12-01', NULL, '{\"id\":10972,\"name\":\"Ireland tour of Bangladesh, 2025\",\"startDt\":\"1762732800000\",\"endDt\":\"1764633600000\"}', '2025-09-28 09:29:48'),
(11016, '11016', 'Kuwait tour of Oman, 2025', NULL, NULL, '2025-09-29', '2025-09-30', NULL, '{\"id\":11016,\"name\":\"Kuwait tour of Oman, 2025\",\"startDt\":\"1759104000000\",\"endDt\":\"1759190400000\"}', '2025-09-28 09:29:48');

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `id` int(11) NOT NULL,
  `team_id` varchar(64) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `country` varchar(128) DEFAULT NULL,
  `raw_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_json`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `team_id`, `name`, `country`, `raw_json`, `created_at`) VALUES
(112, '2', 'India', 'India', '{\"teamId\":2,\"teamName\":\"India\",\"teamSName\":\"IND\",\"imageId\":719031,\"countryName\":\"India\"}', '2025-09-28 09:17:16'),
(113, '96', 'Afghanistan', NULL, '{\"teamId\":96,\"teamName\":\"Afghanistan\",\"teamSName\":\"AFG\",\"imageId\":172188}', '2025-09-28 09:17:16'),
(114, '27', 'Ireland', NULL, '{\"teamId\":27,\"teamName\":\"Ireland\",\"teamSName\":\"IRE\",\"imageId\":495001}', '2025-09-28 09:17:16'),
(115, '3', 'Pakistan', 'Pakistan', '{\"teamId\":3,\"teamName\":\"Pakistan\",\"teamSName\":\"PAK\",\"imageId\":591986,\"countryName\":\"Pakistan\"}', '2025-09-28 09:17:16'),
(116, '4', 'Australia', 'Australia', '{\"teamId\":4,\"teamName\":\"Australia\",\"teamSName\":\"AUS\",\"imageId\":172117,\"countryName\":\"Australia\"}', '2025-09-28 09:17:16'),
(117, '5', 'Sri Lanka', 'Sri Lanka', '{\"teamId\":5,\"teamName\":\"Sri Lanka\",\"teamSName\":\"SL\",\"imageId\":172119,\"countryName\":\"Sri Lanka\"}', '2025-09-28 09:17:16'),
(118, '6', 'Bangladesh', NULL, '{\"teamId\":6,\"teamName\":\"Bangladesh\",\"teamSName\":\"BAN\",\"imageId\":172120}', '2025-09-28 09:17:16'),
(119, '9', 'England', NULL, '{\"teamId\":9,\"teamName\":\"England\",\"teamSName\":\"ENG\",\"imageId\":172123}', '2025-09-28 09:17:16'),
(120, '10', 'West Indies', NULL, '{\"teamId\":10,\"teamName\":\"West Indies\",\"teamSName\":\"WI\",\"imageId\":172124}', '2025-09-28 09:17:16'),
(121, '11', 'South Africa', NULL, '{\"teamId\":11,\"teamName\":\"South Africa\",\"teamSName\":\"RSA\",\"imageId\":172126}', '2025-09-28 09:17:16'),
(122, '12', 'Zimbabwe', 'Zimbabwe', '{\"teamId\":12,\"teamName\":\"Zimbabwe\",\"teamSName\":\"ZIM\",\"imageId\":172127,\"countryName\":\"Zimbabwe\"}', '2025-09-28 09:17:16'),
(123, '13', 'New Zealand', NULL, '{\"teamId\":13,\"teamName\":\"New Zealand\",\"teamSName\":\"NZ\",\"imageId\":172128}', '2025-09-28 09:17:16'),
(124, '71', 'Malaysia', NULL, '{\"teamId\":71,\"teamName\":\"Malaysia\",\"teamSName\":\"MLY\",\"imageId\":172168}', '2025-09-28 09:17:16'),
(125, '72', 'Nepal', NULL, '{\"teamId\":72,\"teamName\":\"Nepal\",\"teamSName\":\"NEP\",\"imageId\":172169}', '2025-09-28 09:17:16'),
(126, '77', 'Germany', NULL, '{\"teamId\":77,\"teamName\":\"Germany\",\"teamSName\":\"GER\",\"imageId\":172171}', '2025-09-28 09:17:16'),
(127, '161', 'Namibia', NULL, '{\"teamId\":161,\"teamName\":\"Namibia\",\"teamSName\":\"NAM\",\"imageId\":172229}', '2025-09-28 09:17:16'),
(128, '185', 'Denmark', NULL, '{\"teamId\":185,\"teamName\":\"Denmark\",\"teamSName\":\"DEN\",\"imageId\":172245}', '2025-09-28 09:17:16'),
(129, '190', 'Singapore', NULL, '{\"teamId\":190,\"teamName\":\"Singapore\",\"teamSName\":\"SIN\",\"imageId\":172250}', '2025-09-28 09:17:16'),
(130, '287', 'Papua New Guinea', NULL, '{\"teamId\":287,\"teamName\":\"Papua New Guinea\",\"teamSName\":\"PNG\",\"imageId\":172336}', '2025-09-28 09:17:16'),
(131, '298', 'Kuwait', NULL, '{\"teamId\":298,\"teamName\":\"Kuwait\",\"teamSName\":\"KUW\",\"imageId\":248427}', '2025-09-28 09:17:16'),
(132, '300', 'Vanuatu', NULL, '{\"teamId\":300,\"teamName\":\"Vanuatu\",\"teamSName\":\"VAN\",\"imageId\":172349}', '2025-09-28 09:17:16'),
(133, '303', 'Jersey', NULL, '{\"teamId\":303,\"teamName\":\"Jersey\",\"teamSName\":\"JER\",\"imageId\":172352}', '2025-09-28 09:17:16'),
(134, '304', 'Oman', NULL, '{\"teamId\":304,\"teamName\":\"Oman\",\"teamSName\":\"OMAN\",\"imageId\":172353}', '2025-09-28 09:17:16'),
(135, '343', 'Fiji', NULL, '{\"teamId\":343,\"teamName\":\"Fiji\",\"teamSName\":\"FIJI\",\"imageId\":172391}', '2025-09-28 09:17:16'),
(136, '527', 'Italy', NULL, '{\"teamId\":527,\"teamName\":\"Italy\",\"teamSName\":\"ITA\",\"imageId\":172577}', '2025-09-28 09:17:16'),
(137, '529', 'Botswana', NULL, '{\"teamId\":529,\"teamName\":\"Botswana\",\"teamSName\":\"BW\",\"imageId\":172579}', '2025-09-28 09:17:16'),
(138, '541', 'Belgium', NULL, '{\"teamId\":541,\"teamName\":\"Belgium\",\"teamSName\":\"BEL\",\"imageId\":172592}', '2025-09-28 09:17:16'),
(139, '44', 'Uganda', NULL, '{\"teamId\":44,\"teamName\":\"Uganda\",\"teamSName\":\"UGA\",\"imageId\":495000}', '2025-09-28 09:17:16'),
(140, '26', 'Canada', NULL, '{\"teamId\":26,\"teamName\":\"Canada\",\"teamSName\":\"CAN\",\"imageId\":172140}', '2025-09-28 09:17:16'),
(141, '7', 'United Arab Emirates', NULL, '{\"teamId\":7,\"teamName\":\"United Arab Emirates\",\"teamSName\":\"UAE\",\"imageId\":172121}', '2025-09-28 09:17:16'),
(142, '8', 'Hong Kong', NULL, '{\"teamId\":8,\"teamName\":\"Hong Kong\",\"teamSName\":\"HK\",\"imageId\":172122}', '2025-09-28 09:17:16'),
(143, '14', 'Kenya', NULL, '{\"teamId\":14,\"teamName\":\"Kenya\",\"teamSName\":\"KEN\",\"imageId\":172129}', '2025-09-28 09:17:16'),
(144, '15', 'United States of America', 'United States of America', '{\"teamId\":15,\"teamName\":\"United States of America\",\"teamSName\":\"USA\",\"imageId\":172130,\"countryName\":\"United States of America\"}', '2025-09-28 09:17:16'),
(145, '23', 'Scotland', NULL, '{\"teamId\":23,\"teamName\":\"Scotland\",\"teamSName\":\"SCO\",\"imageId\":172137}', '2025-09-28 09:17:16'),
(146, '24', 'Netherlands', NULL, '{\"teamId\":24,\"teamName\":\"Netherlands\",\"teamSName\":\"NED\",\"imageId\":172138}', '2025-09-28 09:17:16'),
(147, '25', 'Bermuda', NULL, '{\"teamId\":25,\"teamName\":\"Bermuda\",\"teamSName\":\"BER\",\"imageId\":172139}', '2025-09-28 09:17:16'),
(148, '675', 'Iran', NULL, '{\"teamId\":675,\"teamName\":\"Iran\",\"teamSName\":\"IRN\",\"imageId\":188163}', '2025-09-28 09:17:16');

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

CREATE TABLE `venues` (
  `id` int(11) NOT NULL,
  `venue_id` varchar(64) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `country` varchar(128) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `raw_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_json`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `venues`
--

INSERT INTO `venues` (`id`, `venue_id`, `name`, `city`, `country`, `capacity`, `raw_json`, `created_at`) VALUES
(94, '94', 'Sheikh Zayed Stadium', 'Abu Dhabi', 'United Arab Emirates', NULL, '{\"id\":94,\"ground\":\"Sheikh Zayed Stadium\",\"city\":\"Abu Dhabi\",\"country\":\"United Arab Emirates\",\"imageId\":\"731716\"}', '2025-09-28 09:34:34'),
(153, '153', 'Dubai International Cricket Stadium', 'Dubai', 'United Arab Emirates', NULL, '{\"id\":153,\"ground\":\"Dubai International Cricket Stadium\",\"city\":\"Dubai\",\"country\":\"United Arab Emirates\",\"imageId\":\"731713\"}', '2025-09-28 09:34:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bowling_records`
--
ALTER TABLE `bowling_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `innings`
--
ALTER TABLE `innings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `match_id` (`match_id`);

--
-- Indexes for table `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `match_id` (`match_id`),
  ADD KEY `match_start` (`match_start`),
  ADD KEY `team1_id` (`team1_id`),
  ADD KEY `team2_id` (`team2_id`);

--
-- Indexes for table `partnerships`
--
ALTER TABLE `partnerships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `match_id` (`match_id`),
  ADD KEY `batsman1_id` (`batsman1_id`),
  ADD KEY `batsman2_id` (`batsman2_id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `player_id` (`player_id`),
  ADD KEY `team_id` (`team_id`);

--
-- Indexes for table `player_stats`
--
ALTER TABLE `player_stats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `series`
--
ALTER TABLE `series`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `series_id` (`series_id`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_id` (`team_id`);

--
-- Indexes for table `venues`
--
ALTER TABLE `venues`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `venue_id` (`venue_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bowling_records`
--
ALTER TABLE `bowling_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `innings`
--
ALTER TABLE `innings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `matches`
--
ALTER TABLE `matches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134783;

--
-- AUTO_INCREMENT for table `partnerships`
--
ALTER TABLE `partnerships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `player_stats`
--
ALTER TABLE `player_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `series`
--
ALTER TABLE `series`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11017;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
