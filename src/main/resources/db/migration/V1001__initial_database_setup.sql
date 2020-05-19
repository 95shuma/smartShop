USE `smart` ;

CREATE TABLE IF NOT EXISTS `smart`.`users` (
                          `id` INT NOT NULL AUTO_INCREMENT,
                          `name` VARCHAR(45) NOT NULL,
                          `mail` VARCHAR(45) NOT NULL,
                          `login` VARCHAR(45) NOT NULL,
                          `password` VARCHAR(128) NOT NULL,
                          `enabled` boolean NOT NULL default true,
                          `role` varchar(16) NOT NULL default 'USER',
                          PRIMARY KEY (`id`),
                        UNIQUE INDEX `mail_unique` (`mail` ASC));

CREATE TABLE IF NOT EXISTS `smart`.`baskets` (
                        `id` INT NOT NULL AUTO_INCREMENT,
                        `session` VARCHAR(128) NOT NULL,
                        `users_id` INT NULL,
                        PRIMARY KEY (`id`),
                        INDEX `fk_baskets_users1_idx` (`users_id` ASC) VISIBLE,
                        CONSTRAINT `fk_baskets_users1`
                            FOREIGN KEY (`users_id`)
                                REFERENCES `smart`.`users` (`id`)
                                ON DELETE NO ACTION
                                ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `smart`.`categories` (
                            `id` INT NOT NULL AUTO_INCREMENT,
                            `name` VARCHAR(45) NOT NULL,
                            `description` VARCHAR(45) NOT NULL,
                            `img` VARCHAR(45) NOT NULL,
                            PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `smart`.`brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smart`.`brands` (
                            `id` INT NOT NULL AUTO_INCREMENT,
                            `name` VARCHAR(45) NOT NULL,
                            `img` VARCHAR(45) NOT NULL,
                            PRIMARY KEY (`id`));


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

CREATE TABLE IF NOT EXISTS `smart`.`baskets_products` (
              `id` INT NOT NULL AUTO_INCREMENT,
              `quantity` INT NOT NULL DEFAULT '1',
                 `baskets_id` INT NOT NULL,
                 `products_id` INT NOT NULL,
                 PRIMARY KEY (`id`,`baskets_id`, `products_id`),
                 INDEX `fk_baskets_has_products_products1_idx` (`products_id` ASC) VISIBLE,
                 INDEX `fk_baskets_has_products_baskets1_idx` (`baskets_id` ASC) VISIBLE,
                 CONSTRAINT `fk_baskets_has_products_baskets1`
                     FOREIGN KEY (`baskets_id`)
                         REFERENCES `smart`.`baskets` (`id`)
                         ON DELETE NO ACTION
                         ON UPDATE NO ACTION,
                 CONSTRAINT `fk_baskets_has_products_products1`
                     FOREIGN KEY (`products_id`)
                         REFERENCES `smart`.`products` (`id`)
                         ON DELETE NO ACTION
                         ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `smart`.`resets` (
                   `id` INT NOT NULL AUTO_INCREMENT,
                   `token` VARCHAR(255) NULL DEFAULT NULL,
                   `users_id` INT NOT NULL,
                   PRIMARY KEY (`id`),
                   INDEX `fk_resets_users_idx` (`users_id` ASC) VISIBLE,
                   CONSTRAINT `fk_resets_users`
                       FOREIGN KEY (`users_id`)
                           REFERENCES `smart`.`users` (`id`)
                           ON DELETE NO ACTION
                           ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `smart`.`reviews` (
                `id` INT NOT NULL AUTO_INCREMENT,
                `text` VARCHAR(255) NOT NULL,
                `users_id` INT NOT NULL,
                `products_id` INT NOT NULL,
                PRIMARY KEY (`id`),
                INDEX `fk_reviews_users1_idx` (`users_id` ASC) VISIBLE,
                INDEX `fk_reviews_products1_idx` (`products_id` ASC) VISIBLE,
                CONSTRAINT `fk_reviews_users1`
                    FOREIGN KEY (`users_id`)
                        REFERENCES `smart`.`users` (`id`)
                        ON DELETE NO ACTION
                        ON UPDATE NO ACTION,
                CONSTRAINT `fk_reviews_products1`
                    FOREIGN KEY (`products_id`)
                        REFERENCES `smart`.`products` (`id`)
                        ON DELETE NO ACTION
                        ON UPDATE NO ACTION);