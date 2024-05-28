<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New Reservation</title>
     <style>
        button{
            font-size: 20px;
            background-color: black;
            color:white;
            width:200px;
        }
    </style>
</head>
<body>
<%
    String url = "jdbc:mysql://localhost:3306/hotel_db";
    String username = "root";
    String password = "Sachin@1234";

    String guestName = request.getParameter("guestName");
    String roomNumberStr = request.getParameter("roomNumber");
    String contactNumber = request.getParameter("contactNumber");

    if (guestName == null || roomNumberStr == null || contactNumber == null ||
        guestName.isEmpty() || roomNumberStr.isEmpty() || contactNumber.isEmpty()) {
        out.println("All fields are required.");
        return;
    }

    try {
        int roomNumber = Integer.parseInt(roomNumberStr);

        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "INSERT INTO reservations (guest_name, room_number, contact_number) VALUES (?, ?, ?)")) {

            preparedStatement.setString(1, guestName);
            preparedStatement.setInt(2, roomNumber);
            preparedStatement.setString(3, contactNumber);

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                out.println("Reservation created successfully!");
            } else {
                out.println("Reservation creation failed.");
            }
        }
    } catch (NumberFormatException e) {
        out.println("Invalid number format: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        out.println("JDBC Driver not found: " + e.getMessage());
    } catch (SQLException e) {
        out.println("SQL Error: " + e.getMessage());
    }
%>
<br>
<br>
<button><a href="index_1.jsp">Go back</a></button>
</body>
</html>
