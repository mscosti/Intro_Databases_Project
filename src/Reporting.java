import java.lang.Integer;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

public class Reporting
{
		public static void main(String [] args)
		{
			if (args.length == 1)
			{
				if (!connectToJDBC()) return;

				switch (Integer.valueOf(args[0]))
				{
					case 1:
						System.out.println("Reporting Patient");
						break;
					case 2:
						System.out.println("Reporting Doctors");
						break;
					case 3:
						System.out.println("Report Admission Info");
						break;
					case 4:
						System.out.println("Update Payment");
						break;
				}
			}
			else
				displayPrompt();
		}

		public static void displayPrompt()
		{
			String prompt =  "1- Report Patients Basic Information\n"
							+"2- Report Doctors Basic Information\n"
							+"3- Report Admissions Information\n"
							+"4- Update Admissions Payment\n";
			System.out.println(prompt);
		}

		public static Connection connectToJDBC()
		{
			System.out.println("----Oracle JDBC Connection Testing----");
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");
			} catch (ClassNotFoundException e){
				System.out.println("Where is your oracle JDBC Driver?");
				e.printStackTrace();
				return null;
			}

			System.out.println("Oracle JDBC Driver Registered!");
			Connection connection = null;

			try 
			{
				connection = DriverManager.getConnection(
											"jdbc:oracle:thin:@oracle.wpi.edu:1521:WPI11grxx",
											"mscosti","MSCOSTI");
			} catch (SQLException e)
			{
				System.out.println("connection failed!");
				e.printStackTrace();
				return null;
			}
			return connection;
		}
}

