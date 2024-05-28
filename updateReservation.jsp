<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Reservation</title>
     <style>
        button{
            font-size: 20px;
            background-color: blue;
            color:white;
            width:50px;
        }
    </style>
</head>
<body>
<%
    String url = "jdbc:mysql://localhost:3306/hotel_db";
    String username = "root";
    String password = "Sachin@1234";

    String reservationIdStr = request.getParameter("reservationId");
    String newGuestName = request.getParameter("newGuestName");
    String newRoomNumberStr = request.getParameter("newRoomNumber");
    String newContactNumber = request.getParameter("newContactNumber");

    if (reservationIdStr == null || newGuestName == null || newRoomNumberStr == null || newContactNumber == null ||
        reservationIdStr.isEmpty() || newGuestName.isEmpty() || newRoomNumberStr.isEmpty() || newContactNumber.isEmpty()) {
        out.println("All fields are required.");
        return;
    }

    try {
        int reservationId = Integer.parseInt(reservationIdStr);
        int newRoomNumber = Integer.parseInt(newRoomNumberStr);

        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "UPDATE reservations SET guest_name = ?, room_number = ?, contact_number = ? WHERE reservation_id = ?")) {

            preparedStatement.setString(1, newGuestName);
            preparedStatement.setInt(2, newRoomNumber);
            preparedStatement.setString(3, newContactNumber);
            preparedStatement.setInt(4, reservationId);

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                out.println("Reservation updated successfully!");
            } else {
                out.println("Reservation update failed.");
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
