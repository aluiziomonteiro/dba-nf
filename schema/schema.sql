-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`ESTADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ESTADO` (
  `UF` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`UF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CIDADE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CIDADE` (
  `ID_CIDADE` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(60) NOT NULL,
  `UF` INT NOT NULL,
  PRIMARY KEY (`ID_CIDADE`, `UF`),
  INDEX `fk_CIDADE_ESTADO1_idx` (`UF` ASC) VISIBLE,
  CONSTRAINT `fk_CIDADE_ESTADO1`
    FOREIGN KEY (`UF`)
    REFERENCES `mydb`.`ESTADO` (`UF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ENDERECO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ENDERECO` (
  `ID_ENDERECO` INT NOT NULL AUTO_INCREMENT,
  `RUA` VARCHAR(60) NOT NULL,
  `COMPLEMENTO` VARCHAR(60) NOT NULL,
  `NUM` INT NOT NULL,
  `CEP` VARCHAR(8) NOT NULL,
  `BAIRRO` VARCHAR(60) NOT NULL,
  `ID_CIDADE` INT NOT NULL,
  PRIMARY KEY (`ID_ENDERECO`, `ID_CIDADE`),
  INDEX `fk_ENDERECO_CIDADE1_idx` (`ID_CIDADE` ASC) VISIBLE,
  CONSTRAINT `fk_ENDERECO_CIDADE1`
    FOREIGN KEY (`ID_CIDADE`)
    REFERENCES `mydb`.`CIDADE` (`ID_CIDADE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EMPRESA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EMPRESA` (
  `CNPJ` INT NOT NULL,
  `NOME_FANTASIA` VARCHAR(80) NOT NULL,
  `TELEFONE` VARCHAR(10) NOT NULL,
  `ID_ENDERECO` INT NOT NULL,
  PRIMARY KEY (`CNPJ`),
  INDEX `fk_EMPRESA_ENDERECO1_idx` (`ID_ENDERECO` ASC) VISIBLE,
  CONSTRAINT `fk_EMPRESA_ENDERECO1`
    FOREIGN KEY (`ID_ENDERECO`)
    REFERENCES `mydb`.`ENDERECO` (`ID_ENDERECO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUTO` (
  `ID_PRODUTO` INT NOT NULL AUTO_INCREMENT,
  `DESCRICAO_PRODUTO` VARCHAR(200) NOT NULL,
  `QUANTIDADE_ESTOQUE` INT NOT NULL,
  `PRECO_UNITARIO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_PRODUTO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CLIENTE` (
  `CPF` VARCHAR(11) NOT NULL,
  `NOME` VARCHAR(80) NOT NULL,
  `TELEFONE` VARCHAR(10) NOT NULL,
  `ID_ENDERECO` INT NOT NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_CLIENTE_ENDERECO_idx` (`ID_ENDERECO` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENTE_ENDERECO`
    FOREIGN KEY (`ID_ENDERECO`)
    REFERENCES `mydb`.`ENDERECO` (`ID_ENDERECO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`NOTA_FISCAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`NOTA_FISCAL` (
  `NUM_NOTA_FISCAL` INT NOT NULL AUTO_INCREMENT,
  `DT_NOTA_FISCAL` DATE NOT NULL,
  `CPF` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`NUM_NOTA_FISCAL`, `CPF`),
  INDEX `fk_NOTA_FISCAL_CLIENTE1_idx` (`CPF` ASC) VISIBLE,
  CONSTRAINT `fk_NOTA_FISCAL_CLIENTE1`
    FOREIGN KEY (`CPF`)
    REFERENCES `mydb`.`CLIENTE` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ITEM_NOTA_FISCAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ITEM_NOTA_FISCAL` (
  `ID_ITEM_NOTA_FISCAL` INT NOT NULL AUTO_INCREMENT,
  `QUANTIDADE_ITEM` INT NOT NULL,
  `PRECO_UNITARIO_ITEM` DECIMAL(10,2) NOT NULL,
  `NUM_NOTA_FISCAL` INT NOT NULL,
  `ID_PRODUTO` INT NOT NULL,
  PRIMARY KEY (`ID_ITEM_NOTA_FISCAL`, `NUM_NOTA_FISCAL`, `ID_PRODUTO`),
  INDEX `fk_ITEM_NOTA_FISCAL_PRODUTO1_idx` (`ID_PRODUTO` ASC) VISIBLE,
  INDEX `fk_ITEM_NOTA_FISCAL_NOTA_FISCAL1_idx` (`NUM_NOTA_FISCAL` ASC) VISIBLE,
  CONSTRAINT `fk_ITEM_NOTA_FISCAL_PRODUTO1`
    FOREIGN KEY (`ID_PRODUTO`)
    REFERENCES `mydb`.`PRODUTO` (`ID_PRODUTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEM_NOTA_FISCAL_NOTA_FISCAL1`
    FOREIGN KEY (`NUM_NOTA_FISCAL`)
    REFERENCES `mydb`.`NOTA_FISCAL` (`NUM_NOTA_FISCAL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
