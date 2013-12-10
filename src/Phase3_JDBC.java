public class Phase3_JDBC
{
  	public static void main(String [] args)
  	{
  		if (args.length == 0)
  		{
  			switch (Integer.valueof(args[1]))
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

  	public void displayPrompt()
  	{
  		String prompt =  "1- Report Patients Basic Information"
  						+"2- Report Doctors Basic Information"
  						+"3- Report Admissions Information"
  						+"4- Update Admissions Payment";
  		System.out.println(prompt);
  	}
}

