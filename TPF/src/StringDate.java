import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class StringDate implements Comparable<StringDate> {

    Calendar date=new GregorianCalendar();

    StringDate(String date){
        if(date.equals("tomorrow")){
            this.date.add(Calendar.DAY_OF_YEAR,+1);
        }
        else if(date.matches("\\d{2}/\\d{2}/\\d{4}")){
            String[] stringArray=date.split("/");
            this.date.set(Calendar.DAY_OF_MONTH,Integer.parseInt(stringArray[1]));
            this.date.set(Calendar.MONTH,Integer.parseInt(stringArray[2]));
            this.date.set(Calendar.YEAR,Integer.parseInt(stringArray[3]));
        }
        else if(date.equals("today")){
            throw new IllegalArgumentException();
        }
    }

    @Override
    public String toString(){
        return String.valueOf(date.get(Calendar.DAY_OF_MONTH))+String.valueOf(date.get(Calendar.MONTH))+String.valueOf(date.get(Calendar.YEAR));
    }

    @Override
    public int compareTo(StringDate o) {
        return this.date.compareTo(o.date);
    }

    @Override
    public boolean equals(Object obj) {
        if(this==obj)
            return true;
        if(!(obj instanceof Task))
            return false;
        StringDate temp=(StringDate) obj;
        return date.equals(temp.date);
    }
}