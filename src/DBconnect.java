/*
Connect to DataBase
Create by Aurosong
Updated:2022.4.2
*/
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

/*
* Servlet for login function in Login.jsp
* Created by Aurosong
* */

@WebServlet("/Login")

public class DBconnect extends HttpServlet {

    Connection connection = null;
    ResultSet resultSet = null;
    PreparedStatement preparedStatement = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter writer = response.getWriter();

        response.setContentType("text/html;charset=UTF8");
        request.setCharacterEncoding("gb2312");

        //user's message from client
        String Cusername = request.getParameter("username");
        String Cpassword = request.getParameter("password");

        //user's message from database
        String DBusername = "null";
        String DBpassword = "null";

        //connect to database
        try {
            Class.forName("org.postgresql.Driver");
            connection = (Connection) DriverManager.getConnection("jdbc:postgresql://localhost:5432/WebGIS", "postgres", "528491");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        String sql = "select * from userMsg where username=? and userpwd=?";
        try {
            //statement = connection.createStatement();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1,Cusername);
            preparedStatement.setString(2,Cpassword);
            resultSet = preparedStatement.executeQuery();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        try {
                while(resultSet.next()){
                    DBusername = resultSet.getString("username");
                    DBpassword = resultSet.getString("userpwd");
                }
            } catch (SQLException throwables) {
                throwables.printStackTrace();
        }

        if(DBpassword.equals(Cpassword)&&DBusername.equals(Cusername)){
            writer.write("1");
            writer.close();
        }
        else if(DBpassword.equals("null")||DBusername.equals("null")){
            writer.write("0");
            writer.close();
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

}

