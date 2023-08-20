# mysqlWorkBench


### Exceptions for new table creation in 1:1 1:m

1. Sparse Table
  
2. If we are required to store  attributes which doesnot belong to entity but belong to relationship.
   In m:m relationship sometimes we  should not create a composite Pk in the mapping table but add a special
column id make that Pk
    Reason Of the mapping table has extra rulationships more then 2 then we should add a dedicated column as PK in the mapping table.
   
### Normalization forms

* `1st Normalization Form`: Multi Valued columns.
  Solution Create  a seperate table


*   `2nd Nf`  applicable to tables with composite PK's
  All non-PK cols should depend on complete on complete PK, not part of it.
    In 2nd NF we try to find columns which dont depend on complete Pk Move those columns to separate table
* `3rd Nf`
  No columns with indirect depending on PK All columns should have direct  dependency on PK
  All columns should have direct dependency on Pk


### Sample: Business Requirements
1. There are students
2. Each student has name, email and phone number
3. Each student is assigned to a batch.
4. Every batch has a name, start date and end date
5. Students can shift batches
6. Each student has a mentor
7. Mentor has name, dob and experience
8. Batches have lectures. Each lecture has a topic and is taken by an instructor
9. Instructor has name, dob and experience
10. Multiple batches can learn together in the same lecture.



`Scaler DB`
![image](https://github.com/santoshjeergi/mysqlWorkBench/assets/8055333/d9abaee4-db05-46c5-82fc-af1b109b1fd9)



`Entity Relation Diagram `

![image](https://github.com/santoshjeergi/mysqlWorkBench/assets/8055333/f74f2fb6-d173-42e3-898d-3e5c0d999322)

