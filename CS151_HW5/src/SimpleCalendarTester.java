import java.util.ArrayList;

/**
 * MVC pattern application
 * main class
 * @author lexinma
 *
 */
public class SimpleCalendarTester 
{
	
	/**
	 * main class
	 * @param args
	 */
	public static void main(String[] args)
	{
		//loading existed events file		
		MyCalendar mycal = new MyCalendar("/Users/lexinma/eclipse-workspace/CS151_HW5/src/events");
		ArrayList<Event> events = mycal.getArrayOfevents();
		
		//create month view and day view data models
		MonthviewModel mm = new MonthviewModel();
		DayviewModel dm = new DayviewModel(events);
		
		//create views instance
		SimpleCalendar sc = new SimpleCalendar(mm, dm);	
		mm.addChangeListener(sc);
		
	    				
		
	}	
}



