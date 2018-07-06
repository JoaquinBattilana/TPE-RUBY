import java.util.Set;
import java.util.TreeSet;

public class TaskHolder {

    private int currentId=1;
    private Set<Task> set= new TreeSet<>();
    private String defaultGroup="";
    private String defaultDate;

    public void add(String description, String date, String group){
        if(date==null)
            date=this.defaultDate;
        if(group==null)
            group=this.defaultGroup;
        Task new_task= new Task(currentId,description, new StringDate(date),group);
        set.add(new_task);
        this.currentId+=1;
    }
    public boolean complete(int id){
        Task task=findTask(id);
        if (task.completed())
            return false;
        refreshTask(task);
        return true;
    }
    public void set_group(String group) {
        this.defaultGroup = group;
    }
    public void set_date(String date){
        this.defaultDate=date;
    }
    private void refreshTask(Task task){
        set.remove(task);
        task.complete();
        set.add(task);
    }
    public boolean isEmpty(){
        return set.isEmpty();
    }
    private Task findTask(int id) throws IllegalArgumentException{
        for(Task task:set ){
            if(task.getId()==id)
                return task;
        }
        throw new IllegalArgumentException();
    }
    public Set<Task> list(){
        return new TreeSet<>(set);
    }
    public Set<Task> listToday(){
        Set<Task> temp=new TreeSet<>();
        StringDate today=new StringDate("today");
        for(Task task:set){
            if(task.getExpiration_date()!=null && task.getExpiration_date()==today){
                temp.add(task);
            }
        }
        return temp;
    }
    public Set<Task> listOverdue(){
        Set<Task> temp=new TreeSet<>();
        StringDate today=new StringDate("today");
        for(Task task:set){
            if(task.getExpiration_date()!=null && task.getExpiration_date().compareTo(today)<1){
                temp.add(task);
            }
        }
        return temp;
    }
    public Set<Task> findByText(String text){
        Set<Task> temp=new TreeSet<>();
        for(Task task:set){
            if(task.getDescription().toLowerCase().contains(text.toLowerCase())){
                temp.add(task);
            }
        }
        return temp;
    }
}
