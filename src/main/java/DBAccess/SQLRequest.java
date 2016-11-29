package main.java.DBAccess;


public class SQLRequest {

    private String identifier = "@param";
    private String request;

    private String finalRequest;

    SQLRequest(String request){
        this.request = request;
    }

    public SQLRequest callWithArgs(String... args){
        for(String str : args){
            this.finalRequest = this.request.replaceFirst(identifier, str);
        }

        return this;
    }

    @Override
    public String toString() {
        System.out.println(this.finalRequest);
        return this.finalRequest;
    }

    /*Old one
    private String select;
    private String from;
    private String where;
    private String groupby;
    private String orderby;

    public SQLRequest(){
        from = "";
        where = "";
        groupby = "";
        orderby = "";
    }

    public SQLRequest select(String... select){
        this.select = "";
        for(String s : select){
            this.select += s + ", ";
        }

        this.select = this.select.substring(0, this.select.length()-2);
        return this;
    }

    public SQLRequest addDistinct(){
        this.select = this.select.replaceFirst("SELECT", "SELECT DISTINCT");
        return this;
    }

    public SQLRequest from(String from){
        this.from += "FROM " + from + " ";
        return this;
    }

    public SQLRequest from(SQLRequest request){
        this.from += "FROM ( " + request.toString() + ") ";
        return this;
    }

    public SQLRequest where(String where){
        if(where.equals("")) this.where = "";
        else this.where += "WHERE " + where + " ";
        return this;
    }

    public SQLRequest groupby(String groupby){
        this.groupby += "GROUP BY " + groupby + " ";
        return this;
    }

    public SQLRequest orderby(String orderby){
        this.orderby += "ORDER BY " + orderby + " ";
        return this;
    }

    @Override
    public String toString() {
        System.out.println(select+" "+from+" "+where+" "+groupby+" "+orderby);
        return "SELECT " + select+" "+from+" "+where+" "+groupby+" "+orderby;
    }*/
}
