
  PL/SQL -  Procedural Language using capablities of SQL 
  i.e Interface between PL and SQL
 
  Until now the SQL commands are given individually by the user at the SQL prompt 
  Thus Oracle processor was contantly busy processing some or the other user processor.
  Resulting in congestion of the network & leading to slower response.
 
  Through PL/SQL all the commands & intruction are combined is a single file & the file as whole is passed to Oracle processing.
  PL/SQL allows us to have better control over the way information is handled & processed.
  All SQL commands are perfectly compatible with PL/SQL but with a slight change.
 
  # Structure of the PL/SQL block -
                                     PL/SQL block consists of 4 section
 
  1. Declare -  Place reserved for declaration of the variables.
                  int a;    (In C language)
                  a int;    (In Oracle)
  2. Begin - Contains processing statements.
  3. Exception (Optional) - Used to handle run time error through the programme it self.
  4. End - Signal end of PL/SQL block.
 
  a:=10;  (Assignment in Oracle)
  a==10;  (Equality check in C language)
  a=10;   (Equality check in Oracle)
 
 Q. Write a PL/SQL code to accept a empno & display the name & salary corresponding to it ?
 Ans.
        Set serveroutput on;
        
        Declare
 --                 declare eno to have the same features as empno of emp table
                
                eno emp.empno%type:=&entereno;    --( Enter the empno)
                enm emp.ename%type;
                sl emp.sal%type;
                
        Begin
                Select ename,sal into enm,sl from emp where empno=eno;
 --       In the PL/SQL the Select is always written with into. On left of into are coloumn & add on right of into variables.
 
                dbms_output.put_line('Name = '|| enm);   --( Used to display the data. By default is always display the output on a new line.)
                dbms_output.put_line('Salary = '||sl);
        
        End;
        
 The code executes on the server side & in order to enable our terminal to receive the output we must write "Set serverouput on;"
 It is session specific.
 Every time you came back you need to write "Set serveroutput on;"
 By default all PL/SQL files are in bin folder.

 Q. Write the PL/SQL code to increment the salary of an emp as follows
        For PRESIDENT increment is 10%
        For MANAGER increment is 15%
        For ANALYST increment is 20%
        & For all other = 2000 Rs.
 Ans.
        Declare
                eno emp.empno%type:=&empno;
                job emp.job%type;
                xsal emp.sal%type;
        Begin
                Select job,sal into job, xsal from emp where empno=eno;
                
                dbms_output.put_line('Old Salary = '|| xsal);
                
                if job='PRESIDENT' then
                    xsal:=xsal*1.1;
                elsif job='MANAGER' then
                    xsal:=xsal*1.15;
                elsif job='ANALYST' then
                    xsal:=xsal*1.20;
                else
                    xsal:=xsal+2000;
                    
                end if;
                
                dbms_output.put_line('New Salary = '|| xsal);
                
                update emp
                Set sal=xsal where empno=eno;
                
                End;
                
                Select * from emp
                Rollback;
  
  ******************************************************************************************************************************
  
  # Looping in PL/SQL
 
  PL/SQL supports 3 types of loops
  1. Loop (Itself)
  2. While
  3. For
 
    Declare
            x number(2):=1;
    Begin
            loop
                dbms_output.put_line(x);
                x:=x+1;
                exit when x=20;
            end loop;
    End;
    
  1. Loop - A loop is an entry control loop depending upon the position of exit when there is no concept of infinite loop in PL/SQL.
            The last value generates depends on what is the width.
 
    Declare 
            x number(2):=1;
    Begin
            while x<=5
            loop
                dbms_output.put_line(x);
                x:=x+1;
                exit when x=3;
            end loop;
    End;
    
  Terminating Condititon - Whichever occur first that will be resposible for termination of loop.
                           A loop can have more than one stoping codition & will terminate at that point whichever condition occur first.
 
  # For loop -
              1. Variable used with for loop need not be declared.
              2. By default the increment is always by 1 & can not be changed under any circumstances by any one.
              3. Indicates the range & is inclusive of both the lower limit & upper limit.
                  for x in 1........5
      Lower Limit
      Upper Limit
 
      Declaring variable will not effect value of x
      In loop x is Reinitialised Again
      For x in 1.1..5.5 will be 1..6
      If it would be 5.1 than 5
      For Loop can be used only with Integer & if Decimal are used it will follow concept of rounding
      If Assign 1..100 Automatically size= 3 Digit
      If Assign 1..5 Automatically size= 1 Digit
      If Assign 1..10 Automatically size= 2 Digit
 
        Set Serveroutput on;
        
        Begin
            For x in 1..100
            Loop
                dbms_output.put_line(x);
            end loop;
        End;
        
        
        Begin
            For x in 1..10
            Loop
                dbms_output.put_line(11-x);
            end loop;
        End;
        
        
        Begin
            For x in reverse 1..10
            Loop
                dbms_output.put_line(x);
            end loop;
        End;
        
        
        Begin
            For x in -10..-1
            Loop
                dbms_output.put_line(-x);
            end loop;
        End;
        
Q. Write a PL/SQL code to convert a name & convert every alternate alphabet into upper case ?
Ans.
set serveroutput on;
        Declare 
            Oname varchar(20):='&Oname';
            Cname varchar(20);
            x number(2);
        Begin
            x:=Length(Oname);
            For y in 1..x
            Loop   
                if y mod 2<>0
                then    
                    Cname:=Cname||Upper(substr(Oname,y,1));
                else
                    Cname:=Cname||substr(Oname,y,1);
                end if;
            end loop;
            Dbms_output.put_line(Cname);
            End;
            
  7th string function - SUBSTR - substring 
  It is used to abstract a position of string 
  It takes 3 arguments
 
  1. String
  2. Starting Position
  3. No of char to be extracted from the starting position including the starting position.
 
    Select ename, substr(ename,1,3) from emp;
    Select upper(substr('abcde',3,1)) from dual;
  
*************************************************************************************************************************************  
 
  Exception Handling - 
                      In case of PL/SQl block having multipal exception handlers control goes to that exception which occur first.
      For each error oracle maintain two inbuilt variable called SQL code & SQLERRM 
 
  SQL code returns the error code corresponding to the error that has occured 
  SQLERRM returns oracle error message corresponding to the error that has occured.
 
  We can use these two variables Just like other variables
 
 Alter table dept add constraint p11 primary key(deptno);
 commit;
 
 Begin
    Insert into dept values(&deptno,'&dname','&loc');
    DBMS_output.put_line('Successfully inserted');
    Exception
        When DUP_val_on_index then
            dbms_output.put_line('Record Already Exist');
 End;
 
 Select * from dept;
 Rollback;
 
  Exception is of 2 types
  1. Predefine Exception
  2. User Defined Exception
 
    Select ename,sal from emp where empno=7839;
    Select ename,sal into enm,sl from emp where empno=7839;
    Select ename,sal into enm,sl from emp where job='PRESIDENT';
 
      Predefine Exception                             Cause
 
      1. NO_DATA_FOUND        |   When the select into statement fail to reterive any row
      2. VALUE_ERROR          |   Data type Mismatch with is short accomodate data
      3. TOO_MANY_VALUE       |   When the select into statement retreives more than one row
      4. DUP_VAL_ON_INDEX     |   When the unique(primary key) constraint is voilated
      5. INVALID_CURSOR       |   Trying to read from a cursor which is not opened
      6. OTHERS               |   Handles all other error including the listing above
 
  User defined Exception -
 
    Declare
        a number(3):=&a;
        b number(3):=&b;
        c number(3);
        Tuesday Exception;
 -- Tuesday is a name of user defined exception
    Begin
        if a<0 or b<0 then
            Raise Tuesday;
 -- user defined exception being called . User defined exception can be called as raise exceptionName.
        end if;
        c:=a+b;
        Dbms_output.put_line('Addition='|| c);
        Exception
            When Tuesday then
                Dbms_output.put_line('Addition can be done on +ve numbers');             
    end;
    
    declare
        a number(3);
        b number(3);
        c number(3);
        Tuesday Exception;
 -- Tuesday is a name of user defined exception
    begin
        a:='&a';
        b:='&b';
        if a<0 or b<0 then
            raise Tuesday;
 -- user defined exception being called . User defined exception can be called as raise exceptionName.
        end if;
        c:=a+b;
        dbms_output.put_line('Addition='|| c);
        Exception
        when tuesday then
        dbms_output.put_line('addition can be done on positive nos .');
            when others then
                dbms_output.put_line('Addition can be done on numbers not on characters');             
    end;
    set serveroutput on
    
**********************************************************************************************************************************

  Trigger -
           A trigger is an activity that is automatically fired by the system whenever a triggering event is occured.

  A triggering event could be any DML Operation such as insert,delete or update.
  Every triggering has a timing associated with it, the timing could either by before or after.
  Timing tells Oracle when should the trigger fired & DML operation tells in response to what should the trigger fired.
  A trigger is always localised to table.
  Every trigger has a level associated with it.
      -> Table Level  OR  -> Row Level
 
  A table level trigger fires once for entire operation 
  A row level trigger fires once for each row affected by triggering event.
 
 Q. Write a PL/SQL code such that as soon as a record is deleted from emp table it must be inserted into another table along with
    the name of user who deleted it & date on which it has been deleted ?
 Ans.
        Drop table temp;
        
        Create table temp
        as Select * from emp where 1=2;
        
        alter table temp add unm varchar(10);
        alter table temp add dt date;
        
        Select * from temp;
        
        Select username from user_users;
        
        Set serveroutput on;
        
        Create or Replace trigger Q1
        After delete on emp for each row 
        Declare
            Uname varchar(20);
        Begin 
            Select username into uname from user_users;
            Insert into temp values(:old.empno,:old.ename,:old.job,:old.mgr,:old.hiredate,:old.sal,:old.comm,:old.deptno,uname,sysdate);
 -- By default a trigger creates 2 types of variable
 -- 1  :old ,2  :new
 -- Both :old & :new variables are automatically created with the same name as that of column  of the table on which the trigger is written
 
            Dbms_output.put_line('successful');
        End;
        
        Delete from emp where empno=7839;
        Delete from emp where job='MANAGER';
        Rollback;
        
 Q. Write a PL/SQL code such that when ever a DML operation is performed on emp table the number of emp should be automatically readujsted ?
 Ans.
        Alter table dept Add (NoEmp number(3) Default 5);
        Select * from dept;
        
        Set SERVEROUTPUT ON;
        
        Create or Replace trigger  Q2
        Before delete on emp for each row
        Begin
            DBMS_OUTPUT.PUT_LINE('BYE');
            END;
            
        Create or Replace trigger  Q3
        After Insert on emp for each row
        Begin
            Update dept set NoEmp=NoEmp+1 where deptno= :new.deptno;
            END;
            
        Create or Replace trigger  Q4
        After Delete on emp for each row
        Begin
            Update dept set NoEmp=NoEmp-1 where deptno= :old.deptno;
            END;
        
        Create or Replace trigger  Q5
        After update on emp for each row
        Begin
            Update dept set NoEmp=NoEmp+1 where deptno= :new.deptno;
            Update dept set NoEmp=NoEmp-1 where deptno= :old.deptno;
            END;
        
        Delete from emp where empno=7654;
        Update emp set deptno=20 where empno=7934;
        
        Select * from dept;
        rollback;
    
 Q. Write a PL/SQL code such that nobody should allowed to use your emp table before 9 AM , after 5 PM & ON SUNDAY ?
 Ans.   
        Select to_char(sysdate,'HH24'), TO_CHAR(SYSDATE,'DY') FROM DUAL;
        
        Create or replace trigger Q6
        Before insert or delete or update on emp
 -- By default trigger is always at table level
        Declare
            tm number(3);
            dow varchar(3);
        Begin
            Select to_char(sysdate,'HH24'),to_char(sysdate,'DY') into  tm,dow from dual;
            if tm>19 or tm<9 or dow='sunday'
            then
                raise_application_error(-20000,'Sorry no permission now');
 -- Raise_application_error is used to terminate the execution of  the operation
 -- It takes 2 arguments-
 -- 1. Used defined error code
 -- 2. Error message the error code can be any number In range of -20000 to -20999
            end if;
        end;
        
        Delete from emp;
        drop trigger Q6;        
        rollback;
        SELECT * FROM emp;
        
 Q. Write a PL/SQL  code such that which should be able to find out what operation were created were carried out by which user on which date ?
 Ans.
        Select username from user_users;
        
        Create or Replace trigger Q7
        After insert or delete or update on emp
        Declare 
            Uname varchar(10);
            OPN varchar(10);
        Begin
            Select username into uname from user_users;
            If inserting then 
                OPN:='Insert';
            end if;
            If deleting then
                OPN:='Delete';
            end if;
            If updating then
                OPN:='Update';
            end if;
            Insert into track values(Uname,OPN,Sysdate);
        end;
        
        Create table track(
            Username varchar(10),
            OPN varchar(10),
            Opdate date );
            
        Delete from emp where job='CLERK';
        Select * from track;
        Select * from emp;
        rollback;
        
        
        Create or replace trigger Q8
        Before alter on schema
        Begin
            Raise_application_error(-20111,'Sorry can not alter');
        End;
        
        Alter table track add rollno varchar(2);
        
        Create or replace trigger Q9
        Before create on schema
        Begin   
            Raise_application_error(-20222,'Sorry can not create');
        End;
        
        Create table hi(name varchar(20));
        
        Drop trigger Q8;
        Drop trigger Q9;
        
 Q. Write PL/SQL code such that interest should be automatically credited to the account on the date of maturity ?
    Write a PL/SQL code such that we should be able to find out how many time did the user logon during the day ?
 Ans.
        Create table dell(
            Acno number(5),
            Name varchar(10),
            Amount number(7,2),
            Matdate date,
            CTR number(2)
        );
        
        Insert into Dell values('1001','Ajay',50000,sysdate,0)
        Insert into Dell values('1002','Vijay',40000,sysdate,0)
        Insert into Dell values('1003','Sohan',30000,sysdate,0)
        Insert into Dell values('1004','Mohan',20000,sysdate,0)
        
        Select * from dell;
        
        Update dell set CTR=0;
        Update dell set matdate=sysdate;
        
        Create or replace trigger Q10
        After logon on schema
        Begin
            Update dell Set amount=amount*1.1 where to_char(matdate,'DD MON YYYY')=TO_CHAR(SYSDATE,'DD MON YYYY') And CTR=0;
            Update dell set CTR=CTR+1 where TO_CHAR(MATDATE,'DD MON YYYY')=TO_CHAR(SYSDATE,'DD MON YYYY');
        End;
        
*******************************************************************************************************************************************

  # Cursor -
             A cursor is a pointer to the context area in the memory.
 
  Context Area - It is that area in the memory which store the result derived by the execution of select statement.
 
  * Processing of the cursor takes place in 4 Phase.
 
  1. Declare Phase - Here query associated with the cursor is specified.
                        The query does not execute here
        ex-
                Cursor aa is 
                    Select ename,job from emp where job='CLERK';
                    
                   -> aa = name of cursor
                                        AA
                                  |ENAME  |  JOB  |
 memory in cursor      - - - - >> |       |       |
                                  |_______|_______|
                                  
  2. Open phase/ Population phase - Here the query associated with the cursor is executed & the record pointer points to the 
                                    first record in the record set.
                                                        
        ex-
                Open aa;
               IN OPEN PHASE
                                          AA
                                  |ENAME  |  JOB  |
   memory in cursor      - - - - >> |SMITH |CLERK   |
     RECORD POINTER POINTS TO THE IST  |ALLEN |SALESMAN |
     RECORD

 .3 - FETCH-
            READING FROM THE CURSOR 
                IT READS THE CURRENT RECORD AND RECORD POINT MOVES TO THE NEXT RECORD IN THE RECORD SET.

    ex -    FETCH AA INTO XNAME,XJOB;

    THE NUMBER OF VARIABLE WRITTEN WITH THE FETCH MUST BE EQUAL TO THE NUMBER OF COLUMNS IN THE CURSOR.

 4. CLOSE (OPTIONAL)-
                        CLOSE DEALLOCATES THE MEMORY ASSOCIATED WITH THE CURSOR.


 #CURSOR ATTRIBUTES#

    1ST CURSOR ATBT 0 -
                %ISOPEN - IT RETURNS TRUE IF THE CURSOR IS ALREADY OPEN OTHERWISE RETURN FALSE
    
    ex- 
            BEGIN 
                IF AA % ISOPEN =FALSE THEN
                OPEN AA;
            END IF;
            FETCH AA INTO XNAME,XJOB;
    
    2ND CURSOR ATTRIBUTE - 
                 %FOUND - IT RETURN TRUE - AS LONG AS THE CURSOR CONTAIN RECORDS TO BE PROCESSED, FALSE OTHERWISE.

                    WE CAN READ FILE TILL %FOUND IS TRUE.
    
    ex-
            LOOP 
                FETCH AA INTO .....
                EXIT WHEN  AA%FOUND =FALSE;
            END LOOP;
                    //READ TILL %FOUND=TRUE, WHEN %FOUND=FALSE IE. EOF,THAN NO MORE READ POSSIBLE.
 
 3RD ATTRIBUTE - %NOT FOUND
 -- OPPOSIT TO FOUND
                             IT RETURN TRUE WHEN THERE ARE NO MORE RECORDS TO BE PROCESSED OTHERWISE IT IS GOING TO RETURN FALSE;
                             
 4TH CURSOR ATTRIBUTE : % ROW COUNT
                             IT REUTRNS A NUMBER CORRESPONDING TO THE NUMBER OF ROWS THAT HAVE BEEN PROCESSED.

 ** CURSOR ARE USED TO PROCESS MULTIPLE ROWS .

 Q.  Write a PL/SQL code to display the name & hiredate of the five seniormost emp ?
 Ans.
         Declare
            Cursor S is 
            Select Ename,Hiredate from emp order by hiredate;
            QW S%rowtype;
 -- Declare QW to be the type of a row in the cursor
 -- A row in the cursor of ename & hiredate thus, through QW we can set up a refrence to them as QW.ename or QW.hiredate
        Begin
            Open S;
            Dbms_output.put_line('Rcount '||S%Rowcount);
            Loop 
                exit when S%Rowcount=5;
                Fetch S into QW;
                Dbms_output.put_line(QW.ename||' '||QW.hiredate);
                Dbms_output.put_line('Rcount '||S%Rowcount);
            End loop;
        End;

***************************************************************************************************************************************

 Show user;
 
 Grant Inserd, Delete, Update, Select on emp to ramola;
 Revoke all on emp from ramola;
 
 Update emp set sal=sal+100;
 Rollback;
 
 Second user
 Select * from emp for update;
 That it will in state of deadlock if it use "nowait" clause than second user willnot go in deadlock
 
 Now 1st user
 Select * from emp for update;
 -- Lock applied
 
 2nd user
 Select * from emp for update nowait;
 
 -- ORA-0054: Resource busy & acquire with nowait specified or timeout expired 
 -- 00054 0000-"Resource busy & acquire with nowait specified"
 -- * Cause: Resource interested is busy
 -- * Action: Retry if Necessary
 
 By default cursor are of 2 types
 1 Explicit Cursor
 2 Implicit Cursor
 
 * Explicit Cursor - In a explicit cursor the user has to go through all 4 phase of cursor processing that is declare, open, fetch & close.
 
 * Implicit Cursor - In a implicit cursor the user responsiblity is limited to declaring the curson when the close is done & decided by Oracle.
 
       * By default whenever a cursor is used with the for loop it is called Implicit cursor.
 
 Declare
    Cursor WR is select ename,job from emp where job='MANAGER' order by hiredate for update of job nowait;
    x number(2):=0;
 Begin
    for z in WR
 -- Read a record from the cursor WR into variable z
 -- Thus the data type of z becomes same as cursor WR
    Loop
        Dbms_output.put_line(z.ename||' '||z.job);
        update emp set Job='SR MGR' where current of WR;
 -- It effect on that record in the table which corresponding to the current record in cursor where current of can used only with the implicit cursor
        x:=x+1;
        exit when x=2;
    end loop;
 End;

 Rollback;
 Select * from emp;
 
 *************************************************************************************************************************************
 
 # Anonymous block & stored sub programmes
 
 1 Stored sub programmes - They are name PL/SQL blocks
    They are stored as a part of database server side in compiled form
    We can call one stored sub programme from another 
    for ex . in c one function can call another function
    
    ex - Procedures, function, pakages
        They are stored as a part of database on server side in compiled form
        
 Q. Write a PL/SQL code using procedure which should save as an alternative to DBMS_OUTPUT.PUT_LINE ?
 Ans. 
        Create or Replace procedure Display(Msg in varchar) as
 -- msg - parametername
 -- IN - parametere direction
 -- In- input, out- output, InOut- InputOutput
 -- Varchar parameter datatype size specitfication is not allowed it is dynamically calculated.
 -- As indicates that the body of the procedure is following it.
        Begin
            Dbms_output.put_line(msg);
        End;
        
 A procedure is called in 3 ways
 1 Through a PL/SQL code
 2 From the SQL prompt using the execute command
 3 In SQL developer
 
 Call display('hello');
 execute display('hello');
 exec display('hello');
 
 Declare
    A number(2):=&a;
    B number(2):=&b;
    c number(2);
 Begin
    c:=a+b;
    Display('The Addition is ' ||c ); -- Procedure display being Called
 End; 
 
 Q. Write a PL/SQL code using procedure to increment the salary of an emp ?
 Ans. 
        Create or replace procedure Incsal(eno in number, incamt  varchar, newsal out number)
         as
         Csal emp.sal%type;
        Begin
            Select sal into csal from emp where empno=eno;
            Display('old sal='||csal);
            newsal:=Incamt + Csal;
            Display('New sal='||newsal);
            update emp set sal=newsal where empno=eno;
            
            Exception when NO_DATA_FOUND
                Then
                    Display('Emp no you enter does not exist');
        End;
        
 * By default parameter direction is always 'In'
 * when calling a procedure containing out parameters the number of collectors required must be equal to the number of out parameters
 * Var variable name datatype used to declare variable on SQL Prompt
 * The variable declare at SQL prompt need to be prefixed with the  colon ':'
 * These variables are called as bind variable or enviournment variables & are session specific
 
 var undefined x;
 -- but still work
 print x
 
 var x number
 execute incsal(7839,2000,:x);
 print x;
 
 Select * from emp;
 Rollback;
 
 ==============================================================
FUNCTION ARE SIMILAR TO PROCEDURE
EXCEPT THAT A FUNCTION CAN RETURN A VALUE USING RETURN STATEMENT.

IN CASE A FUNCTION NEEDS TO  RETURN MORE THAN ONE VALUE   - IT CAN 
DO SO BY THE USE OF OUT PARAMETERS.

Q-WRITE A PL/SQL  CODE USING FUNCTION TO ACCEPT THE NUMBER AND CONVERT IT
INTO BINARY.
--13- 1101

create  OR REPLACE FUNCTION  BINARY(NO IN NUMBER)
RETURN VARCHAR AS
Y VARCHAR(10);
A NUMBER(10);
X VARCHAR(10);
BEGIN
    A :=NO;--A:=13
    WHILE A >=1 --13>=1 - TRUE   0>=1 FALSE
    LOOP--X=1,A=1,Y=01 
       X:=A MOD 2;--13 MOD 2 = 1  6 MOD 2= 0  3MOD2= 1   1MOD2= 1
       A:=TRUNC(A/2);--//13/2=6     6/2= 3  3/2= 1    1/2= 0
       Y:=X || Y;--1101
    END LOOP;
    RETURN Y;--1101
END;
X= 1
Y= 1101
SELECT TRUNC(13/2) FROM DUAL;

* A PROCEDURE CAN NOT BE CALLED THROUGH SELECT STATEMENT.


SET SERVEROUTPUT ON;
sELECT BINARY(19) FROM DUAL;
sELECT BINARY(&num) FROM DUAL;
sELECT BINARY(QTY),QTY FROM SHPTS;
select deptno,binary(deptno) from dept;
 
 commit;
 
 