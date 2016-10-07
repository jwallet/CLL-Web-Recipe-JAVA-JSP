-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 05, 2016 at 04:34 AM
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
  `position` int(11) NOT NULL,
  `url_local` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id_image`, `id_recette`, `position`, `url_local`) VALUES
(1, 1, 1, '/images/pain1.jpg'),
(2, 1, 2, '/images/pain2.jpg'),
(3, 1, 3, '/images/pain3.jpg'),
(4, 2, 1, '/images/biscuit-canneberge.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `id_ingredient` int(11) NOT NULL,
  `id_recette` int(11) NOT NULL,
  `quantite` int(11) DEFAULT NULL,
  `id_type_fraction` int(11) NOT NULL DEFAULT '1',
  `id_type_unite` int(11) NOT NULL DEFAULT '1',
  `ingredient` text NOT NULL,
  `position` int(11) DEFAULT NULL,
  `facultatif` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`id_ingredient`, `id_recette`, `quantite`, `id_type_fraction`, `id_type_unite`, `ingredient`, `position`, `facultatif`) VALUES
(1, 1, 1, 1, 4, 'd\'eau tiède', 1, 0),
(2, 1, 2, 1, 2, 'de sucre', 2, 0),
(3, 1, 2, 1, 7, 'de levure active sèche traditionnel', 3, 0),
(4, 1, 2, 1, 4, 'de lait', 4, 0),
(5, 1, NULL, 5, 4, 'de miel', 5, 0),
(6, 1, 4, 1, 2, 'de sel', 6, 0),
(7, 1, NULL, 5, 4, 'd\'huile de canola', 7, 0),
(8, 1, 1, 1, 4, 'd\'eau soit tiède ou froide ( elle est pour tempérer le liquide avant d\'y mettre la levure et les farines )', 8, 0),
(9, 1, 1, 1, 1, 'oeuf', 9, 0),
(10, 1, 2, 2, 4, 'de farine d\'épaute ou équivalent ( cette farine est fait de grains anciens, comme le kamut , le seigle ) ', 10, 1),
(11, 1, NULL, 5, 4, 'de graines de tournesol                ', 11, 0),
(12, 1, NULL, 4, 4, 'de graines de lin moulue', 12, 0),
(13, 1, 1, 2, 4, 'de gruau ', 13, 0),
(14, 1, 5, 1, 4, 'de farine blanche non blanchie', 14, 0),
(15, 2, 1, 1, 4, 'd\'huile et/ou beurre', 1, 0),
(16, 2, 1, 2, 4, 'de cassonade', 2, 0),
(17, 2, 2, 1, 1, 'oeufs', 3, 0),
(18, 2, NULL, 2, 2, 'de vanille', 4, 0),
(19, 2, NULL, 2, 2, 'de sel', 5, 0),
(20, 2, NULL, 2, 2, 'de cannelle', 6, 0),
(21, 2, 1, 1, 4, 'de noix', 7, 0),
(22, 2, 1, 1, 4, 'de pépites de chocolat blanc', 8, 0),
(23, 2, NULL, 6, 4, 'de canneberges', 9, 0),
(24, 2, NULL, 6, 4, 'de coconut', 10, 0),
(25, 2, 1, 1, 4, 'de gruau (si vous retirez le coconut, ajouter 1 tasse de plus de gruau)', 11, 0),
(26, 2, 1, 0, 4, 'de farine', 12, 0);

-- --------------------------------------------------------

--
-- Table structure for table `label`
--

CREATE TABLE `label` (
  `id_label` int(11) NOT NULL,
  `id_recette` int(11) NOT NULL,
  `id_type_label` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `label`
--

INSERT INTO `label` (`id_label`, `id_recette`, `id_type_label`) VALUES
(1, 1, 4),
(2, 2, 4),
(5, 2, 2);

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
(7, '&#8533;', '1/5'),
(8, '&#8534;', '2/5'),
(9, '&#8535;', '3/5'),
(10, '&#8536;', '4/5'),
(11, '&#8537;', '1/6'),
(12, '&#8538;', '5/6'),
(13, '&#8539;', '1/8'),
(14, '&#8540;', '3/8'),
(15, '&#8541;', '5/8'),
(16, '&#8542;', '7/8');

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
(1, 'préparation'),
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
  `position` int(11) NOT NULL,
  `brouillon` tinyint(4) NOT NULL,
  `supprimer` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recettes`
--

INSERT INTO `recettes` (`id_recette`, `titre`, `description`, `instructions`, `position`, `brouillon`, `supprimer`) VALUES
(1, 'Pain maison multigrains', 'À partir de farine riche en grains comme le seigle et le kamut, faites lever vos pains et savourer la fraicheur d\'un pain maison.', 'Dans un poèlon faire frémir 2 tasse de lait .\r\nVerser dans un grand bol le lait chaud et ajouter 1/4 rasse de miel et 4 c,a thé de sel et ll\'huile\r\nRemuer  et laisser tiédir\r\nEntre temps faire dissoudre 2 c a thé sucre dans 1 tasse d\'eau tiède , y saupoudrer  2 sachets de levure  et laisser reposer 10minutes. Ensuite quand la levure a moussé, brasser vivement a la fourchette\r\nVérifier la température du premier mélange et y verser 1 tasses d\'eau tiède plus ou moins pour que tout le liquide soit tiède ( pour ne pas brûler les levures )\r\nAjouter la levure au liquide tiède ,remuer et y incorporer en brassant avec le mixette électrique  2 a 3 tasses farine anciennes 1/4 tasse graine de lin moulu, 1/4 tasse graine de tournesol, 1/2 tasse gruau . Continuer avec de la farine blanche non blanchi environ 5 a 6  tasses , en mettant  1 tasse a la foi .Et quand la mixette n\'en peu plus , ( ne pas faire forcer la mixette , bien mélanger la pâte ) ça prend une bonne cueillere en bois et de l\'huile a coude et on mélange a la main  :)\r\n\r\nFaire entrer la dernière partie de farine ( quand elle commence a être assez danse ) d\'un mouvement circulaire avec la main . Mettre sur uns surface enfarinée et pétrir de 8 a 10 min  jusqu\'a ce que la pâte soit lisse.\r\nFaçonner en boule lisse et mettre dans un bol graisser et graisser la surface de la boule . Couvrir d\'un linge humide et laisser doubler de volume  ( environ 1 1/4   , 1 1/2  heure ) dans un endroit chaud (dans le four sur la grille du bas avec la lumière allumée pour moi )\r\nDégonfler avec le poing , façonner les pains . Graisser les moules et la surface des pains , laisser lever ,doubler de volume ( environ 1 heure 1 1/2 heure )\r\nCuire au four 375* F  environ 20 a 30 min\r\nDonne 4 pains', 1, 0, 0),
(2, 'Biscuits aux pépites de chocolat blanc et canneberges', 'Biscuits aux pépites de chocolat blanc remplis de canneberges, de gruau, de noix et de coconut.', '1. Préchauffer le four à 350F. \r\n2. Dans un grand bol ajouter l\'huile et/ou le beurre, la cassonade, les oeufs, la vanille, le sel et la canelle.\r\n3. Battre les ingrédients avec un fouet. \r\n4. Ajouter les canneberges, les noix, les pépites de chocolat blanc, le gruau (et le coconut). \r\n5. Battre à nouveau avant de terminer avec l\'ajout de la farine, puis mélanger une dernière fois. \r\n6. Cuire de 10 à 12 minutes, pour une plaque contenant 12 biscuits, sur la grille du haut.', 2, 0, 0);

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
-- Dumping data for table `sommaire`
--

INSERT INTO `sommaire` (`id_sommaire`, `id_recette`, `id_type_sommaire`, `nbre_unite`) VALUES
(1, 1, 1, '45 min'),
(2, 1, 2, '20 à 30 min'),
(3, 1, 3, '5 min'),
(4, 1, 4, '4 pains'),
(5, 2, 1, '10 min'),
(6, 2, 2, '10 min'),
(7, 2, 3, '0 min'),
(8, 2, 4, '24 à 30 biscuits');

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
  MODIFY `id_image` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id_ingredient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `label`
--
ALTER TABLE `label`
  MODIFY `id_label` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `p_type_fraction`
--
ALTER TABLE `p_type_fraction`
  MODIFY `id_type_fraction` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `p_type_label`
--
ALTER TABLE `p_type_label`
  MODIFY `id_type_label` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `p_type_sommaire`
--
ALTER TABLE `p_type_sommaire`
  MODIFY `id_type_sommaire` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `p_type_unite`
--
ALTER TABLE `p_type_unite`
  MODIFY `id_type_unite` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `recettes`
--
ALTER TABLE `recettes`
  MODIFY `id_recette` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sommaire`
--
ALTER TABLE `sommaire`
  MODIFY `id_sommaire` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
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
