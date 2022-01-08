import java.time.LocalDate;
import java.util.ArrayList;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

/**
 * Month view data model
 * @author lexinma
 *
 */
public class MonthviewModel 
{
	private LocalDate cal;	
	private ArrayList<ChangeListener> listeners;
	
	/**
	 * constructor
	 */
	public MonthviewModel()
	{
		cal = LocalDate.now();
		listeners = new ArrayList<ChangeListener>();
	}
	
	/**
	 * @return date
	 */
	public LocalDate getcal()
	{
		return cal;
	}
	
	/**
	 * change the date one day before the current date
	 */
	public void forwardUpdate()
	{
		cal = cal.minusDays(1); 
		 //notify views
	    ChangeEvent e = new ChangeEvent(this);
	    for (ChangeListener l : listeners)
	    {
	       l.stateChanged(e);
	    }
	 }
	
	/**
	 * change the date one day after the current date
	 */
	public void backwardUpdate()
	{
		cal = cal.plusDays(1); 
		 //notify views
	    ChangeEvent e = new ChangeEvent(this);
	    for (ChangeListener l : listeners)
	    {
	       l.stateChanged(e);
	    }
	 }
	 
	 public void addChangeListener(ChangeListener listener)
	 {		
		listeners.add(listener);
	 }
		
	

}
