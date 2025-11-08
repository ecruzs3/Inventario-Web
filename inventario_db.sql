CREATE DATABASE  IF NOT EXISTS `inventario_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventario_db`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: inventario_db
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `movimientos_inventario`
--

DROP TABLE IF EXISTS `movimientos_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos_inventario` (
  `movimiento_id` bigint NOT NULL AUTO_INCREMENT,
  `producto_id` int NOT NULL,
  `tipo` enum('E','S') NOT NULL,
  `cantidad` int NOT NULL,
  `nota` varchar(255) DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`movimiento_id`),
  KEY `fk_mov_prod` (`producto_id`),
  CONSTRAINT `fk_mov_prod` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`producto_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `movimientos_inventario_chk_1` CHECK ((`cantidad` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_inventario`
--

LOCK TABLES `movimientos_inventario` WRITE;
/*!40000 ALTER TABLE `movimientos_inventario` DISABLE KEYS */;
INSERT INTO `movimientos_inventario` VALUES (1,1,'E',50,'Compra inicial','2025-10-10 17:32:09',NULL),(2,2,'E',40,'Compra inicial','2025-10-10 17:32:09',NULL),(3,3,'E',60,'Compra inicial','2025-10-10 17:32:09',NULL),(4,1,'S',5,'Venta #1001','2025-10-10 17:32:09',NULL),(5,2,'S',3,'Venta #1002','2025-10-10 17:32:09',NULL),(6,8,'E',12,'TEST','2025-11-07 23:50:46',NULL),(7,8,'S',6,'TEST','2025-11-07 23:51:32',NULL),(8,8,'S',6,'test','2025-11-07 23:56:22',NULL),(9,1,'E',100,'test','2025-11-08 00:34:33',NULL),(10,8,'E',50,'Pruebas','2025-11-08 01:00:26',NULL);
/*!40000 ALTER TABLE `movimientos_inventario` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_mov_before_insert` BEFORE INSERT ON `movimientos_inventario` FOR EACH ROW BEGIN
  DECLARE v_stock INT;

  -- Validar stock suficiente en salidas
  IF NEW.tipo = 'S' THEN
     SELECT stock_actual INTO v_stock
     FROM productos
     WHERE producto_id = NEW.producto_id
     FOR UPDATE;

     IF v_stock IS NULL THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no existe.';
     END IF;

     IF (v_stock - NEW.cantidad) < 0 THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente para la salida.';
     END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_mov_after_insert` AFTER INSERT ON `movimientos_inventario` FOR EACH ROW BEGIN
  -- Ajuste de stock al insertar
  UPDATE productos
     SET stock_actual = stock_actual + (CASE WHEN NEW.tipo='E' THEN NEW.cantidad ELSE -NEW.cantidad END)
   WHERE producto_id = NEW.producto_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_mov_after_update` AFTER UPDATE ON `movimientos_inventario` FOR EACH ROW BEGIN
  -- Calcular diferencia por cambios de tipo/cantidad/producto
  -- 1) Revertir el movimiento anterior
  UPDATE productos
     SET stock_actual = stock_actual - (CASE WHEN OLD.tipo='E' THEN OLD.cantidad ELSE -OLD.cantidad END)
   WHERE producto_id = OLD.producto_id;

  -- 2) Aplicar el nuevo movimiento
  UPDATE productos
     SET stock_actual = stock_actual + (CASE WHEN NEW.tipo='E' THEN NEW.cantidad ELSE -NEW.cantidad END)
   WHERE producto_id = NEW.producto_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_mov_after_delete` AFTER DELETE ON `movimientos_inventario` FOR EACH ROW BEGIN
  -- Revertir el ajuste de stock al eliminar un movimiento
  UPDATE productos
     SET stock_actual = stock_actual - (CASE WHEN OLD.tipo='E' THEN OLD.cantidad ELSE -OLD.cantidad END)
   WHERE producto_id = OLD.producto_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `producto_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `precio_compra` decimal(12,2) NOT NULL DEFAULT '0.00',
  `precio_venta` decimal(12,2) NOT NULL DEFAULT '0.00',
  `stock_actual` int NOT NULL DEFAULT '0',
  `stock_minimo` int NOT NULL DEFAULT '0',
  `proveedor_id` int DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `creado_en` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `fecha_vencimiento` datetime DEFAULT NULL,
  PRIMARY KEY (`producto_id`),
  KEY `fk_productos_proveedor` (`proveedor_id`),
  KEY `idx_productos_nombre` (`nombre`),
  CONSTRAINT `fk_productos_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`proveedor_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Gloss Rosaaaa','Gloss tono rosa',12.50,25.00,145,10,6,1,'2025-10-10 17:32:09','2025-11-08 00:57:26','2025-11-30 00:00:00'),(2,'Rubor Coral','Rubor en polvo tono coral',20.00,39.90,37,8,7,0,'2025-10-10 17:32:09','2025-11-08 00:57:30','2025-11-10 00:00:00'),(3,'Corrector Beige','Corrector líquido beige',18.00,34.90,60,12,6,1,'2025-10-10 17:32:09','2025-11-08 00:57:34','2025-11-30 00:00:00'),(8,'Varios','test',1.50,2.50,50,12,7,0,'2025-11-07 23:46:26','2025-11-08 01:00:25','2025-12-02 00:00:00');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `proveedor_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  `creado_en` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`proveedor_id`),
  UNIQUE KEY `uk_proveedores_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (6,'Asociados, S.A.','33545421','asoc@gmail.com','Guatemala',1,'2025-11-07 23:26:52','2025-11-08 00:56:59'),(7,'Inteli, S.A..','87545421','int@gmail.com','Guatemala',1,'2025-11-08 00:57:16','2025-11-08 01:00:55');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_kardex_simple`
--

DROP TABLE IF EXISTS `vw_kardex_simple`;
/*!50001 DROP VIEW IF EXISTS `vw_kardex_simple`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_kardex_simple` AS SELECT 
 1 AS `movimiento_id`,
 1 AS `producto_id`,
 1 AS `producto`,
 1 AS `tipo`,
 1 AS `cantidad`,
 1 AS `cantidad_con_signo`,
 1 AS `nota`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_stock_actual`
--

DROP TABLE IF EXISTS `vw_stock_actual`;
/*!50001 DROP VIEW IF EXISTS `vw_stock_actual`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_stock_actual` AS SELECT 
 1 AS `producto_id`,
 1 AS `nombre`,
 1 AS `stock_actual`,
 1 AS `stock_minimo`,
 1 AS `precio_compra`,
 1 AS `precio_venta`,
 1 AS `proveedor_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_stock_bajo`
--

DROP TABLE IF EXISTS `vw_stock_bajo`;
/*!50001 DROP VIEW IF EXISTS `vw_stock_bajo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_stock_bajo` AS SELECT 
 1 AS `producto_id`,
 1 AS `nombre`,
 1 AS `stock_actual`,
 1 AS `stock_minimo`,
 1 AS `faltante`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_kardex_simple`
--

/*!50001 DROP VIEW IF EXISTS `vw_kardex_simple`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_kardex_simple` AS select `m`.`movimiento_id` AS `movimiento_id`,`m`.`producto_id` AS `producto_id`,`p`.`nombre` AS `producto`,`m`.`tipo` AS `tipo`,`m`.`cantidad` AS `cantidad`,(case when (`m`.`tipo` = 'E') then `m`.`cantidad` else -(`m`.`cantidad`) end) AS `cantidad_con_signo`,`m`.`nota` AS `nota` from (`movimientos_inventario` `m` join `productos` `p` on((`p`.`producto_id` = `m`.`producto_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_stock_actual`
--

/*!50001 DROP VIEW IF EXISTS `vw_stock_actual`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_stock_actual` AS select `p`.`producto_id` AS `producto_id`,`p`.`nombre` AS `nombre`,`p`.`stock_actual` AS `stock_actual`,`p`.`stock_minimo` AS `stock_minimo`,`p`.`precio_compra` AS `precio_compra`,`p`.`precio_venta` AS `precio_venta`,`p`.`proveedor_id` AS `proveedor_id` from `productos` `p` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_stock_bajo`
--

/*!50001 DROP VIEW IF EXISTS `vw_stock_bajo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_stock_bajo` AS select `p`.`producto_id` AS `producto_id`,`p`.`nombre` AS `nombre`,`p`.`stock_actual` AS `stock_actual`,`p`.`stock_minimo` AS `stock_minimo`,(`p`.`stock_minimo` - `p`.`stock_actual`) AS `faltante` from `productos` `p` where (`p`.`stock_actual` <= `p`.`stock_minimo`) */;
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

-- Dump completed on 2025-11-07 19:18:56
