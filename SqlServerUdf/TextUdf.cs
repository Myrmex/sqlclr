using Microsoft.SqlServer.Server;
using System;
using System.Data.SqlTypes;
using System.Text.RegularExpressions;

namespace SqlServerUdf
{
    /// <summary>
    /// SQL server text-related UDFs.
    /// </summary>
    /// <remarks>See http://www.codeproject.com/Articles/42764/Regular-Expressions-in-MS-SQL-Server 
    /// and http://www.codeproject.com/Articles/680161/Getting-Started-With-SQL-Server-CLR-User-Defi .
    /// <para>Wrapper:</para>
    /// <code>CREATE FUNCTION RegexIsMatch(@text NVARCHAR(MAX), @pattern NVARCHAR(200)) 
    /// RETURNS BIT
    /// AS EXTERNAL NAME [SqlServerUdf].[SqlServerUdf.TextUdf].[RegexIsMatch];</code>
    /// </remarks>
    public class TextUdf
    {
        /// <summary>
        /// Searches the input string for an occurrence of the regular expression
        /// supplied in a pattern parameter.
        /// </summary>
        /// <param name="text">The text to be tested for a match.</param>
        /// <param name="pattern">The regular expression pattern to match.</param>
        /// <param name="options">The options. See the values of the
        /// <see cref="RegexOptions"/> enum.</param>
        /// <returns>True if the input string matches to pattern, else false.
        /// </returns>
        /// <exception cref="ArgumentException">Regular expression parsing error.
        /// </exception>
        /// <remarks>UDF in SQL:
        /// <code>CREATE FUNCTION RegexIsMatch(@text NVARCHAR(MAX) NULL,
        /// @pattern NVARCHAR(200) NOT NULL, @options INT NULL) 
        /// RETURNS BIT
        /// AS EXTERNAL NAME[SqlServerUdf].[SqlServerUdf.TextUdf].[RegexIsMatch];
        /// </code>
        /// </remarks>
        [SqlFunction(Name = "RegexIsMatch", IsDeterministic = true, IsPrecise = true)]
        public static SqlBoolean RegexIsMatch(SqlString text, SqlString pattern,
            SqlInt32 options)
        {
            if (text.IsNull) return SqlBoolean.Null;
            if (pattern.IsNull) pattern = "";

            return Regex.IsMatch((string)text,
                (string)pattern,
                options.IsNull? RegexOptions.None : (RegexOptions)options.Value,
                new TimeSpan(0, 0, 10))
                ? SqlBoolean.True
                : SqlBoolean.False;
        }

        /// <summary>
        /// Return the result of replacing <paramref name="text"/> with
        /// <paramref name="replacement"/> using the specified
        /// <paramref name="pattern"/>.
        /// </summary>
        /// <param name="text">The input text.</param>
        /// <param name="pattern">The pattern.</param>
        /// <param name="replacement">The replacement text.</param>
        /// <param name="options">The options. See the values of the
        /// <see cref="RegexOptions"/> enum.</param>
        /// <returns>Result.</returns>
        [SqlFunction(Name = "RegexReplace", IsDeterministic = true, IsPrecise = true)]
        public static SqlString RegexReplace(SqlString text, SqlString pattern,
            SqlString replacement, SqlInt32 options)
        {
            if (text.IsNull || pattern.IsNull) return text;

            return Regex.Replace((string)text, (string)pattern,
                (string)replacement,
                options.IsNull ? RegexOptions.None : (RegexOptions)options.Value);
        }
    }
}
