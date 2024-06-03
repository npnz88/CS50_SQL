CREATE TABLE `Users` (
    `id` INT AUTO_INCREMENT,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `username` VARCHAR(255) UNIQUE NOT NULL,
    `password` CHAR(128),
    PRIMARY KEY(`id`)
);

CREATE TABLE `Schools` (
		`id` INT AUTO_INCREMENT,
		`school_name` VARCHAR(255) NOT NULL,
		`type_school` ENUM(`Primary`, `Secondary`, `Higher Education`) NOT NULL,
		`location_school` VARCHAR(255) NOT NULL,
		`founded` DATE NOT NULL,
        PRIMARY KEY (`id`)
);

CREATE TABLE `Companies` (
    `company_id` INT AUTO_INCREMENT,
    `company_name` VARCHAR (20) NOT NULL,
    `industry` VARCHAR (20) NOT NULL,
    `location` VARCHAR (20) NOT NULL,
    PRIMARY KEY(`company_id`)
);

CREATE TABLE `connects` (
    `id` INT AUTO_INCREMENT, --users id
    `user_id` INT NOT NULL,
    `following_user_id` INT NOT NULL,
    `date_connected` DATE NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `Users`(`id`),
    FOREIGN KEY (`following_user_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE `school_affiliate`(
    `school_attendee_id` INT AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `school_id` INT NOT NULL,
    `start_affiliation_date` INT NOT NULL,
    `graduation_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `education_type` VARCHAR(10) NOT NULL,
    PRIMARY KEY(`school_attendee_id`),
    FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`),
    FOREIGN KEY(`school_id`) REFERENCES `Schools`(`id`)
);

CREATE TABLE `company_affiliate`(
    `id` INT AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `company_id` INT NOT NULL,
    `start_work_date` DATE NOT NULL,
    `end_work_date` DATE NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`),
    FOREIGN KEY(`company_id`) REFERENCES `Companies`(`company_id`)
);
