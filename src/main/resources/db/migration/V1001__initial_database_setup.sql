USE `smart` ;

-- -----------------------------------------------------
-- Table `smart`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart`.`user` (
                          `id` INT NOT NULL AUTO_INCREMENT,
                          `name` VARCHAR(45) NOT NULL,
                          `mail` VARCHAR(45) NOT NULL,
                          `password` VARCHAR(45) NOT NULL,
                          PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smart`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart`.`categories` (
                            `id` INT NOT NULL AUTO_INCREMENT,
                            `name` VARCHAR(45) NOT NULL,
                            `description` VARCHAR(45) NOT NULL,
                            PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smart`.`brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart`.`brands` (
                            `id` INT NOT NULL AUTO_INCREMENT,
                            `name` VARCHAR(45) NOT NULL,
                            PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smart`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart`.`product` (
                 `id` INT NOT NULL AUTO_INCREMENT,
                 `name` VARCHAR(45) NOT NULL,
                 `description` VARCHAR(45) NOT NULL,
                 `price` FLOAT NOT NULL,
                 `categories_id` INT NOT NULL,
                 `brands_id` INT NOT NULL,
                 PRIMARY KEY (`id`),
                 INDEX `fk_product_categories_idx` (`categories_id` ASC) VISIBLE,
                 INDEX `fk_product_brands1_idx` (`brands_id` ASC) VISIBLE,
                 CONSTRAINT `fk_product_categories`
                     FOREIGN KEY (`categories_id`)
                         REFERENCES `smart`.`categories` (`id`)
                         ON DELETE NO ACTION
                         ON UPDATE NO ACTION,
                 CONSTRAINT `fk_product_brands1`
                     FOREIGN KEY (`brands_id`)
                         REFERENCES `smart`.`brands` (`id`)
                         ON DELETE NO ACTION
                         ON UPDATE NO ACTION)
    ENGINE = InnoDB;
