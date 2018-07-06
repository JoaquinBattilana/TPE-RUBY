

public class Task implements Comparable<Task>{

    private Boolean complete = false;
    private int id;
    private String description;
    private String group;
    private StringDate expiration_date;

    Task(int id, String description, StringDate expiration_date, String group) {
        this.id = id;
        this.description = description;
        this.expiration_date = expiration_date;
        this.group = group;
    }

    public void complete() {
        this.complete = true;
    }
    public boolean completed(){
        return complete;
    }

    @Override
    public int compareTo(Task o) {
        int comp1=complete.compareTo(o.complete);
        if(comp1!=0)
            return comp1;
        int comp2=expiration_date.compareTo(o.expiration_date);
        if(comp2!=0)
            return comp2;
        int comp3=id-o.id;
        return comp3;
    }

    @Override
    public boolean equals(Object obj) {
        if(this==obj)
            return true;
        if(!(obj instanceof Task))
            return false;
        Task temp=(Task) obj;
        if(id==temp.id)
            return true;
        return false;
    }

    @Override
    public int hashCode(){
        int result=17;
        result=31*result+this.id;
        return result;
    }

    public int getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public String getGroup() {
        return group;
    }

    public StringDate getExpiration_date() {
        return expiration_date;
    }
}
