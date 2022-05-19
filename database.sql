-- TABLE CREATION

Declare
Begin
    Execute Immediate 'create table accounts(
        acc_no int,
        overdraft float,
        balance float,
        transaction_limit float not null,
        acc_type varchar(255) not null,
        constraint pk_acc primary key(acc_no))';
    Execute Immediate 'create table customer(
        cust_id int,
        acc_no int,
        address varchar(255),
        pan varchar(20) unique not null,
        dob date not null,
        cust_name varchar(50) not null,
        constraint pk_cust primary key(cust_id),
        constraint fk_cust foreign key(acc_no) references accounts(acc_no))';
    Execute Immediate 'create table transactions(
        acc_no int,
        deposit_amt float,
        withdrawal_amt float,
        constraint fk_trans foreign key(acc_no) references accounts(acc_no))';
    Execute Immediate 'create table loan(
        loan_id int,
        acc_no int,
        loan_type varchar(255) not null,
        principle_amt float not null,
        rate float not null,
        time_months int not null,
        constraint pk_loan primary key(loan_id),
        constraint fk_loan foreign key(acc_no) references accounts(acc_no))';
    Execute Immediate 'create table bank(
        bank_id int,
        bank_name varchar(255) unique not null,
        head_office varchar(100) not null,
        constraint pk_bank primary key(bank_id))';
    Execute Immediate 'create table branch(
        branch_id int,
        bank_id int,
        branch_loc varchar(255) not null,
        cust_id int,
        constraint pk_branch primary key(branch_id),
        constraint fk_branch foreign key(bank_id) references bank(bank_id),constraint fk2_branch foreign key(cust_id) references customer(cust_id))';
    Execute Immediate 'create table employee(
        emp_id int,
        emp_name varchar(50) not null,
        salary float not null,
        pos varchar(100) not null,
        cust_id int,
        branch_id int,
        constraint pk_emp primary key(emp_id),
        constraint fk1_emp foreign key(cust_id) references customer(cust_id),constraint fk2_emp foreign key(branch_id) references branch(branch_id))';
    Execute Immediate 'create table customer_avails_loans(
        cust_id int,
        loan_id int,
        constraint fk1_avails foreign key(cust_id) references customer(cust_id),constraint fk2_avails foreign key(loan_id) references loan(loan_id))';  
End;

-- drop table accounts;
-- drop table customer;
-- drop table transactions;
-- drop table loan;
-- drop table bank;
-- drop table branch;
-- drop table employee;
-- drop table customer_avails_loans;

-- TABLES
--ACCOUNTS
Create Or Replace Procedure Addacc(Acc_No In Int,Overdraft In Float,Balance In Float,Trans_Limit In Float,Acc_Type In Varchar)
Is
Begin
Insert Into Accounts Values(Acc_No,Overdraft,Balance,Trans_Limit,Acc_Type); 
End Addacc;
/

Declare
    Acc_No Accounts.Acc_No%Type;
    Overdraft Accounts.Overdraft%Type;
    Balance Accounts.Balance%Type;
    Trans_Limit Accounts.Transaction_Limit%Type;
    Acc_Type Accounts.Acc_Type%Type;
Begin
    Addacc(&acc_No,&overdraft,&balance,&trans_Limit,'&acc_type');
End;

Desc Accounts;
Select * From Accounts;

--TRANSACTIONS
Create Or Replace Procedure Addtrans(Acc_No In Int,Deposit In Float,Withdrawal In Float)
Is
Begin
Insert Into Transactions Values(Acc_No,Deposit,Withdrawal); 
End Addtrans;
/

Declare
    Acc_No Transactions.Acc_No%Type;
    Deposit Transactions.Deposit_Amt %Type;
    Withdrawal Transactions.Withdrawal_Amt%Type;
Begin
    Addtrans(&acc_No,&deposit,&withdrawal);
End;

Desc Transactions;
Select * From Transactions;

--CUSTOMER
Create Or Replace Procedure Addcust(Cust_Id In Int,Acc_No In Int,Addr In Varchar,Pan In Varchar,Dob In Varchar,Cust_Name In Varchar)
Is
Begin
Insert Into Customer Values(Cust_Id,Acc_No,Addr,Pan,Dob,Cust_Name); 
End Addcust;
/

Declare
    Cust_Id Customer.Cust_Id%Type;
    Acc_No Customer.Acc_No%Type;
    Addr Customer.Address%Type;
    Pan Customer.Pan%Type;
    Dob Customer.Dob%Type;
    Cust_Name Customer.Cust_Name%Type;
Begin
    Addcust(&cust_Id,&acc_No,'&addr','&pan','&dob','&cust_name');
End;

Desc Customer;
Select * From Customer;

--LOANS
Create Or Replace Procedure Addloan(Loan_Id In Int,Acc_No In Int,Loan_Type In Varchar,Principle In Float,Rate In Float,Tm_Mnths In Int)
Is
Begin
Insert Into Loan Values(Loan_Id,Acc_No,Loan_Type,Principle,Rate,Tm_Mnth); 
End Addloan;
/

Declare
    Loan_Id Loan.Loan_Id%Type;
    Acc_No Loan.Acc_No%Type;
    Loan_Type Loan.Loan_Type%Type;
    Principle Loan.Principle_Amt%Type;
    Rate Loan.Rate%Type;
    Tm_Mnths Loan.Time_Months%Type;
Begin
    Addloan(&loan_Id,&acc_No,'&loan_type',&principle,&rate,&tm_Mnth);
End;

Desc Loan;
Select * From Loan;

--CUSTOMER AVAILS LOANS
Create Or Replace Procedure Addavails(Cust_Id In Int,Loan_Id In Int)
Is
Begin
Insert Into Customer_Avails_Loans Values(Cust_Id,Loan_Id); 
End Addavails;
/

Declare
    Cust_Id Customer_Avails_Loans.Cust_Id%Type;
    Loan_Id Customer_Avails_Loans.Loan_Id%Type;
Begin
    Addavails(&cust_Id,&loan_Id);
End;

Desc Customer_Avails_Loans;
Select * From Customer_Avails_Loans;

--BANK
Create Or Replace Procedure Addbank(Bank_Id In Int,Bank_Name In Varchar,Head_Off In Varchar)
Is
Begin
Insert Into Bank Values(Bank_Id,Bank_Name,Head_Off); 
End Addbank;
/

Declare
    Bank_Id Bank.Bank_Id%Type;
    Bank_Name Bank.Bank_Name%Type;
    Head_Off Bank.Head_Office%Type;
Begin
    Addbank(&bank_Id,'&BANK_NAME','&head_off');
End;

Desc Bank;
Select * From Bank;

--BRANCH
Create Or Replace Procedure Addbranch(Branch_Id In Int,Bank_Id In Int,Branch_Loc In Varchar,Cust_Id In Int)
Is
Begin
Insert Into Branch Values(Branch_Id,Bank_Id,Branch_Loc,Cust_Id); 
End Addbranch;
/

Declare
    Branch_Id Branch.Branch_Id%Type;
    Bank_Id Branch.Bank_Id%Type;
    Branch_Loc Branch.Branch_Loc%Type;
    Cust_Id Branch.Cust_Id%Type;
Begin
    Addbranch(&branch_Id,&bank_Id,'&branch_loc',&cust_Id);
End;

Desc Branch;
Select * From Branch;

--EMPLOYEE
Create Or Replace Procedure Addemp(Emp_Id In Int,Emp_Name In Varchar,Sal In Float,Pos In Varchar,Cust_Id In Int,Branch_Id In Int)
Is
Begin
Insert Into Employee Values(Emp_Id,Emp_Name,Sal,Pos,Cust_Id,Branch_Id); 
End Addemp;
/

Declare
    Emp_Id Employee.Emp_Id%Type;
    Emp_Name Employee.Emp_Name%Type;
    Salary Employee.Salary%Type;
    Pos Employee.Pos%Type;
    Cust_Id Employee.Cust_Id%Type;
    Branch_Id Employee.Branch_Id%Type;
Begin
    Addemp(&emp_Id,'&Emp_Name',&salary,'&Pos',&cust_Id,&branch_Id);
End;

Desc Employee;
Select * From Employee; 

-- SHOW TABLES
Select * From Accounts;
Select * From Transactions;
Select * From Customer;
Select * From Loan;
Select * From Customer_Avails_Loans;
Select * From Bank;
Select * From Branch;
Select * From Employee;

-- FUNCTIONS

Create Or Replace Function Totalcustomers
Return Number Is 
   Total Number(20) := 0;
 Begin 
   Select Count(*) Into Total 
   From Customer; 
 Return Total; 
End;
/

Create Or Replace Function Totalloans
Return Number Is 
   Total_Loan Number(20) := 0;
 Begin 
   Select Count(*) Into Total_Loan 
   From Loan; 
 Return Total_Loan; 
End;
/

Create Or Replace Function Totalaccounts
Return Number Is 
   Total_Account Number(20) := 0;
 Begin 
   Select Count(*) Into Total_Account 
   From Accounts; 
 Return Total_Account; 
End;
/

Declare
    Total_Cust Number(20);
Begin
    Total_Cust:=Totalcustomers();
    Dbms_Output.Put_Line('Total no. of customers registered in the bank: '||Total_Cust);
End;

Declare
    Total_Loan Number(20);
Begin
    Total_Loan:=Totalloans();
    Dbms_Output.Put_Line('Total no. of loans registered in the bank: '||Total_Loan);
End;

Declare
    Total_Account Number(20);
Begin
    Total_Account:=Totalaccounts();
    Dbms_Output.Put_Line('Total no. of accounts registered in the bank: '||Total_Account);
End;