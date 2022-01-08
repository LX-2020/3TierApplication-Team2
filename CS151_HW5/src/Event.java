import java.time.LocalDate;
import java.util.Comparator;

/**
 * Event consists of name and a TimeInterval object
 * @author lexinma
 *
 */
public class Event 
{
	private String eventName;
	private TimeInterval timeinterval;
	
	/**
	 * constructor
	 * @param name
	 * @param ti
	 */
	public Event(String name, TimeInterval ti)
	{
		this.eventName = name;
		this.timeinterval = ti;
	}
	
	/**
	 * get event name
	 * @return
	 */
	public String getName() 
	{
		return this.eventName;
	}
	
	/**
	 * get event time interval
	 * @return
	 */
	public TimeInterval getTI() 
	{
		return this.timeinterval;
	}
	
	public String toString()
	{		
		return eventName + "\n" + timeinterval;		
	}
	
	
		
	
	
}