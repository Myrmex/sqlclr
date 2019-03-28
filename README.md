# SQL CLR

Procedure from <https://sqlquantumleap.com/2017/08/09/sqlclr-vs-sql-server-2017-part-2-clr-strict-security-solution-1/>.

## Solution

1.create New Project (a SQL Server Database Project), `SQL2017_KeyAsm`, in your existing Visual Studio Solution.

2.go to `Project` menu | `Properties…` | SQLCLR tab | Signing… button: check the `Sign the assembly` check-box, `New…` in `Choose a strong name key file` drop-down, enter in a password.

3.build the project (Release).

## One-Time Procedures

1.to create the certificate: in a VS Command Prompt window in the fake prj folder:

    MAKECERT -r -pe -n "CN=fusisoft.it/sqlserverudf" -e "12/31/2099" -sv Sql2017Clr-Cert.pvk Sql2017Clr-Cert.cer

(password = `blah`)

2.to merge .cer and .pvk files into .pfx file: in a Command Prompt window:

	PVK2PFX -pvk Sql2017Clr-Cert.pvk -pi blah -spc Sql2017Clr-Cert.cer -pfx Sql2017Clr-Cert.pfx

3.to sign the empty assembly with the .pfx file:

    SIGNTOOL sign /f Sql2017Clr-Cert.pfx /p blah /v .\bin\Release\SQL2017_KeyAsm.dll

4.to convert public key for VARBINARY literal (get `BinaryFormatter.exe` from <https://github.com/SqlQuantumLeap/BinaryFormatter/releases>):

    C:\Exe\BinaryFormatter.exe .\Sql2017Clr-Cert.cer .\Sql2017Clr-Cert.sql 40

5.to convert empty assembly for VARBINARY literal:

    C:\Exe\BinaryFormatter.exe .\bin\Release\SQL2017_KeyAsm.dll .\SQL2017_KeyAsm.sql 40
	
The following steps should be incorporated into a single SQL script. That script can be run once manually, or can be made into a re-runnable (idempotent) script to be used as a PreDeploy script for the main Project. Please note that steps 1 and 4 require the output from steps 8 and 9 above, respectively.

```sql
CREATE CERTIFICATE [TempCert] FROM BINARY = 0x{contents_of_ClrStrictSecurity-Cert.sql};
CREATE LOGIN [TempLogin] FROM CERTIFICATE [TempCert];
GRANT UNSAFE ASSEMBLY TO [TempLogin];
CREATE ASSEMBLY [Sql2017Clr-KeyAsm] FROM 0x{contents_of_SQL2017_KeyAsm.sql};
CREATE ASYMMETRIC KEY [Sql2017Clr-Key] FROM ASSEMBLY [Sql2017Clr-KeyAsm];
CREATE LOGIN [Sql2017Clr-Login] FROM ASYMMETRIC KEY [Sql2017Clr-Key];
GRANT UNSAFE ASSEMBLY TO [Sql2017Clr-Login]; -- REQUIRED!!!!
DROP ASSEMBLY [Sql2017Clr-KeyAsm];
DROP LOGIN [TempLogin];
DROP CERTIFICATE [TempCert];
```

Finally, the following steps are a one-time setup for the Project (and any new Projects added to this Solution) that will cause the assembly to be signed with the same strong name key that was loaded into SQL Server via the steps detailed above.

1.in main Project, go to Project Properties | SQLCLR tab | Signing… button; check the `Sign the assembly` check-box, `Browse…` in `Choose a strong name key file`, find the PFX in the fake project folder and select it.

2.build the Release version of the project. If you get a key import error, try executing this from an elevated VS prompt at the location of the PFX file (replace the `VS_KEY...` code with the one in your build error message, and enter the password (here `blah`) when prompted:

	sn -i Sql2017Clr-Cert.pfx VS_KEY_9E2D5151F12CFB49

### CLR Deployment

Every time you rebuild the assembly:

1.create hex from the assembly DLL:

	C:\Exe\BinaryFormatter.exe .\bin\Release\SqlServerUdf.dll .\SqlServerUdf.sql 40

2.open a query in the target database (NOT master), and:

	CREATE ASSEMBLY [SqlServerUdf] FROM 0x...

replacing `...` with the hex dump created in the previous step.

Create a function wrapper for each UDF like:

```sql
CREATE FUNCTION RegexIsMatch(@text NVARCHAR(MAX) NULL, @pattern NVARCHAR(MAX) NOT NULL, @options INT NULL) 
RETURNS BIT
AS EXTERNAL NAME [SqlServerUdf].[SqlServerUdf.TextUdf].[RegexIsMatch];
GO

CREATE FUNCTION RegexIsMatch(@text NVARCHAR(MAX) NULL, @pattern NVARCHAR(MAX) NOT NULL, @replacement NVARCHAR(MAX), @options INT NULL) 
RETURNS NVARCHAR(MAX)
AS EXTERNAL NAME [SqlServerUdf].[SqlServerUdf.TextUdf].[RegexReplace];
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
