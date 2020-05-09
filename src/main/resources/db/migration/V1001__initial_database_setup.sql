USE `smart` ;

-- -----------------------------------------------------
-- Table `smart`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart`.`users` (
                          `id` INT NOT NULL AUTO_INCREMENT,
                          `name` VARCHAR(45) NOT NULL,
                          `mail` VARCHAR(45) NOT NULL,
                          `login` VARCHAR(45) NOT NULL,
                          `password` VARCHAR(128) NOT NULL,
                          `enabled` boolean NOT NULL default true,
                          `role` varchar(16) NOT NULL default 'USER',
                          PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `smart`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart`.`categories` (
                            `id` INT NOT NULL AUTO_INCREMENT,
                            `name` VARCHAR(45) NOT NULL,
                            `description` VARCHAR(45) NOT NULL,
                            PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `smart`.`brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart`.`brands` (
                            `id` INT NOT NULL AUTO_INCREMENT,
                            `name` VARCHAR(45) NOT NULL,
                            PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `smart`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart`.`products` (
                 `id` INT NOT NULL AUTO_INCREMENT,
                 `name` VARCHAR(45) NOT NULL,
                 `description` VARCHAR(45) NOT NULL,
                 `img` VARCHAR(45) NOT NULL,
                 `price` FLOAT NOT NULL,
                 `categories_id` INT NOT NULL,
                 `brands_id` INT NOT NULL,
                 PRIMARY KEY (`id`),
                 CONSTRAINT `fk_products_categories`
                     FOREIGN KEY (`categories_id`)
                         REFERENCES `smart`.`categories` (`id`),
                 CONSTRAINT `fk_products_brands1`
                     FOREIGN KEY (`brands_id`)
                         REFERENCES `smart`.`brands` (`id`));
