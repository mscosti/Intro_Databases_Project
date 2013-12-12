import java.lang.Integer;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.io.InputStream;
import java.util.Scanner;

public class Reporting
{
	private static Scanner scanner = new Scanner(System.in);
	

	public static void main(String [] args) throws SQLException
	{
		if (args.length == 1)
		{
			Connection conn = connectToJDBC();
			if (conn == null) return;

			System.out.println(args[0]);
			switch (Integer.valueOf(args[0]))
			{
				case 1:

					System.out.println("Enter Patient SSN: ");
					String SSN = scanner.nextLine();
					PreparedStatement pstmt = conn.prepareStatement(
						"SELECT SSN, fName, lName, address "+
						 "FROM Patient WHERE SSN = ?");
					pstmt.setString(1, SSN);
					ResultSet rset = pstmt.execute

					displayPatient(rset);
					break;
				case 2:
					System.out.println("Enter Doctor ID: ");
					String ID = scanner.nextLine();
					PreparedStatement pstmt = conn.prepareStatement(
						"SELECT ID, fName, lName, gender "+
						 "FROM Patient WHERE SSN = ?");
					pstmt.setString(1, Integer.valueOf(ID));
					ResultSet rset = pstmt.execute

					displayDoctor(rset);
					break;
				case 3:
					System.out.println("Enter Admission Number: ");
					String admit = scanner.nextLine();
					PreparedStatement admitInfo = conn.prepareStatement(
						"SELECT A.admissionNum, A.patientSSN, A.admissionDate, A.totalPayment, E.DoctorID " +
						"FROM Admission A INNER JOIN Exammine E ON A.admissionNum = E.admissionNum" +
						"WHERE A.admissionNum = ?");
					PreparedStatement roomList = conn.prepareStatement(
						"SELECT roomNum, startDate, endDate " +
						"FROM StayIn WHERE admissionNum = ?");
					admitInfo.setInt(1,Integer.valueOf(admit));
					roomList.setInt(1,Integer.valueOf(admit));

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

	public static void displayPatient(ResultSet patient) throws SQLException
	{
		patient.next();
		String SSN = patient.getString("SSN");
		String firstName = patient.getString("fName");
		String lastName = patient.getString("lName");
		String address = patient.getString("address");

		String output = "Patient SSN: " + SSN + "\n"
						"Patient First Name: " + firstName + "\n"
						"Patient Last Name: " + lastName + "\n"
						"Patient Address: " + address;

		System.out.println(output);
	}

	public static void displayDoctor(ResultSet doctor) throws SQLException
	{
		doctor.next();
		Int ID = patient.getInt("ID");
		String firstName = patient.getString("fName");
		String lastName = patient.getString("lName");
		String gender = patient.getString("gender");

		String output = "Doctor ID: " + SSN + "\n"
						"Doctor First Name: " + firstName + "\n"
						"Doctor Last Name: " + lastName + "\n"
						"Doctor Gender: " + gender;

		System.out.println(output);
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

