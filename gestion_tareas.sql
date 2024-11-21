-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-11-2024 a las 23:48:48
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_tareas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_project` (IN `p_project_id` INT)   BEGIN
    -- Eliminar los registros relacionados en project_logs
    DELETE FROM project_logs WHERE project_id = p_project_id;

    -- Eliminar el proyecto
    DELETE FROM projects WHERE id = p_project_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_task` (IN `task_id` BIGINT(20))   BEGIN
    DELETE FROM tasks WHERE id = task_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProjectsByUser` (IN `user_id` BIGINT)   BEGIN
    SELECT id, name, user_id, created_at, updated_at
    FROM projects
    WHERE user_id = user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTasksByProject` (IN `project_id` BIGINT)   BEGIN
    SELECT id, title, description, is_completed, project_id, created_at, updated_at
    FROM tasks
    WHERE project_id = project_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_project` (IN `project_name` VARCHAR(255), IN `project_user_id` BIGINT(20))   BEGIN
    INSERT INTO projects (name, user_id, created_at, updated_at)
    VALUES (project_name, project_user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_task` (IN `p_title` VARCHAR(255), IN `p_description` TEXT, IN `p_is_completed` BOOLEAN, IN `p_project_id` INT)   BEGIN
    INSERT INTO tasks (title, description, is_completed, project_id)
    VALUES (p_title, p_description, p_is_completed, p_project_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateProject` (IN `p_project_id` INT, IN `p_name` VARCHAR(255), IN `p_user_id` INT)   BEGIN
    -- Verifica si el proyecto pertenece al usuario
    IF EXISTS (SELECT 1 FROM projects WHERE id = p_project_id AND user_id = p_user_id) THEN
        -- Si el proyecto pertenece al usuario, realiza la actualización
        UPDATE projects
        SET name = p_name, updated_at = NOW()
        WHERE id = p_project_id;
    ELSE
        -- Si no pertenece al usuario, devuelve un error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No tienes permiso para actualizar este proyecto';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_task` (IN `task_id` BIGINT(20), IN `task_title` VARCHAR(255), IN `task_description` TEXT, IN `task_is_completed` BOOLEAN)   BEGIN
    UPDATE tasks
    SET title = task_title, description = task_description, is_completed = task_is_completed, updated_at = CURRENT_TIMESTAMP
    WHERE id = task_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2024_11_03_163959_create_users_table', 1),
(3, '2024_11_03_164011_create_projects_table', 1),
(4, '2024_11_03_164020_create_tasks_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(29, 'App\\Models\\User', 3, 'auth_token', '0673aba613cf866a8683b5adb63ce3a03d3763204f6f1763aa839dea0ff26ad1', '[\"*\"]', '2024-11-21 02:10:18', NULL, '2024-11-21 02:10:13', '2024-11-21 02:10:18'),
(30, 'App\\Models\\User', 3, 'auth_token', '0d56ac8251a4820caf5a2334ec1adfe2bfb3bfc399a26db523a8b05c5ceac4c4', '[\"*\"]', '2024-11-21 02:10:46', NULL, '2024-11-21 02:10:40', '2024-11-21 02:10:46'),
(33, 'App\\Models\\User', 3, 'auth_token', 'f08d3d719d7be7de953532714c65ad706dddb44d29f24aee74d3f832475cd369', '[\"*\"]', '2024-11-21 22:39:54', NULL, '2024-11-21 22:23:43', '2024-11-21 22:39:54'),
(34, 'App\\Models\\User', 3, 'auth_token', 'be513a2d07a706158388e32633df0b68edaae442e908cc679338dee31439772a', '[\"*\"]', '2024-11-22 01:42:39', NULL, '2024-11-22 00:43:48', '2024-11-22 01:42:39'),
(36, 'App\\Models\\User', 3, 'auth_token', '1dd3c981387583f1e42748d937c70b5433bfeeaa22ea5f5234951900c51bff10', '[\"*\"]', '2024-11-22 03:02:54', NULL, '2024-11-22 02:08:24', '2024-11-22 03:02:54'),
(38, 'App\\Models\\User', 6, 'auth_token', 'a699d017f7e5b5ced00a5b0e9e54ecf0f8f6d9eaf74717d783690ce2be7212f8', '[\"*\"]', '2024-11-22 02:41:12', NULL, '2024-11-22 02:35:23', '2024-11-22 02:41:12'),
(42, 'App\\Models\\User', 3, 'auth_token', '8e612da415b5661bb722ba062136dab9f8efff1d39af24e84d344f41fa5d1704', '[\"*\"]', '2024-11-22 03:24:37', NULL, '2024-11-22 03:03:56', '2024-11-22 03:24:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `projects`
--

CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `projects`
--

INSERT INTO `projects` (`id`, `name`, `user_id`, `created_at`, `updated_at`) VALUES
(2, 'gestionador', 3, '2024-11-21 20:44:05', '2024-11-21 20:44:05'),
(3, 'asasas', 6, '2024-11-22 03:03:17', '2024-11-22 03:03:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `project_logs`
--

CREATE TABLE `project_logs` (
  `id` int(11) NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `action` enum('created','updated','deleted') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tasks`
--

CREATE TABLE `tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_completed` tinyint(1) NOT NULL DEFAULT 0,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tasks`
--

INSERT INTO `tasks` (`id`, `title`, `description`, `is_completed`, `project_id`, `created_at`, `updated_at`) VALUES
(16, 'asasa', 'sasas', 0, 2, '2024-11-21 21:42:28', '2024-11-21 21:42:28');

--
-- Disparadores `tasks`
--
DELIMITER $$
CREATE TRIGGER `trg_task_created` AFTER INSERT ON `tasks` FOR EACH ROW BEGIN
    INSERT INTO task_logs (task_id, project_id, action, created_at, updated_at)
    VALUES (NEW.id, NEW.project_id, 'created', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_task_updated` AFTER UPDATE ON `tasks` FOR EACH ROW BEGIN
    IF NEW.is_completed != OLD.is_completed THEN
        INSERT INTO task_logs (task_id, project_id, action, created_at, updated_at)
        VALUES (NEW.id, NEW.project_id, 'updated', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `task_logs`
--

CREATE TABLE `task_logs` (
  `id` int(11) NOT NULL,
  `task_id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `action` enum('created','updated','deleted') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `task_logs`
--

INSERT INTO `task_logs` (`id`, `task_id`, `project_id`, `action`, `created_at`, `updated_at`) VALUES
(6, 16, 2, 'created', '2024-11-21 21:42:28', '2024-11-21 21:42:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Usuario Ejemplo', 'usuario@example.com', '$2y$12$tHC1FDNyGuDcRGHcLFctpO/CtCvaRvxruntgEbi.Ujt7hfd34daqu', '2024-11-03 21:53:51', '2024-11-03 21:53:51'),
(2, 'Tu Nombre', 'tuemail@example.com', '$2y$12$/MRltHf4xUi0/lsc4ZmisObRTEMuefqZSJf6XZrm6bGzAHg33Fw.e', '2024-11-03 23:20:15', '2024-11-03 23:20:15'),
(3, 'Abilson', 'abilsongamer078@gmail.com', '$2y$12$9e6jKfnJrVI2lR5XOgcT/e07/F3nLu4WQYEhvtoWp8gFmnsNE/vmy', '2024-11-03 23:21:46', '2024-11-03 23:21:46'),
(4, 'Angelin', 'angelin@gmail.com', '$2y$12$i.6n/jElrfllbE4Q.5S3aO0GL9C4.oCkdAbdvw.PIoj8fqdZtaMoy', '2024-11-07 02:16:32', '2024-11-07 02:16:32'),
(5, 'Angelin', 'angelin2.0@gmail.com', '$2y$12$UQHKrGsb2uL3sLvIfW.Ane5w5q7wBZ4SOD3PAbjX.7PdoDOyqLk8K', '2024-11-07 02:17:54', '2024-11-07 02:17:54'),
(6, 'liam', 'liam@gmail.com', '$2y$12$9oa3aA2c5JW1D/MUwgvJGee0FDhLC88n0w31PzZltXdSiQVf5cW32', '2024-11-22 02:35:07', '2024-11-22 02:35:07');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `project_logs`
--
ALTER TABLE `project_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indices de la tabla `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indices de la tabla `task_logs`
--
ALTER TABLE `task_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_id` (`task_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `project_logs`
--
ALTER TABLE `project_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `task_logs`
--
ALTER TABLE `task_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `project_logs`
--
ALTER TABLE `project_logs`
  ADD CONSTRAINT `project_logs_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `task_logs`
--
ALTER TABLE `task_logs`
  ADD CONSTRAINT `task_logs_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_logs_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
