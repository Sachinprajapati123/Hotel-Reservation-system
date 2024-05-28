<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    if (request.getParameter("submit") != null) {
        String id = request.getParameter("id");
        String name = request.getParameter("sname");
        String course = request.getParameter("course");
        String fee = request.getParameter("fee");
        
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "Sachin@1234");
            pst = con.prepareStatement("update records set stname = ?, course = ?, fee = ? where id = ?");
            pst.setString(1, name);
            pst.setString(2, course);
            pst.setString(3, fee);
            pst.setString(4, id);
            pst.executeUpdate();  
%>
            <script>   
                alert("Record Updated");           
            </script>
<%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources in the finally block
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title> 
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <h1>Student Update</h1>
    <div class="row">
        <div class="col-sm-4">
            <form  method="POST" action="#">
                <%    
                    Connection con = null;
                    PreparedStatement pst = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "Sachin@1234 ");

                        String id = request.getParameter("id");

                        pst = con.prepareStatement("select * from records where id = ?");
                        pst.setString(1, id);
                        rs = pst.executeQuery();

                        while (rs.next()) {
                %>
                            <div align="left">
                                <label class="form-label">Student Name</label>
                                <input type="text" class="form-control" placeholder="Student Name" value="<%= rs.getString("stname")%>" name="sname" id="sname" required>
                            </div>
                            <div align="left">
                                <label class="form-label">Course</label>
                                <input type="text" class="form-control" placeholder="Course" name="course" value="<%= rs.getString("course")%>" id="course" required>
                            </div>
                            <div align="left">
                                <label class="form-label">Fee</label>
                                <input type="text" class="form-control" placeholder="Fee" name="fee" id="fee" value="<%= rs.getString("fee")%>" required>
                            </div>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        // Close resources in the finally block
                        try {
                            if (rs != null) rs.close();
                            if (pst != null) pst.close();
                            if (con != null) con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
                </br>
                <div align="right">
                    <input type="submit" id="submit" value="submit" name="submit" class="btn btn-info">
                    <input type="reset" id="reset" value="reset" name="reset" class="btn btn-warning">
                </div>
                <div align="right">
                    <p><a href="index..jsp">Click Back</a></p>
                </div>
            </form>
        </div>
    </div>
</body> 
</html>