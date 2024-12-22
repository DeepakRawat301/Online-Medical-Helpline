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
    if (userid == null || pass == null) {
        out.println("All fields are required.");
        return;
    }

    Connection cn = null;
    PreparedStatement prst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MedicalHelpline", "root", "12345");
        String Aloginquery = "Select * from Admin where UserId=? and Password=?";
        prst = cn.prepareStatement(Aloginquery);
        prst.setString(1, userid);
        prst.setString(2, pass);
        ResultSet rs = prst.executeQuery();
        
        if (rs.next()) {
            session.setAttribute("adminlogin", userid); // Use the existing session variable
            response.sendRedirect("adminop.jsp");
            return; 
        } else {
            out.println("Failed to login");
        }
    } catch (ClassNotFoundException | SQLException e) {
        out.println("Exception occurred: " + e.getMessage());
    } finally {
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
    response.sendRedirect("adminlogin.html");
    %>
</body>
</html>
