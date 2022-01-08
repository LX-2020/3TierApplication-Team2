import java.time.LocalDate;
import java.util.ArrayList;

/**
 * Day view data model
 * hold, add, and update events array list
 * @author lexinma
 *
 */
public class DayviewModel  
{	

	private ArrayList<Event> events;	

	/**
	 * constructor
	 * events array list for one specific day view
	 * @param e
	 */
	public DayviewModel(ArrayList<Event> e)
	{		
		events = e;				
	}
	
	/**
	 * get events array list
	 * @return
	 */
	public ArrayList<Event> getEvents()
	{
		return events;
	}
	
	/**
	 * add event to the events array list
	 * @param e
	 */
	public void addEvent(Event e)
	{
		events.add(e);
	}
	
	/**
	 * update events array list
	 * @param d
	 * @return
	 */
	public String updateEvents(LocalDate d) 
	{	
		ArrayList<String> eventsList = new ArrayList<String>();
		
		for(Event event : events)
		{				
			//one-time event
			if( event.getTI().getStartDate().equals(d) )				
			{								
				eventsList.add("\n" + event.getTI().getStartTime()
						+ "-" + event.getTI().getEndTime() + " " + event.getName());
			}
			//recurring event
			else if( event.getTI().getday() == d.getDayOfWeek()
					&& event.getTI().betweenDates(d)) 
			{				
				eventsList.add("\n" + event.getTI().getStartTime()
						+ "-" + event.getTI().getEndTime() + " " + event.getName());
			}				
		}
		
		return eventsList.toString();		
	}

	
}