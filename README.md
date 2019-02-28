# SQL CLR

<https://sqlquantumleap.com/2017/08/09/sqlclr-vs-sql-server-2017-part-2-clr-strict-security-solution-1/>:

1.create New Project (a SQL Server Database Project), `SQL2017_KeyAsm`, in your existing Visual Studio Solution.

2.go to `Project` menu | `Properties…` | SQLCLR tab | Signing… button: check the `Sign the assembly` check-box, `New…` in `Choose a strong name key file` drop-down, enter in a password.

3.build the project (Release).

4.to create the certificate: in a VS Command Prompt window in the fake prj folder:

    MAKECERT -r -pe -n "CN=SqlQuantumLeap.com" -e "12/31/2099" -sv SQL2017-ClrStrictSecurity-Cert.pvk SQL2017-ClrStrictSecurity-Cert.cer

(password = `blah`)

5.to merge .cer and .pvk files into .pfx file: in a Command Prompt window:

	PVK2PFX -pvk SQL2017-ClrStrictSecurity-Cert.pvk -pi blah -spc SQL2017-ClrStrictSecurity-Cert.cer -pfx SQL2017-ClrStrictSecurity-Cert.pfx

6.to sign the empty assembly with the .pfx file:

    SIGNTOOL sign /f SQL2017-ClrStrictSecurity-Cert.pfx /p blah /v .\bin\Release\SQL2017_KeyAsm.dll

7.to convert public key for VARBINARY literal (get `BinaryFormatter.exe` from <https://github.com/SqlQuantumLeap/BinaryFormatter/releases>):

    C:\Exe\BinaryFormatter.exe .\SQL2017-ClrStrictSecurity-Cert.cer .\SQL2017-ClrStrictSecurity-Cert.sql 40

8.to convert empty assembly for VARBINARY literal:

    C:\Exe\BinaryFormatter.exe .\bin\Release\SQL2017_KeyAsm.dll .\SQL2017_KeyAsm.sql 40
	
The following steps should be incorporated into a single SQL script. That script can be run once manually, or can be made into a re-runnable (idempotent) script to be used as a PreDeploy script for the main Project. Please note that steps 1 and 4 require the output from steps 8 and 9 above, respectively.

```sql
CREATE CERTIFICATE [TempCert] FROM BINARY = 0x{contents_of_ClrStrictSecurity-Cert.sql};
CREATE LOGIN [TempLogin] FROM CERTIFICATE [TempCert];
GRANT UNSAFE ASSEMBLY TO [TempLogin];
CREATE ASSEMBLY [SQL2017-ClrStrictSecurity-KeyAsm] FROM 0x{contents_of_SQL2017_KeyAsm.sql};
CREATE ASYMMETRIC KEY [SQL2017-ClrStrictSecurity-Key] FROM ASSEMBLY [SQL2017-ClrStrictSecurity-KeyAsm];
CREATE LOGIN [SQL2017-ClrStrictSecurity-Login] FROM ASYMMETRIC KEY [SQL2017-ClrStrictSecurity-Key];
GRANT UNSAFE ASSEMBLY TO [SQL2017-ClrStrictSecurity-Login]; -- REQUIRED!!!!
DROP ASSEMBLY [SQL2017-ClrStrictSecurity-KeyAsm];
DROP LOGIN [TempLogin];
DROP CERTIFICATE [TempCert];
```

Finally, the following steps are a one-time setup for the Project (and any new Projects added to this Solution) that will cause the assembly to be signed with the same strong name key that was loaded into SQL Server via the steps detailed above.

1.in main Project, go to Project Properties | SQLCLR tab | Signing… button; check the `Sign the assembly` check-box, `Browse…` in `Choose a strong name key file`, find `SigningKey.pfx` in the `Signing Key` project folder.

2.(optional) set up a `PreDeploy` SQL script consisting of the T-SQL commands in the previous set of steps.

In practice, once you have completed the above steps on `master` with the fake assembly, do the following:

1.build the true assembly to be inserted in the DB (Release).
2.create hex from it:

	C:\Exe\BinaryFormatter.exe .\bin\Release\SqlServerUdf.dll .\SqlServerUdf.sql 40

3.open a query in the target database (NOT master), and:

	CREATE ASSEMBLY [SqlServerUdf] FROM 0x...

replacing `...` with the hex dump created in the previous step.

Create a function wrapper for each UDF like:

```sql
CREATE FUNCTION RegexIsMatch(@text NVARCHAR(MAX) NULL, @pattern NVARCHAR(200) NOT NULL, @options INT NULL) 
RETURNS BIT
AS EXTERNAL NAME [SqlServerUdf].[SqlServerUdf.TextUdf].[RegexIsMatch];
GO
```

Note that here the first portion of the name is the assembly name, the second the full class name, and the third the method name.

Use `DROP FUNCTION RegexIsMatch` to remove the wrapper.

To execute the CLR function just invoke the wrapper:

```sql
SELECT dbo.RegexIsMatch('alpha beta', '\bbe*', 0)
SELECT * FROM [Item] WHERE [dbo].[RegexIsMatch]([Lemma],'^[ac].*r$', 0) = 1
```

In the second example notice the `= 1` which is required for comparing the returned boolean.
