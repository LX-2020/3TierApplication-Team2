/**
 * Represents an interval of time for events
 * check whether two intervals overlap or not
 * @author lexinma
 *
 */
import java.time.LocalDate;
//import java.time.LocalDateTime;
import java.time.LocalTime;
//import java.time.format.DateTimeFormatter;
//import java.text.DateFormat;
//import java.text.ParseException;
//import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
//import java.time.Duration;
//import java.time.Instant;
//import java.util.*;
//import java.io.Serializable;

/**
 * Having date and time variables for an event
 * @author lexinma
 *
 */
public class TimeInterval 
{
	
	private LocalTime startTime;
	private LocalTime endTime;
	private LocalDate startDate;
	private LocalDate endDate;
	private DayOfWeek dayOfweek;
		
	/**
	 * constructor
	 * @param day
	 * @param sd
	 * @param ed
	 * @param st
	 * @param et
	 */
	public TimeInterval(DayOfWeek day, LocalDate sd, LocalDate ed, LocalTime st, LocalTime et) 
	{		
		this.dayOfweek = day;
		this.endDate = ed;
		this.endTime = et;
		this.startDate = sd;
		this.startTime = st;
	}
	
	/**
	 * get day of week
	 * @return
	 */
	public DayOfWeek getday() 
	{
		
		return this.dayOfweek;
	}
	
	/**
	 * get starting date of an event
	 * @return
	 */
	public LocalDate getStartDate() 
	{		
		return this.startDate;
	}
	
	/**
	 * get ending date of an event
	 * @return
	 */
	public LocalDate getEndDate()
	{		
		return this.endDate;
	}
	
	/**
	 * get starting time of an event
	 * @return
	 */
	public LocalTime getStartTime() 
	{	
		return this.startTime;
	}
	
	/**
	 * get ending time of an event
	 * @return
	 */
	public LocalTime getEndTime() 
	{	
		return this.endTime;
	}

	/**
	 * check whether the date conflict with the event date
	 * @param date
	 * @return
	 */
	public boolean betweenDates(LocalDate date) 
	{
		if((date.isAfter(this.startDate) && date.isBefore(this.endDate))
			|| this.startDate.equals(date) || this.endDate.equals(date))
			return true;
		return false;			
		
	}

	/**
	 * check whether the time conflict with the event time
	 * @param time
	 * @return
	 */
	public boolean betweenTimes(LocalTime time)
	{		
		if((time.isAfter(this.startTime) && time.isBefore(this.endTime))
				|| this.startTime.equals(time) || this.endTime.equals(time))
		
				return true;
			return false;
	}
	
	
	public String toString() 
	{
		return this.startDate + " " + this.endDate + " " + this.startTime + " " + this.endTime;
		  
	}
	    

		 
}

