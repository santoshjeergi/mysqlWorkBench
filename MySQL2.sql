CREATE DATABASE IF NOT EXISTS scaler_lect;

use scaler_lect;


/*first way*/
CREATE TABLE students (
	id INT PRIMARY KEY,
	first_name VARCHAR(18),
	last_name VARCHAR(18),
	email VARCHAR(10),
	phone VARCHAR(10)
);

DROP TABLE IF EXISTS students;
/*2nd way*/
CREATE TABLE students (
	id INT, 
   	first_name VARCHAR(18),
	last_name VARCHAR(18),
	email VARCHAR(10),
	phone VARCHAR(10),
    /*PRIMARY KEY(id)  /*single attribute*/
    PRIMARY KEY(id, first_name)  /*composite primary key */
);

/*3rd way*/

CREATE TABLE students (
	id INT, 
   	first_name VARCHAR(18),
	last_name VARCHAR(18),
	email VARCHAR(10),
	phone VARCHAR(10)  
);
ALTER TABLE students 
	ADD constraint PK_ID primary key(id);

/*unique key*/
DROP TABLE IF EXISTS students;

CREATE TABLE students (
	id INT, 
   	first_name VARCHAR(18),
	last_name VARCHAR(18),
	email VARCHAR(10),
	phone VARCHAR(10),
    unique KEY(EMAIL),
    /*UNIQUE KEY(PHONE) /*single attribute*/ 
    UNIQUE KEY(PHONE, EMAIL) /*composite key */
);


DROP TABLE IF EXISTS students;
CREATE TABLE students (
	id INT, 
   	first_name VARCHAR(18),
	last_name VARCHAR(18),
	email VARCHAR(10),
	phone VARCHAR(10)
);

ALTER TABLE students 
	ADD constraint UK_Phone UNIQUE KEY(PHONE);   /*using name allows later to drop the constrain by name*/
    
ALTER TABLE students 
	ADD constraint UK_EMAIL UNIQUE KEY(EMAIL);

CREATE TABLE batches (
 id INT PRIMARY KEY,
 name VARCHAR(10)
 );
 
 
 ALTER TABLE students 
 ADD bid INT NOT NULL;
 
 
 ALTER TABLE students 
  ADD constraint FK_Students_Batches FOREIGN KEY(bid) 
  REFERENCES batches(id);

INSERT into batches VALUES (1, "BATCH1");

show full tables;

select * from batches;


select * from scaler_lect.students;


insert into students values( 1, "san", "kum", "sa@a.com", "9880", 5);   /*foreign key constrain*/

insert into students values( 2, "san", "kum", "sa@a.com", "9880", NULL);   
