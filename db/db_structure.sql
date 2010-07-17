CREATE TABLE `atbats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) DEFAULT NULL,
  `inning` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `ball` int(11) DEFAULT NULL,
  `strike` int(11) DEFAULT NULL,
  `outs` int(11) DEFAULT NULL,
  `batter_id` int(11) DEFAULT NULL,
  `pitcher_id` int(11) DEFAULT NULL,
  `stand` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `des` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hit_x` float DEFAULT NULL,
  `hit_y` float DEFAULT NULL,
  `hit_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118114 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `game_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `games` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `home_id` int(11) DEFAULT NULL,
  `away_id` int(11) DEFAULT NULL,
  `game_num` int(11) DEFAULT NULL,
  `umpire_hp_id` int(11) DEFAULT NULL,
  `umpire_1b_id` int(11) DEFAULT NULL,
  `umpire_2b_id` int(11) DEFAULT NULL,
  `umpire_3b_id` int(11) DEFAULT NULL,
  `wind` int(11) DEFAULT NULL,
  `wind_dir` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `temp` int(11) DEFAULT NULL,
  `game_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `runs_home` int(11) DEFAULT NULL,
  `runs_away` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `pitch_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abbreviation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `pitches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pitch_id` int(11) DEFAULT NULL,
  `atbat_id` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `outcome` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `start_speed` float DEFAULT NULL,
  `end_speed` float DEFAULT NULL,
  `sz_top` float DEFAULT NULL,
  `sz_bot` float DEFAULT NULL,
  `pfx_x` float DEFAULT NULL,
  `pfx_z` float DEFAULT NULL,
  `px` float DEFAULT NULL,
  `pz` float DEFAULT NULL,
  `x0` float DEFAULT NULL,
  `y0` float DEFAULT NULL,
  `z0` float DEFAULT NULL,
  `vx0` float DEFAULT NULL,
  `vy0` float DEFAULT NULL,
  `vz0` float DEFAULT NULL,
  `ax` float DEFAULT NULL,
  `ay` float DEFAULT NULL,
  `az` float DEFAULT NULL,
  `break_y` float DEFAULT NULL,
  `break_angle` float DEFAULT NULL,
  `break_length` float DEFAULT NULL,
  `on_1b` int(11) DEFAULT NULL,
  `on_2b` int(11) DEFAULT NULL,
  `on_3b` int(11) DEFAULT NULL,
  `sv_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pitch_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_confidence` float DEFAULT NULL,
  `spin_dir` float DEFAULT NULL,
  `spin_rate` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57090 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gameday_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `eliasid` int(11) DEFAULT NULL,
  `first` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `boxname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lahmanid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `throws` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=920 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abbreviation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stadium` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `umpires` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=765 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
