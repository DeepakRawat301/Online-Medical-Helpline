<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <% 
    String userid = request.getParameter("UserId");
    String pass = request.getParameter("Password");
    String name = request.getParameter("Name");
    Connection cn = null;
    PreparedStatement prst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedicalHelpline", "root", "12345");

        String Aregisterquery = "INSERT INTO admin (UserId, Password, Name) VALUES (?, ?, ?)";
        prst = cn.prepareStatement(Aregisterquery);
        prst.setString(1, userid);
        prst.setString(2, pass);
        prst.setString(3, name);
        int n = prst.executeUpdate();
        if (n > 0) {
            // Close resources before redirecting
            prst.close();
            cn.close();
            response.sendRedirect("adminlogin.html");
            return; // Stop further execution of JSP
        } else {
            out.println("Failed to register doctor");
        }
    } catch (ClassNotFoundException | SQLException e) {
        // Handle exceptions properly (log or display error message)
        out.println("Exception occurred: " + e.getMessage());
    } finally {
        // Close resources in finally block to ensure they are always closed
        try {
            if (prst != null) {
                prst.close();
            }
            if (cn != null) {
                cn.close();
            }
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
    %>
</body>
</html>
