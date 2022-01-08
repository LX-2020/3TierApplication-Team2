import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

/**
 * simple GUI calendar 
 * views contain month view and day view
 * controller contains forward, backward, create, and quit buttons
 * @author lexinma
 *
 */
public class SimpleCalendar extends JFrame implements ChangeListener, MouseListener
{
	private MonthviewModel mm;
	private DayviewModel dm;
	private LocalDate cal;
	private int firstDayofMonth;
	private int lengthOfMonth;
	private int counter;
	private ArrayList<Event> eventlist;
	private ArrayList<JLabel> dateLabels = new ArrayList<JLabel>();
	private JTextArea eventsList;
	private JLabel date, monthLabel;
		
	DateTimeFormatter dateformatter = DateTimeFormatter.ofPattern("MM/d/yyyy");
	DateTimeFormatter timeformatter = DateTimeFormatter.ofPattern("H:mm"); 
	
	/*
	 * constructor 
	 *  @param mModel month view data model
	 *  @param dModel day view data model
	 */
	public SimpleCalendar(MonthviewModel mModel, DayviewModel dModel)
	{
	      mm = mModel;
	      dm = dModel;
	      cal = mm.getcal();
	      eventlist = dm.getEvents();
	      
	      	//top button panel
			JPanel topButton_panel = new JPanel();
			topButton_panel.setLayout(new BoxLayout(topButton_panel, BoxLayout.X_AXIS));
			
			JButton forward = new JButton("<");				
			JButton back = new JButton(">");				
			JButton quit = new JButton("quit");
			
			topButton_panel.add(forward);
			topButton_panel.add(back);
			topButton_panel.add(Box.createHorizontalGlue());
			topButton_panel.add(quit);
			
			//Month view panel		
			JPanel month_panel = new JPanel();
			month_panel.setLayout(new BoxLayout(month_panel, BoxLayout.Y_AXIS));
			JButton create = new JButton("create");
			month_panel.add(create);
			
				//month label		
			String date_text = cal.getMonth() + "  " + cal.getYear();
			monthLabel = new JLabel(date_text);
			month_panel.add(monthLabel);
			
				//date panel in Month view panel		
			JPanel date_panel = new JPanel();
			date_panel.setLayout(new GridLayout(7,7));
			
				//set day label of the calendar
			String day = "SMTWTFS";
			for (int j = 0; j < 7; j++)
			{
				JLabel dayLabel = new JLabel(""+day.charAt(j));
				date_panel.add(dayLabel);
			}
			
				//set date label of the calendar
			firstDayofMonth = LocalDate.of(cal.getYear(), cal.getMonth(), 1).getDayOfWeek().getValue();
			lengthOfMonth = cal.getMonth().length(cal.isLeapYear());
			counter = 0;//count number of created labels
			
				//empty label before the first day of the month
			if (firstDayofMonth != 7)
		        for (counter = 0; counter < firstDayofMonth; counter++) 
		        {
		        	dateLabels.add(new JLabel(" "));
					date_panel.add(dateLabels.get(counter));
					dateLabels.get(counter).addMouseListener(this);
		        }
			for (int j = 1; j <= lengthOfMonth; j++,counter++) 
	        {
				//today's date label
	        	if (j == cal.getDayOfMonth())
	        	{	
	        		dateLabels.add(new JLabel(""+j));
	        		dateLabels.get(counter).setForeground(Color.red);
	    			date_panel.add(dateLabels.get(counter));
	    			dateLabels.get(counter).addMouseListener(this);
					
	        	}        	
	        	else
	        	{	
	        		dateLabels.add(new JLabel(""+j));
	    			date_panel.add(dateLabels.get(counter));
	    			dateLabels.get(counter).addMouseListener(this);
					
	        	}
	        }
				//empty label fill up the grid panel
			for (int k = counter; k < 42; k++)
			{
				dateLabels.add(new JLabel(" "));
				date_panel.add(dateLabels.get(k));
				dateLabels.get(k).addMouseListener(this);
			}
			month_panel.add(date_panel);
			
					
			//Day view panel
			JPanel day_panel = new JPanel();
			day_panel.setLayout(new BorderLayout());			
			
			date = new JLabel("" + cal.getDayOfWeek() + " " + cal.getMonthValue()+"/"+ cal.getDayOfMonth());
			eventsList = new JTextArea();	
			day_panel.add(date, BorderLayout.NORTH);
			day_panel.add(eventsList, BorderLayout.CENTER);	
			
			getContentPane().setLayout(new BoxLayout(getContentPane(), BoxLayout.PAGE_AXIS));
			add(topButton_panel);		
			add(month_panel);
			add(day_panel);
			addMouseListener(this);
			
			setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		    pack();
		    setVisible(true);
			    
		    //action listeners serve as controller to update model
		    forward.addActionListener(new 
		    		ActionListener() 
					{
						public void actionPerformed(ActionEvent e)
						{	
							mm.forwardUpdate(); 
													
						}		
					});
		    
		    back.addActionListener(new 
		    		ActionListener() 
					{
						public void actionPerformed(ActionEvent e)
						{	
							mm.backwardUpdate();
						}
							
					});
		    
		    quit.addActionListener(new 
		    		ActionListener() 
					{
						public void actionPerformed(ActionEvent e)
						{	
							//create output file
							eventlist = dm.getEvents();
							File file = new File("Output.txt");
							try {
								FileWriter writer = new FileWriter(file);
								for(Event event : eventlist)
									for(int i = 0; i < event.toString().length(); i++)
									{
										writer.write(event.toString().charAt(i));
									}
								writer.flush();
								writer.close();
							} catch (IOException e1) 
							{e1.printStackTrace();}	
							
							dispose();
						}
							
					});
		    
		    create.addActionListener(new
		    		ActionListener()
		    		{
		    			public void actionPerformed(ActionEvent e)
		    			{	
		    				//create pop up input window
		    				LocalDate c = mm.getcal();
		    				JTextField eventName = new JTextField();
		    				JTextField startTime = new JTextField();
		    				JTextField endTime = new JTextField();
		    				
		    				Object[] message = { "Event Name:", eventName, "From:", startTime, "to:", endTime};
		    			
		    				int newEvent = JOptionPane.showConfirmDialog(null, message, "", JOptionPane.OK_CANCEL_OPTION);
		    				
		    				LocalTime starttime = LocalTime.parse(startTime.getText(), timeformatter);
		    				LocalTime endtime = LocalTime.parse(endTime.getText(), timeformatter);
		    				boolean checkconflict = false;
		    				//check time conflict
							for (Event event : eventlist) 
							{					
								if (event.getTI().getStartDate().equals(c) 
									&& event.getTI().betweenTimes(starttime))
								{	
									System.out.println("New event time is conflicted with another existed event");
									checkconflict = true;
									break;
								}
							
							}
							if(!checkconflict && newEvent == JOptionPane.OK_OPTION)
							{
								TimeInterval ti = new TimeInterval(c.getDayOfWeek(), c, c, starttime, endtime);					
								Event event = new Event(eventName.getText(),ti);
								dm.addEvent(event);								
													
							}
		    			}
		    		});

		    //date labels serve as views update the display
		    mm.addChangeListener(new 
		    		ChangeListener()
		    		{
		    			public void stateChanged(ChangeEvent e) 
		    			{	
		    				LocalDate cal = mm.getcal();
		    				monthLabel.setText(cal.getMonth() + "  " + cal.getYear());
		    				int firstDayofMonth = LocalDate.of(cal.getYear(), cal.getMonth(), 1).getDayOfWeek().getValue();
		    				int lengthOfMonth = cal.getMonth().length(cal.isLeapYear());
		    				int counter = 0;
		    				if (firstDayofMonth != 7)
		    			        for (counter = 0; counter < firstDayofMonth; counter++) 
		    			        {
		    			        	dateLabels.get(counter).setText(" ");		    						
		    			        }
		    				for (int j = 1; j <= lengthOfMonth; j++,counter++) 
		    		        {
		    					//today's date label
		    		        	if (j == cal.getDayOfMonth())
		    		        	{		    		        			        		
		    		        		dateLabels.get(counter).setText(""+j);
		    		        		dateLabels.get(counter).setForeground(Color.red);		    		        		
		    		        	}        	
		    		        	else
		    		        	{	
		    		        		dateLabels.get(counter).setText(""+j);	
		    		        		dateLabels.get(counter).setForeground(Color.black);		    		        		
		    		        	}
		    		        }
		    				//empty label fill up the grid panel
		    				for (int k = counter; k < 42; k++ )
		    				{
		    					dateLabels.get(k).setText(" ");		    					
		    				}
		    				
		    				date.setText("" + cal.getDayOfWeek() + " " + cal.getMonthValue()+"/"+ cal.getDayOfMonth());
		    				eventsList.setText(dm.updateEvents(cal));
		    				
		    			}
		    			
		    		});
		    
			
		}
						
		//concrete mouse listener
		public void mouseClicked(MouseEvent e) 
		{
			JLabel label = (JLabel) e.getSource();				
			String m = mm.getcal().getMonthValue() + "/" + label.getText() + "/" + cal.getYear();
			LocalDate d = LocalDate.parse(m,dateformatter);
			date.setText("" + d.getDayOfWeek() + " " + d.getMonthValue()+"/"+ d.getDayOfMonth());
			eventsList.setText(dm.updateEvents(d));		
							
		}
						
		public void mousePressed(MouseEvent e) {}
							
		public void mouseReleased(MouseEvent e) {}
							
		public void mouseEntered(MouseEvent e) {}
							
		public void mouseExited(MouseEvent e) {}
							
		public void stateChanged(ChangeEvent e) {}
							
		
}
