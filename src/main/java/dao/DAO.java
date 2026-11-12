package dao;
import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    public static Connection con;
    public DAO() {
        if (con == null) {
            String dbUrl = "jdbc:mysql://localhost:3306/GaraMan?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(dbUrl, "root", "Cnpm@2020?"); // Sửa lại pass của bạn
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}