-- ============================================================
-- JMovie - Online Movie Ticket Booking System
-- MySQL / XAMPP Database Schema & Initial Seed Data
-- ============================================================

CREATE DATABASE IF NOT EXISTS `jmovie` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `jmovie`;

-- ------------------------------------------------------------
-- Table Cleanup
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `reviews`;
DROP TABLE IF EXISTS `bookings`;
DROP TABLE IF EXISTS `showtimes`;
DROP TABLE IF EXISTS `movies`;
DROP TABLE IF EXISTS `users`;

-- ------------------------------------------------------------
-- 1. Users Table
-- ------------------------------------------------------------
CREATE TABLE `users` (
  `id`           VARCHAR(20)  NOT NULL,
  `username`     VARCHAR(50)  NOT NULL,
  `password`     VARCHAR(64)  NOT NULL,
  `email`        VARCHAR(100) NOT NULL,
  `phone`        VARCHAR(20)  DEFAULT '',
  `role`         VARCHAR(10)  NOT NULL DEFAULT 'USER',
  `created_at`   VARCHAR(30)  NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed Default Admin & Sample User (password for both is admin123 / SHA-256)
INSERT INTO `users` (`id`, `username`, `password`, `email`, `phone`, `role`, `created_at`) VALUES
('USR00001', 'admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'admin@jmovie.lk', '0777000001', 'ADMIN', '2026-10-10 00:00:00'),
('USR00002', 'john_doe', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'john@gmail.com', '0771234567', 'USER', '2026-10-10 00:00:00');

-- ------------------------------------------------------------
-- 2. Movies Table
-- ------------------------------------------------------------
CREATE TABLE `movies` (
  `id`           VARCHAR(20)  NOT NULL,
  `title`        VARCHAR(200) NOT NULL,
  `genre`        VARCHAR(50)  NOT NULL,
  `description`  TEXT,
  `duration`     INT          NOT NULL DEFAULT 0,
  `rating`       DOUBLE       NOT NULL DEFAULT 0.0,
  `poster_url`   VARCHAR(500) DEFAULT '',
  `release_date` VARCHAR(15)  NOT NULL,
  `status`       VARCHAR(15)  NOT NULL DEFAULT 'NOW_SHOWING',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed Sample Movies with Poster Image URLs
INSERT INTO `movies` (`id`, `title`, `genre`, `description`, `duration`, `rating`, `poster_url`, `release_date`, `status`) VALUES
('MOV00001', 'Interstellar', 'Sci-Fi', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.', 169, 8.7, 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg', '2014-11-07', 'NOW_SHOWING'),
('MOV00002', 'The Dark Knight', 'Action', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', 152, 9.0, 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg', '2008-07-18', 'NOW_SHOWING'),
('MOV00003', 'Inception', 'Thriller', 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', 148, 8.8, 'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg', '2010-07-16', 'NOW_SHOWING'),
('MOV00004', 'Dune: Part Two', 'Sci-Fi', 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.', 166, 8.5, 'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg', '2024-03-01', 'NOW_SHOWING'),
('MOV00005', 'Oppenheimer', 'Drama', 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb during World War II.', 180, 8.9, 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', '2023-07-21', 'NOW_SHOWING'),
('MOV00006', 'Poor Things', 'Comedy', 'The incredible tale about the fantastical evolution of Bella Baxter, a young woman brought back to life by the brilliant and unorthodox scientist Dr. Godwin Baxter.', 141, 7.9, 'https://image.tmdb.org/t/p/w500/kCGlIMHnOm8JPXIRfka3HBpMd7l.jpg', '2023-12-08', 'COMING_SOON');

-- ------------------------------------------------------------
-- 3. Showtimes Table
-- ------------------------------------------------------------
CREATE TABLE `showtimes` (
  `id`              VARCHAR(20)  NOT NULL,
  `movie_id`        VARCHAR(20)  NOT NULL,
  `movie_title`     VARCHAR(200) NOT NULL,
  `theatre_hall`    VARCHAR(50)  NOT NULL,
  `show_date`       VARCHAR(15)  NOT NULL,
  `show_time`       VARCHAR(10)  NOT NULL,
  `total_seats`     INT          NOT NULL DEFAULT 80,
  `available_seats` INT          NOT NULL DEFAULT 80,
  `price`           DOUBLE       NOT NULL DEFAULT 0.0,
  `booked_seats`    TEXT         DEFAULT '',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_showtime_movie` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed Sample Showtimes
INSERT INTO `showtimes` (`id`, `movie_id`, `movie_title`, `theatre_hall`, `show_date`, `show_time`, `total_seats`, `available_seats`, `price`, `booked_seats`) VALUES
('SHW00001', 'MOV00001', 'Interstellar', 'Hall A', '2026-10-15', '10:00', 80, 80, 850.00, ''),
('SHW00002', 'MOV00001', 'Interstellar', 'Hall B', '2026-10-15', '14:30', 80, 80, 850.00, ''),
('SHW00003', 'MOV00001', 'Interstellar', 'Hall A', '2026-10-16', '18:00', 80, 80, 850.00, ''),
('SHW00004', 'MOV00002', 'The Dark Knight', 'Hall C', '2026-10-15', '11:00', 80, 80, 750.00, ''),
('SHW00005', 'MOV00002', 'The Dark Knight', 'Hall C', '2026-10-16', '15:00', 80, 80, 750.00, ''),
('SHW00006', 'MOV00003', 'Inception', 'Hall B', '2026-10-17', '13:00', 80, 80, 800.00, ''),
('SHW00007', 'MOV00004', 'Dune: Part Two', 'IMAX Hall', '2026-10-15', '16:00', 60, 60, 1200.00, ''),
('SHW00008', 'MOV00004', 'Dune: Part Two', 'IMAX Hall', '2026-10-16', '19:30', 60, 60, 1200.00, ''),
('SHW00009', 'MOV00005', 'Oppenheimer', 'Hall A', '2026-10-18', '12:00', 80, 80, 900.00, '');

-- ------------------------------------------------------------
-- 4. Bookings Table
-- ------------------------------------------------------------
CREATE TABLE `bookings` (
  `id`            VARCHAR(20)  NOT NULL,
  `user_id`       VARCHAR(20)  NOT NULL,
  `username`      VARCHAR(50)  NOT NULL,
  `showtime_id`   VARCHAR(20)  NOT NULL,
  `movie_id`      VARCHAR(20)  NOT NULL,
  `movie_title`   VARCHAR(200) NOT NULL,
  `seats`         VARCHAR(200) NOT NULL,
  `quantity`      INT          NOT NULL DEFAULT 1,
  `total_amount`  DOUBLE       NOT NULL DEFAULT 0.0,
  `status`        VARCHAR(15)  NOT NULL DEFAULT 'CONFIRMED',
  `booking_date`  VARCHAR(30)  NOT NULL,
  `show_date`     VARCHAR(15)  NOT NULL,
  `show_time`     VARCHAR(10)  NOT NULL,
  `theatre_hall`  VARCHAR(50)  DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 5. Reviews Table
-- ------------------------------------------------------------
CREATE TABLE `reviews` (
  `id`           VARCHAR(20)  NOT NULL,
  `user_id`      VARCHAR(20)  NOT NULL,
  `username`     VARCHAR(50)  NOT NULL,
  `movie_id`     VARCHAR(20)  NOT NULL,
  `movie_title`  VARCHAR(200) NOT NULL,
  `rating`       DOUBLE       NOT NULL DEFAULT 5.0,
  `comment`      TEXT         NOT NULL,
  `status`       VARCHAR(15)  NOT NULL DEFAULT 'APPROVED',
  `review_type`  VARCHAR(15)  NOT NULL DEFAULT 'PUBLIC',
  `created_at`   VARCHAR(30)  NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
