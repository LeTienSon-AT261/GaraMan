
package com.garaman.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://127.0.0.1:3306/GaraMan?useSSL=false&serverTimezone=Asia/Ho_Chi_Minh&characterEncoding=UTF-8";

    private static final String USER = "root";
    private static final String PASSWORD = "123456";

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            System.out.println("Ket noi database that bai!");
            e.printStackTrace();
            return null;
        }
    }
}
