
package com.garaman.util;

import java.sql.Connection;

public class TestConnection {

    public static void main(String[] args) {
        Connection connection = DBConnection.getConnection();

        if (connection != null) {
            System.out.println("KET NOI MYSQL THANH CONG!");

            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("KET NOI MYSQL THAT BAI!");
        }
    }
}
