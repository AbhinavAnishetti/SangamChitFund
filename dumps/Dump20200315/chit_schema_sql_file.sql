CREATE DATABASE `chit_schema` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `chit_details` (
  `Chit_Id` int unsigned NOT NULL,
  `Chit_Type` varchar(45) NOT NULL,
  `Chit_Amount` decimal(10,9) NOT NULL,
  `Emi` decimal(10,9) unsigned NOT NULL,
  `No_of_months` int unsigned NOT NULL,
  PRIMARY KEY (`Chit_Id`),
  UNIQUE KEY `Chit_Type_UNIQUE` (`Chit_Type`),
  UNIQUE KEY `Chit_Amount_UNIQUE` (`Chit_Amount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `chit_person_reltn` (
  `Chit_person_reltn_id` double unsigned NOT NULL,
  `Member_id` double unsigned NOT NULL,
  `Chit_id` int unsigned NOT NULL,
  `Date_of_chit` date NOT NULL,
  `No_of_months_paid` int unsigned NOT NULL,
  `Balance` decimal(10,9) unsigned NOT NULL,
  `Total_Amount` decimal(10,9) unsigned NOT NULL,
  PRIMARY KEY (`Chit_person_reltn_id`),
  KEY `FK_Member_id_idx` (`Member_id`),
  KEY `FK_Chit_id_idx` (`Chit_id`),
  CONSTRAINT `FK_Chit_id` FOREIGN KEY (`Chit_id`) REFERENCES `chit_details` (`Chit_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Chit_Member_id` FOREIGN KEY (`Member_id`) REFERENCES `member` (`Member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `loan` (
  `Loan_id` double unsigned NOT NULL,
  `Loan_Amount` decimal(10,9) unsigned NOT NULL,
  `Date_of_loan` date NOT NULL,
  `EMI` decimal(10,9) NOT NULL,
  `Referal_id` double unsigned NOT NULL,
  `Member_id` double unsigned NOT NULL,
  `Balance` decimal(10,9) unsigned NOT NULL,
  `Balance_Amount` double unsigned NOT NULL,
  `Months_Paid` int DEFAULT NULL,
  `Total_Months` int unsigned NOT NULL,
  `Interest_Rate` decimal(10,9) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`Loan_id`),
  KEY `FK_REFERAL_ID_idx` (`Referal_id`),
  KEY `FK_MEMBER_ID_idx` (`Member_id`),
  CONSTRAINT `FK_MEMBER_ID` FOREIGN KEY (`Member_id`) REFERENCES `member` (`Member_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REFERAL_ID` FOREIGN KEY (`Referal_id`) REFERENCES `member` (`Member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `member` (
  `Member_id` double unsigned NOT NULL,
  `First_Name` varchar(45) NOT NULL,
  `Last_Name` varchar(45) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Date_of_Birth` date NOT NULL,
  `Id_Proof_type` varchar(45) NOT NULL,
  `Phone_Number` double unsigned DEFAULT NULL,
  `Email_id` varchar(45) DEFAULT NULL,
  `Role_id` int unsigned NOT NULL,
  PRIMARY KEY (`Member_id`),
  KEY `FK_role_id_idx` (`Role_id`),
  CONSTRAINT `FK_role_id` FOREIGN KEY (`Role_id`) REFERENCES `role` (`Role_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Demographics of a member';

CREATE TABLE `payment` (
  `Payment_Id` double unsigned NOT NULL,
  `Receipt_id` double unsigned NOT NULL,
  `Payment_Date` date NOT NULL,
  `chit_amount_paid` decimal(10,9) unsigned NOT NULL,
  `loan_amount_paid` decimal(10,9) unsigned NOT NULL,
  `Member_id` double unsigned NOT NULL,
  `Chit_id` double unsigned NOT NULL,
  `Loan_id` double unsigned NOT NULL,
  `Total_amount_paid` decimal(10,9) unsigned NOT NULL,
  PRIMARY KEY (`Payment_Id`),
  KEY `FK_RECEIPT_ID_idx` (`Receipt_id`),
  KEY `FK_Loan_Pay_id_idx` (`Loan_id`),
  KEY `FK_Mem_payment_id_idx` (`Member_id`),
  KEY `FK_Chit_Payment_id_idx` (`Chit_id`),
  CONSTRAINT `FK_Chit_Pymnt_id` FOREIGN KEY (`Chit_id`) REFERENCES `chit_person_reltn` (`Chit_person_reltn_id`),
  CONSTRAINT `FK_Loan_Pay_id` FOREIGN KEY (`Loan_id`) REFERENCES `loan` (`Loan_id`),
  CONSTRAINT `FK_Mem_payment_id` FOREIGN KEY (`Member_id`) REFERENCES `member` (`Member_id`),
  CONSTRAINT `FK_RECEIPT_ID` FOREIGN KEY (`Receipt_id`) REFERENCES `reciept` (`Reciept_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `reciept` (
  `Reciept_id` double unsigned NOT NULL,
  `Member_id` double unsigned NOT NULL,
  `Chit_id` double unsigned NOT NULL,
  `Date_of_chit` date NOT NULL,
  `Chit_Amount` decimal(10,9) unsigned NOT NULL,
  `Balance_Amount` decimal(10,9) unsigned NOT NULL,
  `Current_date` date DEFAULT NULL,
  `Payment_Amount` decimal(10,9) unsigned NOT NULL,
  `Payment_Method` varchar(45) DEFAULT NULL,
  `Loan_id` double unsigned NOT NULL,
  `Loan_Amount` decimal(10,9) DEFAULT NULL,
  `Loan_Emi` decimal(10,9) unsigned NOT NULL,
  `Chit_Emi` decimal(10,9) unsigned NOT NULL,
  `total_amount` decimal(10,9) unsigned NOT NULL,
  PRIMARY KEY (`Reciept_id`),
  KEY `FK_RC_MEM_ID_idx` (`Member_id`),
  KEY `FK_RC_CHIT_ID_idx` (`Chit_id`),
  KEY `FK_RC_LOAN_ID_idx` (`Loan_id`),
  CONSTRAINT `FK_RC_Chit_id` FOREIGN KEY (`Chit_id`) REFERENCES `chit_person_reltn` (`Chit_person_reltn_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RC_Loan_id` FOREIGN KEY (`Loan_id`) REFERENCES `loan` (`Loan_id`),
  CONSTRAINT `FK_RC_Mem_id` FOREIGN KEY (`Member_id`) REFERENCES `member` (`Member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `role` (
  `Role_Id` int unsigned NOT NULL,
  `Role_type` varchar(45) NOT NULL,
  PRIMARY KEY (`Role_Id`),
  UNIQUE KEY `Role_type_UNIQUE` (`Role_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Defines the role of a member';






