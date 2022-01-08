/**
 * Data structure for holding events
 * @author lexinma
 *
 */

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

//import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
//import java.io.FileReader;
//import java.io.IOException;
import java.util.ArrayList;

/**
 * loads events from .txt file and stores events in array list.
 * provides methods to print all events in my calendar 
 * @author lexinma
 *
 */
public class MyCalendar 
{
		
	private ArrayList<Event> eventsList = new ArrayList<Event>();
	private ArrayList<ChangeListener> listeners;
	private LocalDate startDate, endDate;
	private LocalTime startTime, endTime;
	private DayOfWeek day;
	String eventName;
	int counter = 0;
	DateTimeFormatter dateformatter = DateTimeFormatter.ofPattern("M/dd/yy");
    DateTimeFormatter timeformatter = DateTimeFormatter.ofPattern("H:mm"); 
    	
	
	/**
	 * constructor 
	 * load events from .txt file
	 * @param filepath
	 */
    public MyCalendar(String filepath) 
	{
			
		File fl = new File(filepath);
		try 
		{								
			Scanner sc = new Scanner(fl);
		    while(sc.hasNextLine()) 
		    {		        	
	        	this.eventName = sc.nextLine(); 
	        	
	        	String dur = sc.nextLine();		        	
		    	String [] tokens = dur.split(" ");		    	   
		    	if(tokens.length < 4) 
		    	{
		    	    this.startTime = LocalTime.parse(tokens[1],timeformatter);
		        	this.endTime = LocalTime.parse(tokens[2],timeformatter);
		       		this.startDate = LocalDate.parse(tokens[0],dateformatter);
		       		this.endDate = LocalDate.parse(tokens[0],dateformatter);
		       		this.day = startDate.getDayOfWeek();		        		
		   	    }
		    	else 
		    	{	    	    				    	    		
		    	    this.startTime = LocalTime.parse(tokens[1],timeformatter);
		    	    this.endTime = LocalTime.parse(tokens[2],timeformatter);
		    		this.startDate = LocalDate.parse(tokens[3],dateformatter);
		    		this.endDate = LocalDate.parse(tokens[4],dateformatter);
		    		this.day = startDate.getDayOfWeek();		       		
		    	} 
		    	TimeInterval ti = new TimeInterval(this.day, this.startDate, this.endDate, this.startTime, this.endTime);
				Event event = new Event(this.eventName,ti);
				eventsList.add(event);
		    } 
		    sc.close();
		}catch (FileNotFoundException e) 
		{
		      System.out.println("\nFile not found.");
		}
		
		listeners = new ArrayList<ChangeListener>();			
		
	}
	
    

	/**
     * get array list
     * @return
     */
	public ArrayList<Event> getArrayOfevents() 
	{
		return eventsList;
	}
		
	/**
	 * print events in the array list	
	 */
	public void printAllEvents() 
	{
		for (Event event : eventsList)
			System.out.println("\n" + event);
	}
	
	
	
	
}		

	
	
	
	

