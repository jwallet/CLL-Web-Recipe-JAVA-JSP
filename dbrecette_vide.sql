-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 12, 2016 at 11:52 PM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbrecette`
--

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id_image` int(11) NOT NULL,
  `id_recette` int(11) NOT NULL,
  `url_local` text NOT NULL,
  `principale` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `id_ingredient` int(11) NOT NULL,
  `id_recette` int(11) NOT NULL,
  `num_ligne` int(11) NOT NULL,
  `quantite` int(11) DEFAULT NULL,
  `id_type_fraction` int(11) NOT NULL DEFAULT '1',
  `id_type_unite` int(11) NOT NULL DEFAULT '1',
  `ingredient` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `label`
--

CREATE TABLE `label` (
  `id_label` int(11) NOT NULL,
  `id_recette` int(11) NOT NULL,
  `id_type_label` int(11) NOT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `p_type_fraction`
--

CREATE TABLE `p_type_fraction` (
  `id_type_fraction` int(11) NOT NULL,
  `fraction` text NOT NULL,
  `fraction_nohtml` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `p_type_fraction`
--

INSERT INTO `p_type_fraction` (`id_type_fraction`, `fraction`, `fraction_nohtml`) VALUES
(1, '', ''),
(2, '&#0189;', '1/2'),
(3, '&#8531;', '1/3'),
(4, '&#8532;', '2/3'),
(5, '&#0188;', '1/4'),
(6, '&#0190;', '3/4'),
(7, '&#8539;', '1/8');

-- --------------------------------------------------------

--
-- Table structure for table `p_type_label`
--

CREATE TABLE `p_type_label` (
  `id_type_label` int(11) NOT NULL,
  `label` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `p_type_label`
--

INSERT INTO `p_type_label` (`id_type_label`, `label`) VALUES
(1, 'Repas'),
(2, 'Dessert'),
(3, 'Soupe'),
(4, 'Divers');

-- --------------------------------------------------------

--
-- Table structure for table `p_type_sommaire`
--

CREATE TABLE `p_type_sommaire` (
  `id_type_sommaire` int(11) NOT NULL,
  `type` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `p_type_sommaire`
--

INSERT INTO `p_type_sommaire` (`id_type_sommaire`, `type`) VALUES
(1, 'preparation'),
(2, 'cuisson'),
(3, 'refroidissement'),
(4, 'portions');

-- --------------------------------------------------------

--
-- Table structure for table `p_type_unite`
--

CREATE TABLE `p_type_unite` (
  `id_type_unite` int(11) NOT NULL,
  `type_unite` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `p_type_unite`
--

INSERT INTO `p_type_unite` (`id_type_unite`, `type_unite`) VALUES
(1, ''),
(2, 'c. à thé'),
(3, 'c. à soupe'),
(4, 'tasse(s)'),
(5, 'boîte(s)'),
(6, 'canne(s)'),
(7, 'sachet(s)'),
(8, 'g'),
(9, 'kg'),
(10, 'ml'),
(11, 'L'),
(12, 'lb'),
(13, 'oz');

-- --------------------------------------------------------

--
-- Table structure for table `recettes`
--

CREATE TABLE `recettes` (
  `id_recette` int(11) NOT NULL,
  `titre` text NOT NULL,
  `description` text NOT NULL,
  `instructions` text NOT NULL,
  `notes` text NOT NULL,
  `brouillon` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `redacteurs`
--

CREATE TABLE `redacteurs` (
  `id_redacteur` int(11) NOT NULL,
  `usager` text COLLATE utf8_unicode_ci NOT NULL,
  `nom` text COLLATE utf8_unicode_ci,
  `motdepasse` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `redacteurs`
--

INSERT INTO `redacteurs` (`id_redacteur`, `usager`, `nom`, `motdepasse`) VALUES
(1, 'siroisa', 'Anne Sirois', 'patate'),
(3, 'admin', NULL, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `sommaire`
--

CREATE TABLE `sommaire` (
  `id_sommaire` int(11) NOT NULL,
  `id_recette` int(11) NOT NULL,
  `id_type_sommaire` int(11) NOT NULL,
  `nbre_unite` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id_image`),
  ADD KEY `id_recette` (`id_recette`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id_ingredient`),
  ADD KEY `id_recette` (`id_recette`),
  ADD KEY `id_type_unite` (`id_type_unite`),
  ADD KEY `id_type_fraction` (`id_type_fraction`);

--
-- Indexes for table `label`
--
ALTER TABLE `label`
  ADD PRIMARY KEY (`id_label`),
  ADD KEY `id_recette` (`id_recette`),
  ADD KEY `id_type_label` (`id_type_label`);

--
-- Indexes for table `p_type_fraction`
--
ALTER TABLE `p_type_fraction`
  ADD PRIMARY KEY (`id_type_fraction`);

--
-- Indexes for table `p_type_label`
--
ALTER TABLE `p_type_label`
  ADD PRIMARY KEY (`id_type_label`);

--
-- Indexes for table `p_type_sommaire`
--
ALTER TABLE `p_type_sommaire`
  ADD PRIMARY KEY (`id_type_sommaire`);

--
-- Indexes for table `p_type_unite`
--
ALTER TABLE `p_type_unite`
  ADD PRIMARY KEY (`id_type_unite`);

--
-- Indexes for table `recettes`
--
ALTER TABLE `recettes`
  ADD PRIMARY KEY (`id_recette`);

--
-- Indexes for table `redacteurs`
--
ALTER TABLE `redacteurs`
  ADD PRIMARY KEY (`id_redacteur`);

--
-- Indexes for table `sommaire`
--
ALTER TABLE `sommaire`
  ADD PRIMARY KEY (`id_sommaire`),
  ADD KEY `type_sommaire` (`id_type_sommaire`),
  ADD KEY `id_recette` (`id_recette`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id_image` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id_ingredient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `label`
--
ALTER TABLE `label`
  MODIFY `id_label` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `p_type_fraction`
--
ALTER TABLE `p_type_fraction`
  MODIFY `id_type_fraction` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `p_type_label`
--
ALTER TABLE `p_type_label`
  MODIFY `id_type_label` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `p_type_sommaire`
--
ALTER TABLE `p_type_sommaire`
  MODIFY `id_type_sommaire` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `p_type_unite`
--
ALTER TABLE `p_type_unite`
  MODIFY `id_type_unite` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `recettes`
--
ALTER TABLE `recettes`
  MODIFY `id_recette` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `redacteurs`
--
ALTER TABLE `redacteurs`
  MODIFY `id_redacteur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `sommaire`
--
ALTER TABLE `sommaire`
  MODIFY `id_sommaire` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`id_recette`) REFERENCES `recettes` (`id_recette`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `ingredients_ibfk_1` FOREIGN KEY (`id_recette`) REFERENCES `recettes` (`id_recette`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ingredients_ibfk_2` FOREIGN KEY (`id_type_unite`) REFERENCES `p_type_unite` (`id_type_unite`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `label`
--
ALTER TABLE `label`
  ADD CONSTRAINT `label_ibfk_1` FOREIGN KEY (`id_recette`) REFERENCES `recettes` (`id_recette`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `label_ibfk_2` FOREIGN KEY (`id_type_label`) REFERENCES `p_type_label` (`id_type_label`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sommaire`
--
ALTER TABLE `sommaire`
  ADD CONSTRAINT `sommaire_ibfk_1` FOREIGN KEY (`id_recette`) REFERENCES `recettes` (`id_recette`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sommaire_ibfk_2` FOREIGN KEY (`id_type_sommaire`) REFERENCES `p_type_sommaire` (`id_type_sommaire`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
