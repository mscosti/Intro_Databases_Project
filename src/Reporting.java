import java.lang.Integer;
import java.sql.*;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.io.InputStream;
import java.util.Scanner;
import java.util.Date;

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
					PreparedStatement patStmt = conn.prepareStatement(
						"SELECT SSN, fName, lName, address "+
						 "FROM Patient WHERE SSN = ?");
					patStmt.setString(1, SSN);
					ResultSet patInfo = patStmt.executeQuery();

					displayPatient(patInfo);
					break;
				case 2:
					System.out.println("Enter Doctor ID: ");
					String ID = scanner.nextLine();
					PreparedStatement docStmt = conn.prepareStatement(
						"SELECT ID, fName, lName, gender "+
						 "FROM Doctor WHERE ID = ?");
					docStmt.setInt(1, Integer.valueOf(ID));
					ResultSet docInfo = docStmt.executeQuery();

					displayDoctor(docInfo);
					break;
				case 3:
					System.out.println("Enter Admission Number: ");
					String admit = scanner.nextLine();
					PreparedStatement admitQry = conn.prepareStatement(
						"SELECT A.admissionNum, A.patientSSN, A.admissionDate, A.totalPayment, E.doctorID " +
						"FROM Admission A INNER JOIN Examine E ON A.admissionNum = E.admissionNum " +
						"WHERE A.admissionNum = ?");
					PreparedStatement roomQry = conn.prepareStatement(
						"SELECT roomNum, startDate, endDate " +
						"FROM StayIn WHERE admissionNum = ?");
					admitQry.setInt(1,Integer.valueOf(admit));
					roomQry.setInt(1,Integer.valueOf(admit));

					ResultSet admitInfo = admitQry.executeQuery();
					ResultSet roomList = roomQry.executeQuery();

					displayAdmissionInfo(admitInfo,roomList);
					break;
				case 4:
					System.out.println("Enter Admission Number: ");
					String admitNum = scanner.nextLine();
					System.out.println("Enter the new total payment: ");
					String newPayment = scanner.nextLine();

					PreparedStatement updatePayment = conn.prepareStatement(
						"UPDATE Admission SET totalPayment = ? WHERE admissionNum = ?");
					updatePayment.setInt(1,Integer.valueOf(newPayment));
					updatePayment.setInt(2,Integer.valueOf(admitNum));

					updatePayment.executeUpdate();

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

		String output = "Patient SSN: " + SSN + "\n" +
						"Patient First Name: " + firstName + "\n" +
						"Patient Last Name: " + lastName + "\n" +
						"Patient Address: " + address;

		System.out.println(output);
	}

	public static void displayDoctor(ResultSet doctor) throws SQLException
	{
		doctor.next();
		int ID = doctor.getInt("ID");
		String firstName = doctor.getString("fName");
		String lastName = doctor.getString("lName");
		String gender = doctor.getString("gender");

		String output = "Doctor ID: " + ID + "\n" +
						"Doctor First Name: " + firstName + "\n" +
						"Doctor Last Name: " + lastName + "\n" +
						"Doctor Gender: " + gender;

		System.out.println(output);
	}

	public static void displayAdmissionInfo(ResultSet admit, ResultSet rooms) throws SQLException
	{
		admit.next();
		int admitNum = admit.getInt("admissionNum");
		String SSN = admit.getString("patientSSN");
		int ID = admit.getInt("doctorID");
		Date admitDate = admit.getDate("admissionDate");
		int payment = admit.getInt("totalPayment");

		String output_admit = 	"Admission Number: " + admitNum + "\n" +
								"Patient SSN: " + SSN + "\n" +
								"Doctor ID: " + ID + "\n" +
								"Admission date (startdate): " + admitDate + "\n" +
								"Total Payment: " + payment + "\n";
		System.out.println(output_admit);

		while(rooms.next())
		{
			int roomNum = rooms.getInt("roomNum");
			Date startDate = rooms.getDate("startDate");
			Date endDate = rooms.getDate("endDate");

			String output_room = 	"RoomNum: " + roomNum +
									" fromDate: " + startDate +
									" toDate: " + endDate + "\n";
			System.out.println(output_room);
		}


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

