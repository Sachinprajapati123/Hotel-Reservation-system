<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Get Room Number</title>
    <style>
        button{
            font-size: 20px;
            background-color: black;
            color:white;
            width:100px;
        }
    </style>
</head>
<body>
<%
    String url = "jdbc:mysql://localhost:3306/hotel_db";
    String username = "root";
    String password = "Sachin@1234";

    String reservationIdStr = request.getParameter("reservationId");

    if (reservationIdStr == null || reservationIdStr.isEmpty()) {
        out.println("Reservation ID is required.");
        return;
    }

    try {
        int reservationId = Integer.parseInt(reservationIdStr);

        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT room_number FROM reservations WHERE reservation_id = ?")) {

            preparedStatement.setInt(1, reservationId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int roomNumber = resultSet.getInt("room_number");
                out.println("The room number for reservation ID " + reservationId + " is " + roomNumber + ".");
            } else {
                out.println("No reservation found with the given ID.");
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
